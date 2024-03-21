class Stonenet < Formula
  homepage "https://stonenet.org/"
  url "https://github.com/bamidev/stonenet/archive/refs/tags/v0.0.17.tar.gz"
  sha256 "06cecc3336902ee1560af2455f65fc10833b1e0ac7e0ec03283ebf7347b7625d"

  depends_on "rust"

  def install
    args = %W[
      PREFIX=#{prefix}
    ]
    system *args, "./install.sh"
  end
end

