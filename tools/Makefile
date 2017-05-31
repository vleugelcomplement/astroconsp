LMK     = latexmk 
LMKOPT  = -f -pdflatex="pdflatex --interaction=batchmode" -pdf
BUILDER = $(LMK) $(LMKOPT)
CLEANER = $(LMK) -c
DISTCLEANER = $(LMK) -C

SETTYPE = ../tools/settype.pl

MAIN    = main
MAINT   = main_t

PDFDIR  = pdf
$(shell mkdir -p $(PDFDIR) &>/dev/null)
TMPDIR  = /tmp/consp/
$(shell mkdir -p $(TMPDIR) &>/dev/null)
MESSAGE = $(shell git log -1 --pretty=%B)


pdfs: ebook timbord hardcopy

product: pdfs post


ebook:
	@cp $(MAIN).tex $(MAINT).tex
	$(SETTYPE) $(MAINT).tex $@
	$(BUILDER) $(MAINT).tex
	@mv $(MAINT).pdf $(PDFDIR)/$(MAIN)_ebook.pdf

timbord:
	@cp $(MAIN).tex $(MAINT).tex
	$(SETTYPE) $(MAINT).tex $@ 
	$(BUILDER) $(MAINT).tex
	@mv $(MAINT).pdf $(PDFDIR)/$(MAIN)_$@.pdf

hardcopy:
	@cp $(MAIN).tex $(MAINT).tex
	$(SETTYPE) $(MAINT).tex $@
	$(BUILDER) $(MAINT).tex
	@mv $(MAINT).pdf $(PDFDIR)/$(MAIN)_$@.pdf

post:
	@cp -r pdf $(TMPDIR)
	@git checkout gh-pages
	@cp -r $(TMPDIR)/pdf .
	@git add pdf
	@git commit -m "$(MESSAGE)"
	@git checkout master
	

plain:	
	$(BUILDER) main.tex


clean:
	$(CLEANER) main.tex

distclean:
	$(DISTCLEANER) main.tex
