class Pupkit < Formula
  desc "A welcome-first CLI for surfacing local environment info and AI usage at a glance."
  homepage "https://github.com/pupkit-labs/pupkit-cli"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v1.0.0/pupkit-aarch64-apple-darwin.tar.xz"
      sha256 "336ed0ba5a50951535aa392602ee1129cc1e79702cc112d11282fbb41bd6b15b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v1.0.0/pupkit-x86_64-apple-darwin.tar.xz"
      sha256 "755bad8620ac809a36bed726e652a7e1f29d5d380ec8b5a799b17c9881155b7a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v1.0.0/pupkit-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "7bd97458fec887e2860d3bc25c506625a8c35603e5254242dc57d943bf005a29"
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
