# 使用 Git 工具远程推送到 GitHub 的完整指南


<!-- more -->
---

## 二、准备工作

1. 申请并登录 [GitHub](www.github.com) 账号
2. 在 GitHub 上新建一个空仓库，例如 `GeRenBoKe`，默认分支设为 `main`。
3. 在本地安装 Git：([Git中文官网](https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%AE%89%E8%A3%85-Git))
   ```bash
   sudo apt update
   sudo apt install git -y
   ```
4. 配置全局用户名和邮箱：
   ```bash
   git config --global user.name "shimoxi123"
   git config --global user.email "you@example.com"
   ```

---

## 三、初始化本地仓库并关联远程

在你的 Hexo 博客根目录（如 `~/BoKe`）下执行：

```bash
cd ~/BoKe
# 初始化 Git 仓库
git init

# 添加远程仓库地址（替换为你的仓库 HTTPS 或 SSH 链接）
git remote add origin https://github.com/shimoxi123/GeRenBoKe.git
```

执行 `git remote -v` 可以查看远程仓库是否配置成功：

```bash
origin  https://github.com/shimoxi123/GeRenBoKe.git (fetch)
origin  https://github.com/shimoxi123/GeRenBoKe.git (push)
```

---

## 四、第一次提交与推送

1. 查看本地变动状态：
   ```bash
   git status
   ```
2. 添加全部文件到暂存区：
   ```bash
   git add .
   ```
3. 提交改动：
   ```bash
   git commit -m "chore: 初始化博客项目"
   ```
4. 将本地 `main` 分支推送到远程：
   ```bash
   git push -u origin main
   ```

> [!NOTE]
> 第一次推送时需要加 `-u`，可以在后续直接使用 `git push`。

---

## 五、后续更新与合并冲突处理

每次修改并想更新到 GitHub 时：

```bash
# 确保远程最新改动拉下来（避免冲突）
git pull --rebase origin main

# 添加与提交本地更改
git add .
git commit -m "feat: 更新文章/配置"

# 推送到远程
git push origin main
```

如果在拉取时发生冲突，Git 会提示冲突文件，按以下步骤解决：

1. 打开冲突文件，手动合并标记（`<<<<<<<`、`=======`、`>>>>>>>`）之间的内容。
2. 标记合并完成：
   ```bash
   git add 冲突文件
   git rebase --continue    # 如果使用 rebase
   # 或者 git commit         # 如果普通 merge
   ```
3. 继续推送：
   ```bash
   git push origin main
   ```

---

## 六、使用 SSH Key 免密码访问（可选）

1. 生成 SSH Key：
   ```bash
   ssh-keygen -t ed25519 -C "you@example.com"
   # 一路回车即可
   ```
2. 将公钥内容复制到 GitHub：
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
   登录 GitHub → Settings → SSH and GPG keys → New SSH key → 粘贴公钥。
3. 测试连接：
   ```bash
   ssh -T git@github.com
   ```
4. 修改远程地址为 SSH 格式：
   ```bash
   git remote set-url origin git@github.com:shimoxi123/GeRenBoKe.git
   ```

此后执行 `git push` 就无需输入用户名和密码。

---

## 七、触发自动部署

- **Netlify**：GitHub 推送后，Netlify 会自动拉取最新代码并部署。可在 Netlify 控制台查看构建日志。
- **GitHub Pages**：可在仓库设置 → Pages，将分支指向 `main` 的 `/(root)`，然后访问 `https://shimoxi123.github.io/GeRenBoKe/`。

---

## 八、总结

本文详细介绍了如何使用 Git 将本地 Hexo 博客项目推送到 GitHub，包括初始化、常规推送、冲突解决，以及 SSH Key 配置与自动部署触发。掌握这些操作后，可以让你的博客更新流程更加自动化、高效。祝写作和部署顺利！

---

*欢迎点赞、评论和 Star 支持，并在评论区分享你的使用心得~*


---

> 作者: [石墨烯积木](https://www.san3.cn)  
> URL: https://www.san3.cn/2025/07/12/23/  

