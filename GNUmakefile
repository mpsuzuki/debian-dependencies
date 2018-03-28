APT_PACKAGES_GZ = $(wildcard *_Packages.gz)
APT_PACKAGES_XZ = $(wildcard *_Packages.xz)
APT_SOURCES_GZ = $(wildcard *_Sources.gz)
APT_SOURCES_XZ = $(wildcard *_Sources.xz)

APT_INPUT_GZ = $(APT_PACKAGES_GZ) $(APT_SOURCES_GZ)
APT_INPUT_XZ = $(APT_PACKAGES_XZ) $(APT_SOURCES_XZ)

OUTPUT_GZ_JSON = $(patsubst %.gz, %.json, $(APT_INPUT_GZ))
OUTPUT_XZ_JSON = $(patsubst %.xz, %.json, $(APT_INPUT_XZ))

.SUFFIXES: .xz .gz .json
.PHONY: ALL

ALL: $(OUTPUT_GZ_JSON) $(OUTPUT_XZ_JSON)

.xz.json:
	echo making $@ from $<
	xz -cd < $< | ruby2.3 ./aptFile2Json.rb --minimize --as-hash > $@ || rm -vf $@

.gz.json:
	echo making $@ from $<
	gzip -cd < $< | ruby2.3 ./aptFile2Json.rb --minimize --as-hash > $@ || rm -vf $@
