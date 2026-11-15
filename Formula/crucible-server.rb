class CrucibleServer < Formula
  desc "Companion to Plex for Crucible: skips, Previously On and answers from a model you choose"
  homepage "https://github.com/guitaripod/Crucible/tree/master/server"
  license "GPL-3.0-only"
  version "0.6.1"

  livecheck do
    url :stable
    regex(/^server-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on :macos
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.6.1/crucible-server-0.6.1-macos-arm64.tar.gz"
      sha256 "4e496e472bf3179a2c68ff4c6c47b9405ec54b97bc2757c0663647e65a6bc557"
    end
    on_intel do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.6.1/crucible-server-0.6.1-macos-x86_64.tar.gz"
      sha256 "351039e7b3d39f9acb66cb099a8c535c5a8e4a0920c8c2126ad5e1d0712093cf"
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
