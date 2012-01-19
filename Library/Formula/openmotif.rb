require 'formula'

class Openmotif < Formula
  url 'ftp://ftp.ics.com/openmotif/2.3/2.3.3/openmotif-2.3.3.tar.gz'
  homepage 'http://www.openmotif.org/'
  md5 'fd27cd3369d6c7d5ef79eccba524f7be'

  def patches
    # Need to patch a single header to add a
    # defined(__APPLE__) query to get this
    # compiled.
    DATA
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--enable-xft", "--enable-jpeg",
                          "--enable-png", "--x-includes=/usr/X11/include",
                          "--x-libraries=/usr/X11/lib"
    system "make install"
  end
end

__END__
diff -Naur openmotif-2.3.3/clients/uil/UilDefI.h openmotif-2.3.3-patched/clients/uil/UilDefI.h
--- openmotif-2.3.3/clients/uil/UilDefI.h   2004-11-18 08:54:32.000000000 +0000
+++ openmotif-2.3.3-patched/clients/uil/UilDefI.h   2011-05-26 22:26:31.000000000 +0000
@@ -283,7 +283,7 @@
 #include "UilIODef.h"
 #include "UilDiagDef.h"
 #include "UilSarDef.h"
-#if defined(linux)
+#if defined(linux) || defined(__APPLE__)
 #define YYSTYPE yystype
 #endif
 #include "UilLexPars.h"
