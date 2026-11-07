class CrucibleServer < Formula
  desc "Companion to Plex for Crucible: skips, Previously On and answers from a local model"
  homepage "https://github.com/guitaripod/Crucible/tree/master/server"
  license "GPL-3.0-only"
  version "0.1.0"

  livecheck do
    url :stable
    regex(/^server-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on :macos
  depends_on "ffmpeg"

  on_macos do
    on_arm do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.1.0/crucible-server-0.1.0-macos-arm64.tar.gz"
      sha256 "43546fcdae7a105f8aff1490c06237141d1c1caf51c6f82a1979d9f0f0d51457"
    end
    on_intel do
      url "https://github.com/guitaripod/Crucible/releases/download/server-v0.1.0/crucible-server-0.1.0-macos-x86_64.tar.gz"
      sha256 "febcbfb899e45a47b94e4459b62cb5924082d206117c1f7bb0280ee70c3a8c95"
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
