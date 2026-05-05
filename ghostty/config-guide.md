# Ghostty 配置文件详解

> 配置文件路径：~/.config/ghostty/config
> 官方参考：https://ghostty.org/docs/config/reference

## 配置文件位置

```
macOS:   ~/.config/ghostty/config
Linux:   ~/.config/ghostty/config
```

查看所有配置选项及默认值：
```bash
ghostty +show-config --default --docs
```

查看当前生效的配置：
```bash
ghostty +show-config
```

查看默认快捷键：
```bash
ghostty +list-keybinds --default
```

查看可用字体：
```bash
ghostty +list-fonts
```

查看可用主题：
```bash
ghostty +list-themes
```

## mason 的当前配置

```bash
# 你的配置文件：~/.config/ghostty/config
font-family = "JetBrains Mono"
font-size = 14
scrollback-limit = 50000
mouse-scroll-multiplier = 1
keybind = shift+enter=text:\x1b\r
```

这是一个简洁的配置，下面我来介绍更多实用选项。


══════════════════════════════════════════════
  字体配置
══════════════════════════════════════════════

```bash
# 主字体
font-family = "JetBrains Mono"

# 粗体字体（可选，不设置则自动合成）
font-family-bold = "JetBrains Mono Bold"

# 斜体字体（可选）
font-family-italic = "JetBrains Mono Italic"

# 字体大小（点数，支持小数）
font-size = 14

# 字体加粗（macOS 独有）
font-thicken = true

# 字体特性（禁用编程连字）
font-feature = -calt

# 可变字体轴设置
font-variation = wght=400
```

查看可用字体：
```bash
ghostty +list-fonts
```


══════════════════════════════════════════════
  主题配置
══════════════════════════════════════════════

```bash
# 设置主题
theme = catppuccin-mocha

# 亮色模式主题（macOS 自动切换）
light-theme = catppuccin-latte

# 暗色模式主题
dark-theme = catppuccin-mocha
```

查看所有内置主题：
```bash
ghostty +list-themes
```

热门主题推荐：
- catppuccin-mocha — 柔和的暗色主题
- dracula — 经典紫色暗色主题
- github-dark — GitHub 暗色风格
- gruvbox-dark — 复古暖色暗色主题
- kanagawa-dragon — 日式暗色主题
- nord — 北欧冷色调主题
- rose-pine — 柔和粉色主题
- tokyonight — 东京夜景风格


══════════════════════════════════════════════
  窗口配置
══════════════════════════════════════════════

```bash
# 窗口初始大小（列x行）
window-size = 120x40

# 窗口内边距
window-padding-x = 8
window-padding-y = 8

# 背景透明度（0.0-1.0）
background-opacity = 0.95

# 背景模糊（macOS）
background-blur-radius = 20

# 窗口装饰（标题栏等）
window-decoration = true

# 窗口主题（system/light/dark）
window-theme = system

# 窗口颜色空间
alpha-blending = native
```


══════════════════════════════════════════════
  光标配置
══════════════════════════════════════════════

```bash
# 光标样式（block/bar/underline）
cursor-style = block

# 光标闪烁（true/false）
cursor-style-blink = true

# 光标颜色（不设置则使用主题颜色）
# cursor-color = #ffffff

# 光标文本颜色
# cursor-text-color = #000000
```


══════════════════════════════════════════════
  滚动配置
══════════════════════════════════════════════

```bash
# 滚动历史行数
scrollback-limit = 50000

# 鼠标滚动速度倍率
mouse-scroll-multiplier = 1
```


══════════════════════════════════════════════
  Shell Integration
══════════════════════════════════════════════

Ghostty 支持 Shell Integration，可以启用更多功能：

```bash
# 启用 shell integration（默认自动检测）
shell-integration = zsh

# Shell integration 的特征
# - 提示符标记（用于 Cmd+Up/Down 跳转）
# - 当前工作目录跟踪
# - 命令执行状态跟踪
```

zsh 用户通常自动生效，无需额外配置。


══════════════════════════════════════════════
  鼠标配置
══════════════════════════════════════════════

```bash
# 鼠标滚动倍率
mouse-scroll-multiplier = 1

# 点击聚焦
mouse-focus-follows-click = false

# 隐藏鼠标（输入时）
mouse-hide-while-typing = true
```


══════════════════════════════════════════════
  Quick Terminal 配置
══════════════════════════════════════════════

```bash
# Quick Terminal 位置（top/bottom/left/right）
quick-terminal-position = top

# Quick Terminal 屏幕（main/cursor/mouse/...）
quick-terminal-screen = main

# Quick Terminal 大小（0.0-1.0，屏幕比例）
quick-terminal-size = 0.5

# Quick Terminal 动画持续时间（秒）
quick-terminal-animation-duration = 0.2

# 自动隐藏（失去焦点时）
quick-terminal-autohide = true
```


══════════════════════════════════════════════
  高级配置
══════════════════════════════════════════════

```bash
# 不发送报告崩溃信息
auto-update = off

# 确认关闭
confirm-close-surface = true

# 剪贴板保护
clipboard-paste-protection = true

# 剪贴板读取（需程序请求）
clipboard-read = ask

# 剪贴板写入
clipboard-write = ask

# URL 检测
link-url = true
```


══════════════════════════════════════════════
  配置热重载
══════════════════════════════════════════════

Ghostty 支持配置热重载，修改配置文件后：

```
方法 1：快捷键 Cmd + Shift + ,
方法 2：菜单 Ghostty → Reload Configuration
方法 3：命令 ghostty +reload-config
```

注意：部分配置（如 window-decoration）需要重启才能生效。
