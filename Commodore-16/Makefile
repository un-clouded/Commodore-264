
BOARD = Commodore-16

FOOTPRINTS=~/files/gEDA-footprints

.SILENT:

pcb:
	gsch2pcb --elements-dir $(FOOTPRINTS) $(BOARD).sch

clean:
	rm -f *~ *.log *.net *.cmd *.new.pcb

