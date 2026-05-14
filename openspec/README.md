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
→ fluid not rigid（流动而非僵化）
→ iterative not waterfall（迭代而非瀑布）
→ easy not complex（简单而非复杂）
→ built for brownfield not just greenfield（新旧项目都适用）
→ scalable from personal projects to enterprises（个人到企业都可扩展）
```

> 来源：GitHub Fission-AI/OpenSpec README


══════════════════════════════════════════════
  安装方法
══════════════════════════════════════════════

### 前提条件

- Node.js 20.19.0 或更高版本
- 支持 npm、pnpm、yarn、bun、nix

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

### 支持的工具（25+）

| 工具 | 命令语法 |
|------|---------|
| Claude Code | `/opsx:propose`、`/opsx:apply` |
| Cursor | `/opsx-propose`、`/opsx-apply` |
| Windsurf | `/opsx-propose`、`/opsx-apply` |
| Copilot (IDE) | `/opsx-propose`、`/opsx-apply` |
| Gemini CLI | 支持 |
| Codex CLI / Codex App | 支持 |
| VS Code | 支持 |
| Kimi CLI | `/skill:openspec-propose`、`/skill:openspec-apply-change` |
| Trae | `/openspec-propose`、`/openspec:apply-change` |

> 来源：GitHub README，docs/supported-tools.md


══════════════════════════════════════════════
  Profile 系统（重要）
══════════════════════════════════════════════

OpenSpec 有两套命令集，通过 Profile 切换：

### 默认 Profile（core）

安装后默认只有 5 个命令：

| 命令 | 用途 |
|------|------|
| `/opsx:propose` | 创建变更 + 一次性生成所有规划文档 |
| `/opsx:explore` | 探索想法、调研问题、澄清需求（不创建文档） |
| `/opsx:apply` | 按 tasks.md 执行实现 |
| `/opsx:sync` | 合并 delta specs 到主 specs（archive 会自动调用） |
| `/opsx:archive` | 归档已完成的变更 |

### 扩展 Profile（workflows）

需要手动开启，多出 6 个命令：

```bash
openspec config profile    # 交互式选择 workflows
openspec update            # 重新生成 Agent 指令
```

开启后新增命令：

| 命令 | 用途 |
|------|------|
| `/opsx:new` | 创建变更骨架（只建目录 + .openspec.yaml） |
| `/opsx:continue` | 逐个创建下一个 artifact（基于依赖图） |
| `/opsx:ff` | 快进，一次性创建所有规划文档 |
| `/opsx:verify` | 验证实现是否匹配文档（三维度检查） |
| `/opsx:bulk-archive` | 批量归档多个变更 |
| `/opsx:onboard` | 新手引导教程（15-30 分钟） |

> 来源：GitHub docs/commands.md


══════════════════════════════════════════════
  命令详解
══════════════════════════════════════════════

### `/opsx:propose` — 创建变更（core 默认）

```text
/opsx:propose [change-name-or-description]
```

- 创建 `openspec/changes/<change-name>/`
- 一次性生成 proposal.md、specs/、design.md、tasks.md
- 停在准备好 `/opsx:apply` 的状态

```
You: /opsx:propose add-dark-mode
AI:  Created openspec/changes/add-dark-mode/
     ✓ proposal.md — why we're doing this, what's changing
     ✓ specs/       — requirements and scenarios
     ✓ design.md    — technical approach
     ✓ tasks.md     — implementation checklist
     Ready for implementation!
```

### `/opsx:explore` — 探索与调研（core）

```text
/opsx:explore [topic]
```

- 开放式对话，不创建任何 artifact
- 可以调研代码库、比较方案、画图
- 准备好后转入 `/opsx:propose` 或 `/opsx:new`

### `/opsx:apply` — 执行实现（core）

```text
/opsx:apply [change-name]
```

- 读取 tasks.md，逐项实现
- 写代码、创建文件、运行测试
- 每完成一项标记 `[x]`
- **中断后可恢复**：进度保存在 tasks.md 的 checkbox 中
- **没有暂停命令**：直接关闭会话即可，下次 `/opsx:apply` 自动从断点继续

```
You: /opsx:apply
AI:  Implementing tasks...
     ✓ 1.1 Add theme context provider
     ✓ 1.2 Create toggle component
     ...
     All tasks complete!
