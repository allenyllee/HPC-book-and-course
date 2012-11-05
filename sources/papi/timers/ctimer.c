#include <stdlib.h>
#include <stdio.h>
#include <time.h>
int main() {
  double start, stop, time;
  int i; double a=5;
  i = CLOCKS_PER_SEC; printf("clock resolution: %d\n",i);
  start = (double)clock()/CLOCKS_PER_SEC;
  for (i=0; i<1000000000; i++)
    a = sqrt(a);
  stop = (double)clock()/CLOCKS_PER_SEC;
  time = stop - start;
  printf("res: %e\nstart/stop: %e,%e\nTime: %e\n",a,start,stop,time);
  return 0;
}
