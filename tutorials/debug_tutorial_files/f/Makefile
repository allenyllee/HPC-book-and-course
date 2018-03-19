info ::
	@echo "make <progname>"
	@echo "make clean"

FC = gfortran
PROGS = ring_1a ring_1b ring_1c ring_2a ring_2b ring_3a ring_3b \
    root root2 roots say square square1 square2
% : %.F
	${FC} -g -o $@ $@.F
clean :
	/bin/rm -rf ${PROGS} *~ *.o *.dSYM
