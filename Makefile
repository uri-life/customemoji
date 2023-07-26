BUILDGIF=bin/buildgif.sh
BUILDPNG=bin/buildpng.sh
GIMPALET=bin/gimpalet.sh
PACK=bin/pack.sh

all: \
	__ \
	library_of_ruina \
	limbcomp \
	lobcorp \
	sq \

__: \
	__hifumi \
	__thonk \

__hifumi:
	$(BUILDGIF) src/__/hifumi
	$(PACK) -name __hifumi src/__/hifumi

__thonk:
	$(BUILDPNG) src/__/thonk
	$(GIMPALET) src/__/thonk
	$(PACK) -name __thonk src/__/thonk

library_of_ruina:
	$(BUILDPNG) src/library_of_ruina
	$(PACK) src/library_of_ruina

limbcomp:
	$(BUILDPNG) src/limbcomp
	$(PACK) src/limbcomp

lobcorp:
	$(BUILDPNG) src/lobcorp
	$(PACK) src/lobcorp

sq:
	$(BUILDPNG) src/sq
	$(PACK) src/sq
