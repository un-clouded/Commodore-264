
#     apt install  node-stylus  coffeescript  ruby  ruby-json  ruby-rdiscount

.SILENT:


%.html: %.md  Makefile  bin/mkhtml
	bin/mkhtml  $<  >/dev/null
	chmod 444  $@


%.css: %.styl  Makefile
	stylus  $<  >/dev/null
	chmod 444  $@


%.js: %.coffee  Makefile
	coffee --compile  $<
	chmod 444  $@


style := lib/style.css
markdown := $(wildcard  *.md  */*.md)
html := $(markdown:.md=.html)
coffee := $(wildcard  *.coffee  */*.coffee)
scripts := $(coffee:.coffee=.js)

all: $(style)  $(html)  $(scripts)

clean:
	rm -f $(style)  $(html)  $(scripts)

