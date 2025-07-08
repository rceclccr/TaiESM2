
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <mv_utils.h>

#include <struct.h>
#include <subroutines.h>

void mat_FTRANSP(int N, double **A) /* A=A^{T} */
{
 register int i,j;
 register double tmp;
 
 	for (i=0;i<N;i++)
 	 for (j=0;j<i;j++)
 	 {
 	  tmp=A[i][j];
          A[i][j]=A[j][i];
          A[j][i]=tmp;        
         }
}

void mat_FCLR(int N, double **A) /* A=0.0 */
{
 register int i,j;
	for(i=0;i<N;i++)
	 for(j=0;j<N;j++) A[i][j]=0.0;
}

void mat_FMUL(int N, double **A, double **B, double **C) /* C=A*B */
{
 register int i,j;
	mat_FTRANSP(N,B);
	for(i=0;i<N;i++)
	 for(j=0;j<N;j++) C[i][j]=vec_FSMUL(N,A[i],B[j]);
}

void mat_FADD(int N, double **A, double **B, double **C) /* C=A+B */
{
 register int i;
	for(i=0;i<N;i++) vec_FADD(N,A[i],B[i],C[i]);
}


void mat_FSUB(int N, double **A, double **B, double **C) /* C=A-B */
{
 register int i;
	for(i=0;i<N;i++) vec_FSUB(N,A[i],B[i],C[i]);
}


void mat_INVERT(int N, double **A, double **C)           /* C=A^{-1) */
{

}

void vec_FADD(int N, double *A, double *B, double *C) /* C=A+B */
{
 register int i;
	for(i=0;i<N;i++) C[i]=A[i]+B[i];
}


void vec_FSUB(int N, double *A, double *B, double *C) /* C=A-B */
{ 
 register int i;
	for(i=0;i<N;i++) C[i]=A[i]-B[i];
}

double vec_FSMUL(int N, double *A, double *B) /* =<A,B> */
{
 register int i;
 register double ret=0.0;
	for(i=0;i<N;i++) ret+=A[i]*B[i];
 return ret;
}

void matvec_FMUL(int N, double **A, double *B, double *C) /* C=A*B */
{
 register int i;
	for(i=0;i<N;i++) C[i]=vec_FSMUL(N,A[i],B);
}

double ** mat_FMEMALLOC(int M, int N)
{
 int i;
 double **ptr=NULL;
	ptr=(double **)calloc((unsigned)M,sizeof(double *));
 if(!ptr) {
	 printf("failed to allocate %d doubles,exiting...\n",M);
	 exit(1);
	}
 for(i=0;i<M;i++) {
	 ptr[i]=(double *) calloc((unsigned) N,sizeof(double));
	 if(!ptr[i]) {
	  printf("failed to allocate %d doubles,exiting...\n",N);
	  exit(1);
	 }
	}
 return ptr;
}

int ** mat_IMEMALLOC(int M, int N)
{
 int	i;
 int	**ptr=NULL;

	ptr=(int **)calloc((unsigned)M,sizeof(int *));
	if(!ptr) {
	 printf("failed to allocate %d integers,exiting...\n",M);
	 exit(1);
	}
	for(i=0;i<M;i++) {
#if 0
	 ptr[i]=(int *) calloc((unsigned) N,sizeof(int));
	 if(!ptr[i]) {
	  printf("failed to allocate %d integers,exiting...\n",N);
	  exit(1);
	 }
#else
	 ptr[i]=vec_IMEMALLOC(N);
#endif
	}

 return ptr;
}

double * vec_FMEMALLOC(int N)
{
 double *ptr=NULL;
	ptr=(double *)calloc((unsigned) N,sizeof(double));
	if(!ptr) {
	 printf("failed to allocate %d doubles,exiting...\n",N);
	 exit(1);
	}
 return ptr;
}

int * vec_IMEMALLOC(int N)
{
 int *ptr=NULL;
	ptr=(int *)calloc((unsigned int) N,sizeof(int));
	if(!ptr) {
	 printf("failed to allocate %d integers,exiting...\n",N);
	 exit(1);
	}
 return ptr;
}

int * vec_IREALLOC(int *start, int N)
{
 int *ptr=NULL;
	ptr=(int *)realloc(start,N*sizeof(int));
	if(!ptr) {
	 printf("failed to reallocate %d integers,exiting...\n",N);
	 exit(1);
	}
 return ptr;
}

void mat_FMEMFREE(double **ptr, int M)
{
 int i;
	for(i=M-1;i>=0;i--)
	 free(ptr[i]);
	free(ptr);
}

