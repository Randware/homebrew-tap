class Waso < Formula
  desc "The WebAssembly Language for Everyone"
  homepage "https://wasome.dev/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-aarch64-apple-darwin.tar.xz"
      sha256 "764b8d49e97beb24e2a34c1cae271f07ccb680346fd7bc8819379dedb9071ffc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-x86_64-apple-darwin.tar.xz"
      sha256 "8ae263f1f7cda3847a4e39655cdd820ab5e1c17b86d1aa72108239a554e4ce63"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ff140d249dcbd40f17048e98d225d50210812dff35d4aef21dadcb6a27d06677"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9860775ea081e1afcccbf6a64131082e6e0646aee1e8d4a7645d725d883b0bbb"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "waso" if OS.mac? && Hardware::CPU.arm?
    bin.install "waso" if OS.mac? && Hardware::CPU.intel?
    bin.install "waso" if OS.linux? && Hardware::CPU.arm?
    bin.install "waso" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
