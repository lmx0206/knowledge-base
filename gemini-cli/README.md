# Gemini CLI 完整使用指南

> 创建时间：2026年5月
> 官方文档：https://geminicli.com/docs/
> GitHub：https://github.com/google-gemini/gemini-cli
> 适用平台：macOS / Linux / Windows (WSL)

## 什么是 Gemini CLI？

Gemini CLI 是 Google 推出的开源终端 AI 编码 Agent，
将 Gemini 模型的强大能力直接带入你的终端。

```
免费额度最大方的 AI 终端 Agent
60 次/分钟，1000 次/天（个人 Google 账号）
100 万 token 上下文窗口
```

## 目录

```
gemini-cli/
├── README.md              ← 你在这里（总览 + 目录）
├── skills.md              技能系统（Agent Skills + Extensions）
├── mcp.md                 MCP 服务器集成
├── save-tokens.md         节省 Token 策略
└── tips-and-tricks.md     技巧与最佳实践
```


══════════════════════════════════════════════
  快速开始
══════════════════════════════════════════════

```bash
# 方式 1：npx 直接运行（无需安装）
npx @google/gemini-cli

# 方式 2：npm 全局安装
npm install -g @google/gemini-cli

# 方式 3：Homebrew
brew install gemini-cli

# 方式 4：MacPorts
sudo port install gemini-cli

# 启动
gemini
```

### 认证方式

```
方式 1：Google 账号登录（推荐，免费）
  - 启动 gemini 后选择 "Sign in with Google"
  - 浏览器完成 OAuth 认证
  - 免费额度：60 次/分钟，1000 次/天
  - 无需 API Key

方式 2：Gemini API Key
  - 从 https://aistudio.google.com/apikey 获取
  - export GEMINI_API_KEY="your-key"
  - 免费额度：1000 次/天
  - 可选择特定模型

方式 3：Vertex AI（企业）
  - 需要 Google Cloud 项目
  - export GOOGLE_CLOUD_PROJECT="your-project"
  - 企业级安全和合规
```

### 发布渠道

```bash
# 稳定版（每周二更新）
npm install -g @google/gemini-cli@latest

# 预览版（每周二更新，可能有 bug）
npm install -g @google/gemini-cli@preview

# 每夜版（每天更新，实验性）
npm install -g @google/gemini-cli@nightly
```

> 来源：Gemini CLI 官方文档


══════════════════════════════════════════════
  核心特性
══════════════════════════════════════════════

### 1. 免费额度最大方

```
个人 Google 账号：
  - 60 次请求/分钟
  - 1000 次请求/天
  - Gemini 3 模型
  - 100 万 token 上下文窗口
  - 完全免费

API Key：
  - 1000 次/天（Gemini 3，flash + pro 混合）
  - 可升级付费
```

### 2. Google Search Grounding

```
Gemini CLI 内置 Google 搜索能力：
  - 自动搜索最新信息
  - 基于实时数据回答
  - 不依赖模型的训练数据截止日期
```

### 3. 多模态能力

```
支持输入：
  - 代码文件
  - PDF 文档
  - 图片（截图、设计稿）
  - 草图

可以用图片、PDF 或草图生成代码！
```

### 4. 会话检查点（Checkpointing）

```
自动保存会话快照：
  - 可以回退到之前的会话状态
  - 支持重放（Rewind）
  - 复杂任务的安全网
```

### 5. 沙箱隔离

```
内置沙箱系统：
  - 隔离工具执行
  - 防止意外修改系统文件
  - 可配置信任级别
```

### 6. GitHub 集成

```
Gemini CLI GitHub Action：
  - Pull Request 自动审查
  - Issue 自动分类和标签
  - @gemini-cli 在 issues/PRs 中提求帮助
  - 自定义工作流
```

### 7. Headless 模式

```bash
# 非交互式执行
gemini --headless "describe this codebase"

# 脚本化
for file in src/*.py; do
  gemini --headless "Review $file"
done
```

### 8. Plan 模式（实验性）

```
安全的只读模式：
  - 只分析和规划，不执行修改
  - 适合复杂任务的预规划
  - 确认后再执行
```

### 9. 子代理（实验性）

```
支持 Subagents：
  - 本地子代理
  - 远程子代理（Remote Subagents）
  - Agent-to-Agent 通信（A2A）
```

> 来源：Gemini CLI 官方文档


══════════════════════════════════════════════
  配置文件
══════════════════════════════════════════════

### GEMINI.md — 项目上下文文件

```markdown
# GEMINI.md 示例

## 项目概述
这是一个基于 Jetpack Compose 的 Android 应用。

## 技术栈
- Kotlin + Jetpack Compose
- MVVM + Clean Architecture
- Hilt + Retrofit + Room

## 代码规范
- 使用 Kotlin 官方代码风格
- 使用 StateFlow 而非 LiveData
- 使用 Material 3

## 常用命令
- 构建：./gradlew assembleDebug
- 测试：./gradlew test
```

### GEMINI.md 层级系统

```
1. 全局：~/.gemini/GEMINI.md（所有项目通用）
2. 环境：工作区目录中的 GEMINI.md
3. JIT：工具访问目录时自动扫描该目录的 GEMINI.md

支持 @file.md 导入语法：
  @./components/instructions.md
  @../shared/style-guide.md
```

### settings.json — 设置文件

```json
{
  "theme": "dark",
  "model": "gemini-3-pro",
  "sandbox": {
    "enabled": true
  },
  "mcpServers": {},
  "hooks": {}
}
```

### 配置文件位置

```
项目级：.gemini/settings.json
用户级：~/.gemini/settings.json
系统级：/etc/gemini-cli/settings.json
优先级：项目 > 用户 > 系统
```

> 来源：Gemini CLI 官方文档


══════════════════════════════════════════════
  与其他工具对比
══════════════════════════════════════════════

```
┌──────────────┬──────────────┬──────────────┬──────────────┐
│ 特性          │ Gemini CLI   │ Claude Code  │ Codex CLI    │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ 免费额度      │ 1000次/天    │ 需 API Key   │ ChatGPT 计划 │
│ 上下文窗口    │ 1M tokens    │ 200K tokens  │ 128K tokens  │
│ 搜索能力      │ ✅ 内置搜索  │ ❌ 无        │ ❌ 无        │
│ 多模态        │ ✅ 图片/PDF  │ ✅ 图片      │ ✅ 图片      │
│ 会话回退      │ ✅ Checkpoint│ ❌ 无        │ ❌ 无        │
│ 沙箱         │ ✅ 内置      │ ❌ 无        │ ✅ 内置      │
│ GitHub Action │ ✅ 原生      │ ❌ 无        │ ❌ 无        │
│ 认证方式      │ Google OAuth │ API Key      │ ChatGPT/API  │
│ Extensions   │ ✅ 丰富      │ ❌           │ ❌           │
│ Hooks        │ ✅ 11 事件   │ ✅ 12 事件   │ ✅ 通知型    │
│ 实现语言      │ TypeScript   │ TypeScript   │ Rust         │
└──────────────┴──────────────┴──────────────┴──────────────┘
```


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Gemini CLI 官方文档
    https://geminicli.com/docs/

[2] Gemini CLI GitHub 仓库
    https://github.com/google-gemini/gemini-cli

[3] Gemini API Key 获取
    https://aistudio.google.com/apikey

[4] Gemini CLI GitHub Action
    https://github.com/google-github-actions/run-gemini-cli

[5] Gemini CLI Extension Gallery
    https://geminicli.com/extensions/browse/
