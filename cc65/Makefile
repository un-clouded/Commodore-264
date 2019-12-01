
#PROJECT = example

# main.o should appear first because execution will begin at the top of main.o
#PARTS = main.o

OUTDIR ?= /tmp/264

CFLAGS += -Os

CLFLAGS = --target c16

AFLAGS = -I ..

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
	rm -f *.map $(PARTS) $(PRODUCT)

