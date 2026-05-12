# 驾驭工程 (Harness Engineering)

> 阶段：2026（第三代，当前前沿）
> 核心问题：怎么让 AI Agent 可靠地持续工作？
> 提出者：Mitchell Hashimoto（Terraform 创始人）

## 什么是驾驭工程？

驾驭（Harness）= AI Agent 中除了模型之外的一切东西。

```
Agent = Model + Harness
        模型    驾驭
        引擎    整辆汽车
```

驾驭工程是设计和构建这个"驾驭"的学科 —
包括工作流、约束、反馈循环、工具链、质量门禁、生命周期管理。

> "Agent 不难，难的是 Harness。" — OpenAI Codex 团队 Ryan Lopopolo

## 三大工程的比喻

```
提示词工程 = 写好一封邮件的内容
上下文工程 = 给邮件加上正确的附件和背景资料
驾驭工程   = 设计整个办公室的工作流程

更具体：
  提示词 → 你对 AI 说的话
  上下文 → AI 能看到的所有信息
  驾驭   → AI 工作的整个环境（工具、规则、检查、反馈、权限）
```

## 为什么需要驾驭工程？

### 模型足够强了，但不可靠

```
2024年："模型太笨了，写不出好代码"
2026年："模型够聪明了，但它会自信地犯同样的错"
```

Agent 可以写代码、调工具、执行长任务。
但如果你只给它一个循环和一个梦想，它会自信地重复同样的错误。

### 关键实验数据

| 场景 | 结果 |
|------|------|
| 同模型+同数据，仅改运行环境 | 成功率 42% → 78% |
| 简单 prompt + 跑一次 | $9，产品不可用 |
| 结构化迭代环境 | $200，产品完整可用 |
| OpenAI Codex 团队 | 7人，100万行代码，0行手写 |
| Stripe Minions | 每周 1,300+ PR 自动合并 |

## 驾驭工程的核心组件

### 1. 前馈控制（Feedforward）— 预防

在 Agent 行动之前，预防错误发生：

```
┌────────────────────────────────────────┐
│  前馈控制示例                           │
│                                        │
│  • AGENTS.md — 项目规则和架构约束       │
│  • Skills — 标准操作流程               │
│  • Linter 规则 — 代码风格强制           │
│  • 架构测试 — 模块边界检查              │
│  • 类型检查 — 编译时错误捕获            │
└────────────────────────────────────────┘
```

### 2. 反馈控制（Feedback）— 纠错

在 Agent 行动之后，检测并修正错误：

```
┌────────────────────────────────────────┐
│  反馈控制示例                           │
│                                        │
│  • 单元测试 — 功能正确性               │
│  • CI/CD 检查 — 构建和部署验证          │
│  • 代码审查 — AI 或人工 review         │
│  • 自定义 linter — 包含修复指令的错误   │
│  • 运行时监控 — SLO 检查               │
└────────────────────────────────────────┘
```

### 3. 两种执行类型

```
计算型（Computational）          推理型（Inferential）
  确定性、快速、CPU 运行            语义分析、慢、GPU 运行
  测试、linter、类型检查            AI 代码审查、LLM as Judge
  毫秒到秒级                        秒到分钟级
  结果可靠                          结果概率性

两者结合 = 最佳效果
```

### 4. 约束创造自由（反直觉发现）

```
Cursor 团队发现：
  给 Agent 无限自由 → 浪费大量 token 探索死路
  给 Agent 明确约束 → 更快收敛到正确答案

"约束 Agent 的解空间，反而大幅提高生产力"
```

### 5. GAN 式双 Agent 架构

Anthropic 发现：模型无法可靠地评估自己的工作。

解决方案：

```
┌──────────┐     ┌──────────┐
│Generator │────>│Evaluator │
│ 生成 Agent│     │ 评估 Agent│
└──────────┘     └──────────┘
     ↑                │
     └────────────────┘
        反馈循环
```

## 实际案例：OpenAI Codex 团队的经验

OpenAI 公开文章记录了一个 Codex Harness 实验：团队从空仓库开始，约五个月后形成约一百万行代码、约 1,500 个 PR；早期由 3 名工程师驱动，之后团队增长到 7 人。重点不是“把所有代码交给模型一次性生成”，而是把仓库知识、工具、验证、日志、review loop 都设计成 Agent 能直接使用的系统。

5 个月经验总结：

```
规则 1: 仓库是 Agent 的唯一真相来源
        不假设任何外部知识

规则 2: 代码必须对 Agent 可读，不只是对人可读
        清晰结构 + repo-local 文档

规则 3: 架构约束用 linter 强制，不用 prompt 要求
        不是"请遵守规则"，而是"系统让你无法违反规则"

规则 4: 自主权逐步授予
        Harness 必须有阶段和门禁

规则 5: 如果 PR 需要大量人工干预，Agent 不是问题，Harness 才是
```

