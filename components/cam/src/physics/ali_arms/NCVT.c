#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <struct.h>
#include <quant_macros.h>
#include <constants.h>
#include <subroutines.h>
#include <mv_utils.h>

#include <sys/stat.h>
#include <unistd.h>

extern const char *data_root;

#define SORT_ON_E if ( EU > EL ) \
  	      	  { \
  	      	   cvt_band= (BAND_CVT *) realloc(cvt_band,(icvt+1)*sizeof(BAND_CVT)); \
  	      	   CHECK_PTR(cvt_band); \
	       	   cvt_band[icvt].ivu_index=iu; \
	           cvt_band[icvt].ivl_index=il; \
	           cvt_band[icvt].mole=iMol; \
	          } \
	          else \
	          { \
	           printf ("AAAAAAAAAAA\n"); \
	           exit(1); \
	          }

BAND_CVT * compute_static_coll_coeff(
			MOLECULE	*mol,
			VIBLEVEL	*v_level,
			PBAND_CVT	*pcvt_band,
			ATMOSPHERE	*atmos,
			double		**Qrot,
			DEBYE_INFO	*deb,
			PARAMETERINFO	*pars)
{
 int iu,il,ivu,ivl,IVU,IVL,NMOL,iMol,id;
 int NCVT,STWT,ND,MOL;
 int icvt, jcvt;
 double EU,EL,EVU,EVL,ColDo, *TE,*sqrt_T;
 double P,TMP13,TMP23,TMP12,BALANCE;

 int		N15MKM;
 double		RPR21,RPR42;
 double		testdeb;

 double		**CColVTUp, **CColVTDo;
 BAND_CVT	*cvt_band;

	N15MKM	=pars->N15MKM;
	RPR21	=pars->RPR21;
	RPR42	=pars->RPR42;
	NMOL	=pars->NMOL;
	TE	=atmos->temperature;
	sqrt_T	=atmos->sqrt_T;
 
	icvt=0;
	cvt_band=NULL;

	for (iMol=0;iMol<NMOL;iMol++)
	{
	 IVU=mol[iMol].ivu_index;
	 IVL=mol[iMol].ivl_index;

	 switch(mol[iMol].hitnumber)
	 {

	  case MOL_H2O:
/*	  case MOL_CO2:*/
	  case MOL_O3:
	  case MOL_N2O:
	  case MOL_CO:
	  case MOL_NO:
	  case MOL_OH:
	  case MOL_N2:  
	  case MOL_O2:  
	  
	  if (IVU==IVL) break; /* excluding molecules with single level */ 
	  
/*
#include "cvt.ncvt"

*/		  
	  printf("NCVT.c: ??? This shouldn't happen in this version. Exiting.\n");
	  exit(0);
	  break;

	  case MOL_CO2:
	   if (pars->co2_rules)
	   {
	  /* CO2 V-T selection rules here */
#include "co2.rules.vt"
	   }
	   else
	   {
/*
#include "cvt.ncvt"

*/		  
	    printf("NCVT.c: ?? This shouldn't happen in this version. Exiting.\n");
	    exit(0);
	   }
	  break;

	  case MOL_O:
	  break;

	  default:
		 printf("\nNCVT: unknown molecule: %d\n Exiting...\n",
		        mol[iMol].hitnumber);
		 exit(1);
	 }
	}


	NCVT=icvt;
	pars->NCVT=NCVT;
	ND=pars->ND;
	CColVTDo=mat_FMEMALLOC(ND,NCVT);
	CColVTUp=mat_FMEMALLOC(ND,NCVT);
	
	pcvt_band->rate_Up=CColVTUp;
	pcvt_band->rate_Do=CColVTDo;
	pcvt_band->NUM=NCVT;

	/* check for doubles now. */

	for (icvt=0;icvt<NCVT-1;icvt++)
	 for (jcvt=icvt+1;jcvt<NCVT;jcvt++)
	  if(
	      ( cvt_band[icvt].ivu_index == cvt_band[jcvt].ivu_index ) &&
	      ( cvt_band[icvt].ivl_index == cvt_band[jcvt].ivl_index ) &&
	      ( cvt_band[icvt].group     == cvt_band[jcvt].group   ) &&
	      ( cvt_band[icvt].partner   == cvt_band[jcvt].partner )
	    )
	  {
	   printf("Found duplicated icvt=%d jcvt=%d entry. Bye...\n",
	           icvt,jcvt);
	   exit(1);
	  }


	for (id=0;id<ND;id++)
	 for (icvt=0;icvt<NCVT;icvt++)
	 {
	  iMol=cvt_band[icvt].mole;
	  MOL=mol[iMol].hitnumber;

	  ivu=cvt_band[icvt].ivu_index;
	  EVU=v_level[ivu].energy;

	  ivl=cvt_band[icvt].ivl_index;
	  EVL=v_level[ivl].energy;

	  BALANCE=Qrot[id][ivu]*exp(-(EVU-EVL)*CHK/TE[id])/
	          Qrot[id][ivl];
	  TMP13=exp(-log(TE[id])/3.0);
	  TMP23=TMP13*TMP13;
	  TMP12=sqrt_T[id];
	  ColDo=-1.0;

	  switch (cvt_band[icvt].group)
	  {
	   case H2O_GROUP_1:
	    switch (cvt_band[icvt].partner)
	    {
	     case MOL_N2:
	   	ColDo=
	   	      1.0e-11*TMP12;
	     break;
	     case MOL_O2:
	  	ColDo=
	  	      1.0e-11*TMP12;
	     break;
	     case MOL_O:
	  	ColDo=
	  	      1.0e-11*TMP12;
	     break;
	     default:
	  	 printf("\nUnknown partner #%d icvt=%d group H2O_1\n",
	  	 	cvt_band[icvt].partner,icvt);
	  	 exit(1);
	    }
	   break;
	   case H2O_GROUP_2:
	    switch (cvt_band[icvt].partner)
	    {
	     case MOL_N2:
	  	ColDo=
	  	      4.6e-13*sqrt_T[id]/sqrt(300.0);
	     break;
	     case MOL_O2:
	  	ColDo=
	  	      3.3e-13*sqrt_T[id]/sqrt(300.0);
	     break;
	     case MOL_O:
	  	ColDo=
	  	      3.0e-12;
	     break;
	     default:
	  	 printf("\nUnknown partner #%d icvt=%d group H2O_2\n",
	  	 	cvt_band[icvt].partner,icvt);
	  	 exit(1);
	    }
	   break;
	   case H2O_GROUP_3:
	    switch (cvt_band[icvt].partner)
	    { 
	     case MOL_N2:
	  	ColDo=
	  	      3.7e-13*TE[id]*exp(-51.3*TMP13);
	     break;
	     case MOL_O2:
	  	ColDo=
	  	      3.7e-13*TE[id]*exp(-51.3*TMP13);
	     break;
	     case MOL_O:
	  	ColDo=
	  	      3.0e-12;
	     break;
	     default:
	  	 printf("\nUnknown partner #%d icvt=%d group H2O_3\n",
	  	 	cvt_band[icvt].partner,icvt);
	  	 exit(1);
	    }
	   break;
	   case H2O_GROUP_4:
	    switch (cvt_band[icvt].partner)
	    {
	     case MOL_N2:
	     case MOL_O2:
	  	ColDo=
	  	      4.1e-14*sqrt_T[id]/sqrt(300.0);
	     break;
	     case MOL_O:
	  	ColDo=
	  	      1.0e-12*sqrt_T[id]/sqrt(300.0);
	     break;
	     default:
	  	 printf("\nUnknown partner #%d icvt=%d group H2O_4\n",
	  	 	cvt_band[icvt].partner,icvt);
	  	 exit(1);
	    }
	   break;
	   case H2O_GROUP_5:
	    switch (cvt_band[icvt].partner)
	    {
	     case MOL_N2:
	  	ColDo=
	  	      1.2e-11*sqrt_T[id];
	     break;
	     case MOL_O2:
	  	ColDo=
	  	      1.1e-11*sqrt_T[id];
	     break;
	     default:
	  	 printf("\nUnknown partner #%d icvt=%d group H2O_5\n",
	  	 	cvt_band[icvt].partner,icvt);
	  	 exit(1);
	    }
	   break;
	   case H2O_GROUP_6:
	    switch (cvt_band[icvt].partner)
	    {
	     case MOL_N2:
	  	ColDo=
	  		4.6e-13*sqrt_T[id]/sqrt(300.0);
	     break;
	     case MOL_O2:
	  	ColDo=
	  		3.3e-13*sqrt_T[id]/sqrt(300.0);
	     break;
	     case MOL_O:
	  	ColDo=
	  		3.0e-12*sqrt_T[id]/sqrt(300.0);
	     break;
	     default:
	  	 printf("\nUnknown partner #%d icvt=%d group H2O_6\n",
	  	 	cvt_band[icvt].partner,icvt);
	  	 exit(1);
	    }
	   break;
	   case CO2_GROUP_1:
	    P=-1.0;
	    switch (cvt_band[icvt].partner)
	    {
	     case MOL_N2:
	  	ColDo=
	  	      4.3e-16*exp(7.0e-3*TE[id]);
	        switch (cvt_band[icvt].alt_dep)
	        {
	         case 1:
	         	if ( TE[id] <= 190.0 )
	         	 P=0.0;
	         	if ( (190.0 < TE[id]) && (TE[id] <= 250.0) )
	         	 P=0.0; 
	         	if ( (250.0 < TE[id]) && (TE[id] <= 350.0) ) 
	         	 P=TE[id]/100-2.5; 
	         	if ( TE[id] > 350.0 ) 
	         	 P=1.0;
	         	break; 
	         case 2:
	         	if ( TE[id] <= 190.0 )
	         	 P=0.0;
	         	if ( (190.0 < TE[id]) && (TE[id] <= 250.0) )
	         	 P=TE[id]/60 - 19.0/6.0;
	         	if ( (250.0 < TE[id]) && (TE[id] <= 350.0) )
	         	 P=3.5 - TE[id]/100;
	         	if ( TE[id] > 350.0 )
	         	 P=0.0;
	         	break;
		 case 3:
	         	if ( TE[id] <= 190.0 )
	         	 P=1.0;
	         	if ( (190.0 < TE[id]) && (TE[id] <= 250.0) )
	         	 P=25.0/6.0 - TE[id]/60;
	         	if ( (250.0 < TE[id]) && (TE[id] <= 350.0) )
	         	 P=0.0;
	         	if ( TE[id] > 350.0 )
	         	 P=0.0;
	         	break;
		 default:
		 	printf ("\nNo such alt_dep=%d\n",
		 	         cvt_band[icvt].alt_dep);
		 	exit(1);
	        }
	        ColDo*=P;
	     break;
	     case MOL_O2:
	  	ColDo=
	  	      1.2e-15/2*
	  	       exp((2.2e-3+7.0e-6*TE[id])*TE[id]);
	     break;
	     case MOL_CO:
	  	ColDo=
	  	      1.7e-14*
	  	       exp((-448.3+53636/TE[id])/TE[id]);
	     break;
	     case MOL_O: /* crashing */
	  	ColDo=
	  	      2.0e-13*sqrt_T[id]/sqrt(300.0);
	        switch (cvt_band[icvt].alt_dep)
	        {
	         case 2:
	         	if ( TE[id] <= 190.0 )
	         	 P=0.1;
	         	if ( (190.0 < TE[id]) && (TE[id] <= 250.0) )
	         	 P=0.8/60*(TE[id]-190)+0.1;
	         	if ( TE[id] > 250.0 )
	         	 P=0.9;
	         	break;
	         case 3:
	         	if ( TE[id] <= 190.0 )
	         	 P=0.9;
	         	if ( (190.0 < TE[id]) && (TE[id] <= 250.0) )
	         	 P=0.8/60*(190-TE[id])+0.9;
	         	if ( TE[id] > 250.0 )
	         	 P=0.1;
	         	break;
		 default:
		 	printf ("\nNo such alt_dep=%d\n",
		 	         cvt_band[icvt].alt_dep);
		 	exit(1);
	        }
	        ColDo*=P;
	     break;
	     case MOL_CO2:
	  	ColDo=
	  	      7.3e-14*
	  	       exp((-850.3+86523/TE[id])/TE[id]);
	        switch (cvt_band[icvt].alt_dep)
	        {
	         case 2:
	         	P=0.18;
	         break;
	         case 3:
	         	P=0.82;
	         break; 
		 default:
		 	printf ("\nNo such alt_dep=%d\n",
		 	         cvt_band[icvt].alt_dep);
		 	exit(1);
	        }
	        ColDo*=P;
	     break;
	     default:
		 printf ("\nNo such partner=%d\n",
		 	   cvt_band[icvt].partner);
		 exit(1);
	    }
	   break;

	   case CO2_GROUP_2:
	  	switch(cvt_band[icvt].partner)
	  	{
	  	 case MOL_N2:
	  	 	ColDo=
	  	 	 (5.5e-17*sqrt_T[id]+6.7e-10*exp(-83.8*TMP13));
	  	 break;
	  	 case MOL_O2:
	  	 	ColDo=
	  	 	 1.0e-15*exp(23.37-230.9*TMP13+564.0*TMP23);
	  	 break;
	  	 case MOL_O:
	  	 	ColDo=
#if 0
	  	 	 3.0e-12*sqrt(TE[id]/300);
	  	 	/*1.5e-12*sqrt(TE[id]/300);*/
#else
		pars->CO2_O_rate_constant*sqrt_T[id]/sqrt(300.0);
#endif
	  	 break;
	  	 case MOL_CO:
	  	  if ( TE[id] < 175 )
	  	        ColDo=7.6e-16;
	  	  else
	  	 	ColDo=
	  	 	 2.1e-12*exp((-2659+223052/TE[id])/TE[id]);
	  	 break;
	  	 case MOL_CO2:
	  	  if ( TE[id] < 175 )
	  	        ColDo=3.3e-15;
	  	  else
	  	 	ColDo=
	  	 	 4.2e-12*exp((-2988+303930/TE[id])/TE[id]);
	  	 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
	  	}
	   break;
	   case CO2_GROUP_3:
	  	 	ColDo=
	  	 	 1.15e-14*sqrt_T[id];
	   break;
	   case CO2_GROUP_4:
	  	switch(cvt_band[icvt].partner)
	  	{
	  	 case MOL_N2:
	  	 case MOL_O2:
	  	 case MOL_O:
	  	 case MOL_CO:
	  	 	ColDo=
	  	 	 5.76e-13*exp(-1.312e-2*(EVU-EVL));
	  	 break;
	  	 case MOL_CO2:
	  	 	ColDo=
	  	 	 5.76e-12*exp(-1.312e-2*(EVU-EVL));
	  	 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
	  	}
	   break;

	   case O3_GROUP_1:
	  	switch(cvt_band[icvt].partner)
	  	{
	  	 case MOL_O2:
	  	      ColDo=
	  	            0.96e-11*pow(300.0/TE[id],0.7);
                 break;
                 case MOL_N2:
	  	      ColDo=
	  	            1.18e-11*pow(300.0/TE[id],0.8);
                 break;
                 case MOL_O:
	  	      ColDo=
	  	            1.0;
                 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d group=O3_1\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
                }
	   break;
	   case O3_GROUP_2:
	  	switch(cvt_band[icvt].partner)
	  	{
	  	 case MOL_O2:
	  	      ColDo=
	  	            1.2e-13*sqrt_T[id]*exp(-26.8/pow(TE[id],1./3));
                 break;
                 case MOL_N2:
	  	      ColDo=
	  	            0.5e-13*sqrt_T[id]*exp(-22.8/pow(TE[id],1./3));
                 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d group=O3_2\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
                }
	   break;
	   case O3_GROUP_3:
	  	switch(cvt_band[icvt].partner)
	  	{
	  	 case MOL_O2:
	  	      ColDo=
	  	            7.0e-13*sqrt_T[id]*exp(-40.0/pow(TE[id],1./3));
                 break;
                 case MOL_N2:
	  	      ColDo=
	  	            5.9e-12*sqrt_T[id]*exp(-53.8/pow(TE[id],1./3));
                 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d group=O3_3\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
                }
	   break;

	   case O3_GROUP_4:
	  	ColDo=1.0;
	   break;

	   case O3_GROUP_5:
	  	ColDo=1.0;
	   break;

	   case O3_GROUP_6:
	  	switch(cvt_band[icvt].partner)
	  	{
                 case MOL_O:
	  	      ColDo=
	  	            1.0e-10;
                 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d group=O3_6\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
                }
	   break;

	   case O3_GROUP_7:
	  	switch(cvt_band[icvt].partner)
	  	{
                 case MOL_O:
	  	      ColDo=
	  	            1./2.*1.05e-11;
                 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d group=O3_7\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
                }
	   break;

	   case O3_GROUP_8:
	  	switch(cvt_band[icvt].partner)
	  	{
                 case MOL_O:
	  	      ColDo=
	  	            0.7/3./2.*5./7.*EVU*1.0e-14;
                 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d group=O3_8\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
                }
	   break;

	   case O3_GROUP_9:
	  	switch(cvt_band[icvt].partner)
	  	{
                 case MOL_N2:
	  	      ColDo=
	  	            1.0e-9; /* is it big enough ? */
                 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d group=O3_9\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
                }
	   break;

	   case O3_GROUP_10:
	  	ColDo=1.0;
	   break;

	   case O3_GROUP_11:
	  	ColDo=
	  	      6.10e-13*sqrt_T[id]*
	  	       exp(-0.58*pow(EVU-EVL,2.0/3.0)*pow(TE[id],-1.0/3.0));
	   break;

/* These constants are in atm-1 */
	   case N2O_GROUP_0: /* big constant for N2O */
	  	ColDo=
	  	      BOLTZK*TE[id]/HPSC;
	   break;

	   case N2O_GROUP_1:
	   case N2O_GROUP_2:
	  	ColDo=
	  	      BOLTZK*TE[id]/HPSC;
	   break;

	   case N2O_GROUP_3:
	  	ColDo=
	  	      BOLTZK*TE[id]/HPSC;
	   break;
 
	   case CO_GROUP_1:
	  	ColDo=
	  	      11.2e-14*TE[id]*exp(-44.3*TMP13);
	   break;

	   case O2_GROUP_1:
	  	switch(cvt_band[icvt].partner)
	  	{
	  	 case MOL_N2:
	  	 	ColDo=
			      1.364e-12*TE[id]*exp(-137.93*TMP13);
	  	 break;
	  	 case MOL_O2:
	  	 	ColDo=
			      1.364e-12*TE[id]*exp(-137.93*TMP13);
		 break;
                 case MOL_O:
	  	 	ColDo=
			     /*4.6e-15/(1.0/TE[id]+1.5e-7*exp(110.0*TMP13));*/
			      1.84e-11/(1.0/TE[id]+1.5e-7*exp(110.0*TMP13));
                 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d group O2_1\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
	  	}
	   break;

	   case O2_GROUP_2:
	  	/* old stuff */
	  	ColDo=0.0;
	   break;

	   case O2_GROUP_3:
	  	switch(cvt_band[icvt].partner)
	  	{
	  	 case MOL_N2:
	  	 	ColDo=
	  	 	      1.0;
	  	 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
	  	}
	   break;

	   case NO_GROUP_1:
	  	switch(cvt_band[icvt].partner)
	  	{
	  	 case MOL_N2:
	  		ColDo=
	  	              1.0e-5;
	  	 break;
	  	 case MOL_O2:
	  		ColDo=
	  	              1.0e-5;
	  	 break;
	  	 case MOL_O:
	  		ColDo=
	  	              6.5e-11;
	  	 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d group NO_1\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
	  	}
	   break;
	  
	   case N2_GROUP_1:
	  	ColDo=
	  	      2.45e-22*pow(TE[id],2.87);
	   break;
	  
	  
	   case N2_GROUP_2:
	  	/* old stuff */
	  	ColDo=0.0;
	   break;

	   case OH_GROUP_1:
	  	switch(cvt_band[icvt].partner)
	  	{
	  	 case MOL_N2:
	  	 	ColDo=
			      1.0e-14;
	  	 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d group OH_1\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
	  	}
	   break;

	   default:
	   printf("\nNCVT:Unknown group:%d MOL=%s:%5.5d %5.5d icvt=%d\n",
	          cvt_band[icvt].group,HitranName[MOL],ivu,ivl,icvt);
	   exit(1);
	  }
	 
	  if(ColDo < 0.0) 
	  {
	   printf("negative collisional constant, exiting...\n");
	   exit(1);
	  }
	 
	  if ( 
	      ( cvt_band[icvt].group != O2_GROUP_2 ) && /* OH for O2 */
	      ( cvt_band[icvt].group != N2_GROUP_2 ) && /* OH for N2 */
	      ( cvt_band[icvt].group != O3_GROUP_4 )    /* O  for O3 */
	     )
	  {
	   ColDo*=atmos->concentration[id]*
	    atmos->c_volume[cvt_band[icvt].partner*ND+id]*
	    cvt_band[icvt].alt_indep;
	   CColVTDo[id][icvt]=ColDo;
	   CColVTUp[id][icvt]=ColDo*BALANCE;
#if 0
if ((v_level[ivu].name==1101)&&(v_level[ivl].name==1))
	   printf("id= %3i ColDo= %6.4e\n",id,ColDo);
#endif	  
	  }
	  else
	  {
	   CColVTDo[id][icvt]=0.0;
	   CColVTUp[id][icvt]=0.0;
	   switch (cvt_band[icvt].group)
	   {
	    case O2_GROUP_2:
	  	 CColVTUp[id][icvt]=8.9e-8*0.75/8.6*
	  	         exp(-log(2.0)*
	  	             (atmos->altitude[id]-86.8)*
	  	             (atmos->altitude[id]-86.8)/
	  	             8.6/8.6
	  	            );
	  	if (pars->tets < 90.0 ) 
	  	 CColVTUp[id][icvt]/=10.0;
	    break;
	    case N2_GROUP_2:
	  	 CColVTUp[id][icvt]=2.9e-9*0.75/8.6*
	  	         exp(-log(2.0)*
	  	             (atmos->altitude[id]-86.8)*
	  	             (atmos->altitude[id]-86.8)/
	  	             8.6/8.6
	  	            );
	  	if (pars->tets < 90.0 ) 
	  	{
	  	 CColVTUp[id][icvt]/=10.0;
	  	 /* O1D */
	  	 CColVTUp[id][icvt]+=3.06e-11*exp(110.0/TE[id])*
	  	  atmos->c_volume[MOL_O1D*ND+id]*
	  	  atmos->concentration[id];
	  	}
	    break;

	    case O3_GROUP_4: /* O3 */
	  	switch(cvt_band[icvt].partner)
	  	{
	  	 case MOL_O:
	  	 	CColVTUp[id][icvt]=0.0;
	  	 	CColVTDo[id][icvt]=ColDo*
	    	 	 cvt_band[icvt].alt_indep*
	  	 	 atmos->c_volume[MOL_O*ND+id]*
	  	 	 atmos->concentration[id];
	  	 break;
	  	 case 0: /* Photolysis hack */
	  		if (pars->tets < 90.0 )
	  		{
	  	 	 CColVTUp[id][icvt]=0.0;
	  	 	 CColVTDo[id][icvt]=1.01e-2;
	  	 	}
	  	 break;
	  	 case MOL_OH:
	  	 	CColVTUp[id][icvt]=0.0;
	  	 	CColVTDo[id][icvt]=1.6e-12*exp(-940/TE[id])*
	    	 	 cvt_band[icvt].alt_indep*
	  	 	 atmos->c_volume[MOL_OH*ND+id]*
	  	 	 atmos->concentration[id];
	  	 break;
	  	 case MOL_HO2:
	  	 	CColVTUp[id][icvt]=0.0;
	  	 	CColVTDo[id][icvt]=1.1e-14*exp(-500/TE[id])*
	    	 	 cvt_band[icvt].alt_indep*
	  	 	 atmos->c_volume[MOL_HO2*ND+id]*
	  	 	 atmos->concentration[id];
	  	 break;
	  	 case MOL_H:
	  	 	CColVTUp[id][icvt]=0.0;
	  	 	CColVTDo[id][icvt]=1.4e-10*exp(-470/TE[id])*
	    	 	 cvt_band[icvt].alt_indep*
	  	 	 atmos->c_volume[MOL_H*ND+id]*
	  	 	 atmos->concentration[id];
	  	 break;
	  	 case MOL_NO:
	  	 	CColVTUp[id][icvt]=0.0;
	  	 	CColVTDo[id][icvt]=2.0e-12*exp(-1400/TE[id])*
	    	 	 cvt_band[icvt].alt_indep*
	  	 	 atmos->c_volume[MOL_NO*ND+id]*
	  	 	 atmos->concentration[id];
	  	 break;
	  	 case MOL_NO2:
	  	 	CColVTUp[id][icvt]=0.0;
	  	 	CColVTDo[id][icvt]=1.2e-13*exp(-2450/TE[id])*
	    	 	 cvt_band[icvt].alt_indep*
	  	 	 atmos->c_volume[MOL_NO2*ND+id]*
	  	 	 atmos->concentration[id];
	  	 break;
	  	 case MOL_O1D:
	  	 	CColVTUp[id][icvt]=0.0;
	  	 	CColVTDo[id][icvt]=1.2e-10*
	    	 	 cvt_band[icvt].alt_indep*
	  	 	 atmos->c_volume[MOL_O1D*ND+id]*
	  	 	 atmos->concentration[id];
	  	 break;
	  	 default:
	  	 	printf("\nUnknown partner #%d icvt=%d group O3_4\n",
	  	 		cvt_band[icvt].partner,icvt);
	  	 	exit(1);
	  	}
	    break;
	    default:
	  	printf("Unknown one-directional transition group:%d\n",
	  	       cvt_band[icvt].group);
	  	exit(1);
	   }
	 }	 
#if 0
/*	 if (id == ND-1) */
	 if (id == ND/2) 
	 {
	  printf ("NCVT:MOL=%2d icvt=%5.5d %12.6e %12.6e IVU=%5.5d IVL=%5.5d EVU=%10.4f EVL=%10.4f\n",
	           MOL,icvt,ColDo,ColDo*BALANCE,v_level[ivu].name,v_level[ivl].name,EVU,EVL);
	 }
#endif
	}
	pcvt_band->band=cvt_band;

 return cvt_band;
} 
