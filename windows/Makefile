CONVERT   = convert
MAKENSIS  = makensis

SDK      := ../../conreality-sdk

all: conreality-sdk-x64.exe

%.bmp: %.png
	$(CONVERT) $< BMP3:$@

conreality-sdk-x64.exe:
	$(MAKENSIS) -DTARGET=x64 -DSDK="$(SDK)" -DOUTFILE="$@" conreality-sdk.nsi

clean:
	@rm -f *.exe *~

.PHONY: clean
.SECONDARY:
.SUFFIXES:
