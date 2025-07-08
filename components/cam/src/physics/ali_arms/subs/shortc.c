
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <mv_utils.h>
#include <functions.h>

int shortc(double *dtaum, double *sm, double *jm, double *diagm,
	     double fincd, int nd,double *pool)
{
/*
 *     driver for the formal solution of the radiative transfer
 *     equation by the method of short characteristics
 */

 register int id;
 register double *dtx0, *dtx1, *dtx2, *riin, *riup, *aiin, *aiup, *dt12;

        dtx0=(double *) (pool);
	dtx1=(double *) (pool+nd);
        dtx2=(double *) (pool+2*nd);

        riin=(double *) (pool+3*nd);
	riup=(double *) (pool+4*nd);
	aiin=(double *) (pool+5*nd);
	aiup=(double *) (pool+6*nd);
        dt12=(double *) (pool+7*nd);

            for(id=0;id<nd-1;id++)
            {
             if (dtaum[id]>1e-2) /* exponent calculation accuracy depends on power */
              {
               dtx1[id]=exp(-dtaum[id]);
               dtx2[id]=(1.0-dtx1[id])/dtaum[id];
               dtx0[id]=1.0-dtx2[id];
               dt12[id]=dtx2[id]-dtx1[id];
              }
             else               /* so we use another form of exponent in thin case */
              {
               dtx1[id]=1.0-dtaum[id]*(1.0-dtaum[id]/2.0);
               dtx0[id]=dtaum[id]*(1.0/2.0-dtaum[id]/3.0);
               dt12[id]=dtx0[id];
              }
            }

/*
 *
 *           incoming intensity
 */
            riin[0]=0.0;
            aiin[0]=0.0;

            for(id=0;id<nd-1;id++)
            {
             riin[id+1]=riin[id]*dtx1[id]+sm[id]*dt12[id]+
                        sm[id+1]*dtx0[id];
             aiin[id+1]=dtx0[id];
            }

/*
 *
 *           outgoing intensity
 */
            riup[nd-1]=fincd;
            aiup[nd-1]=0.0;

            for(id=nd-2;id>=0;id--)
            {
             riup[id]=riup[id+1]*dtx1[id]+sm[id]*dtx0[id]+
                      sm[id+1]*dt12[id];
             aiup[id]=dtx0[id];
            }

/*
 *           final symmetrized (Feautrier) intensity -- (riin+riup)/2
 */
            for(id=0;id<nd;id++)
            {
             jm[id]   =(riin[id]+riup[id])/2.0;
             diagm[id]=(aiin[id]+aiup[id])/2.0;
/*
printf("shortc: id=%3i jm=%1.3e jin=%1.3e jup=%1.3e diag=%1.3e ain=%1.3e aup=%1.3e\n",
id, jm[id],riin[id],riup[id], diagm[id],aiin[id],aiup[id]);
*/
            }

#if 0
/*c            dlam(nd)=dlam(nd-1)*/
            diagm[nd-1]=0.0;
#endif


 return 0;
}

double sho_optlimb1(double *dtaum, double *sm,int nd, double *pool)
{
/*
 *     driver for the formal solution of the radiative transfer
 *     equation by the method of short characteristics
 */

 register int id;
 register double *dtx0, *dtx1, *dtx2, riin, riup;

	dtx0=(double *) (pool);
	dtx1=(double *) (pool+nd);
	dtx2=(double *) (pool+2*nd);

            for(id=0;id<nd-1;id++)
            {
             dtx1[id]=exp(-dtaum[id]);
             dtx2[id]=(1.0-dtx1[id])/dtaum[id];
             dtx0[id]=1.0-dtx2[id];
            }

/*
 *
 *           incoming intensity
 */
            riin=0.0;
            for(id=0;id<nd-1;id++)
            {
             riin=riin*dtx1[id]+sm[id]*(dtx2[id]-dtx1[id])+
                        sm[id+1]*dtx0[id];
            }

/*
 *
 *           outgoing intensity
 */
            riup=riin;

            for(id=nd-2;id>=0;id--)
            {
             riup=riup*dtx1[id]+sm[id]*dtx0[id]+
                      sm[id+1]*(dtx2[id]-dtx1[id]);
            }

 return riup;
}
