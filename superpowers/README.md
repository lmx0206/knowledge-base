# Superpowers：AI 编码 Agent 的技能框架

> 创建时间：2026年5月
> GitHub：https://github.com/obra/superpowers
> 作者：Jesse Vincent（Prime Radiant）
> Stars：176K+（截至 2026年5月，star-history.com 数据）
> 许可证：MIT

## 什么是 Superpowers？

Superpowers 是一个完整的 AI 编码 Agent 软件开发方法论，
由一组可组合的技能（Skills）和初始指令构成，让你的 AI 编码 Agent
从一个"快速打字员"变成一个"有纪律的工程伙伴"。

```
没有 Superpowers 的 Agent：
  你："帮我做个登录功能"
  Agent：[立刻开始写代码，跳过测试，猜架构]

有 Superpowers 的 Agent：
  你："帮我做个登录功能"
  Agent：[先问你几个问题，设计方案，写计划，TDD 实现，代码审查]
```

### 核心理念

```
"把你的 AI Agent 当作一个能力很强但缺乏纪律的初级工程师。
 给它流程护栏，把初级工程师变成高级工程师。"
                                    — Jesse Vincent
```

### 谁创建了它？

Jesse Vincent，连续创业者：

- 1990s：创建 Request Tracker (RT)
- 2005-2008：管理 Perl 6
- 联合创办 Keyboardio（键盘公司）
- 构建 K-9 Mail（后被 Mozilla 收购，成为 Thunderbird for Android）

> 来源：Jesse Vincent 个人博客，GitHub 仓库 README


══════════════════════════════════════════════
  安装方法
══════════════════════════════════════════════

### Claude Code（官方市场）

```bash
# 方法 1：官方市场（推荐）
/plugin install superpowers@claude-plugins-official

# 方法 2：Superpowers 市场
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

### Codex CLI

```bash
# 打开插件搜索界面
/plugins
# 搜索并安装
superpowers
```

### Codex App

```
1. 在 Codex 应用中点击侧边栏的 "Plugins"
2. 在 Coding 分类中找到 Superpowers
3. 点击 + 号安装
```

### Gemini CLI

```bash
# 安装扩展
gemini extensions install https://github.com/obra/superpowers

# 更新
gemini extensions update superpowers
```

### Cursor

```
在 Cursor Agent 聊天中：
/add-plugin superpowers
或在插件市场搜索 "superpowers"
```

### GitHub Copilot CLI

```bash
copilot plugin marketplace add obra/superpowers-marketplace
copilot plugin install superpowers@superpowers-marketplace
```

> 来源：GitHub obra/superpowers README，2026年5月


══════════════════════════════════════════════
  工作流程（The Basic Workflow）
══════════════════════════════════════════════

Superpowers 强制执行一个结构化的开发流程：

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ Brainstorm  │───>│ Write Plan  │───>│ Implement   │
│ 头脑风暴     │    │ 写计划      │    │ 实现        │
└─────────────┘    └─────────────┘    └─────────────┘
      │                  │                  │
      ▼                  ▼                  ▼
  问问题、探索       拆分任务          TDD + 子代理
  设计方案、验证     每个任务          代码审查
  写规格文档         2-5分钟           合并/PR
```

### 阶段 1：Brainstorming（头脑风暴）

触发时机：在写任何代码之前

硬性门槛：

```
"在你提出设计并获得用户批准之前，
 不要调用任何实现技能、写任何代码、搭建任何项目。"
```

Agent 会：

1. 先探索项目上下文（读文件、文档、最近的 commit）
2. 一次问一个澄清问题
3. 提出 2-3 个方案及其权衡
4. 分段展示设计供你审批
5. 写规格文档

只有你批准后，才会进入下一阶段。

> 来源：skills/brainstorming/SKILL.md，Termdock 文章

### 阶段 2：Writing Plans（写计划）

设计审批后，将工作拆分为小任务：

```
每个任务要求：
- 2-5 分钟的工作量
- 精确的文件路径
- 完整的代码上下文
- 验证步骤
- 假设执行者"对你的代码库零上下文，品味存疑"
```

为什么这么严格？因为子代理每次都是全新的上下文，
计划必须详细到一个新 Agent 什么都不知道也能正确完成。

计划强制执行：DRY、YAGNI、TDD。

> 来源：skills/writing-plans/SKILL.md

### 阶段 3：Test-Driven Development（测试驱动开发）

最严格的技能。"铁律"：

```
"没有失败的测试，就没有生产代码。
 在测试之前写了代码？删除它。重新开始。没有例外。"
```

经典 RED-GREEN-REFACTOR 循环：

1. 写一个失败的测试
2. 验证它确实失败了（且失败原因正确）
3. 写最少的代码让测试通过
4. 验证所有测试通过
5. 重构

> 来源：skills/test-driven-development/SKILL.md

### 阶段 4：Subagent-Driven Development（子代理驱动开发）

这是 Superpowers 从"好实践"到"架构创新"的跨越：

