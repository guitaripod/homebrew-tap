class ClaudeBridge < Formula
  desc "Bridge that lets Tailscode drive Claude Code on this Mac over Tailscale"
  homepage "https://github.com/guitaripod/claude-bridge"
  url "https://github.com/guitaripod/claude-bridge/releases/download/1.15.3/claude-bridge-1.15.3-darwin-arm64.tar.gz"
  sha256 "bb01ce54b1c605a957d9664ee0842fea1630fece21f37f8ad9819d5baf5bf7f7"
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
