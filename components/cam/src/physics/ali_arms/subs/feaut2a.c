
#include <stdio.h>
#include <stdlib.h>

#include <functions.h>

int feaut2a_opt(double *dtaum, double *sm, double *jm, double *diagm,
	     double fincd, int nd,double *pool)
{
    /* Local variables */
    double *a, *c, *f, *g, *v;
    register int i, nd1;
    double abc_1,abc_nd,y_nd;
    register double d__1,dt;

	a=(double *) (pool);
	c=(double *) (pool+nd);
	f=(double *) (pool+2*nd);
	g=(double *) (pool+3*nd);
	v=(double *) (pool+4*nd);

     /* Function Body */
    nd1 = nd - 1;
    abc_1 = 2. / dtaum[0] + 1.;

/* Computing 2nd power */
    d__1 = dtaum[0];
    c[0] = 2. / (d__1 * d__1);

    for (i = 1; i < nd1; ++i) {
	dt = dtaum[i-1] + dtaum[i];
	a[i] = 2. / (dt * dtaum[i - 1]);
	c[i] = 2. / (dt * dtaum[i]);
    }
    abc_nd = 2. / dtaum[nd1-1] + 1.;
/* Computing 2nd power */
    d__1 = dtaum[nd1-1];
    a[nd1] = 2. / (d__1 * d__1);
    y_nd = sm[nd1] + fincd * 2. / dtaum[nd1-1];

/*       NOW START THE ELIMINATION */

    f[0] = abc_1 / c[0];
    v[0] = sm[0] / (abc_1 + c[0]);

    for (i = 1; i < nd1; ++i) {
	f[i] = ( 1. + a[i] * f[i - 1]  / (f[i - 1] + 1.)) / c[i];
	v[i] = (  sm[i] + a[i] * v[i - 1]) / (c[i] * (f[i] + 1.));
    }
    jm[nd1] = (y_nd + a[nd1] * v[nd1 - 1]) / (abc_nd + a[nd1]
	    * (f[nd1 - 1] / (f[nd1 - 1] + 1.)));
    for (i = nd1-1; i >=0; --i) {
	jm[i] = jm[i + 1] / (f[i] + 1.) + v[i];
    }

/*        THE FOLLOWING STATEMENTS MAY BE OMITTED IF THE DIAGONAL */
/*        ELEMENTS OF THE INVERSE OPERATOR (DIAG) ARE NOT WANTED. */

    g[nd1] = abc_nd / a[nd1];
    diagm[nd1] = 1. / (abc_nd + a[nd1] * f[nd1 - 1] / (f[nd1 - 1] +
	    1.));
    for (i = nd1-1; i > 0; --i) {
	diagm[i] = 1. / (c[i] * (f[i] + g[i+1] / (g[i+1] + 1.)));
	g[i] = (1. + c[i] * g[i+1] / (g[i+1] + 1.)) / a[i];
    }
    diagm[0] = 1. / (c[0] * (f[0] + g[1] / (g[1] + 1.)));

    return 0;
} /* feaut2a_opt */

int feaut2a_optlimb(double *dtaum, double *sm, double *jm,
	     double fincd,int nd,double *pool)
{
    /* Local variables */
    double *a, *c, *f, *v;
    register int i, nd1;
    double abc_1,abc_nd,y_nd;
    register double d__1,dt;

	a=(double *) (pool);
	c=(double *) (pool+nd);
	f=(double *) (pool+2*nd);
/*	g=(double *) (pool+3*nd);*/
	v=(double *) (pool+3*nd);

     /* Function Body */
    nd1 = nd - 1;
    abc_1 = 2. / dtaum[0] + 1.;

/* Computing 2nd power */
    d__1 = dtaum[0];
    c[0] = 2. / (d__1 * d__1);

    for (i = 1; i < nd1; ++i) {
	dt = dtaum[i-1] + dtaum[i];
	a[i] = 2. / (dt * dtaum[i - 1]);
	c[i] = 2. / (dt * dtaum[i]);
    }
    abc_nd = 2. / dtaum[nd1-1] + 1.;
/* Computing 2nd power */
    d__1 = dtaum[nd1-1];
    a[nd1] = 2. / (d__1 * d__1);
    y_nd = sm[nd1] + fincd * 2. / dtaum[nd1-1];

/*       NOW START THE ELIMINATION */

    f[0] = abc_1 / c[0];
    v[0] = sm[0] / (abc_1 + c[0]);

    for (i = 1; i < nd1; ++i) {
	f[i] = ( 1. + a[i] * f[i - 1]  / (f[i - 1] + 1.)) / c[i];
	v[i] = (  sm[i] + a[i] * v[i - 1]) / (c[i] * (f[i] + 1.));
    }
    jm[nd1] = (y_nd + a[nd1] * v[nd1 - 1]) / (abc_nd + a[nd1]
	    * (f[nd1 - 1] / (f[nd1 - 1] + 1.)));
    for (i = nd1-1; i >=0; --i) {
	jm[i] = jm[i + 1] / (f[i] + 1.) + v[i];
    }

/*        THE FOLLOWING STATEMENTS MAY BE OMITTED IF THE DIAGONAL */
/*        ELEMENTS OF THE INVERSE OPERATOR (DIAG) ARE NOT WANTED. */

    return 0;
} /* feaut2a_optlimb */

