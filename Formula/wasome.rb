class Wasome < Formula
  desc "The WebAssembly Language for Everyone"
  homepage "https://wasome.dev/"
  version "0.1.0-rc9"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Randware/Wasome/releases/download/0.1.0-rc9/wasome-aarch64-apple-darwin.tar.gz"
      sha256 "2153ed65453de63fc5a7a87957e925dd33316d4e4824a01e1aeee404500ce850"
    else
      url "https://github.com/Randware/Wasome/releases/download/0.1.0-rc9/wasome-x86_64-apple-darwin.tar.gz"
      sha256 "f29f37e5812f7c1095bb068a282e4a92403ba88c6b8d8e1d76a70a75bd33334f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Randware/Wasome/releases/download/0.1.0-rc9/wasome-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1aee435e4f1236a46f0db7254cbcb0a2dd605779f4465a5b8a1058a8615ebf41"
    else
      url "https://github.com/Randware/Wasome/releases/download/0.1.0-rc9/wasome-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ded2758a7e91bf9c2c42cf73e2d091374d2ba9470977dccb433a1b55ca0cd9a4"
    end
  end

  def install
    libexec.install "bin", "lib", "std"
    bin.install_symlink libexec/"bin/waso"
  end
end
