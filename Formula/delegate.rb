class Delegate < Formula
  desc "Hands bounded coding tasks to the cheapest model tier that passes verification"
  homepage "https://github.com/guitaripod/delegate"
  url "https://github.com/guitaripod/delegate/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "1b43032e8438b8fd412bfe1588d12b8c6872123e35c4eadbbbdb2146b2f58aa8"
  license "GPL-3.0-only"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    sign_with_fixed_identity bin/"delegate" if OS.mac?
  end

  def sign_with_fixed_identity(binary)
    identifier = "com.guitaripod.delegate"
    system "codesign", "--force", "--sign", "-", "--identifier", identifier,
           "--requirements", "=designated => identifier \"#{identifier}\"", binary
  end

  service do
    run [opt_bin/"delegate", "serve"]
    keep_alive true
    log_path var/"log/delegate.log"
    error_log_path var/"log/delegate.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/delegate --version")
  end
end
