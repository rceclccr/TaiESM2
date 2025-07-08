
#include <math.h>
#include <functions.h>

double voigt  (double X, double A)
{
 int i;
 const double a[7]= {
         122.607931777104326, 214.382388694706425,
         181.928533092181549,  93.15558045813441,
          30.180142196210589,   5.912626209773153,
           0.564189583562615};
 const double b[7]= {
         122.607931773875350, 352.730625110963558,
         457.334478783897737, 348.703917719495792,
         170.354001821091472,  53.992906912940207,
          10.479857114260399};
 const double c[7]= {
         0.5641641, 0.8718681, 1.474395, -19.57862,
          802.4513, -4850.316, 8031.468};
 const double q2 = .564189583547756;

 double  Help_h;
 double  v2, v3, Qre1, Qre2, Qri1, Qri2;
 double  Pre1, Pre2, Pre3, Pre4, Pre5, Pre6, Pre7;
 double  Pri1, Pri2, Pri3, Pri4, Pri5, Pri6, Pri7;

	if (A <= 1.0e-3 && X >= 2.5 )
	{
         v2   = X * X;
         v3   = 1.0;
         Help_h = c[0];
         for (i=1;i<=6;i++)
         {
          v3 *= v2;
          Help_h += c[i] / v3;
         }

         return( ( Help_h * (A / v2) +
                   exp(-v2) * (1.0 + A * A * (1.0 - 2.0 * v2)))*q2 );
        }
        else
        {
         Pre1 =  A;
         Pri1 = -X;
         Pre2 = Pre1 * A + Pri1 * X;
         Pri2 = Pri1 * A - Pre1 * X;
         Pre3 = Pre2 * A + Pri2 * X;
         Pri3 = Pri2 * A - Pre2 * X;
         Pre4 = Pre3 * A + Pri3 * X;
         Pri4 = Pri3 * A - Pre3 * X;
         Pre5 = Pre4 * A + Pri4 * X;
         Pri5 = Pri4 * A - Pre4 * X;
         Pre6 = Pre5 * A + Pri5 * X;
         Pri6 = Pri5 * A - Pre5 * X;
         Pre7 = Pre6 * A + Pri6 * X;
         Pri7 = Pri6 * A - Pre6 * X;
                                                           
         Qre1 = a[0] + Pre1 * a[1] + Pre2 * a[2] + Pre3 * a[3] +
                       Pre4 * a[4] + Pre5 * a[5] + Pre6 * a[6];
         Qri1 =        Pri1 * a[1] + Pri2 * a[2] + Pri3 * a[3] +
                       Pri4 * a[4] + Pri5 * a[5] + Pri6 * a[6];
         Qre2 = b[0] + Pre1 * b[1] + Pre2 * b[2] + Pre3 * b[3] +
                       Pre4 * b[4] + Pre5 * b[5] + Pre6 * b[6] + Pre7;
         Qri2 =        Pri1 * b[1] + Pri2 * b[2] + Pri3 * b[3] +
                       Pri4 * b[4] + Pri5 * b[5] + Pri6 * b[6] + Pri7;
         return ((Qre1 * Qre2 + Qri1 * Qri2) / (Qre2 * Qre2 + Qri2 * Qri2)*q2);
	}

}
