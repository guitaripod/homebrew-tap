class CrucibleServer < Formula
  desc "Companion to Plex for Crucible: skips, Previously On and answers from a model you choose"
  homepage "https://github.com/guitaripod/Crucible/tree/master/server"
  license "GPL-3.0-only"
  version "0.6.2"

  livecheck do
    url :stable
    regex(/^server-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on :macos
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.6.2/crucible-server-0.6.2-macos-arm64.tar.gz"
      sha256 "4879f9cdb1da13218930f49791465259f71f53bb196967e7587349ddaeaad727"
    end
    on_intel do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.6.2/crucible-server-0.6.2-macos-x86_64.tar.gz"
      sha256 "9ce854342b2c22d560b2006b47a1ddbf16ec7f256d379a89a8bbae58fc3fb7d2"
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
