
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(void)
{
 int v,J;
 double B_v, D_v, E_vib, E_rot;
 double v12;
 
 const double w_e     =1580.39;
 const double w_ex_e  =-12.112;
 const double w_ey_e  = 7.54e-2;
 const double w_ez_e  =-4.09e-3;
 const double w_ea_e  = 1.30e-4;
 const double w_eb_e  =-2.21e-6;
 const double B_e     = 1.44566;
 const double alpha_e = 1.579e-2;
 const double D_e     = 4.95e-6;
 const double beta_e  = 8.00e-8;
  
 
	for(v=0;v<30;v++)
	{
	 v12=v+0.5;
	 E_vib=
	        w_e*v12+
	        w_ex_e*v12*v12+
	        w_ey_e*v12*v12*v12+
	        w_ez_e*v12*v12*v12*v12+
	        w_ea_e*v12*v12*v12*v12*v12+
	        w_eb_e*v12*v12*v12*v12*v12*v12-787.176173;
	 printf("E_vib[%5d]=%12.6f\n",
	        v,
	        E_vib
	        );
	 B_v=B_e-alpha_e*v12;
	 D_v=D_e-beta_e*v12;
	 for(J=1;J<100;J+=2)
	 {
	  E_rot=B_v*J*(J+1)-D_v*J*J*(J+1)*(J+1);

	  printf("E_rot[%5d,%5d]=%12.6f , %12.6f\n",
	        v,
	        J,E_rot+E_vib,E_rot
	        );
	 }
	}
 return 0;
}
