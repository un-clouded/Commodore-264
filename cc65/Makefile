
#PROJECT = example

#PARTS = main.o

OUTDIR ?= /tmp/264

CFLAGS += -Os

CLFLAGS = --target plus4

LDFLAGS += -Ln $(OUTDIR)/$(PROJECT).lbl

PRODUCT := $(OUTDIR)/$(PROJECT).prg

.c.o:
	cl65 $(CLFLAGS) $(CFLAGS) $(LDFLAGS) -c $< -o $@

.S.o:
	ca65 $(AFLAGS) $< -o $@

.SILENT:
all: $(PARTS)
	[ -e "$(OUTDIR)" ] || mkdir "$(OUTDIR)"
	cl65 $(CLFLAGS) $(LDFLAGS) -o $(PRODUCT) $(PARTS)  &&  od65 --dump-segsize $(PARTS)

reload:
	killall -q xplus4  ;  xplus4 $(PRODUCT)

clean:
	rm -f *.o *.map $(PRODUCT)

