radical=main
latex=latex

defaut: pdf

dvi: clean data
	$(latex) $(radical).tex
	bibtex $(radical)
	$(latex) $(radical).tex
	$(latex) $(radical).tex
	$(latex) $(radical).tex

ps: dvi
	dvips -o $(radical).ps $(radical).dvi

pdf: ps
	ps2pdf $(radical).ps $(radical).pdf

fast:
	$(latex) $(radical).tex

data: 
	(cd data; make)

suppl:
	$(latex) supplementary_material.tex
	$(latex) supplementary_material.tex

abstract:
	$(latex) abstract.tex
	$(latex) abstract.tex

warn:
	@(awk '/Warning/,/^$$/{if ($$0!~/^$$/) {print $0}}' main.log)

all: pdf suppl

clean:
	@(rm $(radical).{aux,log,pdf,bbl,blg} suppl.{pdf,dvi,aux,log};true)

.PHONY: defaut dvi ps pdf fast data suppl abstract warn all clean
