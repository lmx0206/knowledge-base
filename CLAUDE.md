# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Chinese-language knowledge base maintained by mason, covering AI engineering practices and development tools. Two top-level sections:

- **ai-engineering/** — Three paradigms: Prompt Engineering (2022-2024), Context Engineering (2025), Harness Engineering (2026). Practical focus on configuring AI coding agents for mobile development (Android/Flutter/iOS) on macOS.
- **ghostty/** — Ghostty terminal emulator usage guide, config, shortcuts, tips.

There is no code, build system, or tooling. All content lives in Markdown files.

## Structure

```
README.md                          Root index with navigation table
ai-engineering/
  01-overview/                     Three-era evolution of AI engineering
  02-prompt-engineering/           Prompt engineering techniques
  03-context-engineering/          Context engineering (RAG, memory, tools)
  04-harness-engineering/          Harness engineering (agent runtime design)
  05-practical-tools/              Config templates for AGENTS.md, CLAUDE.md, .cursorrules, etc.
  06-hermes-agent/                 mason's Hermes Agent setup (mimo-v2.5-pro, macOS)
    flutter-android-harness-guide.md  Complete practical guide for AI + Flutter/Android
  07-references/                   Source links and references
  templates/                       Ready-to-copy project templates
    flutter/                       AGENTS.md, init.sh, DECISIONS.md, feature_list.json, progress.md
    android/                       AGENTS.md, init.sh, DECISIONS.md, feature_list.json, progress.md
ghostty/
  README.md                        Ghostty overview and quick start
  config-guide.md                  Configuration guide
  shortcuts.md                     Keyboard shortcuts reference
  tips-and-tricks.md               Tips and tricks
```

Each subdirectory under `ai-engineering/01-` through `07-` contains exactly one `README.md`.

## Conventions

- All content is written in Simplified Chinese
- Maintain the existing folder numbering scheme (01-, 02-, ...) when adding new sections
- Keep the root `README.md` navigation table in sync when adding/removing sections
- Content is curated by "Hermes Agent (mimo-v2.5-pro)" — preserve attribution when editing
- Templates in `templates/flutter/` and `templates/android/` are designed to be copied directly into user projects
