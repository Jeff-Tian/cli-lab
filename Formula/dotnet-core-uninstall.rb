class DotnetCoreUninstall < Formula
  desc "Uninstall tool for .NET Core SDK, Runtime, ASP.NET Core Runtime, and Hosting Bundles"
  homepage "https://github.com/dotnet/cli-lab"
  version "1.7.656206"
  license "MIT"

  # Note: This formula taps from Jeff-Tian/cli-lab which hosts the Homebrew formula.
  # The binaries are from the official dotnet/cli-lab releases.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/dotnet/cli-lab/releases/download/1.7.656206/dotnet-core-uninstall-osx-arm64.tar.gz"
      sha256 "a7219580de19f24dc77302c2676d3f557e568b4e9e7994a600ffbc8c265f1ce4"
    else
      url "https://github.com/dotnet/cli-lab/releases/download/1.7.656206/dotnet-core-uninstall-osx-x64.tar.gz"
      sha256 "94d66b3914597e2cf66cd1521d6abff852619d9bb24621c7f0e67304c32240e7"
    end
  end

  def install
    bin.install "dotnet-core-uninstall"
  end

  def caveats
    <<~EOS
      ====================================
      dotnet-core-uninstall 安装成功！
      ====================================

      使用方法 / Usage:

      1. 列出所有已安装的 .NET SDK 和 Runtime
         List all installed .NET SDKs and Runtimes:
         $ dotnet-core-uninstall list

      2. 执行 dry run 以查看将被卸载的内容（不会实际卸载）
         Perform a dry run to see what would be uninstalled:
         $ dotnet-core-uninstall dry-run --all --sdk

      3. 卸载特定版本的 SDK
         Uninstall a specific SDK version:
         $ dotnet-core-uninstall remove --sdk <version>

      4. 显示帮助信息
         Show help:
         $ dotnet-core-uninstall -h

      更多信息请访问 / For more information:
      https://aka.ms/dotnet-core-uninstall-docs

      GitHub 仓库 / GitHub Repository:
      https://github.com/dotnet/cli-lab
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dotnet-core-uninstall --version 2>&1")
  end
end
