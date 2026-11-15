class CrucibleServer < Formula
  desc "Companion to Plex for Crucible: skips, Previously On and answers from a model you choose"
  homepage "https://github.com/guitaripod/Crucible/tree/master/server"
  license "GPL-3.0-only"
  version "0.4.0"

  livecheck do
    url :stable
    regex(/^server-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on :macos
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.4.0/crucible-server-0.4.0-macos-arm64.tar.gz"
      sha256 "d7bd711a00c6f4e514d4b0f56207b217a8803be08a6f0819df9942825404f594"
    end
    on_intel do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.4.0/crucible-server-0.4.0-macos-x86_64.tar.gz"
      sha256 "8ecc124029ee49b71574b6177bc76714dbd15d5e19688639038fc48437beb3f9"
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
