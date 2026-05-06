# Claude Code Hooks 自动化

> 来源：Anthropic 官方文档 (code.claude.com/docs/en/hooks)
> Pixelmojo "Claude Code Hooks: All 12 Events"
> claudefast "Claude Code Hooks: Complete Guide"
> 更新时间：2026年5月
> 验证状态：已核查

## 什么是 Hooks？

Hooks 是在 Claude Code 特定操作前后自动执行的命令。
类似于 Git Hooks，但是针对 AI Agent 的操作。

```
文件写入前 → 自动运行 lint
文件写入后 → 自动运行类型检查
提交前 → 自动运行测试
```

## 配置位置

```json
// .claude/settings.json 或 .claude/settings.local.json
{
  "hooks": {
    "PreToolUse": [...],
    "PostToolUse": [...]
  }
}
```

> 来源：Anthropic 官方文档


══════════════════════════════════════════════
  全部 12 个 Hook 事件
══════════════════════════════════════════════

Claude Code 支持 12 个生命周期 Hook 事件：

```
事件名称              触发时机                    可阻止？
─────────────────── ─────────────────────────── ────────
UserPromptSubmit     用户提交消息时              YES
PreToolUse           工具执行前                  YES
PostToolUse          工具执行后                  YES
PostToolUseFailure   工具执行失败后              YES
PermissionRequest    权限请求对话框出现时        YES
PermissionDenied     权限被拒绝时                NO
Notification         通知发送时                  NO
Stop                 Agent 停止前                YES
SubagentStop         子代理停止前                YES
PreCompact           上下文压缩前                YES
SessionStart         会话开始时                  NO
SessionEnd           会话结束时                  NO
```

> 来源：claudefast.com, "Claude Code Hooks: Complete Guide to All 12 Lifecycle Events"
> GitHub disler/claude-code-hooks-mastery


══════════════════════════════════════════════
  最常用的 Hook 事件
══════════════════════════════════════════════

### PreToolUse — 工具执行前

在 Claude 执行任何工具（Bash、Edit、Write 等）之前触发。
可以允许、阻止或修改操作。

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "write|edit",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'About to modify a file'"
          }
        ]
      }
    ]
  }
}
```

### PostToolUse — 工具执行后

在工具执行后触发。可以提供反馈给 Claude。

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "write|edit",
        "hooks": [
          {
            "type": "command",
            "command": "dart analyze --no-fatal-infos"
          }
        ]
      }
    ]
  }
}
```

### Stop — Agent 停止前

在 Agent 准备停止响应之前触发。
可以强制执行最终检查。

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "flutter test"
          }
        ]
      }
    ]
  }
}
```

### SessionStart — 会话开始时

在新会话开始时触发。可以设置环境。

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Welcome back!'"
          }
        ]
      }
    ]
  }
}
```

> 来源：Anthropic 官方文档 (code.claude.com/docs/en/hooks)


══════════════════════════════════════════════
  实用 Hook 示例
══════════════════════════════════════════════

### 自动 lint（文件修改后）

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "write|edit",
        "hooks": [
          {
            "type": "command",
            "command": "dart analyze --no-fatal-infos"
          }
        ]
      }
    ]
  }
}
```

效果：每次 Claude 写完文件 → 自动运行 dart analyze → 发现问题立即修复。

### 自动测试（Agent 停止前）

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "flutter test && dart analyze"
          }
        ]
      }
    ]
  }
}
```

### 自动格式化（文件修改后）

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "write|edit",
        "hooks": [
          {
            "type": "command",
            "command": "dart format ."
          }
        ]
      }
    ]
  }
}
```

### 阻止危险命令

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "bash",
        "hooks": [
          {
            "type": "command",
            "command": "check_dangerous_command.sh"
          }
        ]
      }
    ]
  }
}
```

> 来源：Pixelmojo, "Claude Code Hooks: All 12 Events with Examples"


══════════════════════════════════════════════
  Hook 匹配器
══════════════════════════════════════════════

```
matcher 值：
  write      — 文件写入操作
  edit       — 文件编辑操作
  write|edit — 文件写入或编辑
  bash       — Shell 命令执行
  *          — 所有操作
```

> 来源：Anthropic 官方文档


══════════════════════════════════════════════
  最佳实践
══════════════════════════════════════════════

```
1. 保持 Hook 快速
   Hook 会阻塞 Agent 的工作流。
   超过 10 秒的 Hook 会严重影响体验。

2. 只在必要时使用
   不是所有检查都需要 Hook。
   简单的规则放在 CLAUDE.md 中。

3. 错误处理
   Hook 返回非零退出码会阻止操作。
   确保 Hook 足够健壮。

4. 测试 Hook
   先手动运行命令确认正常，
   再配置为 Hook。

5. 使用 matcher 精确匹配
   不要用 * 匹配所有操作，
   只匹配需要的操作类型。

6. 共享配置
   将 .claude/settings.json 提交到 git，
   团队共享 Hooks 配置。
```

> 来源：Anthropic 官方文档，AY Automate "10 Best Claude Code Hooks"


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Anthropic 官方文档 — Hooks Reference
    https://code.claude.com/docs/en/hooks

[2] Pixelmojo, "Claude Code Hooks: All 12 Events with Examples (2026)"
    https://www.pixelmojo.io/blogs/claude-code-hooks-production-quality-ci-cd-patterns

[3] claudefast, "Claude Code Hooks: Complete Guide to All 12 Lifecycle Events"
    https://claudefa.st/blog/tools/hooks/hooks-guide

[4] AY Automate, "10 Best Claude Code Hooks to Add in 2026"
    https://www.ayautomate.com/blog/best-claude-code-hooks

[5] GitHub disler/claude-code-hooks-mastery
    https://github.com/disler/claude-code-hooks-mastery

[6] Sakasegawa, "Harness Engineering Best Practices for Claude Code / Codex Users"
    https://nyosegawa.com/en/posts/harness-engineering-best-practices-2026/
