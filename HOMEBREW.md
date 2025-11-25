# Homebrew 安装指南 / Homebrew Installation Guide

> **Note**: This Homebrew formula is hosted in the Jeff-Tian/cli-lab repository but installs the official binaries from dotnet/cli-lab releases.

## 中文说明

### 安装

通过 Homebrew 安装 `dotnet-core-uninstall` 是在 macOS 上最简单的方式：

```bash
# 1. 添加此仓库作为 tap
brew tap Jeff-Tian/cli-lab https://github.com/Jeff-Tian/cli-lab

# 2. 安装 dotnet-core-uninstall
brew install dotnet-core-uninstall

# 3. 验证安装
dotnet-core-uninstall --version
```

### 使用方法

安装完成后，你可以使用以下命令：

#### 列出所有已安装的 .NET SDK 和 Runtime

```bash
dotnet-core-uninstall list
```

#### 执行 Dry Run（查看将要卸载的内容，不实际执行）

```bash
# 查看将要删除的所有 SDK
dotnet-core-uninstall dry-run --all --sdk

# 查看将要删除的所有 Runtime
dotnet-core-uninstall dry-run --all --runtime
```

#### 卸载特定版本

```bash
# 卸载特定版本的 SDK
dotnet-core-uninstall remove --sdk 6.0.100

# 卸载特定版本的 Runtime
dotnet-core-uninstall remove --runtime 6.0.0
```

#### 卸载所有版本（保留最新版本）

```bash
# 卸载除最新版本外的所有 SDK
dotnet-core-uninstall remove --all-but-latest --sdk

# 卸载除最新版本外的所有 Runtime
dotnet-core-uninstall remove --all-but-latest --runtime
```

### 更新

```bash
# 更新 Homebrew 并升级 dotnet-core-uninstall
brew update
brew upgrade dotnet-core-uninstall
```

### 卸载

```bash
# 卸载 dotnet-core-uninstall
brew uninstall dotnet-core-uninstall

# 可选：移除 tap
brew untap Jeff-Tian/cli-lab
```

---

## English Instructions

### Installation

Installing `dotnet-core-uninstall` via Homebrew is the easiest way on macOS:

```bash
# 1. Tap this repository
brew tap Jeff-Tian/cli-lab https://github.com/Jeff-Tian/cli-lab

# 2. Install dotnet-core-uninstall
brew install dotnet-core-uninstall

# 3. Verify installation
dotnet-core-uninstall --version
```

### Usage

After installation, you can use the following commands:

#### List all installed .NET SDKs and Runtimes

```bash
dotnet-core-uninstall list
```

#### Perform a Dry Run (see what would be removed without actually removing)

```bash
# See what SDKs would be removed
dotnet-core-uninstall dry-run --all --sdk

# See what Runtimes would be removed
dotnet-core-uninstall dry-run --all --runtime
```

#### Uninstall specific versions

```bash
# Uninstall a specific SDK version
dotnet-core-uninstall remove --sdk 6.0.100

# Uninstall a specific Runtime version
dotnet-core-uninstall remove --runtime 6.0.0
```

#### Uninstall all but the latest version

```bash
# Remove all but the latest SDK
dotnet-core-uninstall remove --all-but-latest --sdk

# Remove all but the latest Runtime
dotnet-core-uninstall remove --all-but-latest --runtime
```

### Updating

```bash
# Update Homebrew and upgrade dotnet-core-uninstall
brew update
brew upgrade dotnet-core-uninstall
```

### Uninstallation

```bash
# Uninstall dotnet-core-uninstall
brew uninstall dotnet-core-uninstall

# Optional: Remove the tap
brew untap Jeff-Tian/cli-lab
```

---

## Additional Resources / 其他资源

- Official Documentation / 官方文档: https://aka.ms/dotnet-core-uninstall-docs
- GitHub Repository / GitHub 仓库: https://github.com/dotnet/cli-lab
- Issues / 问题反馈: https://github.com/dotnet/cli-lab/issues
