
#include <struct.h>
#include <subroutines.h>
#include <constants.h>

int is_level_in_problem(
			MOLECULE	*mol,
			int		iMol,
			VIBLEVEL	*v_level,
			int		il)
{
 int ivl;
 
	    for (ivl=mol[iMol].ivl_index;ivl<=mol[iMol].ivu_index;ivl++)
	    {
	     if ( 
	         ( il  == v_level[ivl].name )
	        )
              return ivl;
	    }
 return -1;
}

int mol_in_the_problem ( 
			int		M,
			MOLECULE	*mol,
			PARAMETERINFO	*pars )
{
 int iMol;
 int NMOL;
 
 	NMOL=pars->NMOL;
	for (iMol=0;iMol<NMOL;iMol++)
	{
	 if(mol[iMol].hitnumber == M ) return 1;
	}
 return 0;
}
