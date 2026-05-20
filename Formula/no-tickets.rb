class NoTickets < Formula
  desc "no-tickets CLI — Rust port (Phase 2/3 of cross-platform-cli-binary fix)"
  homepage "https://github.com/magic-ingredients/no-tickets"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.3/no-tickets-aarch64-apple-darwin.tar.gz"
      sha256 "32a6b3761a874ffa85d78a603de5e1cc31043a3130123e4244201b4bd6fac7aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.3/no-tickets-x86_64-apple-darwin.tar.gz"
      sha256 "09b6446c22469818e1ca7b1dfbc70eff187615526a02ee76c5f8cf305ca26516"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.3/no-tickets-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b6b3244a7f13e1b256ba5a24683736580ef943503ea04f375802a36b7d71057e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.3/no-tickets-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9a4e28562cf56f7e02e3ac67c9288c85f4f4151b4a082c2d7459417c7af9eb90"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
    bin.install "no-tickets", "no-tickets-mcp" if OS.mac? && Hardware::CPU.arm?
    bin.install "no-tickets", "no-tickets-mcp" if OS.mac? && Hardware::CPU.intel?
    bin.install "no-tickets", "no-tickets-mcp" if OS.linux? && Hardware::CPU.arm?
    bin.install "no-tickets", "no-tickets-mcp" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
