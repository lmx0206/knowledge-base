# 知识库更新日志

## v1.7.0 — 2026-05-12（Claude HUD 监控工具指南）

### 新增

- `claude-hud/README.md` — Claude Code 实时监控仪表盘完整指南
  - 项目简介与核心功能（8 项）
  - 技术栈说明（Next.js 15 + React 19 + TypeScript + Tailwind CSS v4）
  - 安装与使用方法
  - 项目结构与核心架构（数据流图）
  - 关键组件说明（ClaudeSessionManager、CostCalculator、ToolRegistry）
  - 费用模型定价（Sonnet/Haiku/Opus 三种模型）
  - 与 Hermes Agent 对比表
  - 当前限制与适用场景

### 更新

- 根 `README.md` — 导航表新增 Claude HUD 入口
- `progress.md` — 记录更新进度

### 验证

- GitHub Stars: 143（已验证）
- 版本: 0.1.0（已验证）
- 许可证: MIT（已验证）
- 引用来源包含 GitHub 仓库、npm、Next.js 官方文档、Anthropic 官方文档

## v1.6.0 — 2026-05-11（生产级别 Harness 补全）

### 新增

- `.codex/instructions.md` — Codex Agent 配置
- `.gemini/instructions.md` — Gemini Agent 配置
- `.hermes/AGENTS.md` — Hermes Agent 配置
- `.cursorrules` — Cursor IDE 配置
- `HARNESS_EVALUATION.md` — Harness 工程评估报告

### 更新

- `CLAUDE.md` — 添加 AI Agent 支持对照表

### 效果

- 知识库现在支持 5 个 AI Agent（Claude Code / Codex / Hermes / Gemini / Cursor）
- 所有 Agent 共享相同的硬约束和验证流程
- Harness 成熟度达到 Level 6 (生产级)

### 验证

- 所有配置文件格式正确
- 硬约束一致
- 验证命令统一

## v1.5.0 — 2026-05-11（大型 Android Agent Harness）

### 新增

- `ai-engineering/04-harness-engineering/android-agent-harness.md`
  - 大型多模块 Android 项目的 Agent Harness 搭建方法
  - module map、utility index、coding style、testing guide、change context routing
  - Android 多模块项目的 AGENTS.md 模板
  - Harness 五子系统在 Android 项目中的落地方式

### 更新

- `ai-engineering/04-harness-engineering/README.md`
  - 修正 OpenAI Codex Harness 实验数据表述
  - 增加大型 Android Harness 专文入口
- 根 `README.md` 快速导航新增 Android Agent Harness 入口

### 验证

- 数据来源已通过联网验证
- 引用来源包含 OpenAI、Android Developers、Kotlin、Gradle 官方文档

## v1.4.1 — 2026-05-06（Husky + CI 依赖升级）

### 修复

- pre-commit hook 迁移到 Husky（.husky/pre-commit，可被 git 跟踪）
- `actions/checkout` v4 → v5（node24 runtime，消除弃用警告）
- `markdownlint-cli2-action` v19 → v23（node24 runtime，消除弃用警告）

### 依赖

- 新增 husky ^9.1.7

## v1.4.0 — 2026-05-06（Harness 质量门禁补全）

### 新增

- `scripts/check-references.sh` — 引用来源自动检查脚本
- `.github/workflows/markdown.yml` — GitHub Actions CI
  - Job 1: markdownlint 格式检查
  - Job 2: 引用来源章节检查
  - Job 3: URL 可达性检查（PR + 每周一定时）
- `mlc_config.json` — markdown-link-check 配置
- `npm run check-refs` / `npm run check-links` 脚本
- pre-commit hook 追加引用来源检查

### 依赖

- 新增 markdown-link-check ^3.14.2

## v1.3.1 — 2026-05-06（Markdownlint 质量检查）

### 新增

- markdownlint 配置（`.markdownlint.json` + `.markdownlintignore`）
- pre-commit hook — 提交时自动检查 `.md` 文件格式
- `npm run lint` / `npm run lint:fix` 脚本
- CLAUDE.md 新增 Quality Checks 章节

### 修复

- 全库 Markdown 格式统一（标题/列表/代码块前后空行）
- README.md 导航表多余的 `|` 字符

## v1.3.0 — 2026-05-06（Codex + Gemini + 对比指南）

### 新增

- codex/ — Codex CLI 完整指南（6 个文件）
  - 总览、安装、认证、核心特性（Rust/TUI/沙箱/exec/MCP）
  - 技能系统 + Superpowers 集成
  - MCP 客户端 + 服务器模式
  - 通知 Hook + 沙箱安全 + CI/CD 集成
  - 定价 + 7 种节省 Token 策略
  - TUI 快捷键 + exec 脚本化 + 日志调试
- gemini-cli/ — Gemini CLI 完整指南（5 个文件）
  - 总览、安装、认证、核心特性（免费/搜索/多模态/Checkpoint）
  - Agent Skills + Extensions 双系统
  - MCP 服务器配置 + 资源引用
  - 定价 + Token Caching + 8 种节省策略
  - 搜索能力 + 多模态 + Hooks + GitHub Action
- ai-comparison/ — 三大工具对比与组合使用
  - Claude Code vs Codex CLI vs Gemini CLI 全面对比
  - 场景选择指南
  - 4 种组合使用策略
  - 成本对比分析
  - 跨工具上下文共享方案

### 验证

- 所有内容基于官方文档和 GitHub 仓库
- 安装命令、配置格式、功能特性已核实
- 价格信息来自官方定价页面

## v1.2.0 — 2026-05-05（云部署指南）

### 新增

- cloud-deployment/ — 免费云服务器部署 Hermes Agent 指南
  - Google AI Pro 福利说明（$10/月 Cloud Credits，不含免费 VM）
  - Oracle Cloud Always Free 完整配置（4核24G ARM）
  - 中国大陆用户注册攻略（信用卡要求、VPN、成功率）
  - Hermes Agent 部署步骤
  - 替代方案（AWS/Azure/Google Cloud）

### 验证

- Oracle Cloud 配置数据：已通过官网和社区验证
- Google AI Pro 福利：已通过官方页面和 Reddit 验证
- 中国大陆注册经验：已通过 V2EX、知乎、掘金社区验证

## v1.1.0 — 2026-05-05（审查修正版）

### 修正

- **Superpowers stars**: 179K → 176K（数据来源：star-history.com）
- **Claude Code hooks**: 3 种事件 → 12+ 种事件（数据来源：Anthropic 官方文档）

### 新增

- AGENTS.md — 知识库自身的 Harness 配置
- progress.md — 更新进度跟踪
- changelog.md — 版本历史（本文件）

## v1.0.0 — 2026-05-05（初始版本）

### 新增

- superpowers/ — Superpowers 技能框架指南
- openspec/ — OpenSpec 规格驱动开发指南
- claude-code/ — Claude Code 完整指南（7 个文件）
- ghostty/ — Ghostty 终端使用指南（4 个文件）
- ai-engineering/ — AI 工程三大演变（21 个文件）
- templates/ — Flutter/Android 项目模板
