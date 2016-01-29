class Libmustache < Formula
  desc "C++ implementation of Mustache."
  homepage "https://github.com/jbboehr/libmustache"
  url "https://github.com/jbboehr/libmustache/archive/v0.4.0.tar.gz"
  sha256 "25d2bc59868a306df366bdf56b390f0243ad363165a0e3e0ea5b8af3641bc947"

  bottle do
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS
    #include <mustache/mustache_config.h>
    #include <mustache/mustache.hpp>
    int main() {
        mustache::Mustache m;
        mustache_version_int();
        return 0;
    }
    EOS
    system ENV.cxx, "-std=c++11", "-c", "-o", (testpath/"test.o"), (testpath/"test.cpp")
    system ENV.cxx, "-std=c++11", "-o", (testpath/"test"), (testpath/"test.o"), "-lmustache"
    system (testpath/"test")
  end
end
