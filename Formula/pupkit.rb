class Pupkit < Formula
  desc "A welcome-first CLI for surfacing local environment info and AI usage at a glance."
  homepage "https://github.com/pupkit-labs/pupkit-cli"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v0.0.2/pupkit-aarch64-apple-darwin.tar.xz"
      sha256 "3947583887a7e8cfc621dac4907ef4dd4279adb297afb23ff882f90397a2064d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v0.0.2/pupkit-x86_64-apple-darwin.tar.xz"
      sha256 "edaac644e5ab48172e021e54a3328dbf37386cfd77499cea8267973e0bc36e5e"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v0.0.2/pupkit-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "9d66d1881f6b47479b11e66025d64977aa7b45ccc73ad44aab50987f38d509a4"
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
