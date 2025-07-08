
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <struct.h>
#include <quant_macros.h>
#include <constants.h>
#include <subroutines.h>


#define SORT_ON_E2 \
	 	   cvv_band= (BAND_CVV *) realloc(cvv_band,(icvv+1)*sizeof(BAND_CVV)); \
                   if ( EU1 > EL1 ) \
  	      	   { \
	       	    cvv_band[icvv].ivu_index1=iu1; \
	            cvv_band[icvv].ivl_index1=il1; \
	           } \
	           else \
	           { \
	            cvv_band[icvv].ivu_index1=il1; \
	            cvv_band[icvv].ivl_index1=iu1; \
	            printf("BBBBBBBBBB1\n"); \
	            exit(1); \
	           }; \
                   if ( EU2 > EL2 ) \
  	      	   { \
	       	    cvv_band[icvv].ivu_index2=iu2; \
	            cvv_band[icvv].ivl_index2=il2; \
	           } \
	           else \
	           { \
	            cvv_band[icvv].ivu_index2=il2; \
	            cvv_band[icvv].ivl_index2=iu2; \
	            printf("BBBBBBBBBB2\n"); \
	            exit(1); \
		   }\
		   cvv_band[icvv].mole1=iMol1; \
		   cvv_band[icvv].mole2=iMol2;



BAND_CVV * fill_CVV (
		MOLECULE	*mol,
		VIBLEVEL	*v_level, 
		BAND_CVV	*cvv_band,
		DEBYE_INFO	*deb,
		PARAMETERINFO	*pars)
{
 int	iu1,il1,iu2,il2,ivu1,ivl1,ivu2,ivl2;
 int	NVL,NMOL,N15MKM,NCVV;
 int	iMol1,iMol2,IVU1,IVL1,IVU2,IVL2,MOL1,MOL2;
 int	icvv, jcvv;
 double	EU1,EL1,EU2,EL2;
 double	RPR21,RPR42;
  
	NVL=pars->NVL;
	NMOL=pars->NMOL;
	N15MKM=pars->N15MKM;
	RPR21=pars->RPR21;
	RPR42=pars->RPR42;
	NCVV=pars->NCVV;
	
	icvv=0;
	if ( pars->co2_rules )
	{
#include "co2.rules.vv"
	}	
	
	NCVV=icvv;
	pars->NCVV=NCVV;
	
	for(icvv=0;icvv<NCVV;icvv++)
	{
	 iMol1=cvv_band[icvv].mole1;
	 iMol2=cvv_band[icvv].mole2;
	 iu1=cvv_band[icvv].ivu_index1;
	 il1=cvv_band[icvv].ivl_index1;
	 iu2=cvv_band[icvv].ivu_index2;
	 il2=cvv_band[icvv].ivl_index2;
	 EU1=v_level[iu1].energy;
	 EL1=v_level[il1].energy;
	 EU2=v_level[iu2].energy;
	 EL2=v_level[il2].energy;
	 
	 if (
	     (EU1-EL1) < (EU2-EL2)
	    )
	 {
	  cvv_band[icvv].ivu_index1=iu2;
	  cvv_band[icvv].ivl_index1=il2;
	  cvv_band[icvv].ivu_index2=iu1;
	  cvv_band[icvv].ivl_index2=il1;
	  cvv_band[icvv].mole1=iMol2;
	  cvv_band[icvv].mole2=iMol1;
	 }
	}
#ifdef PRINT	
 	print_CVV(cvv_band,mol,v_level,pars);
#endif
	/* check for doubles now. */

	for (icvv=0;icvv<NCVV-1;icvv++)
	 for (jcvv=icvv+1;jcvv<NCVV;jcvv++)
	  if(
	      ( cvv_band[icvv].ivu_index1 == cvv_band[jcvv].ivu_index1 ) &&
	      ( cvv_band[icvv].ivu_index2 == cvv_band[jcvv].ivu_index2 ) &&
	      ( cvv_band[icvv].ivl_index1 == cvv_band[jcvv].ivl_index1 ) &&
	      ( cvv_band[icvv].ivl_index2 == cvv_band[jcvv].ivl_index2 ) &&
	      ( cvv_band[icvv].group      == cvv_band[jcvv].group      ) 
	    )
	  {
	   printf("Found duplicated icvv=%d jcvv=%d entry. Bye...\n",
	           icvv,jcvv);
	   exit(1);
	  }
#if 0
for (icvv=0;icvv<NCVV;icvv++)
{
printf("icvv= %3i m1= %3i iso1= %3i m2= %3i iso2= %3i IVU1= %3i IVL1= %3i IVU2= %3i IVL2= %3i\n",
icvv,
cvv_band[icvv].mole1,
cvv_band[icvv].iso1,
cvv_band[icvv].mole2,
cvv_band[icvv].iso2,
cvv_band[icvv].ivu_index1,
cvv_band[icvv].ivl_index1,
cvv_band[icvv].ivu_index2,
cvv_band[icvv].ivl_index2);

printf("group= %3i alt_indep= %6.4e alt_dep= %3i\n",
cvv_band[icvv].group,
cvv_band[icvv].alt_indep,
cvv_band[icvv].alt_dep);
}	
#endif	
	
#ifdef PRINT
	printf("init_CVV:found %d CVV\n",NCVV);
#endif

 return cvv_band;
} 
