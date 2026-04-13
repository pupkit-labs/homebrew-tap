class Pupkit < Formula
  desc "A welcome-first CLI for surfacing local environment info and AI usage at a glance."
  homepage "https://github.com/pupkit-labs/pupkit-cli"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v1.0.0/pupkit-aarch64-apple-darwin.tar.xz"
      sha256 "55488bde8f2f9be5904afe7118b1796371700152a864bc034cd2c55d2989fb2e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v1.0.0/pupkit-x86_64-apple-darwin.tar.xz"
      sha256 "f94d9394f1e7ee2dc095fea12709b6a65e0ee2815519a3e58a49a9522f252839"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v1.0.0/pupkit-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "e76fc4300b4832ec9890493b0cb2f78e3355477ec6de8abc6a111324e24e68c3"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pupkit"
      bin.install "PupkitShell" if File.exist?("PupkitShell")
      if File.directory?("PupkitShell_PupkitShell.bundle")
        (prefix/"bin"/"PupkitShell_PupkitShell.bundle").install Dir["PupkitShell_PupkitShell.bundle/**/*"]
      end
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pupkit"
      bin.install "PupkitShell" if File.exist?("PupkitShell")
      if File.directory?("PupkitShell_PupkitShell.bundle")
        (prefix/"bin"/"PupkitShell_PupkitShell.bundle").install Dir["PupkitShell_PupkitShell.bundle/**/*"]
      end
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pupkit"
      bin.install "PupkitShell" if File.exist?("PupkitShell")
      if File.directory?("PupkitShell_PupkitShell.bundle")
        (prefix/"bin"/"PupkitShell_PupkitShell.bundle").install Dir["PupkitShell_PupkitShell.bundle/**/*"]
      end
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
