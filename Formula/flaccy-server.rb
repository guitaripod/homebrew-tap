class FlaccyServer < Formula
  desc "Headless OpenSubsonic server for one music folder, made for Flaccy"
  homepage "https://github.com/guitaripod/flaccy"
  license "GPL-3.0-only"

  livecheck do
    url :stable
    regex(/^server-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on :macos
  depends_on "ffmpeg" => :recommended

  on_macos do
    on_arm do
      url "https://github.com/guitaripod/flaccy/releases/download/server-v1.2.0/flaccy-server-1.2.0-macos-arm64.tar.gz"
      sha256 "8c2fc7bba9157147da368e15eaa1180b2b9a0666386b79b82a72ad49423a4a83"
    end
    on_intel do
      url "https://github.com/guitaripod/flaccy/releases/download/server-v1.2.0/flaccy-server-1.2.0-macos-x86_64.tar.gz"
      sha256 "4f2adc99c6d93e2e7389afce53bdc67a6c6759e6b48d1bba561d50be2d2ce72a"
    end
  end

  def install
    bin.install "flaccy-server"
    sign_with_fixed_identity bin/"flaccy-server"
  end

  def sign_with_fixed_identity(binary)
    identifier = "cc.midgarcorp.flaccy-server"
    system "codesign", "--force", "--sign", "-", "--identifier", identifier,
           "--requirements", "=designated => identifier \"#{identifier}\"", binary
  end

  service do
    run [opt_bin/"flaccy-server", "serve"]
    keep_alive true
    environment_variables PATH: std_service_path_env
    log_path var/"log/flaccy-server.log"
    error_log_path var/"log/flaccy-server.log"
  end

  def caveats
    <<~EOS
      Run `flaccy-server setup` once.
      It asks for your music folder, scans it and prints the QR code that enrolls your first device.
      To let Homebrew run the server instead of the launch agent setup writes, use
        brew services start flaccy-server
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/flaccy-server --version")
  end
end
