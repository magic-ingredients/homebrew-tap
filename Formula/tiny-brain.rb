class TinyBrain < Formula
  desc "Tiny Brain AI assistant — modular TDD workflow CLI"
  homepage "https://github.com/magic-ingredients/tiny-brain-releases"
  url "https://registry.npmjs.org/@magic-ingredients/tiny-brain/-/tiny-brain-0.27.1.tgz"
  version "0.27.1"
  sha256 "7ab992ef1e162cbfa7d9578a622635087695f1d5f2fad14da2cc8ef50a2fcf9d"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{bin}/tiny-brain", "--version"
  end

  def caveats
    <<~EOS
      To install the Claude Code plugin, run:
        tiny-brain install plugin
    EOS
  end
end
