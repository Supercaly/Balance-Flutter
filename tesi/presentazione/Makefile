SLIDES = presentazione.tex
DISCORSO = discorso.md
MAKEFILE = Makefile

slides: $(SLIDES) $(MAKEFILE)
	pdflatex $(SLIDES)

discorso: $(DISCORSO) $(MAKEFILE)
	pandoc $(DISCORSO) -o discorso.pdf

clear:
	rm -f *.toc *.synctex.gz *.aux *.log *.nav *.out *.snm *.odp *.fls *.fdb_latexmk

clear_all:
	make clear
	rm -rf *.pdf
