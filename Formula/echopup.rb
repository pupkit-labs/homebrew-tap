class Echopup < Formula
  desc "EchoPup - AI Voice Dictation Tool - 按住热键说话，自动输入到任意应用"
  homepage "https://github.com/pupkit-labs/echo-pup-rust"
  version "0.0.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-aarch64-apple-darwin.tar.xz"
      sha256 "280f04bac00333b9fc383057720c44769dda429be9183850cf359562a9cc00c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-x86_64-apple-darwin.tar.xz"
      sha256 "bd05f6c2ae3ad19bbfaa1dc959caa8344c6474dd4ec21660b0d678081deb5761"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "d038493c5c0d9d5d2215487ef01af336304a4f447951745b573a2a162e741980"
  end

  def install
    bin.install "echopup"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/echopup --version")
  end
end