int feaut2a(double *dtaum, double *sm, double *jm, double *diagm,
	     double r1, double finc1,
	     double rd, double fincd, int nd)
{
    /* Local variables */
    double beta1, *a, *c, *f, *g;
    int i;
    double betad, *v, *y, dt;
    int nd1;
    double *abc;
    double d__1;
    
	a=(double *) malloc(nd*sizeof(double));
	if(!a)
	{
	 printf("No free memory");
	 exit(1);
	}

	c=(double *) malloc(nd*sizeof(double));
	if(!c)
	{
	 printf("No free memory");
	 exit(1);
	}

	f=(double *) malloc(nd*sizeof(double));
	if(!f)
	{
	 printf("No free memory");
	 exit(1);
	}

	g=(double *) malloc(nd*sizeof(double));
	if(!g)
	{
	 printf("No free memory");
	 exit(1);
	}

	v=(double *) malloc(nd*sizeof(double));
	if(!v)
	{
	 printf("No free memory");
	 exit(1);
	}

	y=(double *) malloc(nd*sizeof(double));
	if(!y)
	{
	 printf("No free memory");
	 exit(1);
	}

	abc=(double *) malloc(nd*sizeof(double));
	if(!abc)
	{
	 printf("No free memory");
	 exit(1);
	}
	


/*     FORMAL SOLUTION ALONG A RAY USING THE SECOND-ORDER FEAUTRIER */
/*     SCHEME (SEE AUER 1967, AP. J. 150, L53), MODIFIED TO TREAT */
/*     BOUNDARY CONDITIONS OF THE FORM */

/*               I(-) = R1 * I(+) + FINC1    AT ID=1 */
/*               I(+) = RD * I(-) + FINCD    AT ID=ND */

/*     THE OTHER VARIABLES ARE: */

/*               DTAUM -- ARRAY OF OPTICAL DEPTH DIFFERENCES ALONG THE RAY
 */
/*                        (DTAUM(ID)=TAUM(ID+1)-TAUM(ID), ID=1,ND-1) */
/*                  JM -- ARRAY OF FEAUTRIER J'S */
/*                  SM -- ARRAY OF SOURCE FUNCTIONS */
/*               DIAGM -- ARRAY OF DIAGONAL ELEMENTS OF THE INVERSE */
/*                        OPERATOR (THE MONOCHROMATIC LAMBDA OPERATOR). */

/*     THIS USES A MODIFICATION OF THE FEAUTRIER ELIMINATION SCHEME */
/*     TO IMPROVE NUMERICAL ACCURACY.  INSTEAD OF USING THE */
/*     COEFFICIENTS B(I), ONE HERE USES ABC(I), DEFINED BY */

/*                  ABC(I) = B(I) -A(I) -C(I) */

/*     (SPECIAL CASES: ABC(1)=B(1)-C(1) AND ABC(N)=B(N)-A(N)) */
/*     THE COEFFICIENTS ABC ARE TYPICALLY OF ORDER UNITY, INSTEAD */
/*     OF ORDER 1/H**2, WHERE H IS THE  GRID SPACING.  IN ADDITION, */
/*     THE METHOD CONSISTS SIMPLY OF USING THE VARIABLE "F" */
/*     INSTEAD OF THE FEAUTRIER "D", WHERE THE RELATION IS */

/*                      D(I) = 1/(1 + F(I)) */

/*     THIS ALLOWS BOTH OPTICALLY THICK AND THIN CASES TO BE DONE */
/*     WITH LITTLE LOSS OF NUMERICAL ACCURACY.  (NOTE THAT ONLY */
/*     PLUS SIGNS APPEAR IN THE FOLLOWING RECURSION RELATIONS */
/*     AND THAT A, B, AND ABC ARE ALL POSITIVE.) */
/*     VERSION 17-JAN-1988 GBR. */

     /* Function Body */
    nd1 = nd - 1;
    beta1 = (1. - r1) / (r1 + 1.);
    betad = (1. - rd) / (rd + 1.);
    abc[0] = beta1 * 2. / dtaum[0] + 1.;

/* Computing 2nd power */
    d__1 = dtaum[0];
    c[0] = 2. / (d__1 * d__1);
    y[0] = sm[0] + finc1 * 2. / ((r1 + 1.) * d__1);

    for (i = 1; i < nd1; ++i) {
	abc[i] = 1.;
	dt = dtaum[i-1] + dtaum[i];
	a[i] = 2. / (dt * dtaum[i - 1]);
	c[i] = 2. / (dt * dtaum[i]);
	y[i] = sm[i];
    }
    abc[nd1] = betad * 2. / dtaum[nd1-1] + 1.;
/* Computing 2nd power */
    d__1 = dtaum[nd1-1];
    a[nd1] = 2. / (d__1 * d__1);
    y[nd1] = sm[nd1] + fincd * 2. / ((rd + 1.) * dtaum[nd1-1]);

/*       NOW START THE ELIMINATION */

    f[0] = abc[0] / c[0];
    v[0] = y[0] / (abc[0] + c[0]);

    for (i = 1; i < nd1; ++i) {
	f[i] = (abc[i] + a[i] * f[i - 1]  / (f[i - 1] + 1.)) / c[i];
	v[i] = (  y[i] + a[i] * v[i - 1]) / (c[i] * (f[i] + 1.));
    }
    jm[nd1] = (y[nd1] + a[nd1] * v[nd1 - 1]) / (abc[nd1] + a[nd1] 
	    * (f[nd1 - 1] / (f[nd1 - 1] + 1.)));
    for (i = nd1-1; i >=0; --i) {
	jm[i] = jm[i + 1] / (f[i] + 1.) + v[i];
    }

/*        THE FOLLOWING STATEMENTS MAY BE OMITTED IF THE DIAGONAL */
/*        ELEMENTS OF THE INVERSE OPERATOR (DIAG) ARE NOT WANTED. */

    g[nd1] = abc[nd1] / a[nd1];
    diagm[nd1] = 1. / (abc[nd1] + a[nd1] * f[nd1 - 1] / (f[nd1 - 1] + 
	    1.));
    for (i = nd1-1; i > 0; --i) {
	diagm[i] = 1. / (c[i] * (f[i] + g[i+1] / (g[i+1] + 1.)));
	g[i] = (abc[i] + c[i] * g[i+1] / (g[i+1] + 1.)) / a[i];
    }
    diagm[0] = 1. / (c[0] * (f[0] + g[1] / (g[1] + 1.)));

    free(a);
    free(c);
    free(f);
    free(g);
    free(v);
    free(y);
    free(abc);
    
    return 0;
} /* feaut2a */

