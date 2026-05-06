# Gemini CLI 技能系统（Agent Skills + Extensions）

> 来源：Gemini CLI 官方文档、agentskills.io
> 更新时间：2026年5月

## 两套扩展系统

Gemini CLI 有两套扩展系统：

```
┌─────────────────────────────────────────────────────┐
│  Agent Skills（技能）                                │
│    - 自包含的指令 + 资源包                           │
│    - 基于 agentskills.io 开放标准                    │
│    - 渐进式加载（只在需要时注入）                     │
│    - 类似 Claude Code 的 Skills                      │
│                                                     │
│  Extensions（扩展）                                  │
│    - 更大的功能包                                    │
│    - 包含 MCP 服务器、自定义命令、主题、Hooks 等     │
│    - 可以包含多个 Skills                             │
│    - 类似 VS Code 的扩展                            │
└─────────────────────────────────────────────────────┘
```


══════════════════════════════════════════════
  Agent Skills
══════════════════════════════════════════════

### 什么是 Agent Skills？

Skills 是 Gemini CLI 的可复用专业知识包。
一个 Skill 就是一个包含 SKILL.md 和资源文件的目录。

```
Skill = 专业顾问
  - 安全审计专家
  - 云部署工程师
  - 代码迁移助手
  - API 集成指南
```

### Skill 生命周期

```
1. 发现（Discovery）
   会话开始时，扫描所有 Skill 的名称和描述
   注入到系统提示中（不加载详细内容）

2. 激活（Activation）
   当任务匹配某个 Skill 时
   模型调用 activate_skill 工具

3. 确认（Consent）
   显示确认对话框
   包含 Skill 名称、用途、目录路径

4. 注入（Injection）
   批准后：
   - SKILL.md 内容添加到对话历史
   - Skill 目录添加到允许的文件路径

5. 执行（Execution）
   模型使用专业知识执行任务
```

### Skill 发现层级

```
优先级从低到高：
  1. 内置 Skills — Gemini CLI 自带
  2. 扩展 Skills — 安装的 Extensions 包含的
  3. 用户 Skills — ~/.gemini/skills/ 或 ~/.agents/skills/
  4. 工作区 Skills — .gemini/skills/ 或 .agents/skills/

同名 Skill：高优先级覆盖低优先级
.agents/skills/ 优先于 .gemini/skills/
```

### 管理 Skills

```bash
# 在会话中
/skills list [all] [nodesc]     # 查看 Skills
/skills link <path>             # 链接 Skill 目录
/skills disable <name>          # 禁用 Skill
/skills enable <name>           # 启用 Skill
/skills reload                  # 刷新 Skills

# 在终端中
gemini skills list --all         # 列出所有 Skills
gemini skills install <url>      # 从 Git 安装
gemini skills uninstall <name>   # 卸载
```

### 创建自定义 Skill

```markdown
# .gemini/skills/my-skill/SKILL.md

## 触发条件
当用户要求创建新的 Android feature 时触发。

## 步骤
1. 分析需求
2. 创建目录结构
3. 实现代码
4. 编写测试

## 约束
- 使用 Kotlin
- 遵循 MVVM 架构

## 验证
- ./gradlew test 全部通过
```

> 来源：Gemini CLI 官方文档 — Agent Skills


══════════════════════════════════════════════
  Extensions（扩展）
══════════════════════════════════════════════

### 什么是 Extensions？

Extensions 是更大的功能包，可以包含：
- 提示词（Prompts）
- MCP 服务器
- 自定义命令
- 主题
- Hooks
- 子代理
- Agent Skills

### 安装 Extensions

```bash
# 从 GitHub 安装
gemini extensions install https://github.com/gemini-cli-extensions/workspace

# 在会话中
/extensions list

# 浏览扩展商店
# https://geminicli.com/extensions/browse/
```

### 管理 Extensions

```bash
# 列出已安装
gemini extensions list

# 更新
gemini extensions update <name>

# 卸载
gemini extensions uninstall <name>
```

### 推荐 Extensions

```
Superpowers — TDD、调试、计划、代码审查
  gemini extensions install https://github.com/obra/superpowers

Firecrawl — 网页抓取
  gemini extensions install https://github.com/mendableai/firecrawl-mcp
```

> 来源：Gemini CLI Extension Gallery


══════════════════════════════════════════════
  与其他工具对比
══════════════════════════════════════════════

```
┌──────────────┬──────────────┬──────────────┬──────────────┐
│ 特性          │ Gemini CLI   │ Claude Code  │ Codex CLI    │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ Skills       │ ✅ Agent Skills│ ✅ Skills   │ ✅ Skills    │
│ Extensions   │ ✅ 丰富      │ ❌ Plugins   │ ❌ Plugins   │
│ 标准         │ agentskills.io│ 自定义       │ 自定义       │
│ 渐进式加载    │ ✅           │ ✅           │ ✅           │
│ 资源绑定      │ ✅           │ ✅           │ ✅           │
│ 发现层级      │ 4 层         │ 2 层         │ 2 层         │
│ 跨工具兼容    │ ✅ .agents/  │ ❌ .claude/  │ ❌           │
└──────────────┴──────────────┴──────────────┴──────────────┘
```


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Gemini CLI Agent Skills 文档
    https://geminicli.com/docs/cli/skills

[2] Gemini CLI Extensions 文档
    https://geminicli.com/docs/extensions

[3] agentskills.io 开放标准
    https://agentskills.io

[4] Gemini CLI Extension Gallery
    https://geminicli.com/extensions/browse/

[5] GitHub Gemini CLI Extensions
    https://github.com/gemini-cli-extensions
