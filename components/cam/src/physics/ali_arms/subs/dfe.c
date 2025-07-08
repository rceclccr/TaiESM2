
#include <stdio.h>
#include <stdlib.h>

#include <functions.h>

int dfe(double *dtaum, double *sm, double *jm, double *diagm,
	     double fincd, int nd,double *pool)
{
/*
 *     formal solution of the radiative transfer
 *     equation by the Discontinuous Finite Element method
 *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 */

 int	id;
 double	*rim, *rip, *riin, *riup, *aim, *aip, *aiin, *aiup;
 register double aa, bb, cc, dt0, dtaup1, dtau2, dtt;

	rim=(double *) (pool);
	rip=(double *) (pool+nd);
	riin=(double *) (pool+2*nd);
	riup=(double *) (pool+3*nd);
	aim=(double *) (pool+4*nd);
	aip=(double *) (pool+5*nd);
	aiin=(double *) (pool+6*nd);
	aiup=(double *) (pool+7*nd);

/*            incoming intensity
 *
 *            upper boundary condition
 */

            rim[0]=0.0;
/*
 *           recurrence relation to determine I^+ and I^-
 *           (which are called RIP and RIM),
 *           AIP and AIM are the correspodning diagonal elements of
 *           the Lambda operator (used for constructing the approximate
 *           Lambda operator)
 */
            aim[0]=0.0;

            for(id=0;id<nd-1;id++)
            {
             dt0=dtaum[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             cc=2.0*dtaup1;
             bb=dt0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim[id+1]=(2.*rim[id]+dt0*sm[id  ]+bb*sm[id+1])*aa;
             rip[id  ]=(cc*rim[id]-dt0*sm[id+1]+bb*sm[id  ])*aa;
             aim[id+1]=bb*aa;
             aip[id  ]=(bb+cc*aim[id])*aa;
            }

            for(id=1;id<nd-1;id++)
            {
             dtt=1.0/(dtaum[id-1]+dtaum[id]);
             riin[id]=(rim[id]*dtaum[id]+rip[id]*dtaum[id-1])*dtt;
             aiin[id]=(aim[id]*dtaum[id]+aip[id]*dtaum[id-1])*dtt;
            }

            riin[0]=rim[0];
            riin[nd-1]=rim[nd-1];
            aiin[0]=aim[0];
            aiin[nd-1]=aim[nd-1];

/*
 *           outgoing intensity
 *
 *           lower boundary condition
 */
            rim[nd-1]=fincd;

/*
 *           recurrence relation to determine I^+ and I^-
 *
 */
            for(id=nd-2;id>=0;id--)
            {
             dt0=dtaum[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             cc=2.0*dtaup1;
             bb=dt0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim[id  ]=(2.*rim[id+1]+dt0*sm[id+1]+bb*sm[id  ])*aa;
             rip[id+1]=(cc*rim[id+1]-dt0*sm[id  ]+bb*sm[id+1])*aa;
             aim[id  ]=bb*aa;
             aip[id+1]=(bb+cc*aim[id+1])*aa;
            }

            for(id=1;id<nd-1;id++)
            {
             dtt=1.0/(dtaum[id-1]+dtaum[id]);
             riup[id]=(rim[id]*dtaum[id-1]+rip[id]*dtaum[id])*dtt;
             aiup[id]=(aim[id]*dtaum[id-1]+aip[id]*dtaum[id])*dtt;
            }

            riup[0]=rim[0];
            riup[nd-1]=rim[nd-1];
            aiup[0]=aim[0];
            aiup[nd-1]=aim[nd-1];
/*
 *           final symmetrized (Feautrier) intensity -- (riin+riup)/2
 */
            for(id=0;id<nd;id++)
            {
             jm[id]   =(riin[id]+riup[id])/2;
             diagm[id]=(aiin[id]+aiup[id])/2;
            }

#if 0
/*c            dlam(nd)=dlam(nd-1)*/
            diagm[nd-1]=0.;
#endif

 return 0;
}

double dfe_optlimb1(double *dtaum, double *sm, double *jm,
	            int nd,double *pool)
{
/*
 *     formal solution of the radiative transfer
 *     equation by the Discontinuous Finite Element method
 *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 */

 int	id;
 double	*rim, *rip, *riin, *riup;
 register double aa, bb, cc, dt0, dtaup1, dtau2, dtt;

	rim=(double *) (pool);
	rip=(double *) (pool+nd);
	riin=(double *) (pool+2*nd);
	riup=(double *) (pool+3*nd);

/*            incoming intensity
 *
 *            upper boundary condition
 */

            rim[0]=0.0;
/*
 *           recurrence relation to determine I^+ and I^-
 *           (which are called RIP and RIM),
 */

            for(id=0;id<nd-1;id++)
            {
             dt0=dtaum[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             cc=2.0*dtaup1;
             bb=dt0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim[id+1]=(2.*rim[id]+dt0*sm[id  ]+bb*sm[id+1])*aa;
             rip[id  ]=(cc*rim[id]-dt0*sm[id+1]+bb*sm[id  ])*aa;
            }

            for(id=1;id<nd-1;id++)
            {
             dtt=1.0/(dtaum[id-1]+dtaum[id]);
             riin[id]=(rim[id]*dtaum[id]+rip[id]*dtaum[id-1])*dtt;
            }

            riin[0]=rim[0];
            riin[nd-1]=rim[nd-1];

/*
 *           outgoing intensity 
 *
 *           symmetric boundary condition 
 */
            rim[nd-1]=riin[nd-1];

/*
 *           recurrence relation to determine I^+ and I^-
 *
 */
            for(id=nd-2;id>=0;id--)
            {
             dt0=dtaum[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             cc=2.0*dtaup1;
             bb=dt0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim[id  ]=(2.*rim[id+1]+dt0*sm[id+1]+bb*sm[id  ])*aa;
             rip[id+1]=(cc*rim[id+1]-dt0*sm[id  ]+bb*sm[id+1])*aa;
            }

            for(id=1;id<nd-1;id++)
            {
             dtt=1.0/(dtaum[id-1]+dtaum[id]);
             riup[id]=(rim[id]*dtaum[id-1]+rip[id]*dtaum[id])*dtt;
            }

            riup[0]=rim[0];
            riup[nd-1]=rim[nd-1];

 return riup[0];
}

double dfe_optlimb2(double *dtaum, double *sm, int nd)
{
/*
 *     formal solution of the radiative transfer
 *     equation by the Discontinuous Finite Element method
 *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 */

 register int	id;
 register double rim0, aa, bb, cc, dt0, dtaup1, dtau2;


/*            incoming intensity
 *
 *            upper boundary condition
 */

            rim0=0.0;
/*
 *           first half.
 */

            for(id=0;id<nd-1;id++)
            {
             dt0=dtaum[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             bb=dt0*dtaup1;
             cc=2.0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim0=(2.*rim0+dt0*sm[id  ]+bb*sm[id+1])*aa;
            }

/*
 *           outgoing radiation.
 *           we are reflected at tangent point.
 */
            for(id=nd-2;id>=0;id--)
            {
             dt0=dtaum[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             bb=dt0*dtaup1;
             cc=2.0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim0=(2.*rim0+dt0*sm[id+1]+bb*sm[id  ])*aa;
            }

 return rim0;
}


int dfe_geom1(double *dtaum, double *emism, double *dlm, double *jm, 
	      double fincd, int nd, double *pool)
{
/*
 *     formal solution of the radiative transfer
 *     equation by the Discontinuous Finite Element method
 *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 */

 int	id;
 double	*rim, *rip, *riin, *riup;
 register double aa, bb, cc, dt0, dtaup1, dtau2, dtt, dl0;
 
	rim=(double *) (pool);
	rip=(double *) (pool+nd);
	riin=(double *) (pool+2*nd);
	riup=(double *) (pool+3*nd);

/*            incoming intensity    
 *          
 *            upper boundary condition 
 */ 
   
            rim[0]=0.0;
/*
 *           recurrence relation to determine I^+ and I^- 
 *           (which are called RIP and RIM)
 */

            for(id=0;id<nd-1;id++)
            {
             dt0=dtaum[id];
             dl0=dlm[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             cc=2.0*dtaup1;
             bb=dl0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim[id+1]=(2.*rim[id]+dl0*emism[id  ]+bb*emism[id+1])*aa;
             rip[id  ]=(cc*rim[id]-dl0*emism[id+1]+bb*emism[id  ])*aa;
            }

            for(id=1;id<nd-1;id++)
            {
             dtt=1.0/(dlm[id-1]+dlm[id]);
             riin[id]=(rim[id]*dlm[id]+rip[id]*dlm[id-1])*dtt;
            }

            riin[0]=rim[0];
            riin[nd-1]=rim[nd-1];

/*               
 *           outgoing intensity 
 *   
 *           lower boundary condition 
 */
            rim[nd-1]=fincd;

/*
 *           recurrence relation to determine I^+ and I^-
 *
 */
            for(id=nd-2;id>=0;id--)
            {
             dt0=dtaum[id];
             dl0=dlm[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             cc=2.0*dtaup1;
             bb=dl0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim[id  ]=(2.*rim[id+1]+dl0*emism[id+1]+bb*emism[id  ])*aa;
             rip[id+1]=(cc*rim[id+1]-dl0*emism[id  ]+bb*emism[id+1])*aa;
            }

            for(id=1;id<nd-1;id++)
            {
             dtt=1.0/(dlm[id-1]+dlm[id]);
             riup[id]=(rim[id]*dlm[id-1]+rip[id]*dlm[id])*dtt;
            }

            riup[0]=rim[0];
            riup[nd-1]=rim[nd-1];

/*
 *           final symmetrized (Feautrier) intensity -- (riin+riup)/2
 */
            for(id=0;id<nd;id++)
             jm[id]=(riin[id]+riup[id])/2;

 return 0;
}

int dfe_geomlimb1(double *dtaum, double *emism, double *dlm, double *jm, 
	          int nd, double *pool)
{
/*
 *     formal solution of the radiative transfer
 *     equation by the Discontinuous Finite Element method
 *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 */

 int	id;
 double	*rim, *rip, *riin, *riup;
 register double aa, bb, cc, dt0, dtaup1, dtau2, dtt, dl0;
 
	rim=(double *) (pool);
	rip=(double *) (pool+nd);
	riin=(double *) (pool+2*nd);
	riup=(double *) (pool+3*nd);

/*            incoming intensity    
 *          
 *            upper boundary condition 
 */ 
   
            rim[0]=0.0;
/*
 *           recurrence relation to determine I^+ and I^- 
 *           (which are called RIP and RIM)
 */

            for(id=0;id<nd-1;id++)
            {
             dt0=dtaum[id];
             dl0=dlm[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             cc=2.0*dtaup1;
             bb=dl0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim[id+1]=(2.*rim[id]+dl0*emism[id  ]+bb*emism[id+1])*aa;
             rip[id  ]=(cc*rim[id]-dl0*emism[id+1]+bb*emism[id  ])*aa;
            }

            for(id=1;id<nd-1;id++)
            {
             dtt=1.0/(dlm[id-1]+dlm[id]);
             riin[id]=(rim[id]*dlm[id]+rip[id]*dlm[id-1])*dtt;
            }

            riin[0]=rim[0];
            riin[nd-1]=rim[nd-1];

/*               
 *           outgoing intensity 
 *   
 *           lower boundary condition 
 */
            rim[nd-1]=riin[nd-1];

/*
 *           recurrence relation to determine I^+ and I^-
 *
 */
            for(id=nd-2;id>=0;id--)
            {
             dt0=dtaum[id];
             dl0=dlm[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             cc=2.0*dtaup1;
             bb=dl0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim[id  ]=(2.*rim[id+1]+dl0*emism[id+1]+bb*emism[id  ])*aa;
             rip[id+1]=(cc*rim[id+1]-dl0*emism[id  ]+bb*emism[id+1])*aa;
            }

            for(id=1;id<nd-1;id++)
            {
             dtt=1.0/(dlm[id-1]+dlm[id]);
             riup[id]=(rim[id]*dlm[id-1]+rip[id]*dlm[id])*dtt;
            }

            riup[0]=rim[0];
            riup[nd-1]=rim[nd-1];

 return riup[0];
}

double dfe_geomlimb2(double *dtaum, double *emism, double *dlm, int nd )
{
/*
 *     formal solution of the radiative transfer
 *     equation by the Discontinuous Finite Element method
 *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 */

 int	id;
 register double rim0, aa, bb, cc, dt0, dtaup1, dtau2, dl0;
 

/*            incoming intensity    
 *          
 *            upper boundary condition 
 */ 
   
            rim0=0.0;
/*
 *           recurrence relation to determine I^+ and I^- 
 *           (which are called RIP and RIM)
 */

            for(id=0;id<nd-1;id++)
            {
             dt0=dtaum[id];
             dl0=dlm[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             cc=2.0*dtaup1;
             bb=dl0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim0=(2.*rim0+dl0*emism[id  ]+bb*emism[id+1])*aa;
            }

/*               
 *           outgoing intensity 
 *   
 *           lower boundary condition 
 */
            for(id=nd-2;id>=0;id--)
            {
             dt0=dtaum[id];
             dl0=dlm[id];
             dtaup1=dt0+1.0;
             dtau2=dt0*dt0;
             cc=2.0*dtaup1;
             bb=dl0*dtaup1;
             aa=1.0/(dtau2+cc);
             rim0=(2.*rim0+dl0*emism[id+1]+bb*emism[id  ])*aa;
            }


 return rim0;
}
