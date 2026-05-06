# Ghostty 技巧与进阶用法

> 实用技巧、常见问题和最佳实践

══════════════════════════════════════════════
  推荐配置（针对 mason 的环境）
══════════════════════════════════════════════

以下是针对你的使用场景（macOS + zsh + 开发）推荐的配置：

```bash
# ~/.config/ghostty/config

# ── 字体 ──
font-family = "JetBrains Mono"
font-size = 14
font-thicken = true

# ── 主题 ──
theme = catppuccin-mocha

# ── 窗口 ──
background-opacity = 0.95
window-padding-x = 8
window-padding-y = 4

# ── 滚动 ──
scrollback-limit = 50000
mouse-scroll-multiplier = 1

# ── Quick Terminal ──
quick-terminal-position = top
quick-terminal-size = 0.5

# ── 快捷键 ──
# Shift+Enter 换行
keybind = shift+enter=text:\x1b\r
# Quick Terminal: Cmd + `
keybind = global:cmd+backquote=toggle_quick_terminal
# 搜索功能（workaround）
keybind = ctrl+f=write_scrollback_file:open
```

使用方式：

```bash
# 复制到配置文件
cat > ~/.config/ghostty/config << 'EOF'
[上面的配置内容]
EOF

# 重新加载
Cmd + Shift + ,
```


══════════════════════════════════════════════
  技巧 1：Quick Terminal（强烈推荐）
══════════════════════════════════════════════

Quick Terminal 是 Ghostty 最实用的功能之一：

- 从屏幕顶部滑出，类似 Quake 游戏的控制台
- 全局快捷键，在任何应用中都能呼出
- 状态保持，隐藏后再次打开显示同样的内容

配置：

```bash
keybind = global:cmd+backquote=toggle_quick_terminal
quick-terminal-position = top
quick-terminal-size = 0.5
```

使用：按 Cmd + `（反引号，在 Tab 键上方）呼出/隐藏

注意事项：

- 需要在 macOS 系统偏好设置中授予 Ghostty 辅助功能权限
- 路径：系统偏好设置 → 隐私与安全性 → 辅助功能


══════════════════════════════════════════════
  技巧 2：分屏操作
══════════════════════════════════════════════

分屏是开发时非常实用的功能：

```bash
# 向右分屏：Cmd + D
# 向下分屏：Cmd + Shift + D

# 在分屏间切换：
# Cmd + Option + 方向键

# 调整分屏大小：
# Cmd + Ctrl + 方向键

# 等分所有分屏：
# Cmd + Ctrl + =

# 切换分屏缩放（放大当前分屏）：
# Cmd + Shift + Enter

# 关闭分屏：
# Cmd + W 或 Ctrl + D
```

使用场景：

- 左边写代码，右边运行命令
- 上面看日志，下面调试
- 多个终端同时监控不同服务


══════════════════════════════════════════════
  技巧 3：Shell Integration
══════════════════════════════════════════════

Ghostty 的 Shell Integration 可以让你：

1. 用 Cmd + Up/Down 在命令提示符之间跳转
2. 自动跟踪当前工作目录
3. 在标签页标题显示当前目录

zsh 用户通常自动启用。如果没有生效，确保你的 .zshrc 中没有禁用它。


══════════════════════════════════════════════
  技巧 4：搜索终端输出
══════════════════════════════════════════════

Ghostty 目前不内置搜索功能。替代方案：

方案 A：导出 scrollback 到文件（推荐）

```bash
# 快捷键：Cmd + Shift + J（粘贴路径）
# 快捷键：Cmd + Shift + Option + J（用编辑器打开）

# 或者自定义：
keybind = ctrl+f=write_scrollback_file:open
```

方案 B：使用 tmux 搜索

```bash
# 进入 tmux 复制模式
Ctrl+B 然后 [
# 搜索
Ctrl+S
# 退出
q
```

方案 C：使用 grep 管道

