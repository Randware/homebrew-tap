class Wasome < Formula
  desc "The WebAssembly Language for Everyone"
  homepage "https://wasome.dev/"
  version "0.1.0-rc8"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Randware/Wasome/releases/download/0.1.0-rc8/wasome-aarch64-apple-darwin.tar.gz"
      sha256 "f2a06cc8275a98b0f171b65b9fd303b464a8f4e230ba658ad733728225624abe"
    else
      url "https://github.com/Randware/Wasome/releases/download/0.1.0-rc8/wasome-x86_64-apple-darwin.tar.gz"
      sha256 "6e6addf5f981e36d1c72843cc851ab608ecba56786910893e726f92c4a14933c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Randware/Wasome/releases/download/0.1.0-rc8/wasome-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9fba8b7305d73044f54e2003e5ec11293760e3fcaf59aa64729658c2e6915634"
    else
      url "https://github.com/Randware/Wasome/releases/download/0.1.0-rc8/wasome-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "22f6c0db2e5b70a8c913d5c39a9aa26b30e816b73875aff31ab0828a89c7c376"
    end
  end

  def install
    libexec.install "bin", "lib", "std"
    bin.install_symlink libexec/"bin/waso"
  end
end
