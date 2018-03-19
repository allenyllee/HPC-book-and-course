################################################################
################################################################
####
#### This Makefile is part of the textbook
#### Introduction to High-Performance Scientific Computing
#### by Victor Eijkhout
#### copyright 2010/1/2/3/4/5
####
#### Makefile for debugging examples
####
################################################################
################################################################

info ::
	@echo "make <progname>"
	@echo "make clean"

PARALLEL = ring_1a ring_1b ring_1c ring_2a ring_2b ring_3a ring_3b
SEQUENTIAL = root root2 roots say square square1 square2
PROGS = ${SEQUENTIAL} ${PARALLEL}

.SECONDEXPANSION:
${SEQUENTIAL} : $$@.c
	cc -g -O1 -o $@ $@.c
${PARALLEL} : $$@.c
	mpicc -g -O1 -o $@ $@.c
clean :
	/bin/rm -rf ${PROGS} *~ *.o *.dSYM ddt.o*
