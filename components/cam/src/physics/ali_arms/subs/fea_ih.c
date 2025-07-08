#include <stdio.h>
#include <stdlib.h>

#include <functions.h>
#include <mv_utils.h>

int fea_ih(double *dtaum, double *sm, double *jm, double *diagm, 
	     double fincd, int nd,double *pool)
{
/*
 *           set up matrix coefficients for the feutrier scheme for the
 *           current frequency-angle point
 *               
 *           upper boundary condition (eq. 27)
 */

 int	id;
 double cc, dtinv, aa;
 double	*a, *b, *c, *v, *f, *d, *z, *e;
 
	a=(double *) (pool);
	c=(double *) (pool+nd);
	f=(double *) (pool+2*nd);
	z=(double *) (pool+3*nd);
	v=(double *) (pool+4*nd);

	b=vec_FMEMALLOC(nd);
	d=vec_FMEMALLOC(nd);
	e=vec_FMEMALLOC(nd);
	
	    cc=2.0/dtaum[0];
            c[0]=cc/dtaum[0];
            b[0]=1.0+cc+c[0];
            a[0]=0.0;
            v[0]=sm[0];
/*               
 *           normal depth points (eqs. 23 - 24)
 */
            for(id=1;id<nd-1;id++)
            {
             dtinv=2.0/(dtaum[id-1]+dtaum[id]);
             a[id]=dtinv/dtaum[id-1];
             c[id]=dtinv/dtaum[id];
             b[id]=1.0+a[id]+c[id];
             v[id]=sm[id];
            }

/*               
 *           lower boundary condition (eq. 28)
 */              
            aa=2.0/dtaum[nd-2];
            a[nd-1]=aa/dtaum[nd-2];
            b[nd-1]=1.0+aa+a[nd-1];
            c[nd-1]=0.0;
            v[nd-1]=sm[nd-1]+aa*fincd;
/*               
 *           ---------------------------------------------------
 *           solve the transfer equation by the Feautrier scheme
 *           call the formal solver
 *               
 *     ****************************************************************
 *
 *
 *     formal solver of the radiative transfer equation in the
 *     Feautrier formalism -- second-order scheme
 *     eqs. 42 - 46
 */

/*
 *     ----------------------------
 *     forward sweep (eqs. 43 - 45)
 *     ----------------------------
 *
 *     i) upper boundary
 */

      f[0]=(b[0]-c[0])/c[0];
      d[0]=1.0/(1.0+f[0]);
      z[0]=v[0]/b[0];
/* 
 *     ii) normal depth points
 */
      for(id=1;id<nd-1;id++)
      {
       f[id]=(b[id]-a[id]-c[id]+a[id]*f[id-1]*d[id-1])/c[id];
       d[id]=1.0/(1.0+f[id]);
       z[id]=(v[id]+a[id]*z[id-1])*d[id]/c[id];
      }

/*
 *     iii) lower boundary
 */

      z[nd-1]=(v[nd-1]+a[nd-1]*z[nd-2])/(b[nd-1]-a[nd-1]*d[nd-2]);
/*
 *     -----------------------------
 *     backward elimination (eq. 46)
 *     -----------------------------
 */   
      jm[nd-1]=z[nd-1];
      for(id=nd-2;id>=0;id--)
      {
       jm[id]=jm[id+1]*d[id]+z[id];
      }

/*
 *     ------------------------------------
 *     evaluation of the approximate lambda 
 *     ------------------------------------
 */

/*   
 *     diagonal terms of the inverse T matrix (eqs. 57, 59)
 */
      e[nd-1]=a[nd-1];
      for(id=nd-2;id>=0;id--)
      {
       e[id]=a[id]/(b[id]-c[id]*e[id+1]);
       diagm[id]=d[id]/c[id]/(1.0-d[id]*e[id+1]);
      }

	/* why ? */
/*      diagm[nd-1]=diagm[nd-2];*/

	free(b);
	free(d);
	free(e);
	
 return 0;
}
