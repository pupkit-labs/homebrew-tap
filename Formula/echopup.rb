class Echopup < Formula
  desc "EchoPup - AI Voice Dictation Tool - 按住热键说话，自动输入到任意应用"
  homepage "https://github.com/pupkit-labs/echo-pup-rust"
  version "0.0.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-aarch64-apple-darwin.tar.xz"
      sha256 "49655de18dafe6fd480375e16dc147496b296b146570c84ad531f5def9c562ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-x86_64-apple-darwin.tar.xz"
      sha256 "a9720b456e4ebe86d0524555f7790693c6ab924773cd6fa58f26e9cfeff14d8d"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "1e3e2b465b1e116dd77be777544d48811485a0640d3f7ec8e3b5d53e56c9cbcf"
  end

  def install
    bin.install "echopup"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/echopup --version")
  end
end
