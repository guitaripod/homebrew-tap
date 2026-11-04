class ClaudeBridge < Formula
  desc "Bridge that lets Tailscode drive Claude Code on this Mac over Tailscale"
  homepage "https://github.com/guitaripod/claude-bridge"
  url "https://github.com/guitaripod/claude-bridge/releases/download/1.18.0/claude-bridge-1.18.0-darwin-arm64.tar.gz"
  sha256 "d1ac04ee08ac0d32e55d69321acdf43a7b0a31f0216f8694ba4e478660fddf83"
  license "GPL-3.0-only"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "claude-bridge"
    sign_with_fixed_identity bin/"claude-bridge"
  end

  def sign_with_fixed_identity(binary)
    identifier = "com.guitaripod.claude-bridge"
    system "codesign", "--force", "--sign", "-", "--identifier", identifier,
           "--requirements", "=designated => identifier \"#{identifier}\"", binary
  end

  service do
    run [opt_bin/"claude-bridge"]
    keep_alive true
    log_path var/"log/claude-bridge.log"
    error_log_path var/"log/claude-bridge.log"
  end

  def caveats
    <<~EOS
      Start it with:  brew services start claude-bridge
      Then run:       claude-bridge pair
      to show the code Tailscode scans.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claude-bridge --version")
  end
end
