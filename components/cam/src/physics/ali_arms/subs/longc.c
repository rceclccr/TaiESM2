
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <mv_utils.h>
#include <functions.h>

int longc(double *dtaum, double *sm, double *jm, double *diagm,
	     double fincd, int nd,double *pool)
 {
  /*
   *     driver for the formal solution of the radiative transfer
   *     equation by the zero-order method of long characteristics
   */

  register int id;
  register double *ex0, *ex1, *ex2, *riin, *riup, *aiin, *aiup, *tau;

  ex0=(double *) (pool);
  ex1=(double *) (pool+nd);
  ex2=(double *) (pool+2*nd);
  riin=(double *) (pool+3*nd);
  riup=(double *) (pool+4*nd);
  aiin=(double *) (pool+6*nd);
  aiup=(double *) (pool+7*nd);
  tau =(double *) (pool+8*nd);


  tau[0]=0.0;

  for(id=0;id<nd-1;id++)
   {
    tau[id+1]=tau[id]+dtaum[id];
   }

  for(id=0;id<nd;id++)
   {
    ex0[id]=exp(tau[id]-tau[nd-1]);

    if (dtaum[id]<1e-2)
     {
      ex1[id]=dtaum[id]*(1.0-dtaum[id]/2.0);
      ex2[id]=ex1[id]/2.0;
     }
    else
     {
      ex2[id]=(1.0-ex1[id])/2.0;
     }
   }


  for(id=0;id<nd;id++)
   {
    if (dtaum[id]<1e-2)
     {
      aiup[id]=dtaum[id]*(1.0-dtaum[id]/2.0)/2.0;
     }
    else
     {
      aiup[id]=(1.0-ex1[id])/2.0;
     }
   }

  for(id=1;id<nd;id++)
   {
    aiin[id]=aiup[id-1];
   }
  aiin[0]=0.0;

  /* Incoming radiation: I- */

  riin[0]=0.0;

  for(id=0;id<nd-1;id++)
   {
    riin[id+1]=riin[id]*ex1[id]+(sm[id]+sm[id+1])*ex2[id];
   }

    /* Outgoing radiation: I+ */
  for(id=nd-2;id>=0;id--)
   {
    riup[id]=riup[id+1]*ex1[id]+(sm[id]+sm[id+1])*ex2[id];
   } 				/* id */

  for (id=0;id<nd;id++)
   {
    riup[id]+=fincd*ex0[id];
   }

  riup[nd-1]=fincd;
  aiup[nd-1]=0.0;

/* final symmetrized (Feautrier) intensity -- (riin+riup)/2 */

  for(id=0;id<nd;id++)
   {
    jm[id]   =(riin[id]+riup[id])/2.0;
    diagm[id]=(aiin[id]+aiup[id])/2.0;
/*
printf(" longc: id=%3i jm=%2.3e jin=%2.3e jup=%2.3e diag=%2.3e ain=%2.3e aup=%2.3e\n",
id, jm[id],riin[id],riup[id], diagm[id],aiin[id],aiup[id]);
*/
   }

 return 0;
}

double exp_m1(double x)
 {
  int i;
  double eps,r,b;
  eps=1e-40;
  b=0.0;
   for (i=2,r=-x;((r>eps) || (r<-eps));i++)
    {
     b+=r;
     r*=-x/i;
    }
  return -b;
 }

