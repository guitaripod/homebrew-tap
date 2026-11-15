class CrucibleServer < Formula
  desc "Companion to Plex for Crucible: skips, Previously On and answers from a model you choose"
  homepage "https://github.com/guitaripod/Crucible/tree/master/server"
  license "GPL-3.0-only"
  version "0.5.4"

  livecheck do
    url :stable
    regex(/^server-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on :macos
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.5.4/crucible-server-0.5.4-macos-arm64.tar.gz"
      sha256 "317aa9bf135bb0bbe4c075ef2d80a3fa41988d98c1a43f8b74c4b8f414a09780"
    end
    on_intel do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.5.4/crucible-server-0.5.4-macos-x86_64.tar.gz"
      sha256 "a27efaf190e5ea6bd249fc2a6093e4233f6af31a8c7b0038b5245e0aaf978168"
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
