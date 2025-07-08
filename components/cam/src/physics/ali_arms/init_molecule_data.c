#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <./include/struct.h>
#include <./include/subroutines.h>
#include <./include/hitran.h>

MOLECULE * init_molecule_data ( 
		MOLECULE		*mol,
		PARAMETERINFO		*pars )

{
 int	iMol, NMOL;
 int	Speci,i;
 const int	iso[]={626,636,628,627, 66, 44, 6};
 
 NMOL=sizeof(iso)/sizeof(int);
 
 pars->NMOL=NMOL;	 
 
 mol= (MOLECULE *) realloc(mol,(NMOL+1)*sizeof(MOLECULE));
 
 for(iMol=0;iMol<NMOL;iMol++)
  {	  
   for (i=0;i<sizeof(mol_param)/sizeof(MOLPARAM);i++)
   if( mol_param[i].name == iso[iMol]) 
    {
     Speci=i;
     break;
    }
   mol[iMol].iso=iso[iMol];
   mol[iMol].sqamass=sqrt(mol_param[Speci].amass);
   mol[iMol].abund=mol_param[Speci].abund;
   mol[iMol].hitnumber=mol_param[Speci].hitnumber;
  }
 return mol;
 /* KL_comments: searching for molecules is ineffective 
 In final version one has to replace this filling by setting of precomputed structure */
}
