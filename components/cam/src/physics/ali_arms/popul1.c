
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <struct.h>
#include <constants.h>
#include <subroutines.h>
#include <functions.h>
#include <mv_utils.h>

int popul2( 
		double			**PopV,
		double			**Delta,
		double			**Qrot,
		MOLECULE		*mol,
		VIBLEVEL		*v_level,
		ATMOSPHERE		*atmos,
		PARAMETERINFO		*pars)

{
 int	iMol,NMOL,IVU,IVL,ND,NVL;
 int	id,il;
 double EVL,SUM,CHK_T;
 double *TE,*Q_exp;
  	
 NMOL	=pars->NMOL;
 ND	=pars->ND;
 NVL	=pars->NVL;
 TE	=atmos->temperature;
 Q_exp  = vec_FMEMALLOC(NVL);
  
 for (id=0;id<ND;id++)
  { 
   CHK_T=CHK/TE[id]; /* acceleration */	  
   for(iMol=0;iMol<NMOL;iMol++)
    {
     IVU=mol[iMol].ivu_index;
     IVL=mol[iMol].ivl_index;
     SUM=0.0;

     for(il=IVL;il<=IVU;il++)
      {
       EVL=v_level[il].energy;
       Q_exp[il]=Qrot[id][il]*exp(-EVL*CHK_T);
       SUM+=Q_exp[il];
      }

     for(il=IVL;il<=IVU;il++)
      {
       EVL=v_level[il].energy;
       PopV[id][il]=Q_exp[il]/SUM;
      }
    }
  } /* id */
 free(Q_exp);
 return 0;
}