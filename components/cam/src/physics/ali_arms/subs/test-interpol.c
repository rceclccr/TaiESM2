
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <functions.h>

int main(void)
{
 int N,m,i,ii;
 int N_short,N_long;
 double *arr_short_x, *arr_long_x;
 double *arr_short_y, *arr_long_y;
 
	scanf("%d %d",&N,&m);
	N_short=N;
	N_long=(N-1)*m+1;
	printf("# N=%d, m=%d, N_long=%d\n",N,m,N_long);

	arr_short_x=(double *) malloc(N_short*sizeof(double));
	arr_short_y=(double *) malloc(N_short*sizeof(double));

	arr_long_x=(double *) malloc(N_long*sizeof(double));
	arr_long_y=(double *) malloc(N_long*sizeof(double));
	
	for(i=0;i<N_short;i++)
	{
	 arr_short_x[i]=N_short-1-i;
	 arr_short_y[i]=sin((double)i);
	 printf("%35.15f %35.15f\n",
	 			arr_short_x[i],arr_short_y[i]);
	}

	for(ii=0;ii<N_long;ii++)
	{
	 arr_long_x[ii]=(double)(N_long-1-ii)/(double)m;
#if 0
	 if (arr_long_x[ii] < arr_short_x[N-1])
	  arr_long_x[ii] = arr_short_x[N-1];
#endif	  
	 
	 printf("ii=%10d %35.15f\n",
	 			ii,arr_long_x[ii]);
	}
	
	interpol_inv(N_short,arr_short_y,arr_short_x,N_long,arr_long_y,
		 arr_long_x);

	for(i=0;i<N_short;i++)
	{
	 printf("%20.15f %20.15f %20.15f %20.15f\n",
	 			arr_short_x[i],arr_short_y[i],
	 			arr_long_x[i*m],arr_long_y[i*m]);
	}

 return 0;
}
