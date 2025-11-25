# Homebrew Formula 验证指南 / Verification Guide

## ⚠️ 重要提示 / Important Note

此 Formula 当前在 `copilot/add-homebrew-formula` 分支中，尚未合并到 main 分支。由于新版 Homebrew 要求 formula 必须在 tap 中，需要创建临时本地 tap 进行测试。

This formula is currently in the `copilot/add-homebrew-formula` branch and hasn't been merged to main yet. Since newer Homebrew versions require formulas to be in a tap, you need to create a temporary local tap for testing.

## 验证步骤 / Verification Steps

### 方法 1: 创建临时本地 Tap 测试（推荐）/ Method 1: Create Temporary Local Tap (Recommended)

```bash
# 1. 克隆此分支到本地 / Clone this branch locally
git clone -b copilot/add-homebrew-formula https://github.com/Jeff-Tian/cli-lab.git
cd cli-lab

# 2. 检查 Formula 语法 / Check formula syntax
ruby -c Formula/dotnet-core-uninstall.rb
# 预期输出 / Expected output: Syntax OK

# 3. 创建本地 tap / Create local tap
brew tap-new jeff-tian/local

# 4. 复制 formula 到 tap / Copy formula to tap
cp Formula/dotnet-core-uninstall.rb "$(brew --repository)/Library/Taps/jeff-tian/homebrew-local/Formula/"

# 5. 安装 / Install
brew install jeff-tian/local/dotnet-core-uninstall

# 6. 验证安装 / Verify installation
dotnet-core-uninstall --version
# 预期输出 / Expected output: 1.7.656206

dotnet-core-uninstall -h
# 应该显示帮助信息 / Should display help information

# 7. 测试基本功能 / Test basic functionality
dotnet-core-uninstall list
# 会列出已安装的 .NET SDK/Runtime（如果有）/ Will list installed .NET SDKs/Runtimes (if any)

# 8. 清理 / Cleanup
brew uninstall dotnet-core-uninstall
brew untap jeff-tian/local
```

### 方法 2: 合并后的安装方式（仅供参考）/ Method 2: Post-merge Installation (For reference only)

**注意：此方法仅在 PR 合并到 main 分支后才能使用** / **Note: This method only works after the PR is merged to main branch**

```bash
# 这些命令在 PR 合并后才能正常工作 / These commands will work after PR is merged
brew tap Jeff-Tian/cli-lab https://github.com/Jeff-Tian/cli-lab
brew install dotnet-core-uninstall
dotnet-core-uninstall --version
brew test dotnet-core-uninstall
```


### 方法 3: 快速语法和结构检查 / Method 3: Quick Syntax and Structure Check

```bash
# 克隆分支 / Clone the branch
git clone -b copilot/add-homebrew-formula https://github.com/Jeff-Tian/cli-lab.git
cd cli-lab

# 只检查 Ruby 语法 / Check Ruby syntax only
ruby -c Formula/dotnet-core-uninstall.rb
# 预期输出 / Expected output: Syntax OK

# 检查 Formula 结构 / Check formula structure
cat Formula/dotnet-core-uninstall.rb
# 应该看到完整的 Formula 定义 / Should see complete formula definition
```

## 常见问题 / Common Issues

### ❌ 问题：brew install 提示 "Homebrew requires formulae to be in a tap" / Issue: brew install says "Homebrew requires formulae to be in a tap"

**原因 / Reason:** 新版 Homebrew 不再支持直接从本地文件安装 formula。

**解决方法 / Solution:** 使用方法 1 创建临时本地 tap 进行测试。

### ❌ 问题：brew tap 后找不到 formula / Issue: Formula not found after brew tap

**原因 / Reason:** Formula 目前只在 PR 分支中，还未合并到 main 分支。Homebrew tap 默认使用 main 分支。

**解决方法 / Solution:** 使用方法 1 创建临时本地 tap 并复制 formula 文件。

### ❌ 问题：brew audit 或 brew style 找不到 formula / Issue: brew audit or brew style can't find formula

**原因 / Reason:** 这些命令需要 formula 在已 tap 的仓库中。

**解决方法 / Solution:** 
1. 使用 `ruby -c` 检查语法
2. 使用方法 1 创建本地 tap 后，可以运行 `brew audit jeff-tian/local/dotnet-core-uninstall`
3. 等待 PR 合并后，再使用标准的 `brew audit` 和 `brew style`

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
