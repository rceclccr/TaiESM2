
#include <sys/stat.h>
#include <unistd.h>

#include <string.h>
#include <stdio.h>
#include <stdlib.h>  

#include <struct.h>
#include <constants.h>
#include <subroutines.h>

int iso_name_to_hitnumber(int N)
{
	switch (N)
	{
	 case 161:
	 case 181:
	 case 171:
	 case 162:
	 return MOL_H2O;
	 
	 case 626:
	 case 636:
	 case 628:
	 case 627:
	 case 638:
	 case 637:
	 case 828:
	 case 728:
	 return MOL_CO2;
	 
	 case 666:
	 case 668:
	 case 686:
	 case 667:
	 case 676:
	 return MOL_O3;
	 
	 case 446:
	 case 456:
	 case 546:
	 case 448:
	 case 447:
	 return MOL_N2O;
	 
	 case 26:
	 case 36:
	 case 28:
	 case 27:
	 case 38:
	 case 37:
	 return MOL_CO;	 
	 
	 case 66:
	 case 68:
	 return MOL_O2;

	 case 44:
	 return MOL_N2;

	 case 46:
         return MOL_NO;
	 
	 case 61:
         return MOL_OH;
	 
	 case 6:
         return MOL_O;
	 
	 default:
	 printf("\nNo such iso: %d\n Exiting...\n",N);
	 exit(1);
	}
}

int iso_name_to_iMol( int N,MOLECULE *mol,PARAMETERINFO *pars)
{
 int iMol;
 	for (iMol=0;iMol<pars->NMOL;iMol++)
 	 if (mol[iMol].iso == N) return iMol;

	 printf("\nNo such iso in the problem (iso_to_iMol): %d\n Exiting...\n",N);
	 exit(1);
}

double PROBDN(int N, int L)
{
 int	K;
 
 	K=N/2;

	if(N%2)
	{
	 if (L)
	 {
	  return ( 2.0/(N/2+1)/(N/2+2) );
	 }
	 else
	 {
	  printf("L=0,N=%d???,exiting...\n",N);
	  exit(1);
	 }
	}
	else
	{
	 if (L)
	 {
	  return ( 2.0/(N/2+1)/(N/2+1) );
	 }
	 else
	 {
	  return ( 1.0/(N/2+1)/(N/2+1) );
	 }
	}
}



int clear_Rmat ( double **Rmat, int NL)
{
 int iu,il;

 	for (iu=0;iu<NL;iu++)
 	 for (il=0;il<NL;il++)
 	  Rmat[iu][il]=0.0;

 return 0;
}

int clear_array ( double **A, int NX,int NY)
{
 int ix,iy;

 	for (ix=0;ix<NX;ix++)
 	 for (iy=0;iy<NY;iy++)
 	  A[ix][iy]=0.0;

 return 0;
}


int filesize(const char *filename)
{
   struct stat st;

    if (!stat( filename, &st)) return (st.st_size);
    else                           return -1;
}

int hit_getint(char *rec, int len)
{ 
  	char buf[16];
  	strncpy(buf,rec,(unsigned int)len);
        buf[len]='\0'; 
        return atoi(buf);
}

double hit_getdbl(char *rec,int len)
{ 
  	char buf[16];
  	strncpy(buf,rec,(unsigned int)len);
        buf[len]='\0'; 
        return atof(buf);  
} 

