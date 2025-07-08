
#ifndef SELECT_STRUCT_H
#define SELECT_STRUCT_H

typedef struct {
/*	int	mole;
	int	iso;*/
	double	frequency;
	double	aein;
	double	gair;
	double	ctmp;
	double	l_Ev;
	int	u_hitnumber;
	int	l_hitnumber;
	int	u_local;
	int	l_local;
	int	u_stwt;
	int	l_stwt;
/*	double	check_hitran;*/
	} LINEsm;
	 
typedef	struct {
/*	int	mole;
	int	iso;*/
	double	energy;
	int	hitnumber;
/*	int	i_viblevel;*/
	int	stwt;
	int	localq;
 	int	marked;
	} ROTLEVELsm;

typedef	struct {
	double	energy;
	int	ptr;
	double	deviation;
	} ROTLEVELpool;
	
#endif /* SELECT_STRUCT_H */
