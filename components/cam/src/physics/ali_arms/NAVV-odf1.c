#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <struct.h>
#include <functions.h>
#include <constants.h>
#include <subroutines.h>
#include <mv_utils.h>
 

int	transfer_odf(
		double			**PopV,
		double			**Qrot,
		ATMOSPHERE		*atmos,
		VIBLEVEL		*v_level,
		MOLECULE		*mol,
		PARAMETERINFO		*pars,
		BAND_ODF		*band_odf
		 )

{
 register double W;

 LINE_ODF	*line_odf;
 
 double	        *Hkm, *TE , *MU, *MW;
 double		**COptVVUp, **COptVVDo, **ODF_PROFILE;
 double		*JM, *JBAR;
 double		*OPACL, *OPACM;
 double		*EMISL,*X,*XW;
 double		*DTAUM, *DIAGM, *DTNORM, *SF, *DIAG;
 double		*dfe_pool, *prof;
 double		*WTS0,*WTS1,*CV;
 
 double		ALBD,ABUND,CONSTA,SQAMASS,Sec;
 double		f0_band,pprof;
 double		P_R_coeff;
 double		J_SF_DIAG,W_ODF_PROFILE,CONST_ABUND;
 double		time;
 
 int		IVL,IVU,laserflag;
 int		iMol,MOL;
 int		id,ND,ia,NA,ifr,NF;
 int		odf_num,odf_index,P_R_join;
 
 line_odf=band_odf->line_odf;
 odf_num=band_odf->odf_num;
 
 COptVVUp=band_odf->rate_Up;
 COptVVDo=band_odf->rate_Do;

 ODF_PROFILE=band_odf->ODF_PROFILE;
  
 NF	=band_odf->integr_odf->NF;
 X	=band_odf->integr_odf->x;
 XW	=band_odf->integr_odf->xw;
 MU	=band_odf->integr_odf->mu;
 MW	=band_odf->integr_odf->mw;

 ALBD	=pars->alb;
 
 TE	=atmos->temperature;
 Hkm	=atmos->altitude;
 CV	=atmos->c_volume;

 ND		=pars->ND;
 NA		=pars->NA;
 P_R_join	=pars->P_R_join;

 dfe_pool  	=vec_FMEMALLOC(ND*8);
 JM		=vec_FMEMALLOC(ND);
 JBAR		=vec_FMEMALLOC(ND);
 WTS0		=vec_FMEMALLOC(ND);
 WTS1		=vec_FMEMALLOC(ND);
  
 OPACL		=vec_FMEMALLOC(ND);
 OPACM		=vec_FMEMALLOC(ND);
 EMISL		=vec_FMEMALLOC(ND);
 DTAUM		=vec_FMEMALLOC(ND);
 DIAGM		=vec_FMEMALLOC(ND);
 DTNORM		=vec_FMEMALLOC(ND);
 SF		=vec_FMEMALLOC(ND);
 DIAG		=vec_FMEMALLOC(ND);
 prof		=vec_FMEMALLOC(ND);
 
 for (odf_index=0;odf_index<odf_num;odf_index++)
  {   
   if ((P_R_join)&&(line_odf[odf_index].type==SKIP_branch)) goto skip_line; /* continue */
      
   iMol 	=line_odf[odf_index].mole;
   MOL  	=mol[iMol].hitnumber;

   ABUND	=mol[iMol].abund;
   SQAMASS	=mol[iMol].sqamass;
   f0_band	=line_odf[odf_index].f0_band;
   
   CONSTA	=H_4_PI*f0_band;
   CONST_ABUND  =CONSTA*ABUND;
   /*  see constants.h:  H_4_PI=HPLANCK/4.0/PI */
   
   for(id=0;id<ND;id++)
     COptVVDo[id][odf_index]=0.0;
   
   for(id=0;id<ND;id++)
     COptVVUp[id][odf_index]=0.0;

   for(id=0;id<ND-1;id++)
    {     
     WTS0[id]=CONST_ABUND*atmos->WTS_suppl_0[id]*CV[MOL*ND+id+1];
     WTS1[id]=CONST_ABUND*atmos->WTS_suppl_1[id]*CV[MOL*ND+id  ];
     /*
     atmos->WTS_suppl_0[id]=(Hkm[id]-Hkm[id+1])/2.0*1.0e5*conc[id+1];   
     atmos->WTS_suppl_1[id]=(Hkm[id]-Hkm[id+1])/2.0*1.0e5*conc[id  ];
     */        	    
    }

   IVU=line_odf[odf_index].IVU;
   IVL=line_odf[odf_index].IVL;
   
   laserflag=0;
   for(id=0;id<ND;id++)
    {
     EMISL[id]=PopV[id][IVU]*line_odf[odf_index].A_band*line_odf[odf_index].SumWup; 
     OPACL[id]=(PopV[id][IVL]*line_odf[odf_index].BU_band-
                PopV[id][IVU]*line_odf[odf_index].BD_band)*line_odf[odf_index].SumWlo; 

/* if (id ==ND/2-1) printf("OPACL: %3i %14.6e %5i %5i\n",odf_index, OPACL[id], v_level[IVU].name, v_level[IVL].name);*/
     
     if (OPACL[id]<=0.0)
      {
	   printf("laser triggered: %3i %14.6e %14.6e %14.6e %14.6e %14.6e %14.6e \n", id, PopV[id][IVL], line_odf[odf_index].BU_band, line_odf[odf_index].SumWlo, 
               PopV[id][IVU], line_odf[odf_index].BD_band, line_odf[odf_index].SumWup);   
       laserflag=1;
      }
    }
    
   /* if (!line_odf[odf_index].FincD) */
     line_odf[odf_index].FincD=EMISL[ND-1]/OPACL[ND-1]*ALBD; 
   /* planckian radiation x surface albedo */
       
   if (laserflag) /* negative opacity */
    {
     for(id=0;id<ND;id++)
      {
       COptVVDo[id][odf_index]+=line_odf[odf_index].A_band;
      }
    }
   else /* positive opacity */
    {
     for(id=0;id<ND;id++)
      {
       SF[id]=EMISL[id]/OPACL[id];
       DIAG[id]=0.0;
       JBAR[id]=0.0;
       if (id>ND) printf("koeff: %3i %3i %14.6e\n",odf_index, id, line_odf[odf_index].koeff[id]);
      }


     for(ifr=0;ifr<NF;ifr++)
      {
       for(id=0;id<ND;id++)
        {
	 pprof=ODF_PROFILE[id][ifr];

         /* prof[id]=line_odf[odf_index].koeff[id]*pprof;*/
         prof[id]=line_odf[odf_index].koeff_tmp*pprof;
	 
	 OPACM[id]=OPACL[id]*prof[id];  
	 	 
	 if (OPACM[id]==0.0) goto skip_point;        
	} /* id */

       for (id=0;id<ND-1;id++)
        {
         DTNORM[id]=WTS0[id]*OPACM[id+1]+
                    WTS1[id]*OPACM[id  ];
	}

       for(ia=0;ia<NA;ia++)
        {
	 Sec=1.0/MU[ia];	
         for (id=0;id<ND;id++)
          {
           DTAUM[id]=Sec*DTNORM[id];
	  }
	  	 
	 dfe(DTAUM,SF,JM,DIAGM,line_odf[odf_index].FincD,ND,dfe_pool); 
	 
	 W=MW[ia]*XW[ifr];
         
	 for(id=0;id<ND;id++)
          {
	   W_ODF_PROFILE=W*ODF_PROFILE[id][ifr];   
           JBAR[id]+=W_ODF_PROFILE*JM[id];	

           DIAG[id]+=W_ODF_PROFILE*DIAGM[id];
	  }
        } /* ia */
skip_point:      
      continue;
      } /* ifr */
      
     for(id=0;id<ND;id++)
      {
       JBAR[id]*=2.0;	/* 2.0 comes from the half of the line */
       DIAG[id]*=2.0;

       if (id>ND) printf("wtf %3i %14.6e\n",odf_index, JBAR[id]);
       
       if ((P_R_join)&&(line_odf[odf_index].type==DOUBLE_branch))       
        {
	     P_R_coeff=2.0;	/* P + R lines */
	    }
       else
	    {
	     P_R_coeff=1.0;	/* separate lines */	
	    } 	
              
       J_SF_DIAG=JBAR[id]-SF[id]*DIAG[id];	/* acceleration */
       
#if 1
       COptVVDo[id][odf_index]+=
         P_R_coeff*(
	 (line_odf[odf_index].A_band*(1.0-DIAG[id])+
          line_odf[odf_index].BD_band*J_SF_DIAG)   )*line_odf[odf_index].SumWup;

       COptVVUp[id][odf_index]+=
	 P_R_coeff*(line_odf[odf_index].BU_band*J_SF_DIAG)*line_odf[odf_index].SumWlo;

#else
       COptVVDo[id][odf_index]+=
	 P_R_coeff*((line_odf[odf_index].A_band+
          line_odf[odf_index].BD_band*JBAR[id])*
	  line_odf[odf_index].SumWup);

       COptVVUp[id][odf_index]+=
	 P_R_coeff*(line_odf[odf_index].BU_band*JBAR[id]);
#endif
       } /* id */
    } /* positive opacity */
skip_line:  
  continue;
  }  /* odf_index */


  
#if 0
for(odf_index=0;odf_index<odf_num;odf_index++)  
printf("odf_i= %3i, BU_band= %6.4e Up= %6.4e Do= %6.4e\n",
odf_index,line_odf[odf_index].BU_band,
COptVVUp[ND/2][odf_index],COptVVDo[ND/2][odf_index]);  
exit(0);  

for(odf_index=0;odf_index<odf_num;odf_index++)  
for(id=0;id<ND;id++)
printf("id= %3i odf_i= %3i, BU_band= %6.4e Up= %6.4e Do= %6.4e\n",
id,odf_index,line_odf[odf_index].BU_band,
COptVVUp[id][odf_index],COptVVDo[id][odf_index]);  
exit(0);  
#endif
  


 free(WTS0);
 free(WTS1);
 free(dfe_pool);
 free(JM);
 free(JBAR);
 free(OPACL);
 free(OPACM);
 free(EMISL);

 free(DTAUM);
 free(DIAGM);
 free(DTNORM);
 free(SF);
 free(DIAG);
 free(prof);

 return 0;
}

