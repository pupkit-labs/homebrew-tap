class Pupkit < Formula
  desc "A welcome-first CLI for surfacing local environment info and AI usage at a glance."
  homepage "https://github.com/pupkit-labs/pupkit-cli"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v0.0.3/pupkit-aarch64-apple-darwin.tar.xz"
      sha256 "4c2c46293661dbdb40e1e8410d2b6f07559780b54a00e5a3972fd4369226e62e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v0.0.3/pupkit-x86_64-apple-darwin.tar.xz"
      sha256 "4f763d692ff662529418a73cdf18858adcc719e4418362121da15331102254ba"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v0.0.3/pupkit-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "21704c0f2e07e42fcdda457fa4dda8c69ec8bfffe8a737650f78b0e2f31b67dc"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "pupkit" if OS.mac? && Hardware::CPU.arm?
    bin.install "pupkit" if OS.mac? && Hardware::CPU.intel?
    bin.install "pupkit" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