```

### `/opsx:sync` — 同步规格（core）

```text
/opsx:sync [change-name]
```

- 将变更中的 delta specs 合并到主 `openspec/specs/` 目录
- 智能合并：追加场景到已有需求，不重复
- archive 会自动提示是否需要 sync，通常不需要手动调用

### `/opsx:archive` — 归档（core）

```text
/opsx:archive [change-name]
```

- 检查 artifact 完成状态
- 检查任务完成情况（未完成会警告，但不阻止）
- 提示同步 delta specs（如未同步）
- 移动到 `openspec/changes/archive/YYYY-MM-DD-<name>/`

### `/opsx:new` — 创建变更骨架（扩展）

```text
/opsx:new [change-name] [--schema <schema-name>]
```

- 只创建目录和 `.openspec.yaml` 元数据
- 用 `/opsx:continue` 或 `/opsx:ff` 后续生成文档
- 适合需要逐步控制的复杂变更

### `/opsx:continue` — 逐个创建文档（扩展）

```text
/opsx:continue [change-name]
```

- 查询 artifact 依赖图
- 创建第一个就绪的 artifact
- 每次只创建一个，适合需要审查的场景

```
You: /opsx:continue
AI:  Change: add-dark-mode
     Artifact status:
     ✓ proposal    (done)
     ◆ specs       (ready)
     ◆ design      (ready)
     ○ tasks       (blocked - needs: specs)
     Creating specs...
     ✓ Created specs/ui/spec.md
     Now available: tasks
```

### `/opsx:ff` — 快进（扩展）

```text
/opsx:ff [change-name]
```

- 一次性按依赖顺序创建所有规划文档
- 比 `/opsx:continue` 更快，适合清晰的小中型功能

### `/opsx:verify` — 验证实现（扩展）

```text
/opsx:verify [change-name]
```

验证三个维度：

| 维度 | 验证内容 |
|------|---------|
| **Completeness** | 所有任务完成、需求覆盖、场景覆盖 |
| **Correctness** | 实现匹配 spec 意图、边界情况处理 |
| **Coherence** | 设计决策在代码中体现、模式一致 |

输出级别：CRITICAL / WARNING / SUGGESTION
**不阻止归档**，但暴露问题。

```
You: /opsx:verify
AI:  Verifying add-dark-mode...
     COMPLETENESS
     ✓ All 8 tasks in tasks.md are checked
     ✓ All requirements in specs have corresponding code
     ⚠ Scenario "System preference detection" has no test coverage
     CORRECTNESS
     ✓ Implementation matches spec intent
     ✓ Edge cases from scenarios are handled
     COHERENCE
     ✓ Design decisions reflected in code structure
     ⚠ Design mentions "CSS variables" but uses Tailwind classes
     SUMMARY
     Critical issues: 0
     Warnings: 2
     Ready to archive: Yes (with warnings)
