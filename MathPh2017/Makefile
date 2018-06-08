LMK     = latexmk 
LMKOPT  = -f -pdflatex="pdflatex --interaction=batchmode" -pdf
BUILDER = $(LMK) $(LMKOPT)
CLEANER = $(LMK) -c
DISTCLEANER = $(LMK) -C

SETTYPE = :#../tools/settype.pl

MAIN    = main
MAIN_ORIG = $(MAIN)_orig
DIR     = $(shell pwd)
COURSE  = $(shell basename "$(DIR)" )
PDFNAME = $(COURSE)_$(MAIN)

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
	@cp $(MAIN).tex $(MAIN_ORIG).tex
	@$(SETTYPE) $(MAIN).tex $*
	@$(BUILDER) $(MAIN).tex
	@mv $(MAIN).pdf $(PDFDIR)/$(PDFNAME)_$*.pdf


pdfs: @sheet clean

product: pdfs post

post:
	@cp -r $(PDFDIR) $(TMPDIR)
	git checkout gh-pages
	@cp -r $(TMPDIR)/$(PDFDIR) .
	git add $(PDFDIR)
	git commit -m '$(MESSAGE)'
	git checkout master
	

plain:	
	$(BUILDER) $(MAIN).tex


clean:
	$(CLEANER) $(MAIN).tex
	$(CLEANER) $(MAIN_ORIG).tex

distclean:
	$(DISTCLEANER) $(MAIN).tex
	$(DISTCLEANER) $(MAIN_ORIG).tex
	@cp $(MAIN_ORIG).tex $(MAIN).tex
	@rm $(MAIN_ORIG).tex

dummy:
	@echo $(MAIN) '<->' $(MAINT)
	@echo $(DIR) 
	@echo '//' $(COURSE)
	@echo '>>' $(PDFNAME)
