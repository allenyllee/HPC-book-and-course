      program mat

        implicit none
      
#include "finclude/petscsys.h"
#include "finclude/petscvec.h"
#include "finclude/petscmat.h"
      
        MPI_Comm :: comm
        PetscInt :: n,ntids,mytid
        PetscInt :: localsize,myfirst,mylast,i
        Mat      :: A
        PetscReal :: v
        PetscErrorCode :: ierr
      
        call PetscInitialize(PETSC_NULL_CHARACTER,ierr)
        CHKERRQ(ierr)
        comm = PETSC_COMM_WORLD
        n = 20
        call PetscOptionsGetInt(PETSC_NULL_CHARACTER,"-n",n,
     >       PETSC_NULL_CHARACTER,ierr)
        CHKERRQ(ierr)
      
        call MPI_Comm_size(comm,ntids,ierr)
        call MPI_Comm_rank(comm,mytid,ierr)
        localsize = PETSC_DECIDE
        call PetscSplitOwnership(comm,localsize,n,ierr)
        CHKERRQ(ierr)
      
        call MatCreate(comm,A,ierr)
        CHKERRQ(ierr)
        call MatSetType(A,MATMPIAIJ,ierr)
        CHKERRQ(ierr)
        call MatSetSizes(A,localsize,localsize,
     >       PETSC_DECIDE,PETSC_DECIDE,ierr)
        CHKERRQ(ierr)
        call MatGetOwnershipRange(A,myfirst,mylast,ierr)
        CHKERRQ(ierr)
      
        do i=myfirst,mylast-1
           v=1.0*mytid
           call MatSetValues(A,1,i,1,i,v,INSERT_VALUES,ierr)
        end do
        CHKERRQ(ierr)
        call MatAssemblyBegin(A,MAT_FINAL_ASSEMBLY,ierr)
        CHKERRQ(ierr)
        call MatAssemblyEnd(A,MAT_FINAL_ASSEMBLY,ierr)
        CHKERRQ(ierr)
        call MatView(A,0,ierr)
        CHKERRQ(ierr)
      
        call MatDestroy(A,ierr)
        CHKERRQ(ierr)
        call PetscFinalize(ierr)
        CHKERRQ(ierr)
      
      end
