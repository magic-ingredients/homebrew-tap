class NoTickets < Formula
  desc "no-tickets CLI — Rust port (Phase 2/3 of cross-platform-cli-binary fix)"
  homepage "https://github.com/magic-ingredients/no-tickets"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.1/no-tickets-aarch64-apple-darwin.tar.xz"
      sha256 "fe71ddd71254c3d1bc4fbc271fc42753bce3deea96fced31205e3d2bb606ed25"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.1/no-tickets-x86_64-apple-darwin.tar.xz"
      sha256 "a3c69caa9ec02375654918073470bd5291a3832717f0e52bdff8f36fe5753a6c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.1/no-tickets-aarch64-unknown-linux-musl.tar.xz"
      sha256 "9be953a256c1e7fa001cede69f580cd93542e0a50163c42f998d15c0b7d1e96c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.1/no-tickets-x86_64-unknown-linux-musl.tar.xz"
      sha256 "67a5c2cb85ab7b049382aee720a71dec9e771e7479a82f7985a737f0fa6c5a33"
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
