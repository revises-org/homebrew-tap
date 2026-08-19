class Cram < Formula
  desc "AI gateway — use Vertex AI from any editor that only speaks Bearer tokens"
  homepage "https://cram.ink"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/revises-org/cram/releases/download/v0.1.3/cram-aarch64-apple-darwin.tar.xz"
      sha256 "eadd2c9f06f6fbb4639f1aff719d44e3a352c7a842364618851c68e6d3d1b487"
    end
    if Hardware::CPU.intel?
      url "https://github.com/revises-org/cram/releases/download/v0.1.3/cram-x86_64-apple-darwin.tar.xz"
      sha256 "fb7bd09632d496e2a2c1f4b111cb1356e3426f11a1f971982f1868cf58bd0d0f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/revises-org/cram/releases/download/v0.1.3/cram-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dd0c712bff9a8e32c1e7978142a0b061dea5618ab431669b341e7ac09b1d17ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/revises-org/cram/releases/download/v0.1.3/cram-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b8fe09012c33b44b280d8916c453d8aaffb859319f3499ac6414e366387a4043"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cram"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cram"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cram"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cram"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
