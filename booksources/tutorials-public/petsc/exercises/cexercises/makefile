info ::
	@echo "make prog"
	@echo "  where prog is one of: ${PROGS}"

include ${PETSC_DIR}/conf/variables

PROGS = init vec mat mul
.SECONDEXPANSION:
%.o : %.c
	-${CC} -c -o $@ $^ ${PETSC_CC_INCLUDES}
${PROGS}: $$@.o 
	-${CLINKER} -o $@ $@.o ${PETSC_LIB}

EXPORT_DIR = petsc_tutorial_files
TARFILE = petsc_tutorial_files.tgz
package :
	rm -rf ../${TARFILE} ../${EXPORT_DIR}
	mkdir ../${EXPORT_DIR}
	svn export . ../${EXPORT_DIR}/cexercises
	cd ../fexercises ; svn export . ../${EXPORT_DIR}/fexercises
	cd .. ; tar fcz ${TARFILE} ${EXPORT_DIR}
	scp ../${TARFILE} ve343@sftp.austin.utexas.edu:/DepartmentalDirectories/tacc/home/veijkhout/public_html/istc/${TARFILE}
clean :
	rm -f *~ *.o ${PROGS}
