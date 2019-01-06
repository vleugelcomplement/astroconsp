LMK     = latexmk 
LMKOPT  = -f -pdf
BUILDER = $(LMK) $(LMKOPT)
CLEANER = $(LMK) -c
DISTCLEANER = $(LMK) -C

SETTYPE = :

MAIN    = main
MAINT   = main_t
DIR     = $(shell pwd)
COURSE  = $(shell basename "$(DIR)" )
PDFNAME = $(COURSE)_$(MAIN)

PDFDIR  = pdf
$(shell mkdir -p $(PDFDIR) &>/dev/null)
TMPDIR  = /tmp/consp
$(shell mkdir -p $(TMPDIR) &>/dev/null)
$(shell mkdir -p $(TMPDIR)/$(PDFDIR) &>/dev/null)
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
MESSAGE = $(shell git log -1 --pretty=%B)

@%:
	@echo ====================
	@echo ::  $*
	@echo ===================
	@cp $(MAIN).tex $(MAINT).tex
	@$(SETTYPE) $(MAINT).tex $*
	@$(BUILDER) $(MAINT).tex
	@mv $(MAINT).pdf $(PDFDIR)/$(PDFNAME)_$*.pdf


pdfs: @commonplace distclean

product: pdfs post

post:
	@cp -r $(PDFDIR) $(TMPDIR)
	@git checkout gh-pages
	@cp -r $(TMPDIR)/$(PDFDIR) .
	@git add $(PDFDIR)
	@git commit -m "$(MESSAGE)"
	@git checkout ${BRANCH}
	

plain:	
	$(BUILDER) $(MAIN).tex


clean:
	$(CLEANER) $(MAIN).tex
	$(CLEANER) $(MAINT).tex

distclean:
	$(DISTCLEANER) $(MAIN).tex
	$(DISTCLEANER) $(MAINT).tex
	@rm $(MAINT).tex

dummy:
	@echo $(MAIN) '<->' $(MAINT)
	@echo $(DIR) 
	@echo '//' $(COURSE)
	@echo '>>' $(PDFNAME)
