# 知识库更新进度

## 最近更新

### 2026-05-12 — 新增 Claude HUD 监控工具指南

- 新增：`claude-hud/README.md` — Claude Code 实时监控仪表盘
  - 项目简介、核心功能、技术栈
  - 安装与使用方法
  - 项目结构与核心架构（数据流图）
  - 关键组件说明（ClaudeSessionManager、CostCalculator、ToolRegistry）
  - 费用模型定价（Sonnet/Haiku/Opus）
  - 与 Hermes Agent 对比
  - 当前限制与适用场景
- 更新：根 `README.md` 导航表新增 Claude HUD 入口

### 2026-05-11 — 补全所有 AI Agent 配置，达到生产级别

- 新增：`.codex/instructions.md` — Codex Agent 配置
- 新增：`.gemini/instructions.md` — Gemini Agent 配置
- 新增：`.hermes/AGENTS.md` — Hermes Agent 配置
- 新增：`.cursorrules` — Cursor IDE 配置
- 更新：`CLAUDE.md` — 添加 AI Agent 支持对照表
- 效果：知识库现在支持 5 个 AI Agent，Harness 成熟度达到 Level 6 (生产级)

### 2026-05-11 — 新增大型 Android Agent Harness 指南

- 新增：`ai-engineering/04-harness-engineering/android-agent-harness.md`
  - 说明大型多模块 Android 项目不应追求一次性读取每行代码，而应建立可导航、可验证、可约束的 Harness
  - 补充 module map、utility index、coding style、testing guide、change context routing、AGENTS.md 模板
  - 引用 OpenAI Harness Engineering、Android Architecture、Android Kotlin Style、Kotlin Coding Conventions、Gradle Multi-Project Builds
- 更新：`ai-engineering/04-harness-engineering/README.md`
  - 修正 OpenAI Codex 团队公开数据表述：约五个月、约一百万行代码、约 1,500 个 PR、早期 3 名工程师后增长到 7 人
  - 增加大型 Android Harness 入口
- 更新：根 `README.md` 快速导航

### 2026-05-06 — 迁移 pre-commit hook 到 Husky

- 修复：pre-commit hook 从 .git/hooks/ 迁移到 .husky/（可被 git 跟踪）
- 新增：husky ^9.1.7 依赖
- 效果：其他开发者 npm install 后自动获得 pre-commit hook

### 2026-05-06 — 升级 GitHub Actions 版本

- 修复：actions/checkout v4 → v5（node24 runtime，消除弃用警告）
- 修复：markdownlint-cli2-action v19 → v23（node24 runtime，消除弃用警告）

### 2026-05-06 — 补全 Harness Engineering 三大质量门禁

- 新增：`scripts/check-references.sh` — 引用来源自动检查脚本
- 新增：`.github/workflows/markdown.yml` — GitHub Actions CI（lint + references + links）
- 新增：`mlc_config.json` — markdown-link-check 配置
- 新增：`npm run check-refs` / `npm run check-links` 脚本
- 更新：pre-commit hook 追加引用来源检查
- 更新：CLAUDE.md Quality Checks 章节补充新命令和 CI 说明
- 依赖：新增 markdown-link-check ^3.14.2

### 2026-05-06 — 新增 markdownlint 质量检查

- 新增：markdownlint 配置（`.markdownlint.json` + `.markdownlintignore`）
- 新增：pre-commit hook，提交时自动检查 `.md` 文件
- 新增：`npm run lint` / `npm run lint:fix` 脚本
- 修复：全库 Markdown 格式问题（空行、表格等）
- 修复：README.md 导航表多余的 `|` 字符
- 更新：CLAUDE.md 新增 Quality Checks 章节

### 2026-05-06 — 新增 Codex CLI + Gemini CLI + 三大工具对比

- 新增：codex/ — Codex CLI 完整指南（6 个文件）
  - README.md：总览、安装、认证、核心特性、沙箱、配置
  - skills.md：技能系统 + Superpowers 集成
  - mcp.md：MCP 客户端 + 服务器模式
  - hooks.md：通知 Hook + 沙箱安全 + CI/CD 集成
  - save-tokens.md：定价 + 7 种节省策略
  - tips-and-tricks.md：TUI 快捷键 + exec 脚本化 + 日志调试
- 新增：gemini-cli/ — Gemini CLI 完整指南（5 个文件）
  - README.md：总览、安装、认证、核心特性、免费额度
  - skills.md：Agent Skills + Extensions 双系统
  - mcp.md：MCP 服务器配置 + 资源引用
  - save-tokens.md：定价 + Token Caching + 8 种节省策略
  - tips-and-tricks.md：搜索能力 + 多模态 + Hooks + GitHub Action
- 新增：ai-comparison/ — 三大工具对比与组合使用
  - README.md：差异对比 + 场景选择 + 4 种组合策略 + 成本对比
- 更新：根 README.md 导航表
- 状态：内容基于官方文档和 GitHub 仓库验证

### 2026-05-05 — 新增云部署指南 + 第二轮审查

- 新增：cloud-deployment/ — 免费云服务器部署 Hermes Agent 指南
  - Google AI Pro 福利说明
  - Oracle Cloud Always Free 完整指南
  - 中国大陆用户注册攻略
  - Hermes Agent 部署步骤
- 审查：第二轮内容核查
  - Oracle Cloud 配置数据已验证
  - 中国大陆注册经验已汇总
  - Google AI Pro 福利已确认
- 状态：所有内容已验证

### 2026-05-05 — 审查与修正

- 完成：全库内容准确性审查
- 修正：Superpowers stars 从 179K → 176K（star-history.com 数据）
- 修正：Claude Code hooks 从 3 种 → 12+ 种（官方文档）
- 新增：AGENTS.md（知识库自身的 Harness 配置）
- 新增：progress.md（进度跟踪）
- 新增：changelog.md（版本历史）
- 状态：所有内容已验证

### 2026-05-05 — 初始创建

- 创建 Superpowers 技能框架指南
- 创建 OpenSpec 规格驱动开发指南
- 创建 Claude Code 完整指南（7 个文件）
- 创建 Ghostty 终端使用指南
- 创建 AI 工程三大演变文档
- 创建 Flutter/Android 项目模板
- 推送到 GitHub

## 待办

- [ ] 定期检查 stars 数据是否过时

- [ ] mason 注册 Oracle Cloud 后更新实际体验
