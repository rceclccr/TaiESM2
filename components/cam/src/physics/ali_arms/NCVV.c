
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <struct.h>
#include <constants.h>
#include <subroutines.h>

int	compute_dynamic_coll_coeff(
			BAND_CVV 	*cvv_band,
			VIBLEVEL	*v_level,
			ATMOSPHERE	*atmos,
			MOLECULE	*mol,
			double 		**PopV,
			double 		**DeltaV,
			double 		**Qrot,
			PARAMETERINFO	*pars,
			double		**Rmat,
			int		id)

{
 int	icvv,icU1,icL1,icU2,icL2,iMol1,iMol2,MOL1,MOL2;
 int	NCVV,ND;
 double	EU1,EL1,EU2,EL2;
 double	e_log_T_3;
 double *TE,*sqrt_T;
 double DeltaE,BALANCE,ColUp,ColDo,CVColl;
 int CO2_special_case_invertVV; /* the nu2 quanta exchange was programmed in reverse way */


	NCVV	=pars->NCVV;
	TE	=atmos->temperature;
	sqrt_T	=atmos->sqrt_T;
	ND	=pars->ND;

	e_log_T_3	=exp(-log(TE[id])/3.0);

	for(icvv=0;icvv<NCVV;icvv++)
	{
         CO2_special_case_invertVV=0; 		
         icU1   = cvv_band[icvv].ivu_index1;
         icL1   = cvv_band[icvv].ivl_index1;
         icU2   = cvv_band[icvv].ivu_index2;
         icL2   = cvv_band[icvv].ivl_index2;

         iMol1  = cvv_band[icvv].mole1;
         iMol2  = cvv_band[icvv].mole2;
         MOL1=mol[iMol1].hitnumber;
         MOL2=mol[iMol2].hitnumber;
	 EU1=v_level[icU1].energy;
	 EL1=v_level[icL1].energy;
	 EU2=v_level[icU2].energy;
	 EL2=v_level[icL2].energy;
         DeltaE = (EU1-EL1)-(EU2-EL2);

	 switch(cvv_band[icvv].group)
	 {
	  case H2O_VV_GROUP_4:
	  	CVColl=
	  		2.92e-16*TE[id]*exp(19.9*e_log_T_3);
	  break;
	  case H2O_VV_GROUP_5:
	  	CVColl=
	  		3.39e-15*TE[id]*exp(-27.0*e_log_T_3);
	  break;
	  case 2: /* CO2 + N2 */
		CVColl=
	  	        8.91e-12/sqrt_T[id];
	  break;

	  case 9: /* CO2 + CO2 v3 */
                 if(DeltaE < 42.0 )
                  CVColl=
                   6.8e-12*sqrt(TE[id]);
                 else
                  CVColl=
                   3.6e-11*sqrt(TE[id])*exp(-DeltaE/26.3);
	  break;

	  case 10:
	  	 CVColl=
	  	        4.7e-11*exp(-0.024*DeltaE); /* easier to debug */
		 /* 4.7!!!! */
		 CO2_special_case_invertVV=1;       
	  break;
	  case 761: /* N2 + O2 uff.*/
	  	 CVColl=
	  	 	4.43e-17*TE[id]*exp(-49.32*exp(-log(TE[id])/3.0));
	  break;

	  case CO_VV_GROUP_1: /* CO + N2 */
	  	 CVColl=
	  		3.42e-10/sqrt_T[id]*exp(-54.7*e_log_T_3);
	  break;

	  case 10006: /* CO2 + CO */
	  	 CVColl=
	  		1.6e-12*exp(-1169/TE[id]+77601/TE[id]/TE[id]);
	  break;

	  case CO2_VV_1: /* CO2 + O2 */
	  	 CVColl=
	  	        5.7e-15*sqrt_T[id]*(2.2-1.3*exp(-315/TE[id]))*
	  	        exp(-56.7/sqrt_T[id]);
	  break;

	  case O3_VV_102:
	  	 CVColl=
	  		1.0e-11;
	  break;

	  case O3_VV_200:
	  	 CVColl=
	  		4.2e-13/sqrt_T[id];
	  break;
	  case O3_VV_001:
	  	 CVColl=
	  		1.6e-12/sqrt_T[id];
	  break;

	  case N2O_VV_GROUP_4:
	  	 CVColl=
	  	        BOLTZK*TE[id]/HPSC;
	  break;
	  case N2O_VV_GROUP_5:
	  	 CVColl=
	  	        BOLTZK*TE[id]/HPSC;
	  break;
	  case N2O_VV_GROUP_6:
	  	 CVColl=
	  	        BOLTZK*TE[id]/HPSC;
	  break;

	  case O2_VV_GROUP_1:
	  	 CVColl=
	  	        1.0;
	  break;

	  case NO_VV_GROUP_1:
	  	 CVColl=
	  	        2.0e-14;
	  break;

	  default:
	  	 printf("\nUnknown group #%d icvv=%d\n",
	  	 	cvv_band[icvv].group,icvv);
	  	 exit(1);
	 }

	 CVColl*=cvv_band[icvv].alt_indep;

/*	 CVColl=0.0;*/
/*
	 printf("icvv=%4.4d: M1=%2.2d M2=%2.2d U1=%2.2d L1=%2.2d U2=%2.2d L2=%2.2d GR=%d EU1=%lf EL1=%lf EU2=%lf EL2=%lf DE=%lf \n",
	         icvv,
	         iMol1,iMol2,
	         icU1,icL1,
	         icU2,icL2,
	         cvv_band[icvv].group,EU1,EL1,EU2,EL2,DeltaE
	         );
	  printf("CVColl=%12.6e\n",CVColl);

	 fflush(stdout);

*/
         BALANCE=exp(-DeltaE*CHK/TE[id])*
         Qrot[id][icU1]/Qrot[id][icL1]*
         Qrot[id][icL2]/Qrot[id][icU2];

         if (CO2_special_case_invertVV) BALANCE=1.0/BALANCE;




         if ( DeltaV[id][icL2] > DeltaV[id][icU1] )
         /*
         if ((EL2>EU1))
         */
          {

	  /* We consider icU1 known and icL2 unknown
	   * in pair icU1,icL2
	   */

          if (CO2_special_case_invertVV) 
            ColDo=CVColl*BALANCE*atmos->concentration[id]*mol[iMol1].abund*
                  atmos->c_volume[MOL1*ND+id]*PopV[id][icU1];
          else
            ColDo=CVColl*atmos->concentration[id]*mol[iMol1].abund*
                  atmos->c_volume[MOL1*ND+id]*PopV[id][icU1];

          Rmat[icL1][icL2]+=ColDo;
          Rmat[icU1][icL2]-=ColDo;
/*        Rmat[icL2][icL2]-=ColDo;     */
          Rmat[icU2][icL2]+=ColDo;
         }
         else
         {
	  /* We consider icL2 known and icU1 unknown
	   * in pair icU1,icL2
	   */

          if (CO2_special_case_invertVV) 
            ColDo=CVColl*BALANCE*atmos->concentration[id]*mol[iMol2].abund*
                  atmos->c_volume[MOL2*ND+id]*PopV[id][icL2];
          else
            ColDo=CVColl*atmos->concentration[id]*mol[iMol2].abund*
                  atmos->c_volume[MOL2*ND+id]*PopV[id][icL2];
                  
           Rmat[icL1][icU1]+=ColDo;
/*         Rmat[icU1][icU1]-={2*}ColDo;     */
	   if (icU1 != icL2 )
           Rmat[icL2][icU1]-=ColDo;
           Rmat[icU2][icU1]+=ColDo;
         }

         if ( DeltaV[id][icL1] > DeltaV[id][icU2] )
         /*
         if ((EL1>EU2))
         */
          {
	  /* We consider icU2 known and icL1 unknown
	   * in pair icU2,icL1
	   */

          if (CO2_special_case_invertVV) 
            ColUp=CVColl*atmos->concentration[id]*mol[iMol2].abund*
                  atmos->c_volume[MOL2*ND+id]*PopV[id][icU2];
          else
            ColUp=CVColl*BALANCE*atmos->concentration[id]*mol[iMol2].abund*
                  atmos->c_volume[MOL2*ND+id]*PopV[id][icU2];

/*        Rmat[icL1][icL1]-=ColUp;     */
          Rmat[icU1][icL1]+=ColUp;
          Rmat[icL2][icL1]+=ColUp;
          Rmat[icU2][icL1]-=ColUp;
         }
         else
         {
	  /* We consider icL1 known and icU2 unknown
	   * in pair icU2,icL1
	   */

          if (CO2_special_case_invertVV) 
            ColUp=CVColl*atmos->concentration[id]*mol[iMol1].abund*
                  atmos->c_volume[MOL1*ND+id]*PopV[id][icL1];
          else
            ColUp=CVColl*BALANCE*atmos->concentration[id]*mol[iMol1].abund*
                  atmos->c_volume[MOL1*ND+id]*PopV[id][icL1];

          if ( icU2 != icL1)
          Rmat[icL1][icU2]-=ColUp;
          Rmat[icU1][icU2]+=ColUp;
          Rmat[icL2][icU2]+=ColUp;
/*        Rmat[icU2][icU2]-=ColUp;      */
         }
	}

/*	exit(1);*/

return 0;
}