## 大型 Android 项目的 Harness

大型多模块 Android 项目不能依赖 Agent 一次性读取每行代码，而要让 Agent 能快速定位“应该读哪几行代码”：

```text
AGENTS.md                         # 入口地图
ARCHITECTURE.md                   # 架构总览
docs/android/module-map.md        # 模块职责和依赖方向
docs/android/utility-index.md     # 工具类和公共抽象索引
docs/android/coding-style.md      # 编码规范和可执行检查
docs/android/testing-guide.md     # 按改动类型选择验证命令
docs/generated/dependency-graph.md # 自动生成的模块依赖图
```

详见：[大型 Android 项目的 Agent Harness 搭建指南](./android-agent-harness.md)。

## 实际案例：Stripe 的做法

```
"Blueprint" 编排系统：
  - 确定性节点：运行 linter、推送 commit（CPU 执行）
  - 推理性节点：实现功能、修复 CI 失败（Agent 执行）

"两次失败"规则：
  - Agent 第一次修复失败 → 自动重试
  - 第二次修复失败 → 立即升级给人工
  - 不允许 Agent 在无限重试循环中浪费资源
```

## Martin Fowler 的驾驭框架

Martin Fowler 将驾驭分为三类：

```
1. 可维护性驾驭 (Maintainability Harness)
   - 代码风格、复杂度、测试覆盖
   - 最容易实现，工具最成熟

2. 架构适应性驾驭 (Architecture Fitness Harness)
   - 模块边界、依赖方向、分层规则
   - 用 ArchUnit 等工具检查

3. 行为驾驭 (Behaviour Harness)
   - 功能正确性、业务逻辑
   - 最难，需要好的测试和规范
```

## 在 Hermes Agent 中的实现

| 驾驭概念 | Hermes 功能 |
|---------|------------|
| 前馈控制 | AGENTS.md、Skills、personality |
| 反馈循环 | 工具输出 → Agent 自我修正 |
| 约束系统 | approvals.mode、安全设置 |
| 质量门禁 | terminal 输出检查、自动重试 |
| 工具链 | 工具集（terminal、file、web 等） |
| 生命周期 | cron jobs、session resume |
| 双 Agent | delegation（子代理委派） |
| 渐进授权 | --yolo 模式、approvals 配置 |
| 持久化 | Memory、Skills、session 存储 |

## 如何实践驾驭工程（给 mason 的建议）

```
第一步：写好 AGENTS.md（前馈控制）
  → 在你的项目根目录放置规则文件
  → 包含技术栈、架构、代码规范、常用命令

第二步：积累 Skills（流程标准化）
  → 每次完成复杂任务，保存为技能
  → 下次直接复用，不依赖模型推理

第三步：配置工具链（环境约束）
  → 确保 terminal、file、web 工具可用
  → 配置 approvals.mode 为 smart

第四步：建立反馈循环
  → 让 Agent 跑测试验证自己的代码
  → 用 linter 检查代码质量

第五步：逐步放权
  → 从小任务开始，信任建立后增加自主权
  → 用 --yolo 模式处理低风险任务
```

## 推荐阅读

- Martin Fowler: "Harness engineering for coding agent users"
- Mitchell Hashimoto: "Engineer the Harness"
- Louis Bouchard: "Harness Engineering: The Missing Layer Behind AI Agents"
- Epsilla: "Why Harness Engineering Replaced Prompting in 2026"
- OpenAI Codex 团队实验报告
- Anthropic: "Building effective agents with long-running agents"

## 参考来源

- [Martin Fowler - Harness Engineering for Coding Agent Users](https://martinfowler.com/articles/harness-engineering.html)
- [Mitchell Hashimoto - Engineer the Harness](https://mitchellh.com/writing/engineer-the-harness)
- [Anthropic - Building Effective Agents](https://docs.anthropic.com/en/docs/build-with-claude/agents)
- [OpenAI - Harness engineering: leveraging Codex in an agent-first world](https://openai.com/index/harness-engineering/)
- [OpenAI Codex CLI](https://github.com/openai/codex)
- [Android Developers - Guide to app architecture](https://developer.android.com/topic/architecture)
- [Gradle Documentation - Multi-Project Builds](https://docs.gradle.org/current/userguide/multi_project_builds.html)
- [Louis Bouchard - Harness Engineering: The Missing Layer Behind AI Agents](https://www.louisbouchard.ai/harness-engineering/)
- [Epsilla - Why Harness Engineering Replaced Prompting in 2026](https://epsilla.com/blog/harness-engineering)
