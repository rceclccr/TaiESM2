
#include <stdio.h>
#include <./include/constants.h>
#include <./include/struct.h>
#include <./include/subroutines.h>

int init_parameters(PARAMETERINFO		*pars)
{
 pars->NA		=2;
 pars->itermax		=100;
 pars->iter0		=7;
 pars->kback		=3;
 pars->kdlay		=1;
 pars->nacc		=0;
 pars->alb		=1.0;
 pars->vv_use_lower	=0;
 pars->co2_rules	=1;

 pars->conv		=1e-4;
 pars->odf_NF1		=15;  /* carved in stone, do not change - otherwise, the ODF LUTs won't work !!! */
 pars->odf_NF2		=15;  /* carved in stone, do not change - otherwise, the ODF LUTs won't work !!! */
 pars->odf_xcore	=0.5; /* carved in stone, do not change - otherwise, the ODF LUTs won't work !!! */
 pars->odf_xmax		=5e1; /* carved in stone, do not change - otherwise, the ODF LUTs won't work !!! */
 pars->P_R_join		=0;
                     
 pars->CO2_O_rate_constant	=3.0e-12;

 return 0;
}

