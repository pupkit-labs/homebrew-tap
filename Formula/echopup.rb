class Echopup < Formula
  desc "EchoPup - AI Voice Dictation Tool - 按住热键说话，自动输入到任意应用"
  homepage "https://github.com/pupkit-labs/echo-pup-rust"
  version "0.0.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-aarch64-apple-darwin.tar.xz"
      sha256 "ae53be94c94e6217a26b7333c8fbeef2248c44d2f8bcd45cf023641bebac2cc6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-x86_64-apple-darwin.tar.xz"
      sha256 "8678bf547f8821611c0cbcb2cf07e150a44cac2d675a3e6f55d1f2d1d7d8ca72"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "1d4fb664bd47d834c3539986e6f25f63a588d038efdcf2a891611c0bc5dd8728"
  end

  def install
    bin.install "echopup"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/echopup --version")
  end
end
