
#include <math.h>
#include <constants.h>
#include <functions.h>

double planck(double v0, double tkin)
{
return ( 2.*HPLANCK*CLIGHT*v0*v0*v0/(exp(v0*CHK/tkin)-1));
}
