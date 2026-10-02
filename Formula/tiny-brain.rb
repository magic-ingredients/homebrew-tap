class TinyBrain < Formula
  desc "Tiny Brain AI assistant — modular TDD workflow CLI"
  homepage "https://github.com/magic-ingredients/tiny-brain-releases"
  url "https://registry.npmjs.org/@magic-ingredients/tiny-brain/-/tiny-brain-0.30.3.tgz"
  version "0.30.3"
  sha256 "7faf4e40b5f06ddac72e2410dfe013a74cf31ff8b4eee537b040f6985bfcff56"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{bin}/tiny-brain", "--version"
    system "#{bin}/tb", "--version"
  end

  def caveats
    <<~EOS
      To set up tiny-brain with your agent clients, run:
        tiny-brain configure
    EOS
  end
end
