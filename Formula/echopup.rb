class Echopup < Formula
  desc "EchoPup - AI Voice Dictation Tool - 按住热键说话，自动输入到任意应用"
  homepage "https://github.com/pupkit-labs/echo-pup-rust"
  version "0.0.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-aarch64-apple-darwin.tar.xz"
      sha256 "97ecc1ffbb7a7b4af54291e7bf3f276d52728bc9fedc56241bf89e4e261289e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-x86_64-apple-darwin.tar.xz"
      sha256 "32a758eccf571521ddcdd433a31f75d707ebd26de3eb6ea2982c53a6ff88b05b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "4a318603c18d4482b07a6c3884f1cd5b80df281e10fbfd1bbeeca98f7ab11d16"
  end

  def install
    bin.install "echopup"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/echopup --version")
  end
end
