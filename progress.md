# 知识库更新进度

## 最近更新

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
