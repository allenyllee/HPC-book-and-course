program quiz
  use mpi
  implicit none
  integer, parameter :: SOME_MAX = 128
  integer numprocs, rank, ierr
  integer next_rank, prev_rank, next_value, local_value, prev_value
  integer tag1, tag2, tag3, tag4
  integer i,j
  integer reqs(SOME_MAX)
  integer stats(MPI_STATUS_SIZE,SOME_MAX)

  tag1 = 1; tag2 = 2; tag3 = 3; tag4 = 4

  call MPI_INIT(ierr)
  call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

  ! Some local computation to generate local_value
  local_value = rank

  ! Assume 1-D ring topology
  prev_rank = mod((rank + numprocs - 1), numprocs) ! Previous neighbor
  next_rank = mod((rank + 1), numprocs)            ! Next neighbor

  !
  ! Send local_value to nearest neighbors
  ! 
  call MPI_SENDRECV(local_value,1,MPI_INTEGER,prev_rank,tag1, &
                    prev_value ,1,MPI_INTEGER,next_rank,tag1,MPI_COMM_WORLD,stats(:,1),ierr)
  call MPI_SENDRECV(local_value,1,MPI_INTEGER,next_rank,tag2, & 
                    next_value ,1,MPI_INTEGER,prev_rank,tag2,MPI_COMM_WORLD,stats(:,2),ierr)

  ! Serialized Output -- still doesn't guarentee order
  do i=0, numprocs-1
    if(rank == i)then
      write(6,*)"(Rank ",rank,"): prev_value: ",prev_value, &
      &         " next_value: ",next_value
      flush(6) ! Flush stdout buffer
    end if
    call MPI_BARRIER(MPI_COMM_WORLD,ierr)
  end do

  call MPI_FINALIZE(ierr)
end program quiz

