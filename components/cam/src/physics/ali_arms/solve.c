
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <struct.h>
#include <functions.h>
#include <constants.h>
#include <subroutines.h>
#include <mv_utils.h>
#define RMAT_PRINT 0

int compute_populations(
     		BAND_ODF		*odf_band,
		PBAND_CVT		*pcvt_band,
     		double			**Rmat,
     		MOLECULE		*mol,
		VIBLEVEL		*v_level,
     		double			**PopVN,
     		ATMOSPHERE		*atmos,
     		PARAMETERINFO		*pars,
     		int			id)

{
 LINE_ODF	*line_odf;
 int 		iMol, *INDX,MOL;
 int 		ND,NCVT,NMOL, NVL;
 int 		icvt,ivu,ivl;
 int		num_odf,odf_index;
 int		ret;
 
 double		det;
 double 	SUM;
 double 	*Rhs, *RhsTemp, **RmatTemp;
 double		*TE;

 double		**CColVTUp, **CColVTDo;
 double		**COptVVUp, **COptVVDo;

 BAND_CVT	*cvt_band;
 
 ND=pars->ND;

 NCVT=pcvt_band->NUM;

 NVL=pars->NVL;
 NMOL=pars->NMOL;
 TE=atmos->temperature;

 line_odf=odf_band->line_odf;
 num_odf=odf_band->odf_num;
 
 INDX    =vec_IMEMALLOC(NVL);
 Rhs     =vec_FMEMALLOC(NVL);
 RhsTemp =vec_FMEMALLOC(NVL);
 RmatTemp=mat_FMEMALLOC(NVL,NVL);

 CColVTUp=pcvt_band->rate_Up;
 CColVTDo=pcvt_band->rate_Do;
 
 COptVVUp=odf_band->rate_Up;
 COptVVDo=odf_band->rate_Do;
  
 cvt_band    =pcvt_band->band;
#if RMAT_PRINT
{
 if (id==ND/2-1)
  {
   printf("\nAfter NCVV2 ID=%d\n",id);
   print_RMAT_RHS(Rmat,Rhs,NVL);
  }
}
#endif
 /* 1st step - static V-T processes */

 
 for (icvt=0;icvt<NCVT;icvt++)
  {
   ivu=cvt_band[icvt].ivu_index;
   ivl=cvt_band[icvt].ivl_index;
   Rmat[ivl][ivu]+=CColVTDo[id][icvt];
   Rmat[ivu][ivl]+=CColVTUp[id][icvt];
  }

#if RMAT_PRINT
{
 if (id==ND/2-1)
  {
   printf("\nAfter NCVT ID=%d\n",id);
   print_RMAT_RHS(Rmat,Rhs,NVL);
  }
}
#endif

 /* 3th step - "dynamic" optical processes */

 for(odf_index=0;odf_index<num_odf;odf_index++)
  {
   ivu=line_odf[odf_index].IVU;
   ivl=line_odf[odf_index].IVL;
   Rmat[ivl][ivu]+=COptVVDo[id][odf_index];
   Rmat[ivu][ivl]+=COptVVUp[id][odf_index];
  }
  
#if RMAT_PRINT
{
 if (id==ND/2-1)
  {
   printf("\nAfter NAVV ID=%d\n",id);
   print_RMAT_RHS(Rmat,Rhs,NVL);
  }
}
#endif
 
 for(ivl=0;ivl<NVL;ivl++)
  {
   /* Rhs[ivl]=-Chem[ivl][id]; */
   Rhs[ivl]=0.0;	/* no chemistry on Mars */
  }

 /* Multiply by corresponding VMR all the columns */

 for(iMol=0;iMol<NMOL;iMol++)
  {
   MOL=mol[iMol].hitnumber;
   for(ivl=0;ivl<NVL;ivl++)
   for(ivu=mol[iMol].ivl_index;ivu<=mol[iMol].ivu_index;ivu++)
    {
     Rmat[ivl][ivu]*=atmos->c_volume[MOL*ND+id]*mol[iMol].abund;
    }
  }
#if RMAT_PRINT
{
 if (id==ND/2-1)
  {
   printf("\nBefore SUM ID=%d\n",id);
   print_RMAT_RHS(Rmat,Rhs,NVL);
  }
}
#endif
 /* NOW CALCULATE DIAGONAL ELEMENTS OF RMAT AS OFF-DIAGONAL ROW SUMS. */

 for(ivu=0;ivu<NVL;ivu++)
  {
   SUM=0.0;
   for(ivl=0;ivl<NVL;ivl++)
     if(ivl != ivu) SUM+=Rmat[ivl][ivu];
   Rmat[ivu][ivu]=-SUM;
  }

 /* THE RATE EQUATIONS ARE LINEARLY DEPENDENT, SO WE CHOOSE ONE ROW TO BE REPLACED
    BY THE PARTICLE CONSERVATION LAW (IN PRINCIPLE IT SHOULDN'T MATTER WHICH)
    FOR EVERY MOLECULE IN THE PROBLEM.	  */
#if RMAT_PRINT
  {
   if (id==ND/2-1)
    {
     printf("\nBefore NORMALIZATION ID=%d\n",id);
     print_RMAT_RHS(Rmat,Rhs,NVL);
    }
  }
#endif
 for(iMol=0;iMol<NMOL;iMol++)
  {
   if (iMol)
     for (ivl=mol[0].ivl_index;ivl<mol[iMol].ivl_index;ivl++)
       Rmat[mol[iMol].ivl_index][ivl]=0.0 ;

   for (ivl=mol[iMol].ivl_index;ivl<=mol[iMol].ivu_index;ivl++)
     Rmat[mol[iMol].ivl_index][ivl]=1.0 ;

   if (iMol!=NMOL-1)
     for (ivl=mol[iMol+1].ivl_index;ivl<=mol[NMOL-1].ivu_index;ivl++)
       Rmat[mol[iMol].ivl_index][ivl]=0.0 ;

   Rhs[mol[iMol].ivl_index]=1.0;
  }

 /* solve the linear system Rmat*PopN[id]=Rhs */

 for(ivl=0;ivl<NVL;ivl++)
  {
   for(ivu=0;ivu<NVL;ivu++)
     RmatTemp[ivl][ivu]=Rmat[ivl][ivu];
   RhsTemp[ivl]=Rhs[ivl];
  }

 ret=mat_LUDCMP(RmatTemp,&det,NVL,INDX);
 if (ret)
  {
   printf("SOLVE: doesn't make sense to go further... Bye.\n");
   exit(1);
  }

 mat_LUBKSB(RmatTemp,NVL,INDX,RhsTemp);
 mat_MPROVE(Rmat,RmatTemp,NVL,INDX,Rhs,RhsTemp);

 for(ivl=0;ivl<NVL;ivl++)
   PopVN[id][ivl]=RhsTemp[ivl];

 free(INDX);
 free(Rhs);
 free(RhsTemp);
 mat_FMEMFREE(RmatTemp,NVL);

#if RMAT_PRINT
 if (id==ND/2-1)
  {
   printf("Rmat printing finished, exiting...\n");
   exit(123);  
  }
#endif
 
 return 0;
}
