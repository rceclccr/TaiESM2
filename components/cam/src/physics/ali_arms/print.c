
#include <stdio.h>
#include <math.h>

#include <struct.h>
#include <constants.h>
#include <subroutines.h>

int print_PARAMETERINFO ( PARAMETERINFO *pars )
{
	printf ("NMOL         = %d\n",pars->NMOL);
	printf ("ND           = %d\n",pars->ND);
	printf ("NA           = %d\n",pars->NA);
	printf ("TETS         = %f [o]\n",pars->tets);
	printf ("NVL          = %d\n",pars->NVL);
	printf ("NCVT         = %d\n",pars->NCVT);
	printf ("NCVV         = %d\n",pars->NCVV);
	printf ("CONV         = %12.6f\n",pars->conv);
	printf ("ITERMAX      = %d\n",pars->itermax);
	printf ("ITER0        = %d\n",pars->iter0);
	printf ("KBACK        = %d\n",pars->kback);
	printf ("KDLAY        = %d\n",pars->kdlay);
	printf ("NACC         = %d\n",pars->nacc);

	printf ("PLANET       = %d\n",pars->planet);
	printf ("ALB          = %12.6f\n",pars->alb);
	printf ("VV_USE_LOWER = %d\n",pars->vv_use_lower);
	printf ("CO2_O_rate_constant= %12.3e [cm3/s]\n",pars->CO2_O_rate_constant);

	printf ("\nODF parameters:\n");
	printf ("NF1 (NF in core) = %i\n", pars->odf_NF1);
	printf ("NF2 (NF in wing) = %i\n", pars->odf_NF2);
	printf ("ODF_Xcore = %6.3e [cm-1]\n", pars->odf_xcore);
	printf ("ODF_Xmax = %6.3e [cm-1]\n", pars->odf_xmax);

 return 0;
}

int print_MOLECULE ( MOLECULE *mol ,int N)
{
	printf ("HITNUMBER  = %d\n",mol[N].hitnumber);
	printf ("ISO        = %d\n",mol[N].iso);
	printf ("SQAMASS    = %12.6f\n",mol[N].sqamass);
	printf ("ABUND      = %12.6f\n",mol[N].abund);
	printf ("NVL        = %d\n",mol[N].nvl);
	printf ("IVU_index  = %d\n",mol[N].ivu_index);
	printf ("IVL_index  = %d\n",mol[N].ivl_index);

 return 0;
}

int print_VIBLEVEL ( VIBLEVEL *v_level ,int N)
{
	printf ("MOLE      = %d\n",v_level[N].mole);
	printf ("ISO       = %d\n",v_level[N].iso);
	printf ("ENERGY    = %12.6f\n",v_level[N].energy);
	printf ("name      = %.5d\n",v_level[N].name);
	printf ("chemgroup = %d\n",v_level[N].chem_group);
	printf ("DMULTI    = %12.6e\n",v_level[N].chem_dmulti);
		
 return 0;
}

int print_ATMOSPHERE ( ATMOSPHERE *atmos,int ND)
{
 int id;
 printf("\nATMOSPHERE MODEL\n");
 printf("#  H km    Pressure     TE      H2O       CO2       O3\
        N2O       CO(lop)   CH4       O2        NO        NO2       HNO3\
      OH        N2        O         O1D       N         H         HO2\
       Conc      Dopfac    Cp\n");
 for (id=0;id<ND;id++)
   printf(
	         "%9.3f %9.3e %9.3f %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3e %9.3f\n",
	         atmos->altitude[id],
	         atmos->pressure[id],
	         atmos->temperature[id],
	         atmos->c_volume[MOL_H2O*ND  +id],
	         atmos->c_volume[MOL_CO2*ND  +id],
	         atmos->c_volume[MOL_O3*ND   +id],
	         atmos->c_volume[MOL_N2O*ND  +id],
	         atmos->c_volume[MOL_CO*ND   +id],
	         atmos->c_volume[MOL_CH4*ND  +id],
	         atmos->c_volume[MOL_O2*ND   +id],
	         atmos->c_volume[MOL_NO*ND   +id],
	         atmos->c_volume[MOL_NO2*ND  +id],
	         atmos->c_volume[MOL_HNO3*ND +id],
	         atmos->c_volume[MOL_OH*ND   +id],
	         atmos->c_volume[MOL_N2*ND   +id],
	         atmos->c_volume[MOL_O*ND    +id],
	         atmos->c_volume[MOL_O1D*ND  +id],
	         atmos->c_volume[MOL_N*ND    +id],
	         atmos->c_volume[MOL_H*ND    +id],
	         atmos->c_volume[MOL_HO2*ND  +id],
	         atmos->concentration[id],
	         12345678.9,			/* I removed dopfac in this version */
	         atmos->Cp[id]
	         );
 return 0;
}

