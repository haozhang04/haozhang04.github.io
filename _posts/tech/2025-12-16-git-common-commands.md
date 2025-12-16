---
layout: post
title: "Git 常用指令速查"
date: 2025-12-16
categories: tech
tags: [git, version-control, tools]
author: haozhang04
---

Git 是目前世界上最先进的分布式版本控制系统。本文整理了日常开发中常用的 Git 指令，方便快速查阅。

## 1. 全局配置 (Config)

在安装 Git 后，首先需要配置用户信息：

```bash
# 设置用户名
git config --global user.name "zhnghao"

# 设置用户邮箱
git config --global user.email "2954474870@qq.com"

# 设置 HTTP/HTTPS 代理（解决 GitHub 连接慢的问题）
git config --global http.proxy http://127.0.0.1:17890
git config --global https.proxy https://127.0.0.1:17890

# 取消代理设置
git config --global --unset http.proxy
git config --global --unset https.proxy

# 查看当前配置
git config --list
```

## 2. 代码仓库获取 (Init & Clone)

```bash
# 在当前目录初始化一个新的 Git 仓库
git init

# 克隆远程仓库到本地
git clone -b master https://gitee.com/haozhang04/uwbot_gui.git
```

## 3. 基本操作 (Basic Snapshotting)

```bash
# 查看文件状态（已修改、已暂存等）
git status

# 添加指定文件到暂存区
git add <file>

# 添加当前目录所有修改到暂存区
git add .

# 提交暂存区的修改到本地仓库
git commit -m "commit message"

# 查看修改内容
git diff
```

## 4. 分支管理 (Branching & Merging)

```bash
# 查看本地分支
git branch

# 查看所有分支（包含远程分支）
git branch -a

# 创建新分支
git branch <branch-name>

# 切换分支
git checkout <branch-name>

# 创建并切换到新分支
git checkout -b <branch-name>

# 合并指定分支到当前分支
git merge <branch-name>

# 删除本地分支
git branch -d <branch-name>
```

## 5. 远程同步 (Sharing & Updating)

```bash
# 查看远程仓库信息
git remote -v

# 添加远程仓库
git remote add origin <repository-url>

# 拉取远程代码并合并（相当于 fetch + merge）
git pull origin <branch-name>

# 推送本地代码到远程仓库
git push origin <branch-name>

# 首次推送并建立追踪关系
git push -u origin <branch-name>
```

## 6. 撤销与回滚 (Undo)

```bash
# 撤销工作区的修改（丢弃文件修改）
git checkout -- <file>
# 或者
git restore <file>

# 暂存区文件撤销回工作区（取消 add）
git reset HEAD <file>
# 或者
git restore --staged <file>

# 回退到上一个版本（保留工作区修改）
git reset --soft HEAD^

# 彻底回退到上一个版本（丢弃所有修改，慎用）
git reset --hard HEAD^
```

## 7. 暂存现场 (Stash)

当手头工作没有完成，需要切换分支修复 bug 时使用：

```bash
# 保存当前工作进度
git stash

# 查看暂存列表
git stash list

# 恢复最近一次暂存的内容
git stash pop
```

## 8. 查看日志 (Log)

```bash
# 查看提交历史
git log

# 查看简洁的提交历史
git log --oneline

# 查看分支合并图
git log --graph --oneline --all
```

希望这份清单能帮助你更高效地使用 Git！
