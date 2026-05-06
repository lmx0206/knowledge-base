# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Chinese-language knowledge base maintained by mason, covering AI engineering practices and development tools. Eight top-level sections:

- **ai-engineering/** — Three paradigms: Prompt Engineering (2022-2024), Context Engineering (2025), Harness Engineering (2026). Practical focus on configuring AI coding agents for mobile development (Android/Flutter/iOS) on macOS.
- **claude-code/** — Claude Code usage guide: CLAUDE.md writing, hooks, MCP servers, skills, token optimization, tips.
- **codex/** — OpenAI Codex CLI guide: sandbox modes, MCP, skills, hooks, token saving, tips.
- **cloud-deployment/** — Free cloud server deployment guide.
- **gemini-cli/** — Google Gemini CLI guide: free tier, MCP, skills, token saving, tips.
- **ghostty/** — Ghostty terminal emulator usage guide, config, shortcuts, tips.
- **openspec/** — OpenSpec specification reference.
- **superpowers/** — Superpowers framework reference.

There is no application code. All content lives in Markdown files. Tooling enforces quality via markdownlint, reference checks, and link validation.

## Quality Checks

```bash
npm run lint          # Check markdown formatting
npm run lint:fix      # Auto-fix formatting issues
npm run check-refs    # Check all docs have 参考来源 section
npm run check-links   # Check all URLs are reachable
```

**Pre-commit hook** (Husky) runs markdownlint + reference check on staged `.md` files. `npm install` 时自动安装。

**GitHub Actions CI** (`.github/workflows/markdown.yml`) runs on push/PR:

- `lint` — markdownlint formatting check
- `references` — 参考来源 section check
- `links` — URL reachability check (PR + weekly schedule)

Config files: `.markdownlint.json`, `.markdownlintignore`, `mlc_config.json`.

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
claude-code/
  README.md                        Claude Code overview
  claude-md.md                     How to write CLAUDE.md
  hooks.md                         Hooks configuration
  mcp.md                           MCP server setup
  skills.md                        Skills system
  save-tokens.md                   Token optimization
  tips-and-tricks.md               Tips and tricks
codex/
  README.md                        Codex CLI overview and quick start
  skills.md                        Skills + Superpowers integration
  mcp.md                           MCP server/client setup
  hooks.md                         Hooks and notifications
  save-tokens.md                   Token optimization
  tips-and-tricks.md               Tips and tricks
cloud-deployment/
  README.md                        Free cloud server deployment guide
gemini-cli/
  README.md                        Gemini CLI overview and quick start
  skills.md                        Agent Skills + Extensions
  mcp.md                           MCP server setup
  save-tokens.md                   Token optimization
  tips-and-tricks.md               Tips and tricks
ghostty/
  README.md                        Ghostty overview and quick start
  config-guide.md                  Configuration guide
  shortcuts.md                     Keyboard shortcuts reference
  tips-and-tricks.md               Tips and tricks
openspec/
  README.md                        OpenSpec specification reference
superpowers/
  README.md                        Superpowers framework reference
```

Each subdirectory under `ai-engineering/01-` through `07-` contains exactly one `README.md`.

## Conventions

- All content is written in Simplified Chinese; technical terms stay in English
- Maintain the existing folder numbering scheme (01-, 02-, ...) when adding new sections
- Keep the root `README.md` navigation table in sync when adding/removing sections
- Content is curated by "Hermes Agent (mimo-v2.5-pro)" — preserve attribution when editing
- Templates in `templates/flutter/` and `templates/android/` are designed to be copied directly into user projects

## Content Standards

Every document must:

- Include a "参考来源" (References) section at the end with official docs or authoritative sources
- Cite sources that are verifiable — data like GitHub stars, version numbers must be verified via web search
- Version the knowledge base in `changelog.md` (semver-style: v1.0.0, v1.1.0, ...)

## Operational Workflow

When making changes to this repo:

1. Read `progress.md` and `changelog.md` first to understand recent updates
2. Verify any factual claims (stars, version numbers, pricing) via web search before writing
3. After changes: update `progress.md` with what was done, update `changelog.md` with version bump
4. Commit and push
