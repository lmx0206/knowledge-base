# mason 的 AI 知识库

> 创建时间：2026年5月
> 维护者：Hermes Agent (mimo-v2.5-pro)

## 目录结构

```
knowledge-base/
└── ai-engineering/
    ├── 01-overview/              总览：AI 工程三大演变
    ├── 02-prompt-engineering/    提示词工程详解
    ├── 03-context-engineering/   上下文工程详解
    ├── 04-harness-engineering/   驾驭工程详解
    ├── 05-practical-tools/       实用工具与配置文件指南
    ├── 06-hermes-agent/          Hermes Agent 实践指南
    │   ├── README.md             Hermes 专属优化策略
    │   └── flutter-android-harness-guide.md  ← 完整实践指南
    ├── 07-references/            参考资料与链接
    └── templates/                ← 可直接复制到项目的模板
        ├── flutter/
        │   ├── AGENTS.md         Flutter 项目配置模板
        │   ├── init.sh           环境检查脚本
        │   ├── feature_list.json 功能列表
        │   ├── progress.md       进度日志
        │   └── DECISIONS.md      架构决策记录
        └── android/
            ├── AGENTS.md         Android 项目配置模板
            ├── init.sh           环境检查脚本
            ├── feature_list.json 功能列表
            ├── progress.md       进度日志
            └── DECISIONS.md      架构决策记录
```

## 快速导航

| 我想... | 去看 |
|---------|------|
| 了解三个工程是什么 | 01-overview/ |
| 学习提示词工程 | 02-prompt-engineering/ |
| 学习上下文工程 | 03-context-engineering/ |
| 学习驾驭工程 | 04-harness-engineering/ |
| 知道 AGENTS.md 怎么写 | 05-practical-tools/ |
| 让 Hermes 更聪明 | 06-hermes-agent/README.md |
| **让 Claude Code/Codex 理解我的项目** | **06-hermes-agent/flutter-android-harness-guide.md** |
| **直接拿模板用** | **templates/flutter/ 或 templates/android/** |
| 找文章和视频 | 07-references/ |

## 核心公式

```
弱模型 + 好上下文 + 好驾驭 ≈ 强模型 + 糟糕配置
```

## 快速开始（5 分钟）

```bash
# 1. 复制模板到你的 Flutter 项目
cp ~/knowledge-base/ai-engineering/templates/flutter/* /path/to/your/flutter/project/

# 2. 复制模板到你的 Android 项目
cp ~/knowledge-base/ai-engineering/templates/android/* /path/to/your/android/project/

# 3. 编辑 AGENTS.md，填入你项目的实际信息

# 4. 运行 init.sh 确认环境正常
cd /path/to/your/project && ./init.sh
```

## 使用方式

- 每个文件夹都有 README.md，直接阅读即可
- 遇到新的知识，告诉我"保存到知识库"
- 定期回顾和更新
- 模板可以直接复制到项目中使用
