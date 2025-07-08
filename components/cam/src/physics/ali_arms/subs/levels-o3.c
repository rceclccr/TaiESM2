
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(void)
{
 int v1,v2,v3;
 double E_vib;
 double v1h, v2h, v3h;

#if 0
 const	double	w1=1133.27; 
 const	double	w2= 713.93; 
 const	double	w3=1085.69; 

 const	double	x11= -5.49; 
 const	double	x12= -6.74; 
 const	double	x13=-30.44; 
 const	double	x22= -0.75; 
 const	double	x23=-13.59; 
 const	double	x33= -9.60; 
#else
 const	double	w1=1133.27; 
 const	double	w2= 713.93; 
 const	double	w3=1085.69; 

 const	double	x11= -5.49; 
 const	double	x12= -6.74; 
 const	double	x13=-30.44; 
 const	double	x22= -0.75; 
 const	double	x23=-13.59; 
 const	double	x33= -9.60; 
#endif

/*
x_11 -5.49
x_22 -0.75
x_33 -9.60
x_13 -30.44
x_12 -6.74
x_23 -13.59

---------------
x_11 -4.9
x_22 -1.0
x_33 -10.6
x_13 -34.8
x_12 -9.1
x_23 -17.0

with

w_1 1134.9
w_2  716.0
w_3 1089.2



*/
 
	for(v1=0;v1<10;v1++)
	 for(v2=0;v2<10;v2++)
	  for(v3=0;v3<10;v3++)
 	  {
	   v1h=v1+0.5;
	   v2h=v2+0.5;
	   v3h=v3+0.5;
	   E_vib=
	        w1*v1h+
	        w2*v2h+
	        w3*v3h+
	        x11*v1h*v1h+
	        x12*v1h*v2h+
	        x13*v1h*v3h+
	        x22*v2h*v2h+
	        x23*v2h*v3h+
	        x33*v3h*v3h-1449.7925;
	 printf("  %1.1d%1.1d%1.1d   =   %12.6f\n",
	        v1,v2,v3,
	        E_vib
	        );
	  }
 return 0;
}
