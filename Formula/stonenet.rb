class Stonenet < Formula
  homepage "https://stonenet.org/"
  url "https://github.com/bamidev/stonenet/archive/refs/tags/v0.0.26.tar.gz"
  sha256 "ff3766a9f8684b48ccb10dd62d594ce0e695d02a371355784a68e309fdfd7fda"

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