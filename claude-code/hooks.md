# Claude Code Hooks 自动化

> 来源：Anthropic 官方文档，Sakasegawa 博客

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
    "PostToolUse": [...],
    "PreCommit": [...]
  }
}
```

## Hook 类型

### PreToolUse
在工具执行前触发。

### PostToolUse
在工具执行后触发。

### PreCommit
在 git commit 前触发。

> 来源：Anthropic 官方文档


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

### 自动测试（提交前）

```json
{
  "hooks": {
    "PreCommit": [
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

> 来源：Sakasegawa, "Harness Engineering Best Practices for Claude Code / Codex Users"


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
```

> 来源：Anthropic 官方文档，社区实践


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Anthropic 官方文档 — Hooks
    https://docs.anthropic.com/en/docs/claude-code/hooks

[2] Sakasegawa, "Harness Engineering Best Practices for Claude Code / Codex Users"
    https://nyosegawa.com/en/posts/harness-engineering-best-practices-2026/

[3] Martin Fowler, "Harness engineering for coding agent users"
    https://martinfowler.com/articles/harness-engineering.html
