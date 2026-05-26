class NoTickets < Formula
  desc "no-tickets CLI — Rust port (Phase 2/3 of cross-platform-cli-binary fix)"
  homepage "https://github.com/magic-ingredients/no-tickets"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.4/no-tickets-aarch64-apple-darwin.tar.gz"
      sha256 "18a6c638d84f1980781c0c91a626560a6b9c79996e61d30657c53d5fb2aaa93a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.4/no-tickets-x86_64-apple-darwin.tar.gz"
      sha256 "ee187aa187728fa892207cdcade7d2345f412203cf53ae38811f87ebf807ec4c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.4/no-tickets-aarch64-unknown-linux-musl.tar.gz"
      sha256 "866169cf1e3d3585a44aaf8e739fba8a32a52713d0c355f66eed9cd469f2b553"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.4/no-tickets-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f97d51c4831fc36da3e21bcf1a57d78a60b3e4cca1b1dc49fcec76b0958e541f"
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
