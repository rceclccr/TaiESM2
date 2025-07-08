
#include <functions.h>

int reflect(int n, double *an)
{
    /* Local variables */
    int i;
    double r;

/*     CHANGES THE ORDER IN ARRAY AN */


    for (i = 0; i < n/2 ; ++i) {
	r = an[i];
	an[i] = an[n - 1 - i];
	an[n - 1 - i] = r;
    }
    return 0;
}
