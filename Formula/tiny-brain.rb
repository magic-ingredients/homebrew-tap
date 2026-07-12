class TinyBrain < Formula
  desc "Tiny Brain AI assistant — modular TDD workflow CLI"
  homepage "https://github.com/magic-ingredients/tiny-brain-releases"
  url "https://registry.npmjs.org/@magic-ingredients/tiny-brain/-/tiny-brain-0.27.2.tgz"
  version "0.27.2"
  sha256 "e3c3df5ada44bdeadc4fc219cf317534b8c594c72125c8f94c770db8143bcaa2"
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
