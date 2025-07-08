#include <stdio.h>
#include <stdlib.h>

#include <struct.h>
#include <constants.h>
#include <subroutines.h>

VIBLEVEL * init_vl_data ( 
		MOLECULE		*mol,
		VIBLEVEL		*v_level,
		PARAMETERINFO		*pars)
{ /* for the last column, see the file results\2020\02_feb2020\feb01_AAK\feb23-02_KBT_Qrot_coeff.dat  */
 const VIBLEVEL vlev_src[]={
 {0,626,    1,0,0,   0.00000,0.891428},                                                           
 {0,626, 1101,0,0, 667.37996,1.776710},                                                         
 {0,626,10002,0,0,1285.40834,0.890971},                                                         
 {0,626, 2201,0,0,1335.13161,1.75879},                                                          
 {0,626,10001,0,0,1388.18432,0.891562},                                                         
 {0,626,11102,0,0,1932.47013,1.77414},                                                          
 {0,626, 3301,0,0,2003.24615,1.73371},                                                          
 {0,626,11101,0,0,2076.85588,1.77560},                                            	                                                                                                                   
 {0,636,    1,0,0,   0.00000,0.891486},                                             
 {0,636, 1101,0,0, 648.47803,1.77539},                                              
 {0,636, 2201,0,0, 1297.26326,1.75902},                                                                                                                                                                
 {0,628,    1,0,0,   0.00000,1.889470},
 {0,628, 1101,0,0, 662.37335,3.766000},
 {0,627,    1,0,0,   0.00000,1.83767},
 {0,627, 1101,0,0, 664.72941,3.65961},
 {0, 66,    0,0,0,   0.00000,1.00},    /* the last element is used in calculating the populations, */  
 {0, 44,    0,0,0,   0.00000,1.00},    /* and for single level objects it doesn't matter what to put here */ 
 {0,  6,    0,0,0,   0.00000,1.00}     /* atomic oxygen - no rotation */
 };
 		 
 int	ivl,ivl_curr,NVL_MAX,NVL,iMol,NMOL,NVL_prev;

 NVL_MAX=sizeof(vlev_src)/sizeof(VIBLEVEL);
 
 NVL=0;
 NVL_prev=0;
 NMOL=pars->NMOL; 
 
 for(iMol=0;iMol<NMOL;iMol++)
  {
   for(ivl=0;ivl<NVL_MAX;ivl++)
     if (vlev_src[ivl].iso==mol[iMol].iso) NVL++;	   
   
   if(NVL==NVL_prev)
    {
     printf("no viblevel data for iso= %i\nExiting...\n",mol[iMol].iso);
     exit(0);
    }	   
   NVL_prev=NVL;
  } /* to be removed from the final version - no flexibility required */	 
  
 v_level= (VIBLEVEL *) realloc(v_level,(NVL+1)*sizeof(VIBLEVEL));
 
 ivl_curr=0;	/* indexing in v_level */
 
 for(iMol=0;iMol<NMOL;iMol++) /* this procedure isn't optimized for large NVL */
  {
   mol[iMol].ivl_index=ivl_curr;
	  
   for(ivl=0;ivl<NVL_MAX;ivl++)
    {
     if (vlev_src[ivl].iso==mol[iMol].iso)
      {
       v_level[ivl_curr].mole		=iMol; 	/* correspondence with mol structure */
		       
       v_level[ivl_curr].iso		=vlev_src[ivl].iso;
       v_level[ivl_curr].name   	=vlev_src[ivl].name;
       v_level[ivl_curr].energy   	=vlev_src[ivl].energy;
       v_level[ivl_curr].chem_group   	=0;
       v_level[ivl_curr].chem_dmulti 	=0;
       v_level[ivl_curr].K_H_Brot   	=vlev_src[ivl].K_H_Brot;
       ivl_curr++;
      }	     	         
    } /* ivl */
   mol[iMol].ivu_index=ivl_curr-1;
   if (mol[iMol].ivu_index<mol[iMol].ivl_index) mol[iMol].ivu_index=mol[iMol].ivl_index; 
  } /* to be removed from the final version - no flexibility required */	 
 
 pars->NVL=ivl_curr;
#if 0
 for(ivl=0;ivl<pars->NVL;ivl++)
 {
 printf("--------------\n");
 print_VIBLEVEL(v_level,ivl);
 }	 
exit(0);
#endif
 return v_level;
}
