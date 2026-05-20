class NoTickets < Formula
  desc "no-tickets CLI — Rust port (Phase 2/3 of cross-platform-cli-binary fix)"
  homepage "https://github.com/magic-ingredients/no-tickets"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.0/no-tickets-aarch64-apple-darwin.tar.xz"
      sha256 "778326b06133b98ae51cbc8bdeba5e5e8df71eca098e7c2af00a623bad5ad99b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.0/no-tickets-x86_64-apple-darwin.tar.xz"
      sha256 "61f5ae97265c6f5ce420545633414337c179009c967158fa0ff3695ed31bdb06"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.0/no-tickets-aarch64-unknown-linux-musl.tar.xz"
      sha256 "682e80540456d36bec2f62c861dd7f8e0c94ef1e45dad06af81d77937d9420e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.0/no-tickets-x86_64-unknown-linux-musl.tar.xz"
      sha256 "a6cb15f39a919b2c7c44b97c7581141ffb79c2a4ab0cc0b13b56f1fff3d841d5"
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
    bin.install "nt", "nt-mcp" if OS.mac? && Hardware::CPU.arm?
    bin.install "nt", "nt-mcp" if OS.mac? && Hardware::CPU.intel?
    bin.install "nt", "nt-mcp" if OS.linux? && Hardware::CPU.arm?
    bin.install "nt", "nt-mcp" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
