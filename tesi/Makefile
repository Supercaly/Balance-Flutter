TEMPLATE = ia_urb_thesis.sty logo-uniurb-2016.jpg.eps
THESIS = tesi.tex
MAKEFILE = Makefile
SOURCES = sources/*.tex

thesis: $(THESIS) $(TEMPLATE) $(MAKEFILE)
	pdflatex --shell-escape tesi.tex

clear:
	rm -f *.fdb_latexmk *.fls *.toc *.lof *.lot *.synctex.gz *.aux *.log sources/*.aux

clear_all:
	make clear
	rm -rf *.pdf figure/*.pdf figure/*.eps sources/__latexindent_temp.tex .texpadtmp/* _minted-tesi/*
