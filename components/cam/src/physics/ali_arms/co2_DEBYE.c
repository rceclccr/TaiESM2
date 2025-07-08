
#include <stdio.h>
#include <stdlib.h>

#include <struct.h>
#include <constants.h>
#include <subroutines.h>
#include <quant_macros.h>

DEBYE_INFO * init_DEBYE(
		DEBYE_INFO	*deb,
		PARAMETERINFO	*pars,
		MOLECULE	*mol)
{
 const DEBYE_INFO deb_src[]={
#include "debye_info.h"
 };
/* {iso,u_level,l_level,frequency,aein,debye} */
 
 double	RPR21,RPR42;
 int	NMAX,N15MKM;
 int	i,ivt15,iDeb,iMol,NMOL;
 
 NMOL=pars->NMOL;
 
 NMAX=sizeof(deb_src)/sizeof(DEBYE_INFO_prelim);

 deb= (DEBYE_INFO *) realloc(deb,NMAX*sizeof(DEBYE_INFO));
 
 iDeb=0;
 
 for(i=0;i<NMAX;i++)
  {
   for(iMol=0;iMol<NMOL;iMol++)
    {
     if (deb_src[i].iso==mol[iMol].iso)
      {
       copy_DEBYE(deb_src,i,deb,iDeb);	      
       iDeb++;
       break;      
      }	     
    }	
  }	 
 
 deb= (DEBYE_INFO *) realloc(deb,(iDeb+1)*sizeof(DEBYE_INFO));
 
 pars->N15MKM=iDeb;
 N15MKM=pars->N15MKM;
	
 for (ivt15=0;ivt15<N15MKM;ivt15++)
  {
   if (( 1101 == deb[ivt15].u_level) &&
       (    1 == deb[ivt15].l_level) &&
       (  626 == deb[ivt15].iso    ))
    {
     RPR21=deb[ivt15].debye;
#ifdef PRINT     
     printf ("\nRPR21=%12.6f\n",RPR21);
#endif    
    }
   if (( 2201 == deb[ivt15].u_level) &&
       ( 1101 == deb[ivt15].l_level) &&
       (  626 == deb[ivt15].iso    ))
    {
     RPR42=deb[ivt15].debye;
#ifdef PRINT     
     printf ("\nRPR42=%12.6f\n",RPR42);
#endif    
    }
  }	
	
 if (RPR21 < 0.0 )
  {
   printf("Couldn't find debye RPR21. Bye.\n");
   exit(1);
  }

 if (RPR42 < 0.0 )
  {
   printf("Couldn't find debye RPR42. Bye.\n");
   exit(1);
  }
	
 pars->RPR21=RPR21;
 pars->RPR42=RPR42;

/* End of debye input */
 return deb;
}

int	copy_DEBYE(	DEBYE_INFO	*A,
			int		i,
			DEBYE_INFO	*B,
			int		j)
{
 B[j].iso	=A[i].iso;
 B[j].u_level 	=A[i].u_level;
 B[j].l_level 	=A[i].l_level;
 B[j].frequency =A[i].frequency;
 B[j].aein 	=A[i].aein;
 B[j].debye 	=A[i].debye;
 return 0;	 
}			


double find_debye(
		int		iMol,
		int		ivu,
		int		ivl,
		MOLECULE	*mol,
		DEBYE_INFO	*deb,
		PARAMETERINFO	*pars)

{
 double retval;
 int ivt15,N15MKM;

	N15MKM=pars->N15MKM;

	      for (ivt15=0;ivt15<N15MKM;ivt15++)
	      {
	       if (((ivu- CO2_V3(ivu) *10) == deb[ivt15].u_level) &&
	           ((ivl- CO2_V3(ivl) *10) == deb[ivt15].l_level) &&
	           (        mol[iMol].iso  == deb[ivt15].iso    )
	          )
	       {
	        retval=deb[ivt15].debye;
	        goto found;	        
	       }
	      }
	      printf("Can't find debye for mol:%3.3d tr.:%5.5d->%5.5d\n",
	              mol[iMol].iso,ivu,ivl);
/*	      exit(1);  for compatibility */
/*	      retval=0.0;*/
	      retval=pars->RPR42; /* hmm */
found:
	return retval;
}
