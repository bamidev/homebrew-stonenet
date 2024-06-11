class Stonenet < Formula
  homepage "https://stonenet.org/"
  url "https://github.com/bamidev/stonenet/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "6f3394ac3c0fbe3e25239a7ae0127beeabd80fb4172479a54a3987844d75c413"

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