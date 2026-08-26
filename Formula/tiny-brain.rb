class TinyBrain < Formula
  desc "Tiny Brain AI assistant — modular TDD workflow CLI"
  homepage "https://github.com/magic-ingredients/tiny-brain-releases"
  url "https://registry.npmjs.org/@magic-ingredients/tiny-brain/-/tiny-brain-0.29.1.tgz"
  version "0.29.1"
  sha256 "0280682b9de80976997d5a766638a19fb07c51c116006c48ba8726058791f6f4"
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
