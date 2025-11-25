# Homebrew Formula 验证指南 / Verification Guide

## 验证步骤 / Verification Steps

### 方法 1: 本地测试安装 / Method 1: Local Installation Test

```bash
# 1. 克隆此分支到本地 / Clone this branch locally
git clone -b copilot/add-homebrew-formula https://github.com/Jeff-Tian/cli-lab.git
cd cli-lab

# 2. 检查 Formula 语法 / Check formula syntax (Ruby)
ruby -c Formula/dotnet-core-uninstall.rb
# 预期输出 / Expected output: Syntax OK

# 3. 尝试安装（使用本地 Formula）/ Try installing (using local formula)
brew install --build-from-source ./Formula/dotnet-core-uninstall.rb

# 4. 验证安装 / Verify installation
dotnet-core-uninstall --version
dotnet-core-uninstall -h

# 5. 测试基本功能 / Test basic functionality
dotnet-core-uninstall list

# 6. 清理 / Cleanup
brew uninstall dotnet-core-uninstall
```

### 方法 2: 直接从 GitHub Tap 安装（推荐）/ Method 2: Install from GitHub Tap (Recommended)

```bash
# 1. 添加 tap（如果之前没有添加）/ Add tap (if not already added)
brew tap Jeff-Tian/cli-lab https://github.com/Jeff-Tian/cli-lab

# 2. 安装 / Install
brew install dotnet-core-uninstall

# 3. 验证版本 / Verify version
dotnet-core-uninstall --version
# 预期输出 / Expected output: 1.7.656206

# 4. 查看帮助 / View help
dotnet-core-uninstall -h

# 5. 测试列出功能（如果有安装的 .NET）/ Test list feature (if .NET is installed)
dotnet-core-uninstall list

# 6. 测试 dry-run（不会真正删除）/ Test dry-run (won't actually delete)
dotnet-core-uninstall dry-run --all --sdk

# 7. 运行内置测试 / Run built-in test
brew test dotnet-core-uninstall
```

### 方法 3: 快速语法检查 / Method 3: Quick Syntax Check

```bash
# 只检查 Ruby 语法 / Check Ruby syntax only
ruby -c Formula/dotnet-core-uninstall.rb
# 预期输出 / Expected output: Syntax OK

# 或者使用 Homebrew 样式检查（在 tap 后）/ Or use Homebrew style check (after tapping)
brew tap Jeff-Tian/cli-lab https://github.com/Jeff-Tian/cli-lab
brew style dotnet-core-uninstall
brew audit --new dotnet-core-uninstall
```

## 预期结果 / Expected Results

### ✅ 成功标志 / Success Indicators

1. **安装成功** / **Installation succeeds**
   - 命令 `brew install dotnet-core-uninstall` 成功完成
   - 显示安装成功信息和使用说明

2. **版本正确** / **Correct version**
   ```
   $ dotnet-core-uninstall --version
   1.7.656206
   ```

3. **可执行** / **Executable**
   - 命令 `dotnet-core-uninstall -h` 显示帮助信息
   - 命令 `dotnet-core-uninstall list` 可以运行（即使没有 .NET 安装）

4. **架构支持** / **Architecture support**
   - 在 Apple Silicon Mac 上，下载 arm64 版本
   - 在 Intel Mac 上，下载 x64 版本

### ❌ 问题排查 / Troubleshooting

如果遇到问题，请检查：

1. **Homebrew 版本** / **Homebrew version**
   ```bash
   brew --version
   # 需要 Homebrew 3.0+ / Requires Homebrew 3.0+
   ```

2. **macOS 版本** / **macOS version**
   ```bash
   sw_vers
   # 需要 macOS 10.15+ / Requires macOS 10.15+
   ```

3. **网络连接** / **Network connection**
   - 确保可以访问 github.com
   - 确保可以下载 GitHub releases

4. **权限** / **Permissions**
   ```bash
   # 检查 Homebrew 目录权限 / Check Homebrew directory permissions
   ls -la $(brew --prefix)
   ```

## 测试矩阵 / Test Matrix

| 测试项 / Test Item | Apple Silicon (M1/M2/M3) | Intel (x64) | 状态 / Status |
|-------------------|--------------------------|-------------|---------------|
| 语法检查 / Syntax check | ✅ | ✅ | Verified |
| SHA256 校验 / SHA256 verification | ✅ | ✅ | Verified |
| 安装 / Installation | 待测试 / To test | 待测试 / To test | - |
| 版本显示 / Version display | 待测试 / To test | 待测试 / To test | - |
| 帮助命令 / Help command | 待测试 / To test | 待测试 / To test | - |
| List 功能 / List feature | 待测试 / To test | 待测试 / To test | - |

## 自动化测试 / Automated Tests

Formula 包含内置测试，Homebrew 会在安装后自动运行：

```ruby
test do
  assert_match version.to_s, shell_output("#{bin}/dotnet-core-uninstall --version 2>&1")
end
```

可以手动运行此测试：
```bash
brew test dotnet-core-uninstall
```

## 安全验证 / Security Verification

1. **SHA256 校验和已验证** / **SHA256 checksums verified**
   - arm64: `a7219580de19f24dc77302c2676d3f557e568b4e9e7994a600ffbc8c265f1ce4`
   - x64: `94d66b3914597e2cf66cd1521d6abff852619d9bb24621c7f0e67304c32240e7`

2. **来源可信** / **Trusted source**
   - 二进制文件来自官方 dotnet/cli-lab GitHub releases
   - 版本 1.7.656206（最新稳定版）

3. **代码审查** / **Code review**
   - Ruby 语法检查通过
   - CodeQL 安全扫描：0 个警报

## 反馈 / Feedback

如果在验证过程中发现任何问题，请：
1. 记录完整的错误消息
2. 包含系统信息（macOS 版本、芯片类型）
3. 在 GitHub issue 中报告

If you find any issues during verification:
1. Record the full error message
2. Include system information (macOS version, chip type)
3. Report in the GitHub issue
