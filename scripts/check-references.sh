#!/bin/sh
# check-references.sh — 检查 .md 文件是否包含引用来源章节
# 用法: bash scripts/check-references.sh
# 退出码: 0 = 全部通过, 1 = 有文件缺少引用来源

# 豁免文件列表（不需要引用来源）
EXEMPT_FILES="progress.md|changelog.md|CLAUDE.md|AGENTS.md|DECISIONS.md"

FAILED=0
MISSING=""

# 遍历所有 .md 文件（排除 node_modules 和 .git）
for f in $(find . -name "*.md" -not -path "./node_modules/*" -not -path "./.git/*"); do
  # 跳过 templates 目录下的文件
  case "$f" in */templates/*) continue ;; esac

  # 跳过豁免文件
  BASENAME=$(basename "$f")
  echo "$BASENAME" | grep -qE "^($EXEMPT_FILES)$" && continue

  # 检查是否包含引用来源关键词
  if ! grep -qE "参考来源|参考资料|^## 来源" "$f" 2>/dev/null; then
    FAILED=$((FAILED + 1))
    MISSING="$MISSING\n  ❌ $f"
  fi
done

if [ $FAILED -gt 0 ]; then
  echo "❌ $FAILED 个文件缺少引用来源章节:$MISSING"
  echo ""
  echo "请在文档末尾添加 '## 参考来源' 章节。"
  echo "豁免文件: $EXEMPT_FILES, templates/"
  exit 1
fi

echo "✅ 所有文档均包含引用来源章节"
exit 0
