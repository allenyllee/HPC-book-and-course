      program set
      
        implicit none
      
#include "finclude/petscsys.h"
#include "finclude/petscvec.h"
      
        MPI_Comm       comm
        integer        ntids,mytid,myfirst,mylast,i
        character*80   msg
        Vec            x
        PetscInt       n
        PetscScalar    one
        PetscErrorCode ierr
      
        call PetscInitialize(PETSC_NULL_CHARACTER,ierr)
        CHKERRQ(ierr)
        comm = PETSC_COMM_WORLD
        n = 20
        call PetscOptionsGetInt(PETSC_NULL_CHARACTER,"-n",n,
     >       PETSC_NULL_CHARACTER,ierr)
        CHKERRQ(ierr)
      
        call MPI_Comm_size(comm,ntids,ierr)
        call MPI_Comm_rank(comm,mytid,ierr)
        CHKERRQ(ierr)
      
        call VecCreate(comm,x,ierr)
        CHKERRQ(ierr)
        call VecSetSizes(x,PETSC_DECIDE,n,ierr)
        CHKERRQ(ierr)
        call VecSetType(x,VECMPI,ierr)
        CHKERRQ(ierr)
      
        call VecGetOwnershipRange(x,myfirst,mylast,ierr)
        CHKERRQ(ierr)
        write(*,10) mytid,myfirst,mylast
 10     format("Processor",i5," range from",i5," to",i5)
      
        one = 1.
        call VecSet(x,one,ierr)
        CHKERRQ(ierr)
        call VecAssemblyBegin(x,ierr)
        CHKERRQ(ierr)
        call VecAssemblyEnd(x,ierr)
        CHKERRQ(ierr)
        call VecView(x,PETSC_NULL_INTEGER,ierr)
        CHKERRQ(ierr)
      
        call VecDestroy(x,ierr)
        CHKERRQ(ierr)
        call PetscFinalize(ierr)
        CHKERRQ(ierr)
      
      end
