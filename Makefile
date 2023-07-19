BUILDGIF=bin/buildgif.sh
BUILDPNG=bin/buildpng.sh
PACK=bin/pack.sh

all: \
	__hifumi \
	library_of_ruina \
	limbcomp \
	lobcorp \
	sq \

__hifumi:
	$(BUILDGIF) src/__hifumi
	$(PACK) src/__hifumi

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
