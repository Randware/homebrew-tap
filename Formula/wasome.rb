class Wasome < Formula
  desc "The WebAssembly Language for Everyone"
  homepage "https://wasome.dev/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-aarch64-apple-darwin.tar.xz"
      sha256 "a329ef457959fa0a51320a99ab787df9fb8ab1bdade730cd2ac9f31b42d9f778"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-x86_64-apple-darwin.tar.xz"
      sha256 "ae81bf82863fbbfeda9c4d0b2daf22a8055f64be7cc1c6cebe96ca9daded7827"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "39f72654bb1f398d3d3e186c076b4e57e334dee2d330609e2a9613d3d9b2c4e9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Randware/Wasome/releases/download/v0.1.0/wasome-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3ccd76366158730cd5fa444670329c0d4ff1c90cf35af0a3ca2b88d1022d3a1e"
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
