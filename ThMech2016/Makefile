LMK     = latexmk 
LMKOPT  = -f -pdflatex="pdflatex --interaction=batchmode" -pdf
BUILDER = $(LMK) $(LMKOPT)
CLEANER = $(LMK) -c
DISTCLEANER = $(LMK) -C

SETTYPE = ../tools/settype.pl

MAIN    = bettermech
MAINT   = main_t

PDFDIR  = pdf
$(shell mkdir -p $(PDFDIR) &>/dev/null)
TMPDIR  = /tmp/consp
$(shell mkdir -p $(TMPDIR) &>/dev/null)
$(shell mkdir -p $(TMPDIR)/$(PDFDIR) &>/dev/null)
MESSAGE = $(shell git log -1 --pretty=%B)

@%:
	@echo ====================
	@echo ::  $*
	@echo ===================
	@cp $(MAIN).tex $(MAINT).tex
	@$(SETTYPE) $(MAINT).tex $*
	@$(BUILDER) $(MAINT).tex
	@mv $(MAINT).pdf $(PDFDIR)/$(MAIN)_$*.pdf


pdfs: @ebook @timbord @hardcopy distclean

product: pdfs post

post:
	@cp -r $(PDFDIR) $(TMPDIR)
	@git checkout gh-pages
	@cp -r $(TMPDIR)/$(PDFDIR) .
	@git add $(PDFDIR)
	@git commit -m "$(MESSAGE)"
	@git checkout master
	

plain:	
	$(BUILDER) $(MAIN).tex


clean:
	$(CLEANER) $(MAIN).tex
	$(CLEANER) $(MAINT).tex

distclean:
	$(DISTCLEANER) $(MAIN).tex
	$(DISTCLEANER) $(MAINT).tex
	@rm $(MAINT).tex