int print_QROT ( double **Qrot, int id, PARAMETERINFO *pars)
{
 int NVL,ND;
 int ivl;

 	ND=pars->ND;
 	NVL=pars->NVL;

	printf("QROT:ID=%d\n",id); 	
 	for (ivl=0;ivl<NVL;ivl++)
	{
	 printf("%12.6f\n",Qrot[id][ivl]);
	}

 return 0;
}

int print_CVV ( BAND_CVV	*cvv_band,
	        MOLECULE	*mol,
	        VIBLEVEL	*v_level,
	        PARAMETERINFO	*pars)
{
 int	NCVV;
 int	icvv;
#ifdef DUMP_CO2
 int	iMol1, iMol2;
#endif
 
 	NCVV=pars->NCVV;

 	for (icvv=0;icvv<NCVV;icvv++)
	{
#ifdef DUMP_CO2
	 iMol1=cvv_band[icvv].mole1;
	 iMol2=cvv_band[icvv].mole2;
	 if (mol[iMol1].hitnumber == MOL_CO2 && mol[iMol2].hitnumber == MOL_CO2 )
	  printf("%3d %5.5d + %3d %5.5d -> %3d %5.5d + %3d %5.5d %2d %12.6e\n",
	         mol[cvv_band[icvv].mole1].iso,
	         v_level[cvv_band[icvv].ivu_index1].name,
	         mol[cvv_band[icvv].mole2].iso,
	         v_level[cvv_band[icvv].ivl_index2].name,
	         mol[cvv_band[icvv].mole1].iso,
	         v_level[cvv_band[icvv].ivl_index1].name,
	         mol[cvv_band[icvv].mole2].iso,
	         v_level[cvv_band[icvv].ivu_index2].name,
	         cvv_band[icvv].group,
	         cvv_band[icvv].alt_indep
	         );
#else
	 printf("icvv=%4.4d: M1=%3d M2=%3d U1=%5.5d L1=%5.5d U2=%5.5d L2=%5.5d GR=%2d INDEP=%12.6e Delta1=%12.6f Delta2=%12.6f DeltaE=%12.6f\n",
	         icvv,
	         mol[cvv_band[icvv].mole1].iso,
	         mol[cvv_band[icvv].mole2].iso,
	         v_level[cvv_band[icvv].ivu_index1].name,
	         v_level[cvv_band[icvv].ivl_index1].name,
	         v_level[cvv_band[icvv].ivu_index2].name,
	         v_level[cvv_band[icvv].ivl_index2].name,
	         cvv_band[icvv].group,
	         cvv_band[icvv].alt_indep,
	         (v_level[cvv_band[icvv].ivu_index1].energy-
	          v_level[cvv_band[icvv].ivl_index1].energy),
	         (v_level[cvv_band[icvv].ivu_index2].energy-
	          v_level[cvv_band[icvv].ivl_index2].energy),
	         (v_level[cvv_band[icvv].ivu_index1].energy-
	          v_level[cvv_band[icvv].ivl_index1].energy)-
	         (v_level[cvv_band[icvv].ivu_index2].energy-
	          v_level[cvv_band[icvv].ivl_index2].energy)
	         );
#endif
	}

 return 0;
}

int print_RMAT( double **Rmat,int NL)
{
 int iu,il;
	
	for (iu=0;iu<NL;iu++)
	{
	 for (il=0;il<NL;il++)
	 {
	  printf(" %8.1e",Rmat[iu][il]);
	 }
	 printf("\n");
	}
	
 return 0;
}

