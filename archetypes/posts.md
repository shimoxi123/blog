---
# 文章标题，自动使用文件名（去掉扩展名）并转为标题风格
title: '{{ replace .File.ContentBaseName "-" " " | title }}'
# 文章副标题，显示在标题之下；留空则不显示
subtitle: ''
# 发布日期，通常使用当前时间；可覆写为固定日期，例如 '2025-01-01T10:00:00+08:00'
date: '{{ .Date }}'
# 最后修改日期，留空则沿用构建时的文件修改时间或 Git 提交时间
lastmod: ''
# 文章唯一别名，留空则 Hugo 根据标题自动生成 slug
slug: ''
# 是否为草稿，true 时仅用 `hugo --buildDrafts` 才会渲染
draft: false
# 文章描述，同时用于 SEO meta description 和首页列表摘要
description: ''
# 关键词，逗号分隔；用于 SEO meta keywords
keywords: ''
# 文章权重，数值越小优先级越高；用于排序
weight: 0
# 标签列表，可添加多个
tags:
  - 标签
# 分类列表，通常只有一个；可添加多个
categories:
  - 分类
# 集合列表，自定义分类维度；参考 hugo.toml 中的 `collection = "collections"`
collections:
  - 集合
# 手动指定文章摘要；留空则 Hugo 自动提取正文或 description 作为摘要
summary: ''
# 文章详情页的特色图片，支持本地资源与站点资源路径
featured_image: '/image.png'
# 文章列表页（首页等）的预览图片，通常缩略图版本
featured_image_preview: '/image.png'
# 开启 / 关闭当前页面的评论系统
comment: true
# 转载声明
repost:
  enable: false # 是否显示转载声明
  url: ''       # 原文链接

# 页面级参数（page-level params），用于渲染声明信息等
params:
  disclaimer:
    enable: true   # 是否开启声明
    content: ''    # 声明文本内容
    type: ai       # 声明类型：ai / note / warning 等

# 站点资源声明（用于 page bundle 模式），例如封面图
# resources:
#   - name: featured-image
#     src: featured-image.jpg
#   - name: featured-image-preview
#     src: featured-image-preview.jpg

# {{/* 参见 front matter 说明：https://fixit.lruihao.cn/documentation/content-management/front-matter/ */}}
---

<!--more-->
