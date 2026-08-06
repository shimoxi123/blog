---
date: '{{ .Date }}'
draft: false # 是否为草稿，默认为 false
title: '{{ replace .File.ContentBaseName "-" " " | title }}' # 文章标题，默认为文件名
subtitle: "" # 文章副标题，默认为空
description: "" # 文章描述，默认为空
comment: true # 是否开启评论
weight: 0 # 文章权重，默认为 0，数值越小优先级越高
tags:
  - 标签
categories:
  - 分类
summary: "" # 文章摘要，默认为空
featured_image_preview: "" # 文章列表页预览图，默认为空
featured_image: "" # 文章详情页图片，默认为空

# See details front matter: https://fixit.lruihao.cn/documentation/content-management/introduction/#front-matter
---

<!--more-->