double fea_optlimb1(double *dtaum, double *sm, double *jm, 
	                int nd,double *pool)
{
    /* Local variables */
    double *a, *c, *f, *v;
    register int i, nd1;
    double abc_1,abc_nd,y_nd;
    register double d__1,dt;
    
	a=(double *) (pool);
	c=(double *) (pool+nd);
	f=(double *) (pool+2*nd);
/*	g=(double *) (pool+3*nd);*/
	v=(double *) (pool+3*nd);
	
     /* Function Body */
    nd1 = nd - 1;
    abc_1 = 2. / dtaum[0] + 1.;

/* Computing 2nd power */
    d__1 = dtaum[0];
    c[0] = 2. / (d__1 * d__1);

    for (i = 1; i < nd1; ++i) {
	dt = dtaum[i-1] + dtaum[i];
	a[i] = 2. / (dt * dtaum[i - 1]);
	c[i] = 2. / (dt * dtaum[i]);
    }
    abc_nd = 1.;
/* Computing 2nd power */
    d__1 = dtaum[nd1-1];
    a[nd1] = 2. / (d__1 * d__1);
    y_nd = sm[nd1];

/*       NOW START THE ELIMINATION */

    f[0] = abc_1 / c[0];
    v[0] = sm[0] / (abc_1 + c[0]);

    for (i = 1; i < nd1; ++i) {
	f[i] = ( 1. + a[i] * f[i - 1]  / (f[i - 1] + 1.)) / c[i];
	v[i] = (  sm[i] + a[i] * v[i - 1]) / (c[i] * (f[i] + 1.));
    }
    jm[nd1] = (y_nd + a[nd1] * v[nd1 - 1]) / (abc_nd + a[nd1] 
	    * (f[nd1 - 1] / (f[nd1 - 1] + 1.)));
    for (i = nd1-1; i >=0; --i) {
	jm[i] = jm[i + 1] / (f[i] + 1.) + v[i];
    }

    return jm[0];
}
