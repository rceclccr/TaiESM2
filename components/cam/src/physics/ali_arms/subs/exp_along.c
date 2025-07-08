
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <functions.h>

int exp_along(double *dtaum, double *jm, int ND)
{
 double sum=0.0;
 int id;
 	jm[0]=1.0;
        for(id=1;id<ND;id++)
        {
         sum+=dtaum[id-1];
         jm[id]=exp(-sum);
/*	 printf("TAUM[%2d]=%12.6le JM[%2d]=%12.6le\n",id,sum,id,jm[id]);
 */       }
 return 0;
}
