# -*- makefile -*-
################################################################
################################################################
####
#### Makefile for:
####     Introduction to High-Performance Scientific Computing
#### by Victor Eijkhout
#### copyright 2010-7
####
################################################################
################################################################

info ::
	@echo "Do: make pdf"
	@echo "to format the book"

pdf :
	for t in EijkhoutIntroToHPC EijkhoutTutorialsForHPC ; do \
	TEXINPUTS=${TEXINPUTS}:graphics pdflatex $$t ; \
	TEXINPUTS=${TEXINPUTS}:graphics pdflatex $$t ; \
	TEXINPUTS=${TEXINPUTS}:graphics pdflatex $$t ; \
	cp $$t.pdf ../ ; \
	done

info ::
	@echo "Do: make clean"
	@echo "to clean up temporary files"
clean ::
	@/bin/rm -f *.{aux,blg,ilg,log,out,toc} *~ comment.cut \
	    exercises/*
