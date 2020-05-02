
BOARD = Commodore-16

FOOTPRINTS=~/files/gEDA-footprints

.SILENT:

all: pcb

# File, Write, EPS within gschem to /tmp/Commodore-16.eps then:
svg:
	rm -f /tmp/Commodore-16.svg
	eps2svg /tmp/Commodore-16.eps
	mv /tmp/Commodore-16.svg .
	rm /tmp/Commodore-16.eps

pcb:
	gsch2pcb --elements-dir $(FOOTPRINTS) $(BOARD).sch

clean:
	rm -f *~ *.log *.net *.cmd *.new.pcb

