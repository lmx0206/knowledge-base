# 知识库 AGENTS.md — Agent 操作手册

> 这是知识库本身的 Harness 配置
> 遵循 Harness Engineering 5 个子系统

## 项目概述

mason 的 AI 知识库 — 包含 AI 工程、工具使用、最佳实践的结构化文档。

## 开始工作前

1. 阅读 progress.md 了解上次更新内容
2. 阅读 changelog.md 了解版本历史
3. 检查 git log --oneline -5 了解最近改动

## 硬约束（不可违反）

1. **引用来源** — 所有内容必须包含引用来源（可溯源）
2. **来源权威** — 引用来源必须是官方文档或权威社区
3. **数据验证** — 数据（stars、版本号等）必须联网验证
4. **参考来源** — 每个文档结尾必须有"参考来源"章节
5. **语言规范** — 中文撰写，技术术语保留英文

## 文档结构规范

```
主题/
├── README.md          ← 主文档（概述 + 详细内容 + 参考来源）
├── 子主题1.md         ← 可选的子文档
└── 子主题2.md         ← 可选的子文档
```

## 验证清单（每次更新前必须通过）

- [ ] 所有数据已联网验证（stars、版本号等）
- [ ] 所有引用来源可访问
- [ ] 内容与官方文档一致
- [ ] 包含"参考来源"章节

## 验证命令

```bash
# 格式检查
npm run lint

# 自动修复格式
npm run lint:fix

# 引用来源检查
npm run check-refs

# 链接可达性检查
npm run check-links
```

## 更新流程

1. 联网搜索最新信息
2. 与现有内容对比
3. 修正过时或错误信息
4. 更新 progress.md
5. 更新 changelog.md
6. git commit + push

## 已知规范

- Stars 数据来源：star-history.com 或 GitHub 页面
- 版本号来源：GitHub releases
- 安装命令来源：官方 README
