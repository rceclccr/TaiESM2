
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <struct.h>
#include <constants.h>
#include <subroutines.h>
#include <mv_utils.h>

double check_conv(
		double 			**PopV,
		double 			**PopVN,
		double			**DeltaV,
		PARAMETERINFO		*pars )
{
 int id, ivl;
 int  NVL,ND;
 int imax; /* -1 */
 double dPop;
 int	tmpH=-1;
 double	CONV;

 NVL=pars->NVL;
 ND=pars->ND;
 
 CONV=pars->conv;
 
 dPop=0.0;

 for (ivl=0;ivl<NVL;ivl++)
  {
   for (id=0;id<ND;id++)
    {
     if (PopVN[id][ivl]>0.0)
      {
       DeltaV[id][ivl]=fabs((PopVN[id][ivl]-PopV[id][ivl])/PopVN[id][ivl]);
      }      
     else
      {
#ifdef PRINT       
       printf("Check conv: level N %i has negative value for population at id= %i\n",ivl,id);
       printf("Therefore, it's not involved in the convergency check!!!\n");
#endif       
       DeltaV[id][ivl]=0.0;
      }

     if ( DeltaV[id][ivl] > dPop )
      {
       dPop=DeltaV[id][ivl];
       tmpH=id;
       imax=ivl;
      }
    }
  }
  
#ifdef PRINT
 printf ( "\nConvergency: MAX Delta= %3.6e imax= %3i\n",dPop,imax);
 fflush(stdout);
#endif
 if (dPop <CONV ) return 0.0;
 else return dPop;
}

int update_pops(
		double 			**PopV,
		double 			**PopVN,
		PARAMETERINFO		*pars )
{
 int	ND,NVL;
 int	ivl,id;

 ND=pars->ND;
 NVL=pars->NVL;

 for (ivl=0;ivl<NVL;ivl++)
  {
   for (id=0;id<ND;id++)
    {
     if (PopVN[id][ivl] < 0.0 )
      {
#ifdef PRINT       
       printf("Negative PopVN[%i][%i]=%1.6e. Will use old Pop= %1.6e\n",
                              id,ivl,PopVN[id][ivl],PopV[id][ivl]);
#endif
       /*
       Other variants:

       PopV[id][ivl]=-PopVN[id][ivl];
       PopV[id][ivl]=1e-30;

       If the level constantly has a negative population, then all three variants fail

       */
      }
     else
      {
       PopV[id][ivl]=PopVN[id][ivl];
      }
    }
  } /* ivl */
 return 0;
}