```bash
# 运行命令并搜索输出
your_command | grep "search_term"
```


══════════════════════════════════════════════
  技巧 5：字体和主题切换
══════════════════════════════════════════════

Ghostty 内置了数百个主题，可以随时切换：

```bash
# 查看所有主题
ghostty +list-themes

# 在配置中切换主题
theme = dracula

# 热重载（不用重启）
Cmd + Shift + ,
```

推荐主题（适合开发）：

- catppuccin-mocha — 柔和护眼
- dracula — 经典紫色
- github-dark — GitHub 风格
- gruvbox-dark — 复古暖色
- nord — 冷色调
- tokyonight — 东京夜景


══════════════════════════════════════════════
  技巧 6：与 tmux 配合使用
══════════════════════════════════════════════

虽然 Ghostty 原生支持分屏和标签页，但 tmux 提供了更多功能：

- 会话持久化（断开后可恢复）
- 更强大的窗口管理
- 跨 SSH 会话保持

推荐用法：

- Ghostty 负责：渲染、字体、主题、Quick Terminal
- tmux 负责：会话管理、持久化、远程工作

```bash
# 在 Ghostty 中启动 tmux
tmux new -s work

# 断开（不关闭会话）
Ctrl+B 然后 D

# 重新连接
tmux attach -t work
```


══════════════════════════════════════════════
  技巧 7：全局快捷键
══════════════════════════════════════════════

Ghostty 支持全局快捷键（即使不在前台也生效）：

```bash
# 全局 Quick Terminal
keybind = global:cmd+backquote=toggle_quick_terminal

# 全局新窗口
keybind = global:cmd+shift+n=new_window
```

注意：需要授予辅助功能权限
路径：系统偏好设置 → 隐私与安全性 → 辅助功能 → Ghostty


══════════════════════════════════════════════
  技巧 8：剪贴板增强
══════════════════════════════════════════════

```bash
# 粘贴保护（防止意外粘贴大量内容）
clipboard-paste-protection = true

# 复制 URL 到剪贴板
keybind = ctrl+shift+u=copy_url_to_clipboard

# 复制终端标题到剪贴板
keybind = ctrl+shift+t=copy_title_to_clipboard
```


══════════════════════════════════════════════
  常见问题
══════════════════════════════════════════════

Q: 如何重置终端状态？
A: 运行命令 reset 或者自定义快捷键：
   keybind = cmd+shift+r=reset

Q: 如何查看当前生效的配置？
A: ghostty +show-config

Q: 如何查看默认配置？
A: ghostty +show-config --default

Q: 配置修改后不生效？
A: 按 Cmd + Shift + , 热重载
   部分选项需要重启 Ghostty

Q: Quick Terminal 快捷键不工作？
A: 检查系统偏好设置 → 隐私与安全性 → 辅助功能
   确保 Ghostty 已被授权

Q: 字体显示不正确？
A: ghostty +list-fonts 查看可用字体
   确保字体名称拼写正确

Q: 如何恢复默认配置？
A: 删除 ~/.config/ghostty/config
   Ghostty 会使用内置默认值


══════════════════════════════════════════════
  CLI 命令速查
══════════════════════════════════════════════

```bash
ghostty                        # 启动 Ghostty
ghostty +show-config           # 显示当前配置
ghostty +show-config --default # 显示默认配置
ghostty +show-config --default --docs  # 显示所有配置及文档
ghostty +list-keybinds         # 列出当前快捷键
ghostty +list-keybinds --default  # 列出默认快捷键
ghostty +list-fonts            # 列出可用字体
ghostty +list-themes           # 列出可用主题
ghostty +version               # 显示版本
ghostty +help                  # 显示帮助

## 参考来源

- [Ghostty 官方文档](https://ghostty.org/docs)
- [Ghostty GitHub 仓库](https://github.com/ghostty-org/ghostty)
- [Ghostty 配置参考](https://ghostty.org/docs/config/reference)
```
