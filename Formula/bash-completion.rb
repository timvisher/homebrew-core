# NOTE: version 2 is out, but it requires Bash 4, and macOS ships
# with 3.2.57. If you've upgraded bash, use bash-completion@2 instead.
class BashCompletion < Formula
  desc "Programmable completion for Bash 3.2"
  homepage "https://github.com/scop/bash-completion"
  url "https://github.com/scop/bash-completion/archive/1.3.tar.gz"
  sha256 "e0edb2540cc7e8904a9e517983e8a2c3a27fc2d80f6210398fca2a1c093224ae"
  revision 3

  bottle do
    cellar :any_skip_relocation
    sha256 "9219c2b46362677e9ae6e19b344b774c3e9f163ae6bf6cf2686da06419aaec89" => :mojave
    sha256 "b069be5574bdf6d12fd1fda17c3162467b68165541166d95d1a9474653a63abc" => :high_sierra
    sha256 "58be92ef01d5068f37b1c00af8e9b202bdb409c93121bb0e07dcbb5e55dc3be2" => :sierra
    sha256 "58be92ef01d5068f37b1c00af8e9b202bdb409c93121bb0e07dcbb5e55dc3be2" => :el_capitan
    sha256 "58be92ef01d5068f37b1c00af8e9b202bdb409c93121bb0e07dcbb5e55dc3be2" => :yosemite
  end

  conflicts_with "bash-completion@2", :because => "Differing version of same formula"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf", "-i"

    inreplace "bash_completion" do |s|
      s.gsub! "/etc/bash_completion", etc/"bash_completion"
      s.gsub! "readlink -f", "readlink"
    end

    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats; <<~EOS
    Add the following line to your ~/.bash_profile:
      [[ -r "#{etc}/profile.d/bash_completion.sh" ]] && . "#{etc}/profile.d/bash_completion.sh"
  EOS
  end

  test do
    system "bash", "-c", ". #{etc}/profile.d/bash_completion.sh"
  end
end
