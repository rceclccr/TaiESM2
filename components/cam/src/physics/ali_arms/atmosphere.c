
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <struct.h>
#include <constants.h>
#include <functions.h>
#include <subroutines.h>
#include <planet.h>
#include <mv_utils.h>

void fill_atmosphere_model (ATMOSPHERE		*atmos,
			PARAMETERINFO		*pars,
			MOLECULE		*mol,
			float			*H,
			float			*P,
			float			*T,
			float			*CO2,
			float			*O,
			float			*N2,
			float			*O2)

{
 int id,jd,ND;

 ND=pars->ND;
 alloc_atmos(ND,atmos);
 
 pars->planet=1;	/* Mars */
   
 for(id=0;id<ND;id++)
  {
   if (id<ND-1) 
     jd=id;
   else
     jd=id-1;
   	  
   atmos->altitude[id]			=H[jd];
   atmos->pressure[id]			=P[jd];
   atmos->temperature[id]		=T[jd];

   atmos->c_volume[MOL_CO2*ND +id]	=CO2[jd];
   atmos->c_volume[MOL_O*ND   +id]	=O[jd];  
   atmos->c_volume[MOL_N2*ND +id]	=N2[jd];
   atmos->c_volume[MOL_O2*ND +id]	=O2[jd];
   atmos->sqrt_T[id]			=sqrt(atmos->temperature[id]);
   atmos->concentration[id]= 
           atmos->pressure[id]/atmos->temperature[id]/BOLTZK*HPSC;
   
  }   
 atmos->altitude[ND-1]			=H[ND-2]-(H[ND-3]-H[ND-2])*2.0;
 /* this trick affects the lower boundary */
}

int fill_atmos (ATMOSPHERE	*atmos)
{
 double		*Hkm,*conc,*CV;
 int 		id;
 int		ND;

 ND	=atmos->ND;
 Hkm	=atmos->altitude;
 CV	=atmos->c_volume;
 conc	=atmos->concentration;

 for(id=0;id<ND;id++)
  {
   conc[id]=atmos->pressure[id]/atmos->temperature[id]/BOLTZK*HPSC;

   atmos->Cp[id]=7./2.*(CV[MOL_CO2*ND+id]+
 	  	        CV[MOL_O2*ND+ id]+
 	  	        CV[MOL_N2*ND+ id]+
 	  	        CV[MOL_CO*ND+ id])+
 	  	 5./2.*CV[MOL_O*ND+id];
  
   if (id<ND-1)
    { 
     atmos->WTS_suppl_0[id]=(Hkm[id]-Hkm[id+1])/2.0*1.0e5*
                conc[id+1];
   
     atmos->WTS_suppl_1[id]=(Hkm[id]-Hkm[id+1])/2.0*1.0e5*
                conc[id  ];
    }
   else
    {
     atmos->WTS_suppl_0[id]=atmos->WTS_suppl_0[id-1];	    
     atmos->WTS_suppl_1[id]=(Hkm[id-1]-Hkm[id])/2.0*1.0e5*conc[id  ];
    }     
  } /* id */
 return 0;
}

int alloc_atmos (
		int			ND,
		ATMOSPHERE		*atmos)
{
	atmos->ND		 = ND;
	atmos->altitude          = vec_FMEMALLOC(ND);
	atmos->c_volume          = vec_FMEMALLOC(ND*NMOLMAX);
	atmos->temperature       = vec_FMEMALLOC(ND);
	atmos->sqrt_T	         = vec_FMEMALLOC(ND);
	atmos->pressure          = vec_FMEMALLOC(ND);
	atmos->concentration     = vec_FMEMALLOC(ND);
	atmos->Cp                = vec_FMEMALLOC(ND);
        atmos->WTS_suppl_0	 = vec_FMEMALLOC(ND);
        atmos->WTS_suppl_1	 = vec_FMEMALLOC(ND);
	
 return 0;
}

int free_atmos (
		ATMOSPHERE	*atmos,
		int		ND)
{
 free(atmos->altitude);
 free(atmos->c_volume);
 free(atmos->temperature);
 free(atmos->sqrt_T);
 free(atmos->pressure);
 free(atmos->concentration);
 free(atmos->Cp);
 free(atmos->WTS_suppl_0);
 free(atmos->WTS_suppl_1);
	
 return 0;
}
