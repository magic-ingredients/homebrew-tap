class NoTickets < Formula
  desc "no-tickets CLI — Rust port (Phase 2/3 of cross-platform-cli-binary fix)"
  homepage "https://github.com/magic-ingredients/no-tickets"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.2/no-tickets-aarch64-apple-darwin.tar.xz"
      sha256 "ebb0cba3080dc97db7f50ab7f5d383143b085fe32b3d145880d84284cf76d683"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.2/no-tickets-x86_64-apple-darwin.tar.xz"
      sha256 "b753233d4911d3e600fdeb7a47b890cdfff9db98aef2e9bdf3f90c07fd775dee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.2/no-tickets-aarch64-unknown-linux-musl.tar.xz"
      sha256 "34f2b64ff7a8f33692aaf78a2a59b392e312bf5084939c835c6564f249a5f677"
    end
    if Hardware::CPU.intel?
      url "https://github.com/magic-ingredients/no-tickets/releases/download/v0.1.2/no-tickets-x86_64-unknown-linux-musl.tar.xz"
      sha256 "b380c21803f2fa5c8b50b95607dfedf96ad2f06670717369639ca4929db2aaa6"
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
