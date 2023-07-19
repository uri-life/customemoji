BUILDGIF=bin/buildgif.sh
BUILDPNG=bin/buildpng.sh
PACK=bin/pack.sh

all: \
	__hifumi \
	lobcorp \

__hifumi:
	$(BUILDGIF) src/__hifumi
	$(PACK) src/__hifumi

lobcorp:
	$(BUILDPNG) src/lobcorp
	$(PACK) src/lobcorp