```
主 Agent（协调者）
  │
  ├── 子代理 1 → 任务 1 → 代码审查
  ├── 子代理 2 → 任务 2 → 代码审查
  ├── 子代理 3 → 任务 3 → 代码审查
  └── ...
```

每个子代理：

- 从全新上下文开始
- 只接收任务描述和相关上下文
- 不接收完整对话历史（防止上下文污染）

两阶段审查：

1. 规格合规性审查
2. 代码质量审查

结果："Claude 自主工作数小时不偏离计划，这并不罕见。"

> 来源：skills/subagent-driven-development/SKILL.md

### 阶段 5：Code Review（代码审查）

在任务之间触发：

- 派遣独立子代理审查完成的工作
- 审查者获得精确的评估上下文
- 按严重程度报告问题
- 关键问题阻止进度

> 来源：skills/requesting-code-review/SKILL.md

### 阶段 6：Finishing（完成）

任务全部完成后：

- 验证测试
- 提供选项（合并/PR/保留/丢弃）
- 清理工作树


══════════════════════════════════════════════
  技能库（Skills Library）
══════════════════════════════════════════════

### 测试类

- test-driven-development — RED-GREEN-REFACTOR 循环

### 调试类

- systematic-debugging — 4 阶段根因分析
- verification-before-completion — 确认问题真的修复了

### 协作类

- brainstorming — 苏格拉底式设计精炼
- writing-plans — 详细实施计划
- executing-plans — 批量执行 + 人工检查点
- dispatching-parallel-agents — 并行子代理
- requesting-code-review — 提交前检查清单
- receiving-code-review — 响应反馈（不带防御心理）
- using-git-worktrees — 并行开发分支
- finishing-a-development-branch — 合并/PR 决策
- subagent-driven-development — 快速迭代 + 两阶段审查

### 元技能

- writing-skills — 创建新技能的最佳实践
- using-superpowers — 技能系统介绍

> 来源：GitHub obra/superpowers，skills/ 目录


══════════════════════════════════════════════
  设计哲学
══════════════════════════════════════════════

```
1. 测试驱动开发 — 先写测试，永远
2. 系统化优于临时方案 — 流程优于猜测
3. 降低复杂度 — 简单是首要目标
4. 证据优于声明 — 验证后再宣布成功
```

### 刚性 vs 柔性

```
刚性技能（有铁律）：
  TDD、调试 — 不能跳过，跳过会有复合后果

柔性技能（有指导）：
  头脑风暴 — 结构化但自适应
  代码审查 — 报告发现，人工决定

每个技能都解释"为什么"：
  "为什么测试必须先失败再通过"
  "为什么根因比症状重要"
  "为什么新鲜上下文防止漂移"
```

> 来源：Termdock 文章 "Superpowers: Skills Framework Reshaping AI Dev"


══════════════════════════════════════════════
  实际效果
══════════════════════════════════════════════

### chardet 项目案例

使用 Superpowers 开发 chardet 7.0.0：

- 速度提升 41 倍
- 准确率 96.8%
- 修复了数十个长期问题
- 测试套件覆盖 2,161 个文件、99 种编码

> 来源：Termdock 文章引用

### 自动触发

安装后，技能自动触发，无需手动调用：

```
开始新任务 → 自动触发 brainstorming
批准设计 → 自动触发 writing-plans
开始实现 → 自动触发 TDD
遇到 bug → 自动触发 systematic-debugging
任务完成 → 自动触发 code review
```

也可以手动调用：
"Use the brainstorming skill to help me think through this."


══════════════════════════════════════════════
  验证安装成功
══════════════════════════════════════════════

```
1. 开始新的 Claude Code 会话
2. 说 "帮我做个登录功能"
3. 如果安装成功，Agent 会：
   - 宣布它正在使用哪个技能
   - 先问问题而不是直接写代码
   - 遵循结构化流程
```


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] obra/superpowers GitHub 仓库
    https://github.com/obra/superpowers
    MIT License，179K+ stars（2026年5月）

[2] Jesse Vincent, "Superpowers: How I'm using coding agents in October 2025"
    https://blog.fsck.com/2025/10/09/superpowers/

[3] Termdock, "Superpowers: Skills Framework Reshaping AI Dev"
    https://www.termdock.com/en/blog/superpowers-framework-agent-skills
    2026年3月

[4] Marc Nuri, "The Claude Code Skills Framework Shipped as Markdown"
    https://blog.marcnuri.com/superpowers-claude-code-skills-framework

[5] Medium, "Superpowers explained: the popular Claude plugin that enforces TDD"
    https://blog.devgenius.io/superpowers-explained-the-claude-plugin-that-enforces-tdd-subagents-and-planning-c7fe698c3b82

[6] Medium, "Superpowers: Workflow For Coding Agents"
    https://hasamba.medium.com/superpowers-workflow-for-coding-agents-040738ae33db

[7] Reddit r/BuildToShip, "How to give Claude Code Superpowers"
    https://www.reddit.com/r/BuildToShip/comments/1smg9zd/how_to_give_claude_code_superpowers/
