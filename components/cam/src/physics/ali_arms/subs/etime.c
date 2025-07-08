#include <sys/time.h>
#include <unistd.h>
#include <sys/times.h>
#include <sys/types.h>
#include <stdio.h>

#include <functions.h>

double el_time(void)
{
struct tms buf;
long den;
time_t t1;

times(&buf);
t1 = buf.tms_utime;
den = sysconf(_SC_CLK_TCK);
return t1*1.0/den;
}
#if 0
double el_time2(void)
 {
  /* returns time in clock ticks */

  int i;
  clock_t tt;
  double  time;
  tt=clock();
  time=1.0*tt;
  i=time;
  printf("we return=%i\n",i);
  return (time);
 }
#else

double el_time2(void)
 {
  /* returns real time in seconds with accuracy up to microsecond */

  struct timeval 	buffer;

  int 		t;

  gettimeofday(&buffer,NULL);
  t=buffer.tv_usec;
  return(buffer.tv_sec+t*1.0e-6);
 }
#endif