int print_RMAT_RHS( double **Rmat, double *Rhs,int NL)
{
 int iu,il;
	
	for (iu=0;iu<NL;iu++)
	{
	 for (il=0;il<NL;il++)
	 {
	  printf(" %8.1e",Rmat[iu][il]);
	 }
	 printf(" : %8.1e",Rhs[iu]);
	 printf("\n");
	}

 return 0;
}

int print_RMAT_RHS_long( double **Rmat, double *Rhs,int NL)
{
 int iu,il;
	
	for (iu=0;iu<NL;iu++)
	{
	 for (il=0;il<NL;il++)
	 {
	  printf(" %24.15e",Rmat[iu][il]);
	 }
	 printf(" : %24.15e",Rhs[iu]);
	 printf("\n");
	}

 return 0;
}

int print_POP( 
		double		**PopV, 
		PARAMETERINFO	*pars)
{
 int ND,NVL;
 int ivl,id;

	printf ("\nPOP\n");
	ND=pars->ND;
	NVL=pars->NVL;
	for (id=0;id<ND;id++)
	{
	 for (ivl=0;ivl<NVL;ivl++)
	 {
	  printf(" %14.6e",PopV[id][ivl]);
	 }
	 printf("\n");
	}

 return 0;
}


int print_TVIB_plus( 
		double		**PopV,
		double		**Qrot,
		VIBLEVEL	*v_level,
		MOLECULE	*molecule,
		ATMOSPHERE	*atmos,
		PARAMETERINFO	*pars)
{
 int ND,NMOL,NVL;
 int il,iu,id,iMol,ivu,ivl;

	ND=pars->ND;
	NVL=pars->NVL;
	NMOL=pars->NMOL;
	NVL=pars->NVL;
	
	printf ("\n#TVIB\n");
#if 1
	 printf("#       ");
	 iu=2;
         for(iMol=0;iMol<NMOL;iMol++)
         {
          ivu=molecule[iMol].ivu_index;
          ivl=molecule[iMol].ivl_index;
          for(il=ivl+1;il<=ivu;il++)
	  {
	   printf(" %8d",iu);
	   iu++;
	  }
	 }
	 printf("       ");
	 printf("\n");

	 printf("#       ");
         for(iMol=0;iMol<NMOL;iMol++)
         {
          ivu=molecule[iMol].ivu_index;
          ivl=molecule[iMol].ivl_index;
          for(il=ivl+1;il<=ivu;il++)
	  {
	   printf(" %8.3d",
	          v_level[il].iso
	         );
	  }
	 }
	 printf("       ");
	 printf("\n");

	 printf("# Alt   ");
         for(iMol=0;iMol<NMOL;iMol++)
         {
          ivu=molecule[iMol].ivu_index;
          ivl=molecule[iMol].ivl_index;
          for(il=ivl+1;il<=ivu;il++)
	  {
	   printf(" %8.5d",
	          v_level[il].name
	         );
	  }
	 }
	 printf("      Tkin");
	 printf("\n");
#else
	printf ("#");
        for(ivl=0;ivl<NVL;ivl++)
        {
	   printf(" %8.3d",
                   v_level[ivl].iso);
        }
	printf ("\n");

	printf ("#");
        for(ivl=0;ivl<NVL;ivl++)
        {
	   printf(" %8.5d",
                   v_level[ivl].name);
        }
	printf ("\n");
#endif

	for (id=0;id<ND;id++)
	{
	 printf("% 8.3f",atmos->altitude[id]);
         for(iMol=0;iMol<NMOL;iMol++)
         {
          ivu=molecule[iMol].ivu_index;
          ivl=molecule[iMol].ivl_index;
          for(il=ivl+1;il<=ivu;il++)
	  {
	   printf(" %8.5f",
	    v_level[il].energy*CHK/
	     log(PopV[id][ivl]*Qrot[id][il]/
	         PopV[id][il]/Qrot[id][ivl])
	         );
	  }
	 }
	 printf(" %8.3f",atmos->temperature[id]);
	 printf("\n");
	} 

 return 0;
}

int print_FMAT( double **A,int NR,int NL)
{
 int iu,il;
	
	for (il=0;il<NL;il++)
	{
	 for (iu=0;iu<NR;iu++)
	 {
	  printf("%13.6e ",A[iu][il]);
	 }
	 printf("\n");
	}

 return 0;
}
