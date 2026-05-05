# [项目名称]

## 项目概述
[一句话描述你的 Android 应用]

## 技术栈
- 语言：Kotlin 2.x
- UI：Jetpack Compose + Material 3
- 架构：MVVM + Clean Architecture
- 依赖注入：Hilt
- 网络：Retrofit + OkHttp + Moshi
- 数据库：Room
- 异步：Coroutines + Flow
- 测试：JUnit 5 + MockK + Turbine

## 模块结构

```
app/
├── src/main/java/com/example/app/
│   ├── data/
│   │   ├── local/        # Room DAO、Entity
│   │   ├── remote/       # Retrofit API、DTO
│   │   └── repository/   # Repository 实现
│   ├── domain/
│   │   ├── model/        # 领域模型
│   │   ├── repository/   # Repository 接口
│   │   └── usecase/      # 用例
│   ├── presentation/
│   │   ├── ui/           # Compose Screen
│   │   └── viewmodel/    # ViewModel
│   └── di/               # Hilt 模块
├── src/test/             # 单元测试
└── src/androidTest/      # 仪器测试
```

## 开始工作前
1. `./gradlew assembleDebug`
2. `./gradlew test`
3. 阅读 progress.md 了解上次进度
4. 阅读 feature_list.json 了解当前状态

## 硬约束
1. Kotlin only，不要用 Java
2. 使用 StateFlow 而非 LiveData
3. 使用 Material 3 组件
4. 每个 ViewModel 必须有单元测试
5. lint 零警告才能提交
6. domain 层不能依赖 Android 框架
7. ViewModel 不能直接访问 DataSource
8. 使用 Hilt 注入所有依赖

## 命令
```bash
./gradlew assembleDebug              # 构建 Debug APK
./gradlew test                       # 运行单元测试
./gradlew connectedAndroidTest       # 运行仪器测试
./gradlew lint                       # lint 检查
./gradlew clean                      # 清理
```

## 代码规范
- Kotlin 官方代码风格
- Compose 函数：PascalCase + 描述性命名
- 使用 Material 3 颜色和排版
- 使用 WindowSizeClass 适配不同屏幕
- 异步用 suspend + withContext(Dispatchers.IO)

## 验证清单（完成任务前必须通过）
- [ ] ./gradlew test 全部通过
- [ ] ./gradlew lint 零警告
- [ ] ./gradlew assembleDebug 编译成功
- [ ] 功能在模拟器上验证

## 已知坑
- Room 迁移必须写 Migration，否则数据丢失
- Compose 版本与 Kotlin 版本有兼容矩阵
- Hilt 多模块需要额外 @InstallIn 配置
- Gradle 版本目录(libs.versions.toml)更新后需 sync
- Compose 的 remember 和 LaunchedEffect 要注意生命周期
