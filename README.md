# 机器人技术博客

基于 [Jekyll Theme Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) 构建的静态博客。

## 功能特性

- **LaTeX 支持**: 使用 MathJax 渲染数学公式。
- **代码高亮**: 支持多种语言的代码块高亮。
- **视频嵌入**: 支持 Bilibili 和 YouTube 视频嵌入。
- **Mermaid**: 支持流程图绘制。

## 快速开始

### 本地运行

1. 安装 Ruby 和 Jekyll。
2. 安装依赖：
   ```bash
   bundle install
   ```
3. 启动本地服务器：
   ```bash
   bundle exec jekyll serve --port 4001
   ```
4. 访问 `http://127.0.0.1:4000`。

### 部署到 GitHub Pages

1. 将代码推送到 GitHub 仓库 `haozhang04.github.io`。
2. GitHub Actions 会自动构建并部署网站。
3. 访问 `https://haozhang04.github.io`。

## 写作指南

在 `_posts` 目录下创建 Markdown 文件，格式为 `YYYY-MM-DD-title.md`。

示例 Front Matter：

```yaml
---
title: 文章标题
date: 2024-05-20 12:00:00 +0800
categories: [分类1, 分类2]
tags: [标签1, 标签2]
math: true       # 开启 LaTeX
mermaid: true    # 开启 Mermaid
---
```

## B 站视频嵌入

使用以下 Liquid 标签嵌入 B 站视频：

```liquid
{% include embed/bilibili.html id='BV号' %}
```
