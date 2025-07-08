
#include <math.h>
#include <functions.h>

int gauss(double x1, double x2, double *x, 
	double *w, int n)
{

    /* Local variables */
    int iter;
    int i, j, m;
    double z, p1, p2, p3, z1, pp, xi, xj, xl, xm, xn;
	double d__1;

/*     CALCULATES THE DIVISION POINTS X(I) AND WEIGHTS W(I) FOR AN */
/*     N-POINT GAUSSIAN QUADRATURE FORMULA OVER THE RANGE X1 TO X2. */
/*     WRITTEN BY G. RYBICKI 7 OCTOBER 1981. */

    /* Function Body */
    m = (n + 1) / 2;
    xn = (double) (n);
    xm = (x2 + x1) * .5;
    xl = (x2 - x1) * .5;
    for (i = 0; i < m; ++i) {
	xi = (double) (i+1);
	z = cos((xi - .25) * 3.141592654 / (xn + .5));
	iter = 1;
	while(iter) {
	    p1 = 1.;
	    p2 = 0.;
	    for (j = 0; j < n; ++j) {
		p3 = p2;
		p2 = p1;
		xj = (double) (j+1);
		p1 = ((xj * 2. - 1.) * z * p2 - (xj - 1.) * p3) / xj;
	    }
	    pp = n * (z * p1 - p2) / (z * z - 1.);
	    z1 = z;
	    z = z1 - p1 / pp;
	    if ((d__1 = z - z1, fabs(d__1)) < 1e-14) {
		iter = 0;
	    }
	}
	x[i] = xm - xl * z;
	x[n - i -1] = xm + xl * z;
	w[i] = xl * 2. / ((1. - z * z) * pp * pp);
	w[n - i -1] = w[i];
    }
    return 0;
} /* gauss_ */

