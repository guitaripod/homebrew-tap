class CrucibleServer < Formula
  desc "Companion to Plex for Crucible: skips, Previously On and answers from a model you choose"
  homepage "https://github.com/guitaripod/Crucible/tree/master/server"
  license "GPL-3.0-only"
  version "0.6.0"

  livecheck do
    url :stable
    regex(/^server-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on :macos
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.6.0/crucible-server-0.6.0-macos-arm64.tar.gz"
      sha256 "4cb26506c366483fcfebec67560e4288a4077e2236d80bbd0616852aa7285b22"
    end
    on_intel do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.6.0/crucible-server-0.6.0-macos-x86_64.tar.gz"
      sha256 "7f41c6058f36def8f114c1f5d9b59cd0fe992c623d0f94255c852cf5ee528eef"
    end
  end

  def install
    bin.install "crucible-server"
  end

  def caveats
    <<~EOS
      Run `crucible-server setup` once, on the Mac that runs Plex.
      It signs you in with Plex, finds a local model, keeps the server running and shows the QR code that pairs Crucible.
      No local model? Use a hosted one with your own key: crucible-server model --url ADDRESS --name NAME --key-file FILE
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/crucible-server --version")
  end
end
