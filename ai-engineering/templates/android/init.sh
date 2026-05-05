#!/bin/bash
set -e

echo "=== Java 环境检查 ==="
java -version 2>&1 || echo "⚠️ Java 未安装或不在 PATH 中"

echo ""
echo "=== 构建项目 ==="
./gradlew assembleDebug

echo ""
echo "=== 运行测试 ==="
./gradlew test

echo ""
echo "=== lint 检查 ==="
./gradlew lint

echo ""
echo "=== 环境健康 ✓ ==="
