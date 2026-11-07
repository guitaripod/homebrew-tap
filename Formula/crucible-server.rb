class CrucibleServer < Formula
  desc "Companion to Plex for Crucible: skips, Previously On and answers from a local model"
  homepage "https://github.com/guitaripod/Crucible/tree/master/server"
  license "GPL-3.0-only"
  version "0.2.0"

  livecheck do
    url :stable
    regex(/^server-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on :macos
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.2.0/crucible-server-0.2.0-macos-arm64.tar.gz"
      sha256 "86a4fe25703812c0044bdeecc02bdbb660694c3c9da50e00c5aa3326c758f425"
    end
    on_intel do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.2.0/crucible-server-0.2.0-macos-x86_64.tar.gz"
      sha256 "2e0423e988b728d0fd3bf862bbbe4efd52a4b80f9438fe1c46e66fdace73e36a"
    end
  end

  def install
    bin.install "crucible-server"
  end

  def caveats
    <<~EOS
      Run `crucible-server setup` once, on the Mac that runs Plex.
      It signs you in with Plex, finds a local model, keeps the server running and shows the QR code that pairs Crucible.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/crucible-server --version")
  end
end
