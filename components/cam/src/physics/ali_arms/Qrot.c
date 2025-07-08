
#include <stdio.h>

#include <math.h>
#include <struct.h>
#include <constants.h>
#include <subroutines.h>

int compute_qrot (
		double			**Qrot,
		VIBLEVEL		*v_level,
		ATMOSPHERE		*atmos,
		PARAMETERINFO		*pars)
{
 int 	ND,id,ivl,NVL;
 double *TE;

 ND =pars->ND;
 TE =atmos->temperature;
 NVL=pars->NVL;

 for (id=0;id<ND;id++)
  {
   for(ivl=0;ivl<NVL;ivl++)
    Qrot[id][ivl]=v_level[ivl].K_H_Brot*TE[id]; /* rigid rotator approximation */   
  }
  
 return 0;
}

