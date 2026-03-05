# agent-skill-factory (智能体技能工厂)

一个通用的、工程化的 Agent 技能开发与进化环境。实现“源码即开发，构建即技能”的闭环。

## 📖 文档体系 (Documentation)
- **[核心铁律 (CORE_LAWS)](.spec/CORE_LAWS.md)**: 遵循“禁止瞎猜 + 必须建议”的最高准则。
- **[需求文档 (PRD)](.spec/docs/PRD.md)**: 项目愿景与需求分析。
- **[技术方案 (TDD)](.spec/docs/TDD.md)**: 编译器与部署器架构设计。
- **[使用说明 (USAGE)](.spec/docs/USAGE.md)**: 如何创建新技能及执行进化。

## 🏗️ 目录结构 (Structure)
- **`core/`**: 核心编译器 (`build.sh`) 与部署器 (`deploy.sh`)。
- **`projects/`**: 各项技能的源码工程 (如 `ubuntu-ai-assistant`)。
- **`config/`**: 全局配置。
- **`templates/`**: 标准化 Skill 模板。

## 🚀 快速开始 (Quick Start)
1. 配置根目录 `.env` 文件。
2. 运行 `./core/deploy.sh <项目名>` 执行构建与发布。
