LMK     = latexmk 
LMKOPT  = -f -pdflatex="pdflatex --interaction=nonstopmode" -pdf
BUILDER = $(LMK) $(LMKOPT)
CLEANER = $(LMK) -c


all: ebook timbord hardcopy

ebook:
	cp main.tex main_orig.tex
	../tools/settype.pl main.tex ebook
	$(BUILDER) main.tex
	mv main.pdf pdf/main_ebook.pdf
	cp main_orig.tex main.tex 

timbord:
	cp main.tex main_orig.tex
	../tools/settype.pl main.tex timbord
	$(BUILDER) main.tex
	mv main.pdf pdf/main_timbord.pdf
	cp main_orig.tex main.tex 

hardcopy:
	cp main.tex main_orig.tex
	../tools/settype.pl main.tex hardcopy
	$(BUILDER) main.tex
	mv main.pdf pdf/main_hardcopy.pdf
	cp main_orig.tex main.tex 

plain:	
	$(BUILDER) main.tex


clean:
	$(CLEANER) main.tex
