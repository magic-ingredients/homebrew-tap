class TinyBrain < Formula
  desc "Tiny Brain AI assistant — modular TDD workflow CLI"
  homepage "https://github.com/magic-ingredients/tiny-brain-releases"
  url "https://registry.npmjs.org/@magic-ingredients/tiny-brain/-/tiny-brain-0.28.1.tgz"
  version "0.28.1"
  sha256 "659844928bdca827b0350d15cfe78ec5f2630040f9f5d898b2d896e0a7d47618"
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
