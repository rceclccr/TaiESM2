
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <struct.h>
#include <constants.h>
#include <subroutines.h>
#include <functions.h>
#include <mv_utils.h>

int do_ng_acceleration(
			int		 iter,
			MOLECULE	*molecule,
			double		**PopV,
			double		**PopVN,
			double		***G, /* PopStack      */
			double		***D, /* PopStackDelta */
			PARAMETERINFO	*pars)
{
/*
 *          USES RESULTS OF "KBACK" PREVIOUS ITERATIONS AND NG'S METHOD
 *          TO PRODUCE NEW VALUE OF POPULATIONS ("POPVN") THAT ARE
 *          CLOSER TO SOLUTION THAN LAST COMPUTED VALUE OF THE UPDATED
 *         POPULATIONS.  PARAMETERS ARE:
 *
 *             ITER  - ITERATION NUMBER
 *             ITER0 - ITERATION NUMBER AT WHICH NG'S METHOD BEGINS
 *             KBACK - NUMBER OF PREVIOUS ITERATES STORED AND USED; MUST
 *                     LIE BETWEEN 2 AND 5
 *
 *         THIS ROUTINE DIFFERS FROM SUBROUTINE ACCEL IN THAT NG'S METHOD
 *         IS APPLIED CONTINUOUSLY FOR ITER.GE.ITER0.
 *
 */

 int	NVL,ND,KBACK,NMOL,KDLAY,ITER0,KBACK1;
 int	il,id,ik,jk,ivu,ivl,iMol;
 double	sum,csum;

 double	***H, **XM, *C, **XMtmp, *Ctmp;
 int	*INDX;
 
 double	**Pop0;

 double	det; 
 int	ret;
 
 /* UPDATE D'S AND G'S. */

 NVL=pars->NVL;
 ND=pars->ND;
 KBACK=pars->kback;
 NMOL=pars->NMOL;
 KDLAY=pars->kdlay;
 ITER0=pars->iter0;
	
 KBACK1=KBACK+1;
	
 H=(double ***) calloc((unsigned int)KBACK1,sizeof(double **));
 CHECK_PTR(H);

 for(ik=0;ik<KBACK1;ik++)
   H[ik]=mat_FMEMALLOC(ND,NVL);

 XM   =mat_FMEMALLOC(KBACK,KBACK);
 XMtmp=mat_FMEMALLOC(KBACK,KBACK);

 C    =vec_FMEMALLOC(KBACK);
 Ctmp =vec_FMEMALLOC(KBACK);

 INDX =vec_IMEMALLOC(KBACK);

 Pop0 =mat_FMEMALLOC(ND,NVL);

 for (ivl=0;ivl<NVL;ivl++)
  {
   for (id=0;id<ND;id++)
    {
     for (ik=KBACK;ik>=1;ik--)
      {
       D[ik][id][ivl]=D[ik-1][id][ivl];
       G[ik][id][ivl]=G[ik-1][id][ivl];
      }
     G[0][id][ivl]=PopVN[id][ivl];
     D[0][id][ivl]=PopVN[id][ivl]-PopV[id][ivl];
    }
  }  
         
 /* DO NG ACCELERATION IF ITER>=ITER0. Otherwise, store the preliminary data */
	 
 if ( !(iter >= ITER0 && !((iter-ITER0)%KDLAY)) ) goto exit;
 
 for (id=0;id<ND;id++)   
  {	   
   for (ivl=0;ivl<NVL;ivl++)
    {	   
     for (ik=1;ik<=KBACK;ik++)
      {    
       H[ik][id][ivl]=D[0][id][ivl]-D[ik][id][ivl];
      }
    }	
  }  
   
  /* FORM MATRIX ELEMENTS */
	 
 for (iMol=0;iMol<NMOL;iMol++)
  {
   ivu=molecule[iMol].ivu_index;
   ivl=molecule[iMol].ivl_index;
   
   if (ivu==ivl) continue;
   
   for (ik=1;ik<=KBACK;ik++)
    {
     for (jk=1;jk<=ik;jk++)
      {
       sum=0.0;
       for (id=0;id<ND;id++)
	{
	 for (il=ivl;il<=ivu;il++)
	  {
	   sum+=H[ik][id][il]*H[jk][id][il]/G[0][id][il]/G[0][id][il];
	  }
        }  
       XM[ik-1][jk-1]=sum;
       XM[jk-1][ik-1]=sum;
      }      
           
     sum=0.0;
     for (id=0;id<ND;id++)
      {    
       for (il=ivl;il<=ivu;il++)
        {   
	 sum+=D[0][id][il]*H[ik][id][il]/G[0][id][il]/G[0][id][il]; 
        }
      }   
     C[ik-1]=sum;
    } /* ik */

   /* SOLVE LINEAR SYSTEM XM*C=A FOR C-COEFFICIENTS */
	   
   for(ik=0;ik<KBACK;ik++)
    {
     for(jk=0;jk<KBACK;jk++) 
       XMtmp[ik][jk]=XM[ik][jk];
     
     Ctmp[ik]=C[ik];
    } /* ik */
   ret=mat_LUDCMP(XMtmp,&det,KBACK,INDX);
   if (ret)
    {
     for (ik=0;ik<KBACK;ik++) Ctmp[ik]=0.0;
     goto was_singular;
    } 
          
   mat_LUBKSB(XMtmp,KBACK,INDX,Ctmp);
   mat_MPROVE(XM,XMtmp,KBACK,INDX,C,Ctmp);

was_singular:

   csum=0;
   for (ik=0;ik<KBACK;ik++) 
     csum+=Ctmp[ik];
    
   /* COMPUTE ACCELERATED NEW POPULATION */

   for (id=0;id<ND;id++)
    {	   
     for (il=ivl;il<=ivu;il++)
      {
       sum=(1.0-csum)*G[0][id][il];
       for (ik=1;ik<=KBACK;ik++) 
	 sum+=Ctmp[ik-1]*G[ik][id][il];	 
       PopVN[id][il]=sum;
      }
    } /* id */ 	
  } /* iMol */

exit:
 for(ik=0;ik<KBACK1;ik++)
   mat_FMEMFREE(H[ik],ND);

 free(H);  
   
 mat_FMEMFREE(XM,KBACK);
 mat_FMEMFREE(XMtmp,KBACK);

 free(INDX);
 free(C);
 free(Ctmp);

 mat_FMEMFREE(Pop0,ND);

 return 0;
}
