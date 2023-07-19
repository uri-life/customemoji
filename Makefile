BUILDGIF=bin/buildgif.sh
BUILDPNG=bin/buildpng.sh
PACK=bin/pack.sh

all: \
	__hifumi \

__hifumi:
	$(BUILDGIF) src/__hifumi
	$(PACK) src/__hifumi
