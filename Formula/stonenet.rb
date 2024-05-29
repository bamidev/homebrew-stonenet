class Stonenet < Formula
  homepage "https://stonenet.org/"
  url "https://github.com/bamidev/stonenet/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "9cf00fe41c38231e2e9649aadf778591528589a4666072739b68aaaa002017c8"

  depends_on "rust"

  service do
    run opt_bin/"stonenetd"
    working_dir HOMEBREW_PREFIX/"share/stonenet"
    process_type :background
    keep_alive true
  end

  def install
    args = %W[
      PREFIX=#{prefix}
    ]
    system "cargo", "build", "--release"

    bin.install "target/release/stonenetd" => "stonenetd"
    system "install", "conf/default.toml", "-D", "#{prefix}/etc/config.toml"
    system "mkdir", "-p", "#{prefix}/share/stonenet"
    system "cp", "-r", "static", "#{prefix}/share/stonenet"
    system "cp", "-r", "templates", "#{prefix}/share/stonenet"
    system "mkdir", "-p", "#{prefix}/var/lib/stonenet"
    system "mkdir", "-p", "#{prefix}/var/log"
  end
end