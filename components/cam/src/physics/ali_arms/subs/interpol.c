
#include <stdio.h>

#include <functions.h>
#include <mv_utils.h>
#include <math.h>

int interpol( int n , double *y , double *x ,
	      int nn, double *yy, double *xx)
{

    int i, ii, is;

/*     GIVEN ORDINATES Y(I) AND ABSCISSAS X(I), SUCH THAT X(I).LT.X(I+1),
*/
/*     I=1,N, THIS ROUTINE FINDS INTERPOLATED ORDINATES YY(II) AT */
/*     ABSCISSAS XX(II), SUCH THAT XX(II).LT.XX(II+1), II=1,NN. */
/*     FOR N.LE.4 INTERPOLATIONS ARE DONE WITH A (N-1)-TH ORDER POLYNOMIAL
 */
/*     FIT OF THE DATA.  FOR N.GT.4 INTERPOLATIONS IN THE INTERVAL FROM */
/*    X(2) TO X(N-1) ARE DONE USING A CUBIC FIT OF THE DATA AT FOUR POINTS
,*/
/*    TWO ON EACH SIDE OF XX.  FOR XX OUTSIDE THIS RANGE A CUBIC FIT OF TH
E*/
/*     FIRST FOUR (OR LAST FOUR) POINTS IS USED. */
/*     VERSION 1.01 GBR 22-DEC-1987. */


	/* sanity checks */

	for(i=0;i<n-1;i++)
	 if (x[i] >= x[i+1])
	 {
	  printf("INTERPOL:i=%d,x[i]=%13.6e > x[i+1]=%13.6e\n",
	  	i,x[i],x[i+1]);
	  exit(1);
	 }

#if 0
	for(ii=0;ii<nn-1;ii++)
	{
	 if (xx[ii] >= xx[ii+1])
	 {
	  printf("INTERPOL:ii=%d,xx[ii]=%13.6e >= xx[ii+1]=%13.6e\n",
	  	ii,xx[ii],xx[ii+1]);
	  exit(1);
	 }
	 if(xx[ii])
	 {
	 }
	}
#endif

    /* Function Body */
    if (n <= 4) {
	for (ii = 0; ii < nn; ++ii) {
	    yy[ii] = poly(n, y, x, xx[ii]);
	}
    } else {
	i = 0;
	for (ii = 0; ii < nn; ++ii) {
	    while(i < n && xx[ii] > x[i]){
                  i++;
	    }
	    is = i - 2;
	    if (is < 0) is = 0;
	    if (is > n - 4) is = n - 4;
	    yy[ii] = poly(4, &y[is], &x[is], xx[ii]);
	}
    }
    return 0;
}

int interpol_inv( int n , double *y , double *x ,
	          int nn, double *yy, double *xx)
{
 int	i, ii;
 double	*ytmp, *xtmp, *xxtmp, *yytmp;

	xtmp =vec_FMEMALLOC(n);
	ytmp =vec_FMEMALLOC(n);
	xxtmp=vec_FMEMALLOC(nn);
	yytmp=vec_FMEMALLOC(nn);

	/* sanity checks */

	for(i=0;i<n-1;i++)
	{
	 if (x[i] < x[i+1])
	 {
	  printf("INTERPOL_INV:i=%d,x[i]=%13.6e < x[i+1]=%13.6e Bye...\n",
	  	i,x[i],x[i+1]);
	  exit(1);
	 }
	 xtmp[i]=x[n-1-i];
	 ytmp[i]=y[n-1-i];
	}

	if (xx[0] > x[0])
	{
	 printf("INTERPOL_INV:xx[0]=%13.6e > x[0]=%13.6e Bye...\n",
	 	xx[0],x[0]);
	 exit(1);
	}

#if 0
	if (xx[nn-1] < x[n-1])
	{
	 printf("INTERPOL_INV:xx[nn-1]=%13.6e > x[n-1]=%13.6e Bye...\n",
	 	xx[nn-1],x[n-1]);
	 exit(1);
	}
#endif
	 xtmp[n-1]=x[0];
	 ytmp[n-1]=y[0];
#if 0
	for(i=0;i<n;i++)
	 printf("i=%d,xtmp=%35.15f ytmp=%35.15f\n",
	 			i,xtmp[i],ytmp[i]);
#endif

#if 1
	for(ii=0;ii<nn-1;ii++)
	{
	 if (xx[ii] < xx[ii+1])
	 {
	  printf("INTERPOL_INV:ii=%d,xx[ii]=%13.6e < xx[ii+1]=%13.6e\n",
	  	ii,xx[ii],xx[ii+1]);
	  exit(1);
	 }
	 xxtmp[ii]=xx[nn-1-ii];
	}
#endif

	xxtmp[nn-1]=xx[0];

#if 0
	for(ii=0;ii<nn;ii++)
	 printf("ii=%d,xxtmp=%35.15f yytmp=%35.15f\n",
	 			ii,xxtmp[ii],yytmp[ii]);
#endif

	interpol(n,ytmp,xtmp,nn,yytmp,xxtmp);

	for(ii=0;ii<nn;ii++)
	 yy[ii]=yytmp[nn-1-ii];

	free(xtmp);
	free(ytmp);
	free(xxtmp);
	free(yytmp);

    return 0;
}

