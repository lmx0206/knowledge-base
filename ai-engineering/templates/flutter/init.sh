#!/bin/bash
set -e

echo "=== Flutter 环境检查 ==="
flutter doctor -v 2>/dev/null || echo "⚠️ Flutter 未安装或不在 PATH 中"

echo ""
echo "=== 安装依赖 ==="
flutter pub get

echo ""
echo "=== 代码生成 ==="
dart run build_runner build --delete-conflicting-outputs

echo ""
echo "=== 运行测试 ==="
flutter test

echo ""
echo "=== 静态分析 ==="
dart analyze

echo ""
echo "=== 环境健康 ✓ ==="
