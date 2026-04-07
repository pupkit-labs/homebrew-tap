class Pupkit < Formula
  desc "A welcome-first CLI for surfacing local environment info and AI usage at a glance."
  homepage "https://github.com/pupkit-labs/pupkit-cli"
  version "0.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v0.0.6/pupkit-aarch64-apple-darwin.tar.xz"
      sha256 "42904a62653f4d9d7f90a48e5c869db5de4edfa6ea9b5c8d322ad5fe4cb3d498"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v0.0.6/pupkit-x86_64-apple-darwin.tar.xz"
      sha256 "47bab8cf2f7caf3559d4b70bd445ad799f6f58eef3de8bf63986b31fa16937cd"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v0.0.6/pupkit-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "6cae0d32dcd96ab3450c58c1c9820ae5f10ec4336d28095f8ed211086b02b30d"
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