double poly(int n, double *y, double *x, double xx)
{
    double ret_val;
    double prod;
    unsigned int i, j;

/* *****   FITS AN (N-1)TH ORDER POLYNOMIAL TO THE DATA POINTS Y(I) AT */
/* *****   ABSCISSAS X(I), I=1,N, AND RETURNS THE VALUE OF THE */
/* *****   POLYNOMIAL AT ABSCISSA XX. */
/* *****   WRITTEN BY G. RYBICKI 24 JUNE 1983. */

    /* Function Body */
    ret_val = 0.;

    for (i = 0; i < n; ++i) {
	prod = 1.;
	for (j = 0; j < n; ++j) {
	    if (j != i) {
		prod = prod * (xx - x[j]) / (x[i] - x[j]);
	    }
	}
	ret_val += y[i] * prod;
    }
    return ret_val;
}

int interpol_lin( int n , double *y , double *x ,
	      int nn, double *yy, double *xx)
{
 int i, ii;
 double	k,b;

 /* same sanity checks */

 for(i=0;i<n-1;i++)
  {
   if (x[i] >= x[i+1])
    {
     printf("INTERPOL_LIN:i=%d,x[i]=%13.6e > x[i+1]=%13.6e\n",i,x[i],x[i+1]);
     exit(1);
    }
  }

  for(ii=0;ii<nn-1;ii++)
   {
    if (xx[ii] >= xx[ii+1])
     {
      printf("INTERPOL_LIN:ii=%d,xx[ii]=%13.6e > xx[ii+1]=%13.6e\n",ii,xx[ii],xx[ii+1]);
      exit(1);
     }
   }

 /* simple linear interpolation ... */

 i=0;

 for (ii = 0; ii < nn; ++ii)
  {
   while (xx[ii]>x[i])
    {
     i++;
    }
   if (i)
    {
     k=(y[i]-y[i-1])/(x[i]-x[i-1]);
     b=y[i]-k*x[i];
     yy[ii] = k*xx[ii]+b;
    }
   else
    {
     yy[ii]=y[0];
    }
  }

 return 0;
}

int interpol_log( int n , double *y , double *x ,
	      int nn, double *yy, double *xx)
{
 int i, ii, is;

 /* sanity checks */

 for(i=0;i<n-1;i++)
 if (x[i] >= x[i+1])
  {
   printf("INTERPOL_LOG:i=%d,x[i]=%13.6e > x[i+1]=%13.6e\n",i,x[i],x[i+1]);
   exit(1);
  }

 /* Function Body */

 for(i=0;i<n;i++)
  {
   if (y[i])
    {
     y[i]=log(y[i]);	/* to make the set smoother */
    }
  }

  /*  Below there's the same procedure as "interpol" */

 if (n <= 4)
  {
   for (ii = 0; ii < nn; ++ii)
    {
     yy[ii] = poly(n, y, x, xx[ii]);
    }
  }
 else
  {
   i = 0;
   for (ii = 0; ii < nn; ++ii)
    {
     while(i < n && xx[ii] > x[i])
      {
       i++;
      }

     is = i - 2;
     if (is < 0) is = 0;
     if (is > n - 4) is = n - 4;
     yy[ii] = poly(4, &y[is], &x[is], xx[ii]);
    }

   /* -----interpolation is finished ---------*/

   for (ii = 0; ii < nn; ii++)
    {
     if (yy[ii])
      {
       yy[ii]=exp(yy[ii]);      /* to restore the interpolated data */
      }
    }
  }
 return 0;
}