void mat_IMEMFREE(int **ptr, int M)
{
 int i;
	for(i=M-1;i>=0;i--)
	 free(ptr[i]);
	free(ptr);
}

void vec_FMEMFREE(double *ptr)
{
	free(ptr);
}

#define TINY 1.0e-120;

int mat_LUDCMP(double **a, double *det, int n, int *indx)
{
	int i,imax=-1,j,k;
	double big,dum,sum,temp,d;
	double *vv;

	vv=vec_FMEMALLOC(n);

	d=1.0;
	for (i=0;i<n;i++) {
                big=0.0;
		for (j=0;j<n;j++)
			if ((temp=fabs(a[i][j])) > big) big=temp;
		if (big == 0.0) {
                 printf("error in line N%i\n",i);
		 printf("FATAL ERROR: Singular matrix in routine LUDCMP\n");
		 print_RMAT(a,n);
		 printf("FATAL ERROR: Singular matrix in routine LUDCMP\n");
		 return (-1);
		}
		vv[i]=1.0/big;
	}
	for (j=0;j<n;j++) {
		for (i=0;i<j;i++) {
			sum=a[i][j];
			for (k=0;k<i;k++) sum -= a[i][k]*a[k][j];
			a[i][j]=sum;
		}
		big=0.0;
		for (i=j;i<n;i++) {
			sum=a[i][j];
			for (k=0;k<j;k++)
				sum -= a[i][k]*a[k][j];
			a[i][j]=sum;
			if ( (dum=vv[i]*fabs(sum)) >= big) {
				big=dum;
				imax=i;
			}
		}
		if (j != imax) {
			for (k=0;k<n;k++) {
				dum=a[imax][k];
				a[imax][k]=a[j][k];
				a[j][k]=dum;
			}
			d = -d;
			vv[imax]=vv[j];
		}
		indx[j]=imax;
		if (a[j][j] == 0.0) a[j][j]=TINY;
		if (j != (n-1)) {
			dum=1.0/(a[j][j]);
			for (i=j+1;i<n;i++) a[i][j] *= dum;
		}
	}
	free(vv);
	*det=d;

 return 0;
}

#undef TINY

int mat_LUBKSB(double **a,int n,int *indx,double *b)
{
	int i,ii=-1,ip,j;
	double sum;

	for (i=0;i<n;i++) {
		ip=indx[i];
		sum=b[ip];
		b[ip]=b[i];
		if ( ii >=0 )
			for (j=ii;j<i;j++) sum -= a[i][j]*b[j];
		else if (sum != 0.0) ii=i;
		b[i]=sum;
	}
	for (i=n-1;i>=0;i--) {
		sum=b[i];
		for (j=i+1;j<n;j++) sum -= a[i][j]*b[j];
		b[i]=sum/a[i][i];
	}
 return 0;
}

int mat_MPROVE(double **a,double **alud,int n,int *indx,double *b,double *x)
{
	int j,i;
	double sdp;
	double *r;

	r=vec_FMEMALLOC(n);

	for (i=0;i<n;i++) {
		sdp = -b[i];
		for (j=0;j<n;j++) sdp += a[i][j]*x[j];
		r[i]=sdp;
	}
	mat_LUBKSB(alud,n,indx,r);
	for (i=0;i<n;i++) x[i] -= r[i];
	free(r);
 return 0;
}

int alloc_rates(
		int			ND,
		PBAND			*pband)
{
 int NUM;

	NUM=pband->NUM;

        if(NUM)
        {
	 pband->rate_Do =mat_FMEMALLOC(ND,NUM);
	 pband->rate_Up =mat_FMEMALLOC(ND,NUM);
	}
	else
        {
	 pband->rate_Do =NULL;
	 pband->rate_Up =NULL;
	}

 return 0;
}

int dealloc_rates(
		int			ND,
		PBAND			*pband)
{
 int NUM;
printf("error is suspected  - check dealloc rates\nExiting\n");
exit(0);
 NUM=pband->NUM;
 if(NUM)
  {
   mat_FMEMFREE(pband->rate_Do,ND);
   mat_FMEMFREE(pband->rate_Up,ND);
  }

 return 0;
}

int clear_rates(
		int			ND,
		PBAND			*pband)
{
 int i,id,NUM;

 NUM=pband->NUM;

 for (i=0;i<NUM;i++)
  {
   for (id=0;id<ND;id++)
    {
     pband->rate_Do[id][i]=0.0;
     pband->rate_Up[id][i]=0.0;
    }
  }
  
 return 0;
}
