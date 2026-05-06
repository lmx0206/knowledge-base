# [项目名称]

## 项目概述

[一句话描述你的 Flutter 应用]

## 技术栈

- Flutter 3.x + Dart 3.x
- 状态管理：Riverpod 2.x
- 路由：go_router
- 网络：dio
- 本地存储：shared_preferences + drift
- 代码生成：freezed + json_serializable + build_runner
- 测试：flutter_test + mocktail

## 架构：Feature-First Clean Architecture

```
lib/
├── core/
│   ├── config/       # 环境配置
│   ├── di/           # 依赖注入
│   ├── error/        # 错误处理（Either<Failure, T>）
│   ├── network/      # Dio 拦截器、API 客户端
│   ├── theme/        # Material 3 主题
│   └── utils/        # 扩展函数、工具类
├── features/
│   ├── auth/
│   │   ├── data/         # DataSource + Repository 实现
│   │   ├── domain/       # Entity + Repository 接口 + UseCase
│   │   └── presentation/ # Screen + Widget + Provider
│   ├── home/
│   └── [feature]/
├── router/           # GoRouter 配置
└── main.dart
```

## 开始工作前

1. `flutter pub get`
2. `dart run build_runner build --delete-conflicting-outputs`
3. `flutter test`
4. 阅读 progress.md 了解上次进度
5. 阅读 feature_list.json 了解当前状态

## 硬约束

1. domain 层不能依赖任何外部包（只用 Dart 核心库）
2. 所有 API 响应用 freezed 定义 Model
3. 状态管理只用 Riverpod，不用 setState
4. 每个 feature 必须有测试
5. dart analyze 零警告才能提交
6. 使用 const 构造函数（性能优化）
7. 优先使用 final
8. 异步用 async/await，不用 .then()

## 命令

```bash
flutter pub get                           # 安装依赖
dart run build_runner build --delete-conflicting-outputs  # 代码生成
flutter test                              # 运行所有测试
flutter test test/features/auth/...       # 运行单个测试
dart analyze                              # 静态分析
dart format .                             # 格式化
flutter build apk --release               # 构建 APK
flutter build ios --release               # 构建 iOS
```

## 代码规范

- 文件名：snake_case.dart
- 类名：PascalCase
- 变量/函数：camelCase
- 常量：SCREAMING_SNAKE_CASE
- Widget 参数：Key? key 在第一位
- Compose 风格的小 Widget 优先

## 验证清单（完成任务前必须通过）

- [ ] flutter test 全部通过
- [ ] dart analyze 零警告
- [ ] dart format . 无变化
- [ ] 功能在模拟器上验证

## 已知坑

- build_runner 生成文件后需要手动运行
- go_router 的 redirect 逻辑容易死循环
- Riverpod 的 autoDispose 要注意生命周期
- iOS 构建需要先 cd ios && pod install
- freezed 代码生成有时需要 --delete-conflicting-outputs
