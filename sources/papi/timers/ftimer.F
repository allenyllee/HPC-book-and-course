      implicit none
      INTEGER :: rate, tstart, tstop
      REAL    :: time
      real    :: a
      integer :: i

      CALL SYSTEM_CLOCK(COUNT_RATE = rate)
      if (rate==0) then
         print *,"No clock available"
         stop
      else
         print *,"Clock frequency:",rate
      end if
      CALL SYSTEM_CLOCK(COUNT = tstart)
      a = 5
      do i=1,1000000000
         a = sqrt(a)
      end do
      CALL SYSTEM_CLOCK(COUNT = tstop)
      time = REAL( ( tstop - tstart )/ rate )
      print *,a,tstart,tstop,time
      end
      
