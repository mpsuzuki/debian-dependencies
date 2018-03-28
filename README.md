what is this?
=============

if you are a free software developer, maybe you had some
experiences of the consideration "should I introduce a
backward incompatible change to fix a bug or underspecified
behaviour?".

in such cases, maybe you want to know how many softwares
are dependent with the past behaviour. of course, it is
basically impossible to obtain the sufficient information,
because we do not have the telemetrying inspectors into
the computers of the users.

thus, collecting the software packages of the large scale
Linux distributions and check how your softwares are used
would be the second or third better options. nothing to
say, you do not want to install the distribution just for
such survey.

fortunately, Debian provides the plain text database of
their packages with the dependency (for runtime, and for
development). so, here I collect their package database
and make json (collecting the dependency info only),
and search the packages.

examples
--------

how many packages depend on libpoppler-cpp in runtime?

$ ruby ./lookupPackageDependsOn.rb --debian-release-sed=deb-rel.sed  --packages libpoppler-cpp

main    07.0    wheezy  2       libpoppler-cpp-dev,pdfgrep
main    08.0    jessie  3       libpoppler-cpp-dev,libreoffice-subsequentcheckbase,pdfgrep
main    09.0    stretch 3       boomaga,libpoppler-cpp-dev,pdfgrep
main    10.0    buster  3       boomaga,libpoppler-cpp-dev,pdfgrep
main    unst    sid     4       boomaga,libevas-loaders,libpoppler-cpp-dev,pdfgrep

how many packages depend on libpoppler-private-dev in development?

$ ruby ./lookupPackageDependsOn.rb --debian-release-sed=deb-rel.sed  --sources libpoppler-private-dev

main    07.0    wheezy  17      calibre,calligra,cups-filters,gambas3,gdal,gdcm,gnome-commander,inkscape,libextractor,libreoffice,luatex,pdf2djvu,pdfgrep,pdftoipe,popplerkit.framework,texlive-bin,xpdf
main    08.0    jessie  14      calligra,cups-filters,gambas3,gdal,gdcm,inkscape,libreoffice,pdf2djvu,pdf2htmlex,pdftoipe,popplerkit.framework,texlive-bin,texmaker,xpdf
main    09.0    stretch 17      apvlv,boomaga,calligra,cups-filters,emacs-pdf-tools,extractpdfmark,gambas3,gdal,gdcm,inkscape,ipe-tools,libreoffice,pdf2djvu,popplerkit.framework,texlive-bin,texmaker,xpdf
main    10.0    buster  15      apvlv,calligra,cups-filters,emacs-pdf-tools,extractpdfmark,gdal,gdcm,inkscape,ipe-tools,libreoffice,pdf2djvu,popplerkit.framework,texlive-bin,texmaker,xpdf
main    unst    sid     17      apvlv,calligra,cups-filters,emacs-pdf-tools,extractpdfmark,gambas3,gdal,gdcm,inkscape,ipe-tools,libreoffice,pdf2djvu,popplerkit.framework,texlive-bin,texmaker,utopia-documents,xpdf