```

### `/opsx:bulk-archive` — 批量归档（扩展）

```text
/opsx:bulk-archive [change-names...]
```

- 列出所有已完成的变更
- 检测 spec 冲突，按时间顺序归档
- 冲突解决：检查代码库实际实现

### `/opsx:onboard` — 新手引导（扩展）

```text
/opsx:onboard
```

- 交互式教程，使用你的真实代码库
- 走完完整工作流：探索 → propose → specs → design → tasks → apply → verify → archive
- 耗时 15-30 分钟


══════════════════════════════════════════════
  暂停与继续
══════════════════════════════════════════════

OpenSpec **没有暂停命令**。

- 进度保存在 `tasks.md` 的 checkbox 中（`[x]` = 已完成）
- 直接关闭会话 = "暂停"
- 下次会话 `/opsx:apply` 自动从最后一个未勾选的 task 继续
- 不需要任何恢复或 resume 操作


══════════════════════════════════════════════
  典型工作流
══════════════════════════════════════════════

### 最简流程（core profile）

```bash
/opsx:propose add-feature    # 1. 创建变更 + 生成文档
# 审批 proposal/specs/design/tasks
/opsx:apply                  # 2. 执行实现
/opsx:archive                # 3. 归档
```

### 逐步控制流程（扩展 profile）

```bash
/opsx:new add-feature        # 1. 创建骨架
/opsx:continue               # 2. 逐个生成文档，每个都审查
/opsx:continue               #    ...直到所有文档就绪
/opsx:apply                  # 3. 执行实现
/opsx:verify                 # 4. 验证（三维度）
/opsx:archive                # 5. 归档
```

### 快速流程（扩展 profile）

```bash
/opsx:new add-feature        # 1. 创建骨架
/opsx:ff                     # 2. 快进生成所有文档
/opsx:apply                  # 3. 执行实现
/opsx:verify                 # 4. 验证
/opsx:archive                # 5. 归档
```

### 探索流程（需求不明确时）

```bash
/opsx:explore 如何实现移动端认证？   # 1. 调研讨论
/opsx:propose add-jwt-auth          # 2. 确定方向后创建变更
/opsx:apply                         # 3. 执行
/opsx:archive                       # 4. 归档
```


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

1. **模型选择** — OpenSpec 在高推理能力模型上效果最好。推荐：Opus 4.5、GPT 5.2

2. **上下文卫生** — 开始实现前清空上下文窗口。在整个会话中保持良好的上下文卫生。

3. **先审批再实现** — 不要跳过 proposal 阶段。花 5 分钟审批规格，节省 50 分钟返工。

4. **保持规格更新** — 代码变更后更新规格文档。规格是活的文档，不是一次性产物。

> 来源：GitHub README


══════════════════════════════════════════════
  故障排查
══════════════════════════════════════════════

| 问题 | 解决方案 |
|------|---------|
| "Change not found" | 指定变更名：`/opsx:apply add-dark-mode`；检查目录是否存在 |
| "No artifacts ready" | 运行 `openspec status --change <name>` 查看阻塞原因 |
| "Schema not found" | 运行 `openspec schemas` 查看可用 schema |
| 命令不识别 | 运行 `openspec init` + `openspec update`；重启 AI 工具 |
| 文档生成不正确 | 在 `openspec/config.yaml` 添加项目上下文；用 `/opsx:continue` 替代 `/opsx:ff` 获得更多控制 |

> 来源：GitHub docs/commands.md


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Fission-AI/OpenSpec GitHub 仓库
    https://github.com/Fission-AI/OpenSpec
    MIT License，45.3K+ stars（2026年5月）

[2] OpenSpec 官方文档 — Commands 参考
    https://github.com/Fission-AI/OpenSpec/blob/main/docs/commands.md

[3] OpenSpec 官方网站
    https://openspec.dev

[4] Y Combinator, "OpenSpec: The Spec Framework for Coding Agents"
    https://www.ycombinator.com/launches/Pdc-openspec-the-spec-framework-for-coding-agents

[5] GitHub Blog, "Spec-driven development with AI"
    https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/

[6] DEV.to, "How to make AI follow your instructions more for free (OpenSpec)"
    https://dev.to/webdeveloperhyper/how-to-make-ai-follow-your-instructions-more-for-free-openspec-2c85

[7] YouTube, "Getting Started with OpenSpec | Spec Driven Development"
    https://www.youtube.com/watch?v=raPTOBUpc3M

[8] YouTube, "OpenSpec Changes Everything - No More Vibe Coding"
    https://www.youtube.com/watch?v=5oUmpdpbejk
