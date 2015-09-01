################################################################
################################################################
####
#### Makefile for:
####     Introduction to High-Performance Scientific Computing
#### by Victor Eijkhout
#### copyright 2010-5
####
################################################################
################################################################

info ::
	@echo "Do: make pdf"
	@echo "to format the book"

pdf :
	TEXINPUTS=${TEXINPUTS}:graphics pdflatex EijkhoutIntroToHPC
	TEXINPUTS=${TEXINPUTS}:graphics pdflatex EijkhoutIntroToHPC
	TEXINPUTS=${TEXINPUTS}:graphics pdflatex EijkhoutIntroToHPC
	cp EijkhoutIntroToHPC.pdf ../

info ::
	@echo "Do: make clean"
	@echo "to clean up temporary files"
clean ::
	@/bin/rm -f *.{aux,blg,ilg,log,out,toc} *~ comment.cut \
	    exercises/*
