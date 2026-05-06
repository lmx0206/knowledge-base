# Codex Hooks 与自动化

> 来源：OpenAI 官方文档
> 更新时间：2026年5月

## 什么是 Hooks？

Hooks 是在 Codex 特定操作前后自动执行的命令。
类似于 Git Hooks，但针对 AI Agent 的操作。

```
Agent 完成一轮 → 自动运行通知
Agent 修改文件 → 自动运行 lint
Agent 执行命令 → 自动验证安全性
```


══════════════════════════════════════════════
  Codex 的 Hook 系统
══════════════════════════════════════════════

### 通知 Hook

Codex 支持在 Agent 完成一轮工作后自动执行通知脚本：

```toml
# ~/.codex/config.toml

[notify]
command = "terminal-notifier"
args = ["-title", "Codex", "-message", "Turn completed!"]
```

### macOS 桌面通知

```bash
# 安装 terminal-notifier
brew install terminal-notifier

# 配置
[notify]
command = "terminal-notifier"
args = ["-title", "Codex", "-message", "Task completed", "-sound", "default"]
```

### WSL2 自动 Toast 通知

当 Codex 检测到在 WSL2 的 Windows Terminal 中运行时（WT_SESSION 环境变量），
自动回退到 Windows 原生 Toast 通知，无需额外配置。

### 自定义通知脚本

```bash
#!/bin/bash
# notify.sh

# 桌面通知
notify-send "Codex" "Turn completed"

# 写日志
echo "$(date): Turn completed" >> ~/.codex/turns.log

# 发送到 Slack（可选）
# curl -X POST -H 'Content-type: application/json' \
#   --data '{"text":"Codex turn completed"}' \
#   $SLACK_WEBHOOK_URL
```

```toml
# ~/.codex/config.toml
[notify]
command = "bash"
args = ["~/.codex/notify.sh"]
```


══════════════════════════════════════════════
  沙箱与安全控制
══════════════════════════════════════════════

Codex 的沙箱系统是一种"前馈控制"Hook，
在命令执行前自动检查安全性：

```
Agent 想执行 rm -rf /
  ↓ 沙箱拦截
  ↓ read-only 模式：阻止
  ↓ workspace-write 模式：阻止（不在工作目录内）
  ↓ danger-full-access 模式：允许（你已接受风险）
```

### 测试沙箱行为

```bash
# 测试命令在沙箱中的行为
codex sandbox macos --log-denials "rm -rf /"
codex sandbox linux "rm -rf /"
```


══════════════════════════════════════════════
  与 Claude Code Hooks 对比
══════════════════════════════════════════════

```
┌─────────────────┬──────────────────┬──────────────────┐
│ 特性             │ Codex            │ Claude Code      │
├─────────────────┼──────────────────┼──────────────────┤
│ 通知 Hook       │ ✅ 完成后通知    │ ✅ 12 种事件     │
│ 文件操作 Hook    │ ❌（通过沙箱）   │ ✅ PreToolUse    │
│ 命令执行 Hook    │ ❌（通过沙箱）   │ ✅ PostToolUse   │
│ 会话生命周期     │ ❌               │ ✅ SessionStart  │
│ 自定义脚本       │ ✅ notify 配置   │ ✅ settings.json │
│ 沙箱安全        │ ✅ 内置          │ ❌ 无            │
│ 匹配器          │ ❌               │ ✅ 正则匹配      │
└─────────────────┴──────────────────┴──────────────────┘

总结：
  - Codex 的安全控制主要通过沙箱实现（更底层）
  - Claude Code 的 Hook 系统更灵活（12 种事件）
  - 两者可以互补使用
```


══════════════════════════════════════════════
  CI/CD 集成
══════════════════════════════════════════════

使用 codex exec 实现自动化：

```yaml
# GitHub Actions 示例
name: AI Code Review
on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm install -g @openai/codex
      - run: |
          codex exec --ephemeral "Review this PR and list potential issues" \
            --sandbox read-only
        env:
          OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
```


══════════════════════════════════════════════
  最佳实践
══════════════════════════════════════════════

```
1. 生产环境始终使用 read-only 沙箱
2. 开发环境使用 workspace-write
3. 仅在容器中使用 danger-full-access
4. 配置通知 Hook 跟踪 Agent 工作进度
5. 用 codex exec --ephemeral 做一次性任务
6. 用 codex sandbox 测试命令安全性
7. 在 CI/CD 中使用 read-only + exec 模式
```


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] OpenAI Codex 官方文档
    https://developers.openai.com/codex

[2] Codex CLI GitHub — 配置文档
    https://github.com/openai/codex/blob/main/docs/config.md

[3] terminal-notifier GitHub
    https://github.com/julienXX/terminal-notifier
