
#ifndef QUANT_MACROS_H
#define QUANT_MACROS_H

#define CO2_N(x) ( 2*( int)((x)/10000)+( ( int)((x)/1000) - (( int) ((x)/10000))*10 ))

#define CO2_L(x) ( ( int)((x)/100) - (( int) ((x)/1000))*10 )

#define CO2_V3(x) ( ( int)((x)/10) - (( int) ((x)/100))*10 )

#define CO2_M(x) ((x) - (( int) ((x)/10))*10)

#define N2O_V1(x) (( int)((x)/1000))

#define N2O_V2(x) ( ( int)((x)/100) - (( int) ((x)/1000))*10 )

#define N2O_L(x) ( ( int)((x)/10) - (( int) ((x)/100))*10 )

#define N2O_V3(x) ((x) - (( int) ((x)/10))*10 )

#endif /* QUANT_MACROS_H */
