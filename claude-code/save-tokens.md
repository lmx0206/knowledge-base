# Claude Code 节省 Token 策略

> 来源：Anthropic 官方文档，Medium，Reddit，社区实践
> 更新时间：2026年5月

## 为什么节省 Token 很重要？

```
Claude Code 按 token 计费：
  输入：$3-15 / 百万 token（取决于模型）
  输出：$15-75 / 百万 token

一个典型的会话可能消耗 100K-500K token。
如果浪费 50%，每月可能多花 $75-375。
```

> 来源：Medium, "Stop Wasting Tokens: A Developer's Guide to Claude Code Cleanup"


══════════════════════════════════════════════
  策略 1：使用 /compact 压缩上下文
══════════════════════════════════════════════

```bash
# 在会话中定期运行
/compact

# 效果：
# - 压缩对话历史
# - 保留关键信息
# - 释放上下文窗口空间
```

何时使用：
- 对话变长时
- 切换任务前
- 感觉 Claude "忘记"之前的内容时

> 来源：Anthropic 官方文档


══════════════════════════════════════════════
  策略 2：使用 /clear 清空上下文
══════════════════════════════════════════════

```bash
# 完全清空上下文，开始新会话
/clear

# 何时使用：
# - 完成一个独立任务后
# - 上下文已经很混乱时
# - 切换到完全不同的任务时
```

> 来源：Builder.io, "50 Claude Code Tips"


══════════════════════════════════════════════
  策略 3：精简 CLAUDE.md
══════════════════════════════════════════════

```
CLAUDE.md 的每一行都会消耗 token。

600 行的 CLAUDE.md ≈ 10-20K token（每次会话）

优化方法：
1. 保持 50-200 行
2. 只写 Claude 猜不到的信息
3. 详细内容放 docs/ 子目录
4. 定期删除过时规则
```

实测数据：
```
600 行 AGENTS.md → 成功率 45%
拆分后 200 行   → 成功率 72%
```

> 来源：DEV.to, "Harness Engineering Quick Actionable Guide"


══════════════════════════════════════════════
  策略 4：使用 Skills 而非重复说明
══════════════════════════════════════════════

```
不好的做法：
  每次对话都重复解释项目架构

好的做法：
  把架构信息写成 Skill，按需加载

Skills 的优势：
- 只在需要时加载（节省 token）
- 可复用（不用重复写）
- 可维护（一处修改，处处生效）
```

> 来源：Anthropic 官方文档 — Skill authoring best practices


══════════════════════════════════════════════
  策略 5：精确指定文件
══════════════════════════════════════════════

```
不好的做法：
  "帮我优化这个项目"
  → Claude 可能读取大量无关文件

好的做法：
  "帮我优化 src/features/auth/login_viewmodel.dart"
  → Claude 只读取相关文件

技巧：
- 用 @ 文件引用
- 明确指定目录范围
- 分步完成大任务
```

> 来源：Builder.io, "50 Claude Code Tips"


══════════════════════════════════════════════
  策略 6：使用 Plan Mode
══════════════════════════════════════════════

```bash
# 进入计划模式
/plan

# 或按 Shift + Tab

# 效果：
# - Claude 先收集上下文
# - 提出澄清问题
# - 制定计划
# - 确认后再实现
```

为什么节省 token？
- 避免"写了再改"的浪费
- 先对齐理解，再动手
- 减少不必要的探索

> 来源：Codex 官方文档 — Best practices


══════════════════════════════════════════════
  策略 7：使用子代理（Subagents）
══════════════════════════════════════════════

```
主会话的上下文会不断增长。

使用子代理处理独立任务：
- 子代理有独立的上下文窗口
- 完成后只返回摘要
- 不污染主会话的上下文
```

> 来源：Anthropic 官方文档


══════════════════════════════════════════════
  策略 8：避免常见浪费
══════════════════════════════════════════════

```
浪费 1：让 Claude 读取整个项目
  → 明确指定需要读取的文件

浪费 2：重复解释需求
  → 写在 CLAUDE.md 或 Skill 中

浪费 3：不压缩就继续
  → 定期 /compact

浪费 4：长对话不清理
  → 完成一个任务就 /clear

浪费 5：CLAUDE.md 太长
  → 保持 50-200 行

浪费 6：不用 Plan Mode
  → 复杂任务先 /plan
```

> 来源：Medium, "Stop Wasting Tokens"，社区实践


══════════════════════════════════════════════
  Token 使用监控
══════════════════════════════════════════════

```bash
# 查看当前会话的 token 使用量
/cost

# 查看详细统计
/cost --detailed
```

> 来源：Anthropic 官方文档


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Anthropic 官方文档 — Claude Code
    https://docs.anthropic.com/en/docs/claude-code

[2] Medium, "Stop Wasting Tokens: A Developer's Guide to Claude Code Cleanup"
    https://naqeebali-shamsi.medium.com/stop-wasting-tokens-a-developers-guide-to-claude-code-cleanup-de842f6403e5

[3] Builder.io, "50 Claude Code Tips and Best Practices"
    https://www.builder.io/blog/claude-code-tips-best-practices

[4] DEV.to, "Harness Engineering Quick Actionable Guide"
    https://dev.to/truongpx396/harness-engineering-quick-actionable-guide-2b93

[5] LevelUp, "Claude Code Mastery: The 21 Tips That Actually Matter in 2026"
    https://levelup.gitconnected.com/claude-code-mastery-the-21-tips-that-actually-matter-in-2026-5436f50ddbed

[6] Reddit r/ClaudeAI, "I built a tool that saves ~50K tokens per conversation"
    https://www.reddit.com/r/ClaudeAI/comments/1sa2jbz/i_built_a_tool_that_saves_50k_tokens_per_claude/
