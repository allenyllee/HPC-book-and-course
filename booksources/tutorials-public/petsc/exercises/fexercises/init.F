      program init
      
        implicit none
#include "finclude/petsc.h"
      
        PetscInt      n
        character*80      msg
        PetscErrorCode ierr
      
        call PetscInitialize(PETSC_NULL_CHARACTER,ierr)
        CHKERRQ(ierr)
        n = 20
        call PetscOptionsGetInt(PETSC_NULL_CHARACTER,"-n",n,
     >       PETSC_NULL_CHARACTER,ierr)
        CHKERRQ(ierr)
        write(msg,10) n
 10     format("Input parameter:",i5,"\n")
        call PetscPrintf(PETSC_COMM_WORLD,msg,ierr)
        CHKERRQ(ierr)
        call PetscFinalize(ierr)
        CHKERRQ(ierr)
      
      end
