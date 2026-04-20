class Echopup < Formula
  desc "EchoPup - AI Voice Dictation Tool - 按住热键说话，自动输入到任意应用"
  homepage "https://github.com/pupkit-labs/echo-pup-rust"
  version "0.0.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-aarch64-apple-darwin.tar.xz"
      sha256 "cb3ab4ca8584aa32b6845e49588958a46fc16190c43bf77eb7c9c6077fc71bba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-x86_64-apple-darwin.tar.xz"
      sha256 "04f4cf603ae305b5ccfaad97bf2ec2169d128e94f6a5a35f18694e312d4701c2"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pupkit-labs/echo-pup-rust/releases/download/v0.0.1/echopup-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "7d198a085c5653f51ea8e3a7d14a979ef2e928e87427179223e1545632c19294"
  end

  def install
    bin.install "echopup"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/echopup --version")
  end
end
