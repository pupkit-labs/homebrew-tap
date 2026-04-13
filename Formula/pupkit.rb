class Pupkit < Formula
  desc "A welcome-first CLI for surfacing local environment info and AI usage at a glance."
  homepage "https://github.com/pupkit-labs/pupkit-cli"
  version "1.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v1.0.2/pupkit-aarch64-apple-darwin.tar.xz"
      sha256 "bbad18f1e8b5885d023c8c735de6a3594a4590a21c3b714e5f65a44bf056e52c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v1.0.2/pupkit-x86_64-apple-darwin.tar.xz"
      sha256 "48dffc9c45e1f600d2d51f27fcec3251d07b3ca706cab1ac7022937e562aded8"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/pupkit-labs/pupkit-cli/releases/download/v1.0.2/pupkit-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "5cab7eea4be2e63f8f564845e7b7b96fbdaed5bcc6a2f145a5a9b4b8d76f42f1"
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
