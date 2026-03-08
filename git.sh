#!/bin/bash
set -euo pipefail  # 严格模式

##############################################################################
# 🚀 配置参数
##############################################################################
# 推送和拉取的目标分支
DEFAULT_BRANCH="main" 

DEFAULT_COMMIT_MSG="$(date +'%Y-%m-%d %H:%M:%S')"
REMOTE_NAME="origin"
REMOTE_URL=""

##############################################################################
# 🎨 工具函数
##############################################################################
GREEN="\033[32m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"
MAGENTA="\033[35m"
RESET="\033[0m"
BOLD="\033[1m"

separator() { echo -e "$MAGENTA-----------------------------------------------------------------$RESET"; }
info() { echo -e "[$BOLD$GREEN  INFO  $RESET] $1"; }
warn() { echo -e "[$BOLD$YELLOW  WARN  $RESET] $1"; }
error() { echo -e "[$BOLD$RED ERROR $RESET] $1" >&2; exit 1; }
title() { separator; echo -e "[$BOLD$BLUE ⚙️ OPERATION ⚙️ $RESET] $1"; separator; }

##############################################################################
# 📚 脚本用法说明
##############################################################################
usage() {
    separator
    echo -e "$BOLD$CYAN\n✨ Git 自动化工具 ✨\n$RESET"
    separator
    echo "Usage: $0 [OPTIONS]"
    echo "默认行为：执行 git add -> commit -> push 流程。"
    echo -e "Target Branch: $BOLD$GREEN $DEFAULT_BRANCH $RESET"
    echo
    echo "Options:"
    echo "  -m <msg>      设置提交信息（仅在执行提交时有效）"
    echo "  -r <url>      仅配置远程仓库 URL (不提交)"
    echo "  -i            仅执行 'git init' 初始化仓库 (不提交)"
    echo "  -p            仅执行 'git pull --rebase' (不提交)"
    echo "  -h            显示帮助信息"
}

##############################################################################
# ⚙️ 核心 Git 操作函数
##############################################################################

is_git_repo() { git rev-parse --is-inside-work-tree &>/dev/null; }
has_changes() { ! git diff --quiet --exit-code || ! git diff --cached --quiet --exit-code; }
is_remote_exist() { git remote get-url "$REMOTE_NAME" &>/dev/null; }

# 1. 初始化 Git 仓库
do_init() {
    title "初始化 Git 仓库"
    if is_git_repo; then
        warn "Git 仓库已存在，跳过初始化"
    else
        info "正在执行：git init -b $BRANCH"
        git init -b "$BRANCH" || error "git init 失败"
    fi
}

# 2. 配置远程仓库
do_remote_add() {
    title "配置远程仓库"
    if is_remote_exist; then
        warn "远程仓库 '$REMOTE_NAME' 已存在，跳过配置"
    else
        info "正在执行：git remote add $REMOTE_NAME $REMOTE_URL"
        git remote add "$REMOTE_NAME" "$REMOTE_URL" || error "git remote add 失败"
    fi
}

# 3. 拉取远程代码
do_pull() {
    title "拉取远程最新代码"
    if ! is_git_repo; then error "不是 Git 仓库，无法拉取！"; fi
    
    info "正在执行：git pull --rebase $REMOTE_NAME $BRANCH"
    if ! git pull --rebase "$REMOTE_NAME" "$BRANCH"; then
        warn "拉取失败。如果是新创建的分支且远程尚无此分支，请忽略此警告。"
        warn "如果是网络或冲突问题，请手动解决。"
    else
        info "代码拉取成功！"
    fi
}

# 4. 提交和推送主流程
do_commit_push() {
    title "Git 提交与推送主流程"
    if ! is_git_repo; then error "不是 Git 仓库！"; fi

    if ! has_changes; then
        warn "没有检测到修改的文件，无需提交"
    else
        info "正在执行：git add ."
        git add . || error "git add 失败"

        info "正在执行：git commit -m \"$COMMIT_MSG\""
        git commit -m "$COMMIT_MSG" || error "git commit 失败"
    fi

    info "正在执行：git push $REMOTE_NAME $BRANCH"
    if ! git push "$REMOTE_NAME" "$BRANCH"; then
        warn "直接推送失败，尝试设置上游分支并推送 (set-upstream)..."
        git push --set-upstream "$REMOTE_NAME" "$BRANCH" || error "推送失败！请检查网络或权限"
    fi
}

##############################################################################
# ➡️ 流程控制
##############################################################################

RUN_INIT=0
RUN_PULL=0
RUN_COMMIT_PUSH=1   # 默认开启
ACTION_MODE=0       # 标记是否处于“单指令”模式

COMMIT_MSG="$DEFAULT_COMMIT_MSG"
BRANCH="$DEFAULT_BRANCH"

while getopts "m:r:iph" opt; do
    case $opt in
        m) 
            COMMIT_MSG="$OPTARG" 
            ;;
        r) 
            REMOTE_URL="$OPTARG"
            ACTION_MODE=1 
            ;;
        i) 
            RUN_INIT=1
            ACTION_MODE=1 
            ;;
        p) 
            RUN_PULL=1
            ACTION_MODE=1 
            ;;
        h) usage; exit 0 ;;
        \?) echo -e "$BOLD$RED 错误：无效参数 -$OPTARG $RESET" >&2; usage; exit 1 ;;
        :) echo -e "$BOLD$RED 错误：参数 -$OPTARG 需要传入值 $RESET" >&2; usage; exit 1 ;;
    esac
done

# 关键逻辑：如果检测到单指令模式 (ACTION_MODE=1)，则关闭默认的提交推送
if [ "$ACTION_MODE" -eq 1 ]; then
    RUN_COMMIT_PUSH=0
fi

# 如果指定了远程URL，通常意味着需要确保仓库已初始化
if [ -n "$REMOTE_URL" ]; then 
    RUN_INIT=1 
fi

# 1. 初始化 (仅当 -i 或 -r 触发时)
if [ "$RUN_INIT" -eq 1 ]; then do_init; fi

# 2. 配置远程 (仅当 -r 触发时)
if [ -n "$REMOTE_URL" ]; then do_remote_add; fi

# 3. 拉取 (仅当 -p 触发时)
if [ "$RUN_PULL" -eq 1 ]; then do_pull; fi

# 4. 提交推送 (仅当没有指定 -i, -p, -r 时执行)
if [ "$RUN_COMMIT_PUSH" -eq 1 ]; then do_commit_push; fi

##############################################################################
# ✅ 执行成功
##############################################################################
separator
echo -e "[$BOLD$GREEN SUCCESS $RESET] $BOLD$CYAN Git 自动化流程执行完毕！ $RESET"
echo -e "[$BOLD$GREEN DETAIL $RESET] $BOLD$YELLOW 操作分支：$BRANCH $RESET"
echo -e "[$BOLD$GREEN DETAIL $RESET] $BOLD$YELLOW 提交信息：$COMMIT_MSG $RESET"
separator