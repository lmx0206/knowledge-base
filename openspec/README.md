# OpenSpec：AI 编码的规格驱动开发框架

> 创建时间：2026年5月
> GitHub：https://github.com/Fission-AI/OpenSpec
> 作者：Fission AI（YC W26）
> Stars：45.3K+（截至 2026年5月）
> 许可证：MIT
> 官网：https://openspec.dev

## 什么是 OpenSpec？

OpenSpec 是一个规格驱动开发（Spec-Driven Development, SDD）框架，
让你在写代码之前先和 AI 对齐"要做什么"。

```
传统方式（Vibe Coding）：
  你："帮我做个暗黑模式"
  AI：[直接开始写代码，可能理解错了你的意思]

OpenSpec 方式（SDD）：
  你：/opsx:propose add-dark-mode
  AI：[生成 proposal.md、specs/、design.md、tasks.md]
  你：审批
  AI：[按规格实现]
```

### 核心理念

```
"AI 编码助手很强大，但当需求只存在于聊天历史中时，
 它们就变得不可预测。OpenSpec 添加了一个轻量级的规格层，
 让你在写任何代码之前先达成一致。"
                                    — OpenSpec 官方
```

### 为什么需要 OpenSpec？

```
没有 OpenSpec：
  - 需求在聊天历史中，AI 记不住
  - AI 猜你要什么，猜错了你才发现
  - 每次新会话都要重新解释

有 OpenSpec：
  - 需求在文件中，AI 每次都能看到
  - 先对齐规格，再写代码
  - 有组织、可追踪、可迭代
```

> 来源：GitHub Fission-AI/OpenSpec README


══════════════════════════════════════════════
  安装方法
══════════════════════════════════════════════

### 前提条件

- Node.js 20.19.0 或更高版本

### 安装步骤

```bash
# 1. 全局安装
npm install -g @fission-ai/openspec@latest

# 2. 进入项目目录并初始化
cd your-project
openspec init

# 3. 更新 Agent 指令（在每个项目中运行）
openspec update
```

### 更新

```bash
npm install -g @fission-ai/openspec@latest
openspec update
```

### 支持的工具

OpenSpec 支持 25+ 个 AI 工具：

- Claude Code
- Codex CLI / Codex App
- Gemini CLI
- Cursor
- GitHub Copilot
- VS Code
- 以及更多

> 来源：GitHub README，docs/getting-started.md


══════════════════════════════════════════════
  核心工作流（3 步）
══════════════════════════════════════════════

### 步骤 1：Propose（提议）

告诉 AI 你想做什么：

```bash
/opsx:propose add-dark-mode
```

AI 会生成：

```
openspec/changes/add-dark-mode/
├── proposal.md    ← 为什么做、改什么
├── specs/         ← 需求和场景
├── design.md      ← 技术方案
└── tasks.md       ← 实现清单
```

你审批这些文档。

### 步骤 2：Apply（执行）

```bash
/opsx:apply
```

AI 按照 tasks.md 中的清单逐项实现：

```
✓ 1.1 Add theme context provider
✓ 1.2 Create toggle component
✓ 2.1 Add CSS variables
✓ 2.2 Wire up localStorage
All tasks complete!
```

### 步骤 3：Archive（归档）

```bash
/opsx:archive
```

完成的变更归档：

```
openspec/changes/archive/2025-01-23-add-dark-mode/
```

规格更新，准备下一个功能。

> 来源：GitHub README


══════════════════════════════════════════════
  扩展工作流
══════════════════════════════════════════════

如果你需要更细粒度的控制：

```bash
/opsx:new          # 创建新变更
/opsx:continue     # 继续未完成的变更
/opsx:ff           # 快进（跳过某些步骤）
/opsx:verify       # 验证实现
/opsx:bulk-archive # 批量归档
/opsx:onboard      # 项目入门
```

选择扩展配置：

```bash
openspec config profile
openspec update
```

> 来源：GitHub README


══════════════════════════════════════════════
  与其他工具对比
══════════════════════════════════════════════

```
vs. Spec Kit (GitHub)
  - Spec Kit 更重，有严格的阶段门禁
  - OpenSpec 更轻，允许自由迭代

vs. Kiro (AWS)
  - Kiro 功能强但锁定在他们的 IDE 中
  - OpenSpec 可以和你已有的工具配合

vs. 没有规格
  - 没有规格 = 模糊的 prompt + 不可预测的结果
  - OpenSpec 带来可预测性，没有额外负担
```

> 来源：GitHub README


══════════════════════════════════════════════
  最佳实践
══════════════════════════════════════════════

```
1. 模型选择
   OpenSpec 在高推理能力模型上效果最好。
   推荐：Opus 4.5、GPT 5.2

2. 上下文卫生
   开始实现前清空上下文窗口。
   在整个会话中保持良好的上下文卫生。

3. 先审批再实现
   不要跳过 proposal 阶段。
   花 5 分钟审批规格，节省 50 分钟返工。

4. 保持规格更新
   代码变更后更新规格文档。
   规格是活的文档，不是一次性产物。
```

> 来源：GitHub README，Medium 文章


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Fission-AI/OpenSpec GitHub 仓库
    https://github.com/Fission-AI/OpenSpec
    MIT License，45.3K+ stars（2026年5月）

[2] OpenSpec 官方文档
    https://openspec.dev

[3] Y Combinator, "OpenSpec: The Spec Framework for Coding Agents"
    https://www.ycombinator.com/launches/Pdc-openspec-the-spec-framework-for-coding-agents

[4] GitHub Blog, "Spec-driven development with AI"
    https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/

[5] DEV.to, "How to make AI follow your instructions more for free (OpenSpec)"
    https://dev.to/webdeveloperhyper/how-to-make-ai-follow-your-instructions-more-for-free-openspec-2c85

[6] YouTube, "Getting Started with OpenSpec | Spec Driven Development"
    https://www.youtube.com/watch?v=raPTOBUpc3M

[7] YouTube, "OpenSpec Changes Everything - No More Vibe Coding"
    https://www.youtube.com/watch?v=5oUmpdpbejk
