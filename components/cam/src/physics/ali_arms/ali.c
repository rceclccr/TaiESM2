#include <quant_macros.h>
#include <stdio.h>
#include <stdlib.h>

#include <struct.h>
#include <constants.h>
#include <subroutines.h>
#include <functions.h>
#include <mv_utils.h>

#include <sys/stat.h>
#include <unistd.h>
#include <string.h>

int ali_(	float	*H,
		float 	*P,
		float 	*T,
		float 	*CO2,
		float 	*O,
		float	*N2,
		float	*O2,
		float 	*CH_SUM,
		int 	*N)
{
 PARAMETERINFO 	*pars;
 PARAMETERINFO	parsdata;
 DEBYE_INFO	*deb;

 MOLECULE	*mol;
 VIBLEVEL	*v_level;

 BAND_CVT	*cvt_band;
 PBAND		pcvt_band;

 BAND_CVV	*cvv_band;

 ATMOSPHERE	atmos;
 INTEGR_ODF 	integr_ODF;

 BAND_ODF	*band_odf;

 LINE_ODF	*line_odf;

 double		**PopV, **PopVN, **DeltaV, **Qrot;
 double		**Rmat, **RmatBig;
 double		***PopStack, ***PopStackDelta;

 double		time;

 double		t0,t1,t2,t3,t4,t5;

 double		maxDelta,maxDeltaPrev;

 int		NMOL,ND,NVL,NCVT,NCVV,N15MKM;
 int		id,ik,iter;
 int		KBACK,KBACK1;

 PopV=NULL;PopVN=NULL;DeltaV=NULL;Qrot=NULL;
 Rmat=NULL;RmatBig=NULL;PopStack=NULL;PopStackDelta=NULL;

 pars=NULL;deb=NULL;mol=NULL;v_level=NULL;
 cvt_band=NULL;cvv_band=NULL;


 pars=&parsdata;
 memset(pars,0,sizeof(parsdata));

 init_parameters(pars);

#ifdef PRINT
 printf("\nThe program starts with the following parameters:\n");
 print_PARAMETERINFO(pars);
#endif

 mol=init_molecule_data(mol,pars);
 NMOL=pars->NMOL;

 /* atmospheric data initialization */

 ND=N[0]+1;
 pars->ND=ND;
 pars->tets=100.0;

 fill_atmosphere_model(&atmos,pars,mol,H,P,T,CO2,O,N2,O2);
 fill_atmos(&atmos);

#ifdef PRINT
 print_PARAMETERINFO(pars);
 print_ATMOSPHERE(&atmos,ND);
#endif

 v_level=init_vl_data(mol,v_level,pars);
 NVL=pars->NVL;

#ifdef PRINT
 printf("\nNVL=%d\n",NVL);
#endif

 PopV  	=mat_FMEMALLOC(ND,NVL);
 PopVN 	=mat_FMEMALLOC(ND,NVL);
 DeltaV	=mat_FMEMALLOC(ND,NVL);
 Qrot	=mat_FMEMALLOC(ND,NVL);

 compute_qrot(Qrot,v_level,&atmos,pars);

 integr_ODF.NA = pars->NA;
 integr_ODF.NF=pars->odf_NF1+pars->odf_NF2;

 init_ODF_freq(&integr_ODF,pars);

 band_odf= (BAND_ODF*) calloc(1,sizeof(BAND_ODF));

 band_odf->integr_odf=&integr_ODF;
 band_odf->line_odf= (LINE_ODF*) calloc (1000,sizeof(LINE_ODF));
 /* excessive memory allocation. One can reduce it and make dynamical as init_odf
 returns the actual size of the line_odf array */

 band_odf->ODF_PROFILE=mat_FMEMALLOC(ND,integr_ODF.NF);

 band_odf->odf_num=init_odf(Qrot,&atmos,v_level,mol,pars,band_odf);
 line_odf=band_odf->line_odf;

 band_odf->rate_Up=mat_FMEMALLOC(ND,band_odf->odf_num);
 band_odf->rate_Do=mat_FMEMALLOC(ND,band_odf->odf_num);

 deb=NULL;
 deb=init_DEBYE(deb,pars,mol);
 N15MKM=pars->N15MKM;
#ifdef PRINT
 printf ("\nN15MKM=%d\n",N15MKM);
#endif
 KBACK=pars->kback;
 KBACK1=KBACK+1;

 PopStack=(double ***) calloc(KBACK1,sizeof(double **));
 CHECK_PTR(PopStack);

 for(ik=0;ik<KBACK1;ik++)
   PopStack[ik]=mat_FMEMALLOC(ND,NVL);

 PopStackDelta=(double ***) calloc(KBACK1,sizeof(double **));
 CHECK_PTR(PopStackDelta);

 for(ik=0;ik<KBACK1;ik++)
   PopStackDelta[ik]=mat_FMEMALLOC(ND,NVL);

 cvv_band=NULL;
 cvv_band=fill_CVV(mol,v_level,cvv_band,deb,pars);
 NCVV=pars->NCVV;

#ifdef PRINT
 printf("\nNCVV=%d\n",NCVV);
#endif

 maxDeltaPrev=1e10;

 Rmat=mat_FMEMALLOC(NVL,NVL);

 pcvt_band.type=TYPE_CVT;

 cvt_band=compute_static_coll_coeff(mol,v_level,&pcvt_band,&atmos,Qrot,deb,pars);

 NCVT=pcvt_band.NUM;

#ifdef PRINT
 printf("\nNCVT=%d\n",NCVT);
#endif

 popul2(PopV,DeltaV,Qrot,mol,v_level,&atmos,pars); /* initial populations - LTE or read */

 /* main iteration cycle */

 if (pars->itermax == 0)
  {
   PopVN=PopV;
   goto out;
  }  /* LTE */

 for (iter=0;iter<pars->itermax;iter++)
  {
   transfer_odf(PopV,Qrot,&atmos,v_level,mol,pars,band_odf);

   for (id=0;id<ND;id++)
    {
     clear_Rmat(Rmat,NVL);

     if (NCVV)
     compute_dynamic_coll_coeff(cvv_band,v_level,&atmos,mol,PopV,
	        	        DeltaV,Qrot,pars,Rmat,id);

     compute_populations(band_odf,&pcvt_band,
	  		 Rmat,mol,v_level,PopVN,&atmos,pars,id);
    }
   maxDelta=check_conv(PopV,PopVN,DeltaV,pars);

   if (!maxDelta) goto out;
   if ((pars->nacc)&&(maxDelta<maxDeltaPrev))
     do_ng_acceleration(iter,mol,PopV,PopVN,PopStack,PopStackDelta,pars);

   maxDeltaPrev=maxDelta;
   update_pops(PopV,PopVN,pars);
  }

out:
 update_pops(PopV,PopVN,pars);

#ifdef PRINT
print_POP(PopVN,pars);
print_TVIB_plus(PopVN,Qrot,v_level,mol,&atmos,pars);
#endif

 if (pars->itermax)
  {
   ch_vib_rates (band_odf,mol,v_level,PopVN,&atmos,pars,CH_SUM);
  }

 /* Memory deallocation */
 mat_FMEMFREE(PopV,ND);
 mat_FMEMFREE(PopVN,ND);
 mat_FMEMFREE(DeltaV,ND);
 mat_FMEMFREE(Qrot,ND);
 mat_FMEMFREE(Rmat,NVL);

 free_ODF_freq(&integr_ODF);
 free_band_odf(band_odf,ND);
 free_atmos(&atmos,ND);

 free(deb);
 free(cvv_band);
 free(cvt_band);
 free(mol);
 free(v_level);

 for(ik=0;ik<KBACK1;ik++)
   mat_FMEMFREE(PopStack[ik],ND);
 free(PopStack);

 for(ik=0;ik<KBACK1;ik++)
   mat_FMEMFREE(PopStackDelta[ik],ND);
 free(PopStackDelta);

 mat_FMEMFREE(pcvt_band.rate_Up,ND);
 mat_FMEMFREE(pcvt_band.rate_Do,ND);


 return 0;
}


