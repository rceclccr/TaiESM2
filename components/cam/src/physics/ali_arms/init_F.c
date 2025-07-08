
#include <stdio.h>
#include <math.h>
#include <struct.h>
#include <subroutines.h>

#include <functions.h>
#include <mv_utils.h>
#include <constants.h>

int init_ODF_freq(
		INTEGR_ODF		*integr_ODF,
		PARAMETERINFO		*pars)
{
 int NA;
 double *MU, *MW;

 double	*X,*XW;
 int	ifr,NF,NF1,NF2;

 NF1=pars->odf_NF1;
 NF2=pars->odf_NF2;
 NF=NF1+NF2;

 integr_ODF->x=vec_FMEMALLOC(NF);
 integr_ODF->xw=vec_FMEMALLOC(NF);

 X=vec_FMEMALLOC(NF1);
 XW=vec_FMEMALLOC(NF1);

 gauss(0.0, pars->odf_xcore, X, XW, NF1);

 for (ifr=0;ifr<NF1;ifr++)
  {
   integr_ODF->x[ifr] =X[ifr];
   integr_ODF->xw[ifr]=XW[ifr];
  }

 free(X);
 free(XW);
 /* it's ugly, but it should work */

 X=vec_FMEMALLOC(NF2);
 XW=vec_FMEMALLOC(NF2);

 gauss(pars->odf_xcore, pars->odf_xmax, X, XW, NF2);

 for (ifr=0;ifr<NF2;ifr++)
  {
   integr_ODF->x[ifr+NF1] =X[ifr];
   integr_ODF->xw[ifr+NF1]=XW[ifr];
  }

 free(X);
 free(XW);

 NA=integr_ODF->NA;
 MU=vec_FMEMALLOC(NA);
 MW=vec_FMEMALLOC(NA);

 if( NA == 1 ) 
  {
   MU[0]=1/sqrt(3.0);
   MW[0]=1.0;
  }
 else 
  {
   gauss(0.0,1.0,MU,MW,NA);
  }

 integr_ODF->mu=MU;
 integr_ODF->mw=MW;
 
 /* KL_comments: one has set all these parameters as a table !!! */
 return 0;
}

int	free_ODF_freq(INTEGR_ODF		*integr_ODF)
{
 free(integr_ODF->mu);
 free(integr_ODF->mw);
 free(integr_ODF->x);
 free(integr_ODF->xw);

 return 0;		
}