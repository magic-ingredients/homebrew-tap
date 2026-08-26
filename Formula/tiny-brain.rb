class TinyBrain < Formula
  desc "Tiny Brain AI assistant — modular TDD workflow CLI"
  homepage "https://github.com/magic-ingredients/tiny-brain-releases"
  url "https://registry.npmjs.org/@magic-ingredients/tiny-brain/-/tiny-brain-0.29.0.tgz"
  version "0.29.0"
  sha256 "0fa03c5d0ee336d3cdc007df9918c5e109f62e9867679a52d498639bbbc55c75"
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
