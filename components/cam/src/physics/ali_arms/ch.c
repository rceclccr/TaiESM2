
#include <stdio.h>
#include <stdlib.h>

#include <struct.h>
#include <constants.h>
#include <subroutines.h>
#include <mv_utils.h>

int	ch_vib_rates (
     		BAND_ODF		*band_odf,
     		MOLECULE		*mol,
		VIBLEVEL		*v_level,
     		double			**PopV,
     		ATMOSPHERE		*atmos,
     		PARAMETERINFO		*pars,
		float			*CH_SUM)
{
 LINE_ODF	*line_odf;
 int 		id,odf_index,odf_num,ivl,ivu,iMol,MOL;
 int 		ND;
 double		ABUND,EVU,EVL;

 line_odf=band_odf->line_odf;

 ND=pars->ND; 
 odf_num=band_odf->odf_num;
 
 for(id=0;id<ND-1;id++)
/* ND-1: in order not to violate memory allocated for CH_SUM in Fortran */	 
  {
   for (odf_index=0;odf_index<odf_num;odf_index++)
    {
     iMol 	=line_odf[odf_index].mole;
     MOL	=mol[iMol].hitnumber;
     ABUND	=mol[iMol].abund;

     ivu=line_odf[odf_index].IVU;
     ivl=line_odf[odf_index].IVL;
     EVU=v_level[ivu].energy;
     EVL=v_level[ivl].energy;
     
     CH_SUM[id]+=
 	  	atmos->c_volume[MOL*ND+id]*ABUND/
 	  	(atmos->Cp[id])*/*24.0*60.0*60.0**/(EVU-EVL)*CHK*
 	  	(PopV[id][ivl]*band_odf->rate_Up[id][odf_index]
 	  	-PopV[id][ivu]*band_odf->rate_Do[id][odf_index]);

    }
  }
 return 0;
}

