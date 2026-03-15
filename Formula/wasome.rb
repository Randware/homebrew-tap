class Wasome < Formula
  desc "The WebAssembly Language for Everyone"
  homepage "https://wasome.dev/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-aarch64-apple-darwin.tar.xz"
      sha256 "7360acfd6564962d13997812fea5c379e993a3cc388e86e12d6e7cd07c3c8942"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-x86_64-apple-darwin.tar.xz"
      sha256 "755d91766d380e9326f550c934a5065cff2f08384c40979ffaa0054fa9661964"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "31f6e67bde3af8dd0293fa01c34da273da22946bf74e9b517fbcfec0b566fe7f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "746df8313e25ddd4dbf07cf0483eaa0eff09a83e8baef909f4c73ef9ae1942c1"
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
