
#     apt install  node-stylus  coffeescript  ruby  ruby-json  ruby-rdiscount

.SILENT:


%.html: %.md  Makefile  bin/mkhtml
	rm -f $@
	bin/mkhtml  $<  >/dev/null
	chmod 444  $@


%.css: %.styl  Makefile
	rm -f $@
	stylus  $<  >/dev/null
	chmod 444  $@


%.js: %.coffee  Makefile
	rm -f $@
	coffee --compile  $<
	chmod 444  $@


style := lib/style.css
markdown := $(wildcard  *.md  */*.md)
html := $(markdown:.md=.html)
coffee := $(wildcard  *.coffee  */*.coffee)
scripts := $(coffee:.coffee=.js)

all: $(style)  $(html)  $(scripts)
	chmod 755  lib  C16
	chmod 444  lib/*.ico  lib/*.png  C16/*.svg

clean:
	rm -f $(style)  $(html)  $(scripts)

