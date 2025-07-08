	.file 1 "dfe.c"
	.loc 1 7
 #      7 int dfe(double *dtaum, double *sm, double *jm, double *diagm, 
	.globl  dfe
	.ent 	dfe
	.loc 1 7
dfe:															   # 000007
	ldah	$gp, ($27)
	unop
	lda	$gp, ($gp)
	unop
L$157:
	.loc 1 9
 #      8 	     double fincd, int nd,double *pool)
 #      9 {
	sextl	$21, $21												   # 000009
	.loc 1 7
	ldq	$1, ($sp)												   # 000007
	.loc 1 23
 #     10 /*
 #     11  *     formal solution of the radiative transfer
 #     12  *     equation by the Discontinuous Finite Element method
 #     13  *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 #     14  */
 #     15 
 #     16  int	id;
 #     17  double	*rim, *rip, *riin, *riup, *aim, *aip, *aiin, *aiup;
 #     18  register double aa, bb, cc, dt0, dtaup1, dtau2, dtt;
 #     19  
 #     20 	rim=(double *) (pool);
 #     21 	rip=(double *) (pool+nd);
 #     22 	riin=(double *) (pool+2*nd);
 #     23 	riup=(double *) (pool+3*nd);
	s4addq	$21, $31, $4												   # 000023
	.loc 1 22
	addq	$21, $21, $3												   # 000022
	s8addq	$3, $1, $6
	.loc 1 24
 #     24 	aim=(double *) (pool+4*nd);
	s8addq	$4, $1, $8												   # 000024
	.loc 1 23
	subq	$4, $21, $22												   # 000023
	.loc 1 25
 #     25 	aip=(double *) (pool+5*nd);
	addq	$21, $4, $4												   # 000025
	.loc 1 27
 #     26 	aiin=(double *) (pool+6*nd);
 #     27 	aiup=(double *) (pool+7*nd);
	s8subq	$21, $21, $24												   # 000027
	.loc 1 26
	s4subq	$3, $3, $3												   # 000026
	.loc 1 44
 #     28 
 #     29 /*            incoming intensity    
 #     30  *          
 #     31  *            upper boundary condition 
 #     32  */ 
 #     33    
 #     34             rim[0]=0.0;
 #     35 /*
 #     36  *           recurrence relation to determine I^+ and I^- 
 #     37  *           (which are called RIP and RIM),
 #     38  *           AIP and AIM are the correspodning diagonal elements of
 #     39  *           the Lambda operator (used for constructing the approximate
 #     40  *           Lambda operator)
 #     41  */
 #     42             aim[0]=0.0;
 #     43 
 #     44             for(id=0;id<nd-1;id++)
	subl	$21, 1, $27												   # 000044
	.loc 1 7
	lda	$sp, -64($sp)												   # 000007
	stq	$26, ($sp)
	.loc 1 21
	s8addq	$21, $1, $5												   # 000021
	.loc 1 7
	stq	$9, 8($sp)												   # 000007
	.loc 1 21
	s8addq	$21, $1, $20												   # 000021
	.loc 1 7
	stq	$10, 16($sp)												   # 000007
	.loc 1 23
	s8addq	$22, $1, $22												   # 000023
	.loc 1 7
	stq	$11, 24($sp)												   # 000007
	.loc 1 25
	s8addq	$4, $1, $4												   # 000025
	.loc 1 7
	stq	$12, 32($sp)												   # 000007
	.loc 1 27
	s8addq	$24, $1, $24												   # 000027
	.loc 1 7
	stq	$13, 40($sp)												   # 000007
	.loc 1 26
	s8addq	$3, $1, $3												   # 000026
	.loc 1 7
	stq	$14, 48($sp)												   # 000007
	.mask 0x04007E00,-64
	.fmask 0x00000000,0
	.frame  $sp, 64, $26
	.prologue 1
	.loc 1 44
	subl	$21, 4, $7												   # 000044
	.loc 1 34
	stt	$f31, ($1)												   # 000034
	.loc 1 44
	clr	$25													   # 000044
	.loc 1 42
	stt	$f31, ($8)												   # 000042
	.loc 1 44
	ble	$27, L$160												   # 000044
	cmple	$7, $27, $12
	.loc 1 46
 #     45             {
 #     46              dt0=dtaum[id];
	mov	$16, $0													   # 000046
	.loc 1 52
 #     47              dtaup1=dt0+1.0;
 #     48              dtau2=dt0*dt0;
 #     49              cc=2.0*dtaup1;
 #     50              bb=dt0*dtaup1;
 #     51              aa=1.0/(dtau2+cc);
 #     52              rim[id+1]=(2.*rim[id]+dt0*sm[id  ]+bb*sm[id+1])*aa;
	mov	$1, $2													   # 000052
	.loc 1 54
 #     53              rip[id  ]=(cc*rim[id]-dt0*sm[id+1]+bb*sm[id  ])*aa;
 #     54              aim[id+1]=bb*aa;
	lda	$23, 8($8)												   # 000054
	.loc 1 52
	mov	$17, $9													   # 000052
	.loc 1 53
	s8addq	$21, $1, $10												   # 000053
	.loc 1 44
	stq	$12, 56($sp)												   # 000044
	.loc 1 55
 #     55              aip[id  ]=(bb+cc*aim[id])*aa;
	mov	$4, $11													   # 000055
	.loc 1 44
	beq	$12, L$162												   # 000044
	cmplt	$31, $7, $12
L$162:
	.loc 1 47
	ldq	$28, ($gp)												   # 000047
	lds	$f0, ($28)
	.loc 1 44
	beq	$12, L$167												   # 000044
	unop
L$165:
	.loc 1 46
	ldt	$f1, ($0)												   # 000046
	.loc 1 52
	ldt	$f14, ($2)												   # 000052
	ldt	$f15, ($9)
	ldt	$f17, 8($9)
	.loc 1 44
	addl	$25, 4, $25												   # 000044
	.loc 1 52
	lda	$0, 32($0)												   # 000052
	.loc 1 44
	cmplt	$25, $7, $12												   # 000044
	.loc 1 53
	lda	$2, 32($2)												   # 000053
	.loc 1 47
	addt	$f1, $f0, $f11												   # 000047
	.loc 1 48
	mult	$f1, $f1, $f13												   # 000048
	.loc 1 53
	lda	$9, 32($9)												   # 000053
	.loc 1 55
	lda	$10, 32($10)												   # 000055
	.loc 1 52
	mult	$f1, $f15, $f15												   # 000052
	addt	$f14, $f14, $f16
	.loc 1 55
	lda	$23, 32($23)												   # 000055
	.loc 1 44
	lda	$11, 32($11)												   # 000044
	.loc 1 49
	addt	$f11, $f11, $f12											   # 000049
	.loc 1 50
	mult	$f1, $f11, $f11												   # 000050
	.loc 1 52
	addt	$f16, $f15, $f15											   # 000052
	.loc 1 51
	addt	$f13, $f12, $f13											   # 000051
	.loc 1 52
	mult	$f11, $f17, $f17											   # 000052
	.loc 1 53
	mult	$f12, $f14, $f14											   # 000053
	.loc 1 51
	divt	$f0, $f13, $f13												   # 000051
	.loc 1 52
	addt	$f15, $f17, $f15											   # 000052
	mult	$f15, $f13, $f15
	stt	$f15, -24($2)
	.loc 1 53
	ldt	$f18, -24($9)												   # 000053
	ldt	$f19, -32($9)
	mult	$f1, $f18, $f10
	mult	$f11, $f19, $f19
	subt	$f14, $f10, $f10
	addt	$f10, $f19, $f10
	mult	$f10, $f13, $f10
	stt	$f10, -32($10)
	.loc 1 55
	ldt	$f21, -40($23)												   # 000055
	mult	$f12, $f21, $f12
	addt	$f11, $f12, $f12
	.loc 1 54
	mult	$f11, $f13, $f11											   # 000054
	.loc 1 55
	mult	$f12, $f13, $f12											   # 000055
	.loc 1 54
	stt	$f11, -32($23)												   # 000054
	.loc 1 55
	stt	$f12, -32($11)												   # 000055
	.loc 1 46
	ldt	$f22, -24($0)												   # 000046
	.loc 1 52
	ldt	$f27, -24($2)												   # 000052
	ldt	$f28, -24($9)
	ldt	$f30, -16($9)
	.loc 1 47
	addt	$f22, $f0, $f24												   # 000047
	.loc 1 48
	mult	$f22, $f22, $f26											   # 000048
	.loc 1 52
	addt	$f27, $f27, $f29											   # 000052
	mult	$f22, $f28, $f28
	.loc 1 49
	addt	$f24, $f24, $f25											   # 000049
	.loc 1 50
	mult	$f22, $f24, $f24											   # 000050
	.loc 1 52
	addt	$f29, $f28, $f28											   # 000052
	.loc 1 51
	addt	$f26, $f25, $f26											   # 000051
	.loc 1 53
	mult	$f25, $f27, $f27											   # 000053
	.loc 1 52
	mult	$f24, $f30, $f30											   # 000052
	.loc 1 51
	divt	$f0, $f26, $f26												   # 000051
	.loc 1 52
	addt	$f28, $f30, $f28											   # 000052
	mult	$f28, $f26, $f28
	stt	$f28, -16($2)
	.loc 1 53
	ldt	$f1, -16($9)												   # 000053
	ldt	$f16, -24($9)
	mult	$f22, $f1, $f1
	mult	$f24, $f16, $f16
	subt	$f27, $f1, $f1
	addt	$f1, $f16, $f1
	mult	$f1, $f26, $f1
	stt	$f1, -24($10)
	.loc 1 55
	ldt	$f17, -32($23)												   # 000055
	mult	$f25, $f17, $f17
	addt	$f24, $f17, $f17
	.loc 1 54
	mult	$f24, $f26, $f24											   # 000054
	.loc 1 55
	mult	$f17, $f26, $f17											   # 000055
	.loc 1 54
	stt	$f24, -24($23)												   # 000054
	.loc 1 55
	stt	$f17, -24($11)												   # 000055
	.loc 1 46
	ldt	$f15, -16($0)												   # 000046
	.loc 1 52
	ldt	$f21, -16($2)												   # 000052
	ldt	$f13, -16($9)
	ldt	$f12, -8($9)
	.loc 1 47
	addt	$f15, $f0, $f14												   # 000047
	.loc 1 48
	mult	$f15, $f15, $f10											   # 000048
	.loc 1 52
	addt	$f21, $f21, $f11											   # 000052
	mult	$f15, $f13, $f13
	.loc 1 49
	addt	$f14, $f14, $f19											   # 000049
	.loc 1 50
	mult	$f15, $f14, $f14											   # 000050
	.loc 1 52
	addt	$f11, $f13, $f11											   # 000052
	.loc 1 51
	addt	$f10, $f19, $f10											   # 000051
	.loc 1 52
	mult	$f14, $f12, $f12											   # 000052
	.loc 1 53
	mult	$f19, $f21, $f21											   # 000053
	.loc 1 51
	divt	$f0, $f10, $f10												   # 000051
	.loc 1 52
	addt	$f11, $f12, $f11											   # 000052
	mult	$f11, $f10, $f11
	stt	$f11, -8($2)
	.loc 1 53
	ldt	$f22, -8($9)												   # 000053
	ldt	$f29, -16($9)
	mult	$f15, $f22, $f18
	mult	$f14, $f29, $f29
	subt	$f21, $f18, $f18
	addt	$f18, $f29, $f18
	mult	$f18, $f10, $f18
	stt	$f18, -16($10)
	.loc 1 55
	ldt	$f30, -24($23)												   # 000055
	mult	$f19, $f30, $f19
	addt	$f14, $f19, $f19
	.loc 1 54
	mult	$f14, $f10, $f14											   # 000054
	.loc 1 55
	mult	$f19, $f10, $f10											   # 000055
	.loc 1 54
	stt	$f14, -16($23)												   # 000054
	.loc 1 55
	stt	$f10, -16($11)												   # 000055
	.loc 1 46
	ldt	$f28, -8($0)												   # 000046
	.loc 1 52
	ldt	$f25, -8($2)												   # 000052
	ldt	$f26, -8($9)
	ldt	$f17, ($9)
	.loc 1 47
	addt	$f28, $f0, $f27												   # 000047
	.loc 1 48
	mult	$f28, $f28, $f1												   # 000048
	.loc 1 52
	mult	$f28, $f26, $f26											   # 000052
	addt	$f25, $f25, $f24
	.loc 1 49
	addt	$f27, $f27, $f16											   # 000049
	.loc 1 50
	mult	$f28, $f27, $f27											   # 000050
	.loc 1 52
	addt	$f24, $f26, $f24											   # 000052
	.loc 1 51
	addt	$f1, $f16, $f1												   # 000051
	.loc 1 53
	mult	$f16, $f25, $f25											   # 000053
	.loc 1 52
	mult	$f27, $f17, $f17											   # 000052
	.loc 1 51
	divt	$f0, $f1, $f1												   # 000051
	.loc 1 52
	addt	$f24, $f17, $f17											   # 000052
	mult	$f17, $f1, $f17
	.loc 1 54
	mult	$f27, $f1, $f11												   # 000054
	.loc 1 52
	stt	$f17, ($2)												   # 000052
	.loc 1 53
	ldt	$f15, ($9)												   # 000053
	ldt	$f13, -8($9)
	mult	$f28, $f15, $f15
	mult	$f27, $f13, $f13
	subt	$f25, $f15, $f15
	addt	$f15, $f13, $f13
	mult	$f13, $f1, $f13
	stt	$f13, -8($10)
	.loc 1 55
	ldt	$f12, -16($23)												   # 000055
	.loc 1 54
	stt	$f11, -8($23)												   # 000054
	.loc 1 55
	mult	$f16, $f12, $f12											   # 000055
	addt	$f27, $f12, $f12
	mult	$f12, $f1, $f1
	stt	$f1, -8($11)
	.loc 1 44
	bne	$12, L$165												   # 000044
	cmplt	$25, $27, $7
	beq	$7, L$160
	unop
L$167:
	.loc 1 46
	ldt	$f22, ($0)												   # 000046
	.loc 1 52
	ldt	$f19, ($2)												   # 000052
	ldt	$f14, ($9)
	ldt	$f28, 8($9)
	.loc 1 44
	addl	$25, 1, $25												   # 000044
	lda	$0, 8($0)
	cmplt	$25, $27, $12
	.loc 1 53
	lda	$2, 8($2)												   # 000053
	.loc 1 47
	addt	$f22, $f0, $f29												   # 000047
	.loc 1 48
	mult	$f22, $f22, $f30											   # 000048
	.loc 1 53
	lda	$9, 8($9)												   # 000053
	.loc 1 55
	lda	$10, 8($10)												   # 000055
	.loc 1 52
	mult	$f22, $f14, $f14											   # 000052
	addt	$f19, $f19, $f10
	.loc 1 55
	lda	$23, 8($23)												   # 000055
	.loc 1 44
	lda	$11, 8($11)												   # 000044
	.loc 1 49
	addt	$f29, $f29, $f18											   # 000049
	.loc 1 50
	mult	$f22, $f29, $f29											   # 000050
	.loc 1 52
	addt	$f10, $f14, $f10											   # 000052
	.loc 1 51
	addt	$f30, $f18, $f30											   # 000051
	.loc 1 52
	mult	$f29, $f28, $f28											   # 000052
	.loc 1 53
	mult	$f18, $f19, $f19											   # 000053
	.loc 1 51
	divt	$f0, $f30, $f30												   # 000051
	.loc 1 52
	addt	$f10, $f28, $f10											   # 000052
	mult	$f10, $f30, $f10
	.loc 1 54
	mult	$f29, $f30, $f23											   # 000054
	.loc 1 52
	stt	$f10, ($2)												   # 000052
	.loc 1 53
	ldt	$f26, ($9)												   # 000053
	ldt	$f24, -8($9)
	mult	$f22, $f26, $f21
	mult	$f29, $f24, $f24
	subt	$f19, $f21, $f19
	addt	$f19, $f24, $f19
	mult	$f19, $f30, $f19
	stt	$f19, -8($10)
	.loc 1 55
	ldt	$f17, -16($23)												   # 000055
	.loc 1 54
	stt	$f23, -8($23)												   # 000054
	.loc 1 55
	mult	$f18, $f17, $f17											   # 000055
	addt	$f29, $f17, $f17
	mult	$f17, $f30, $f17
	stt	$f17, -8($11)
	.loc 1 44
	bne	$12, L$167												   # 000044
	.loc 1 56
 #     56             }
L$160:															   # 000056
	.loc 1 58
 #     57 
 #     58             for(id=1;id<nd-1;id++)
	cmple	$27, 1, $7												   # 000058
	bne	$7, L$168
	subl	$21, 4, $25
	mov	1, $0
	cmple	$25, $27, $14
	.loc 1 61
 #     59             {
 #     60              dtt=1.0/(dtaum[id-1]+dtaum[id]);
 #     61              riin[id]=(rim[id]*dtaum[id]+rip[id]*dtaum[id-1])*dtt;
	lda	$2, 8($1)												   # 000061
	lda	$9, 8($20)
	lda	$10, 8($6)
	.loc 1 62
 #     62              aiin[id]=(aim[id]*dtaum[id]+aip[id]*dtaum[id-1])*dtt;
	lda	$11, 8($8)												   # 000062
	lda	$12, 8($4)
	lda	$23, 8($3)
	.loc 1 58
	stq	$14, 56($sp)												   # 000058
	.loc 1 60
	mov	$16, $13												   # 000060
	.loc 1 58
	beq	$14, L$170												   # 000058
	cmple	$25, 1, $14
	xor	$14, 1, $14
L$170:
	.loc 1 60
	ldq	$28, ($gp)												   # 000060
	lds	$f25, ($28)
	.loc 1 58
	beq	$14, L$175												   # 000058
L$173:
	.loc 1 60
	ldt	$f15, ($13)												   # 000060
	ldt	$f13, 8($13)
	.loc 1 61
	ldt	$f27, ($2)												   # 000061
	ldt	$f11, ($9)
	.loc 1 58
	addl	$0, 4, $0												   # 000058
	cmplt	$0, $25, $14
	.loc 1 61
	lda	$2, 32($2)												   # 000061
	.loc 1 60
	addt	$f15, $f13, $f16											   # 000060
	lda	$9, 32($9)
	.loc 1 62
	lda	$10, 32($10)												   # 000062
	.loc 1 61
	mult	$f27, $f13, $f13											   # 000061
	mult	$f11, $f15, $f11
	.loc 1 62
	lda	$11, 32($11)												   # 000062
	lda	$12, 32($12)
	lda	$13, 32($13)
	.loc 1 60
	divt	$f25, $f16, $f16											   # 000060
	.loc 1 58
	lda	$23, 32($23)												   # 000058
	.loc 1 61
	addt	$f13, $f11, $f11											   # 000061
	mult	$f11, $f16, $f11
	stt	$f11, -32($10)
	.loc 1 62
	ldt	$f12, -32($11)												   # 000062
	ldt	$f1, -24($13)
	ldt	$f22, -32($12)
	ldt	$f14, -32($13)
	mult	$f12, $f1, $f1
	mult	$f22, $f14, $f14
	addt	$f1, $f14, $f1
	mult	$f1, $f16, $f1
	stt	$f1, -32($23)
	.loc 1 60
	ldt	$f28, -24($13)												   # 000060
	ldt	$f10, -16($13)
	.loc 1 61
	ldt	$f21, -24($2)												   # 000061
	ldt	$f24, -24($9)
	.loc 1 60
	addt	$f28, $f10, $f26											   # 000060
	.loc 1 61
	mult	$f21, $f10, $f10											   # 000061
	mult	$f24, $f28, $f24
	.loc 1 60
	divt	$f25, $f26, $f26											   # 000060
	.loc 1 61
	addt	$f10, $f24, $f10											   # 000061
	mult	$f10, $f26, $f10
	stt	$f10, -24($10)
	.loc 1 62
	ldt	$f19, -24($11)												   # 000062
	ldt	$f18, -16($13)
	ldt	$f29, -24($12)
	ldt	$f23, -24($13)
	mult	$f19, $f18, $f18
	mult	$f29, $f23, $f23
	addt	$f18, $f23, $f18
	mult	$f18, $f26, $f18
	stt	$f18, -24($23)
	.loc 1 60
	ldt	$f30, -16($13)												   # 000060
	ldt	$f17, -8($13)
	.loc 1 61
	ldt	$f27, -16($2)												   # 000061
	ldt	$f15, -16($9)
	.loc 1 60
	addt	$f30, $f17, $f0												   # 000060
	.loc 1 61
	mult	$f27, $f17, $f17											   # 000061
	mult	$f15, $f30, $f15
	.loc 1 60
	divt	$f25, $f0, $f0												   # 000060
	.loc 1 61
	addt	$f17, $f15, $f15											   # 000061
	mult	$f15, $f0, $f15
	stt	$f15, -16($10)
	.loc 1 62
	ldt	$f13, -16($11)												   # 000062
	ldt	$f11, -8($13)
	ldt	$f12, -16($12)
	ldt	$f22, -16($13)
	mult	$f13, $f11, $f11
	mult	$f12, $f22, $f12
	addt	$f11, $f12, $f11
	mult	$f11, $f0, $f0
	stt	$f0, -16($23)
	.loc 1 60
	ldt	$f14, -8($13)												   # 000060
	ldt	$f16, ($13)
	.loc 1 61
	ldt	$f21, -8($2)												   # 000061
	ldt	$f28, -8($9)
	.loc 1 60
	addt	$f14, $f16, $f1												   # 000060
	.loc 1 61
	mult	$f21, $f16, $f16											   # 000061
	mult	$f28, $f14, $f14
	.loc 1 60
	divt	$f25, $f1, $f1												   # 000060
	.loc 1 61
	addt	$f16, $f14, $f14											   # 000061
	mult	$f14, $f1, $f14
	stt	$f14, -8($10)
	.loc 1 62
	ldt	$f24, -8($11)												   # 000062
	ldt	$f10, ($13)
	ldt	$f19, -8($12)
	ldt	$f29, -8($13)
	mult	$f24, $f10, $f10
	mult	$f19, $f29, $f19
	addt	$f10, $f19, $f10
	mult	$f10, $f1, $f1
	stt	$f1, -8($23)
	.loc 1 58
	bne	$14, L$173												   # 000058
	cmplt	$0, $27, $14
	beq	$14, L$168
L$175:
	.loc 1 60
	ldt	$f23, ($13)												   # 000060
	ldt	$f26, 8($13)
	.loc 1 61
	ldt	$f27, ($2)												   # 000061
	ldt	$f30, ($9)
	.loc 1 58
	addl	$0, 1, $0												   # 000058
	lda	$2, 8($2)
	lda	$9, 8($9)
	.loc 1 60
	addt	$f23, $f26, $f18											   # 000060
	.loc 1 58
	cmplt	$0, $27, $25												   # 000058
	.loc 1 62
	lda	$10, 8($10)												   # 000062
	.loc 1 61
	mult	$f27, $f26, $f26											   # 000061
	mult	$f30, $f23, $f23
	.loc 1 62
	lda	$11, 8($11)												   # 000062
	lda	$12, 8($12)
	lda	$13, 8($13)
	.loc 1 60
	divt	$f25, $f18, $f18											   # 000060
	.loc 1 58
	lda	$23, 8($23)												   # 000058
	.loc 1 61
	addt	$f26, $f23, $f23											   # 000061
	mult	$f23, $f18, $f23
	stt	$f23, -8($10)
	.loc 1 62
	ldt	$f17, -8($11)												   # 000062
	ldt	$f15, ($13)
	ldt	$f13, -8($12)
	ldt	$f22, -8($13)
	mult	$f17, $f15, $f15
	mult	$f13, $f22, $f13
	addt	$f15, $f13, $f13
	mult	$f13, $f18, $f13
	stt	$f13, -8($23)
	.loc 1 58
	bne	$25, L$175												   # 000058
	.loc 1 63
 #     63             }
L$168:															   # 000063
	.loc 1 65
 #     64 
 #     65             riin[0]=rim[0];
	ldt	$f12, ($1)												   # 000065
	.loc 1 66
 #     66             riin[nd-1]=rim[nd-1];
	s8addq	$21, $6, $9												   # 000066
	.loc 1 68
 #     67             aiin[0]=aim[0];
 #     68             aiin[nd-1]=aim[nd-1];
	s8addq	$21, $8, $11												   # 000068
	.loc 1 65
	stt	$f12, ($6)												   # 000065
	.loc 1 81
 #     69 
 #     70 /*               
 #     71  *           outgoing intensity 
 #     72  *   
 #     73  *           lower boundary condition 
 #     74  */
 #     75             rim[nd-1]=fincd;
 #     76 
 #     77 /*
 #     78  *           recurrence relation to determine I^+ and I^-
 #     79  *
 #     80  */
 #     81             for(id=nd-2;id>=0;id--)
	subl	$21, 2, $23												   # 000081
	.loc 1 66
	ldt	$f11, -8($5)												   # 000066
	.loc 1 68
	s8addq	$21, $3, $25												   # 000068
	.loc 1 89
 #     82             {
 #     83              dt0=dtaum[id];
 #     84              dtaup1=dt0+1.0;
 #     85              dtau2=dt0*dt0;
 #     86              cc=2.0*dtaup1;
 #     87              bb=dt0*dtaup1;
 #     88              aa=1.0/(dtau2+cc);
 #     89              rim[id  ]=(2.*rim[id+1]+dt0*sm[id+1]+bb*sm[id  ])*aa;
	s8addq	$23, $17, $17												   # 000089
	.loc 1 92
 #     90              rip[id+1]=(cc*rim[id+1]-dt0*sm[id  ]+bb*sm[id+1])*aa;
 #     91              aim[id  ]=bb*aa;
 #     92              aip[id+1]=(bb+cc*aim[id+1])*aa;
	s8addq	$23, $4, $13												   # 000092
	.loc 1 66
	stt	$f11, -8($9)												   # 000066
	.loc 1 89
	s8addq	$23, $1, $9												   # 000089
	.loc 1 67
	ldt	$f0, ($8)												   # 000067
	.loc 1 84
	ldq	$28, ($gp)												   # 000084
	.loc 1 83
	s8addq	$23, $16, $0												   # 000083
	.loc 1 89
	lda	$9, 8($9)												   # 000089
	.loc 1 67
	stt	$f0, ($3)												   # 000067
	.loc 1 91
	s8addq	$23, $8, $12												   # 000091
	.loc 1 68
	ldt	$f21, -8($11)												   # 000068
	.loc 1 84
	lds	$f28, ($28)												   # 000084
	.loc 1 89
	lda	$17, 8($17)												   # 000089
	.loc 1 92
	lda	$13, 8($13)												   # 000092
	.loc 1 68
	stt	$f21, -8($25)												   # 000068
	.loc 1 90
	s8addq	$23, $20, $25												   # 000090
	.loc 1 75
	stt	$f20, -8($5)												   # 000075
	.loc 1 81
	blt	$23, L$176												   # 000081
	cmplt	$23, 3, $10
	.loc 1 90
	lda	$25, 8($25)												   # 000090
	.loc 1 81
	bne	$10, L$182												   # 000081
	unop
L$180:
	.loc 1 83
	ldt	$f16, ($0)												   # 000083
	.loc 1 89
	ldt	$f10, ($9)												   # 000089
	ldt	$f1, ($17)
	ldt	$f30, -8($17)
	.loc 1 81
	subl	$23, 4, $23												   # 000081
	.loc 1 89
	lda	$0, -32($0)												   # 000089
	.loc 1 81
	cmplt	$23, 3, $10												   # 000081
	.loc 1 90
	lda	$9, -32($9)												   # 000090
	.loc 1 84
	addt	$f16, $f28, $f24											   # 000084
	.loc 1 85
	mult	$f16, $f16, $f19											   # 000085
	.loc 1 90
	lda	$17, -32($17)												   # 000090
	.loc 1 92
	lda	$25, -32($25)												   # 000092
	.loc 1 89
	mult	$f16, $f1, $f1												   # 000089
	addt	$f10, $f10, $f27
	.loc 1 92
	lda	$12, -32($12)												   # 000092
	.loc 1 81
	lda	$13, -32($13)												   # 000081
	.loc 1 86
	addt	$f24, $f24, $f29											   # 000086
	.loc 1 87
	mult	$f16, $f24, $f24											   # 000087
	.loc 1 89
	addt	$f27, $f1, $f1												   # 000089
	.loc 1 88
	addt	$f19, $f29, $f19											   # 000088
	.loc 1 89
	mult	$f24, $f30, $f30											   # 000089
	.loc 1 90
	mult	$f29, $f10, $f10											   # 000090
	.loc 1 88
	divt	$f28, $f19, $f19											   # 000088
	.loc 1 89
	addt	$f1, $f30, $f1												   # 000089
	mult	$f1, $f19, $f1
	stt	$f1, 24($9)
	.loc 1 90
	ldt	$f26, 24($17)												   # 000090
	ldt	$f23, 32($17)
	mult	$f16, $f26, $f14
	mult	$f24, $f23, $f23
	subt	$f10, $f14, $f10
	addt	$f10, $f23, $f10
	mult	$f10, $f19, $f10
	stt	$f10, 32($25)
	.loc 1 92
	ldt	$f17, 40($12)												   # 000092
	mult	$f29, $f17, $f17
	addt	$f24, $f17, $f17
	.loc 1 91
	mult	$f24, $f19, $f24											   # 000091
	.loc 1 92
	mult	$f17, $f19, $f17											   # 000092
	.loc 1 91
	stt	$f24, 32($12)												   # 000091
	.loc 1 92
	stt	$f17, 32($13)												   # 000092
	.loc 1 83
	ldt	$f22, 24($0)												   # 000083
	.loc 1 89
	ldt	$f12, 24($9)												   # 000089
	ldt	$f11, 24($17)
	ldt	$f21, 16($17)
	.loc 1 84
	addt	$f22, $f28, $f18											   # 000084
	.loc 1 85
	mult	$f22, $f22, $f25											   # 000085
	.loc 1 89
	addt	$f12, $f12, $f0												   # 000089
	mult	$f22, $f11, $f11
	.loc 1 86
	addt	$f18, $f18, $f13											   # 000086
	.loc 1 87
	mult	$f22, $f18, $f18											   # 000087
	.loc 1 89
	addt	$f0, $f11, $f0												   # 000089
	.loc 1 88
	addt	$f25, $f13, $f25											   # 000088
	.loc 1 90
	mult	$f13, $f12, $f12											   # 000090
	.loc 1 89
	mult	$f18, $f21, $f21											   # 000089
	.loc 1 88
	divt	$f28, $f25, $f25											   # 000088
	.loc 1 89
	addt	$f0, $f21, $f0												   # 000089
	mult	$f0, $f25, $f0
	stt	$f0, 16($9)
	.loc 1 90
	ldt	$f20, 16($17)												   # 000090
	ldt	$f16, 24($17)
	mult	$f22, $f20, $f15
	mult	$f18, $f16, $f16
	subt	$f12, $f15, $f12
	addt	$f12, $f16, $f12
	mult	$f12, $f25, $f12
	stt	$f12, 24($25)
	.loc 1 92
	ldt	$f27, 32($12)												   # 000092
	mult	$f13, $f27, $f13
	addt	$f18, $f13, $f13
	.loc 1 91
	mult	$f18, $f25, $f18											   # 000091
	.loc 1 92
	mult	$f13, $f25, $f13											   # 000092
	.loc 1 91
	stt	$f18, 24($12)												   # 000091
	.loc 1 92
	stt	$f13, 24($13)												   # 000092
	.loc 1 83
	ldt	$f30, 16($0)												   # 000083
	.loc 1 89
	ldt	$f10, 16($9)												   # 000089
	ldt	$f29, 16($17)
	ldt	$f24, 8($17)
	.loc 1 84
	addt	$f30, $f28, $f26											   # 000084
	.loc 1 85
	mult	$f30, $f30, $f23											   # 000085
	.loc 1 89
	addt	$f10, $f10, $f19											   # 000089
	mult	$f30, $f29, $f29
	.loc 1 86
	addt	$f26, $f26, $f14											   # 000086
	.loc 1 87
	mult	$f30, $f26, $f26											   # 000087
	.loc 1 89
	addt	$f19, $f29, $f19											   # 000089
	.loc 1 88
	addt	$f23, $f14, $f23											   # 000088
	.loc 1 89
	mult	$f26, $f24, $f24											   # 000089
	.loc 1 90
	mult	$f14, $f10, $f10											   # 000090
	.loc 1 88
	divt	$f28, $f23, $f23											   # 000088
	.loc 1 89
	addt	$f19, $f24, $f19											   # 000089
	mult	$f19, $f23, $f19
	stt	$f19, 8($9)
	.loc 1 90
	ldt	$f17, 8($17)												   # 000090
	ldt	$f22, 16($17)
	mult	$f30, $f17, $f1
	mult	$f26, $f22, $f22
	subt	$f10, $f1, $f1
	addt	$f1, $f22, $f1
	mult	$f1, $f23, $f1
	stt	$f1, 16($25)
	.loc 1 92
	ldt	$f11, 24($12)												   # 000092
	mult	$f14, $f11, $f11
	addt	$f26, $f11, $f11
	.loc 1 91
	mult	$f26, $f23, $f26											   # 000091
	.loc 1 92
	mult	$f11, $f23, $f11											   # 000092
	.loc 1 91
	stt	$f26, 16($12)												   # 000091
	.loc 1 92
	stt	$f11, 16($13)												   # 000092
	.loc 1 83
	ldt	$f21, 8($0)												   # 000083
	.loc 1 89
	ldt	$f12, 8($9)												   # 000089
	ldt	$f27, 8($17)
	ldt	$f18, ($17)
	.loc 1 84
	addt	$f21, $f28, $f20											   # 000084
	.loc 1 85
	mult	$f21, $f21, $f16											   # 000085
	.loc 1 89
	mult	$f21, $f27, $f27											   # 000089
	addt	$f12, $f12, $f25
	.loc 1 86
	addt	$f20, $f20, $f15											   # 000086
	.loc 1 87
	mult	$f21, $f20, $f20											   # 000087
	.loc 1 89
	addt	$f25, $f27, $f25											   # 000089
	.loc 1 88
	addt	$f16, $f15, $f16											   # 000088
	.loc 1 90
	mult	$f15, $f12, $f12											   # 000090
	.loc 1 89
	mult	$f20, $f18, $f18											   # 000089
	.loc 1 88
	divt	$f28, $f16, $f16											   # 000088
	.loc 1 89
	addt	$f25, $f18, $f18											   # 000089
	mult	$f18, $f16, $f18
	.loc 1 91
	mult	$f20, $f16, $f24											   # 000091
	.loc 1 89
	stt	$f18, ($9)												   # 000089
	.loc 1 90
	ldt	$f13, ($17)												   # 000090
	ldt	$f30, 8($17)
	mult	$f21, $f13, $f0
	mult	$f20, $f30, $f30
	subt	$f12, $f0, $f0
	addt	$f0, $f30, $f0
	mult	$f0, $f16, $f0
	stt	$f0, 8($25)
	.loc 1 92
	ldt	$f29, 16($12)												   # 000092
	.loc 1 91
	stt	$f24, 8($12)												   # 000091
	.loc 1 92
	mult	$f15, $f29, $f15											   # 000092
	addt	$f20, $f15, $f15
	mult	$f15, $f16, $f15
	stt	$f15, 8($13)
	.loc 1 81
	beq	$10, L$180												   # 000081
	blt	$23, L$176
L$182:
	.loc 1 83
	ldt	$f19, ($0)												   # 000083
	.loc 1 89
	ldt	$f14, ($9)												   # 000089
	ldt	$f23, ($17)
	ldt	$f11, -8($17)
	.loc 1 81
	subl	$23, 1, $23												   # 000081
	lda	$0, -8($0)
	.loc 1 90
	lda	$9, -8($9)												   # 000090
	lda	$17, -8($17)
	.loc 1 84
	addt	$f19, $f28, $f10											   # 000084
	.loc 1 85
	mult	$f19, $f19, $f1												   # 000085
	.loc 1 89
	mult	$f19, $f23, $f23											   # 000089
	addt	$f14, $f14, $f26
	.loc 1 92
	lda	$25, -8($25)												   # 000092
	lda	$12, -8($12)
	.loc 1 81
	lda	$13, -8($13)												   # 000081
	.loc 1 86
	addt	$f10, $f10, $f22											   # 000086
	.loc 1 87
	mult	$f19, $f10, $f10											   # 000087
	.loc 1 89
	addt	$f26, $f23, $f23											   # 000089
	.loc 1 88
	addt	$f1, $f22, $f1												   # 000088
	.loc 1 89
	mult	$f10, $f11, $f11											   # 000089
	.loc 1 90
	mult	$f22, $f14, $f14											   # 000090
	.loc 1 88
	divt	$f28, $f1, $f1												   # 000088
	.loc 1 89
	addt	$f23, $f11, $f11											   # 000089
	mult	$f11, $f1, $f11
	.loc 1 91
	mult	$f10, $f1, $f18												   # 000091
	.loc 1 89
	stt	$f11, ($9)												   # 000089
	.loc 1 90
	ldt	$f21, ($17)												   # 000090
	ldt	$f27, 8($17)
	mult	$f19, $f21, $f17
	mult	$f10, $f27, $f27
	subt	$f14, $f17, $f14
	addt	$f14, $f27, $f14
	mult	$f14, $f1, $f14
	stt	$f14, 8($25)
	.loc 1 92
	ldt	$f25, 16($12)												   # 000092
	.loc 1 91
	stt	$f18, 8($12)												   # 000091
	.loc 1 92
	mult	$f22, $f25, $f22											   # 000092
	addt	$f10, $f22, $f10
	mult	$f10, $f1, $f1
	stt	$f1, 8($13)
	.loc 1 81
	bge	$23, L$182												   # 000081
	.loc 1 93
 #     93             }
L$176:															   # 000093
	.loc 1 95
 #     94 
 #     95             for(id=1;id<nd-1;id++)
	bne	$7, L$183												   # 000095
	subl	$21, 4, $12
	mov	1, $2
	.loc 1 98
 #     96             {
 #     97              dtt=1.0/(dtaum[id-1]+dtaum[id]);
 #     98              riup[id]=(rim[id]*dtaum[id-1]+rip[id]*dtaum[id])*dtt;
	lda	$10, 8($1)												   # 000098
	lda	$20, 8($20)
	lda	$14, 8($22)
	.loc 1 99
 #     99              aiup[id]=(aim[id]*dtaum[id-1]+aip[id]*dtaum[id])*dtt;
	lda	$0, 8($8)												   # 000099
	lda	$9, 8($24)
	lda	$4, 8($4)
	.loc 1 95
	cmple	$12, $27, $13												   # 000095
	beq	$13, L$185
	cmple	$12, 1, $17
	xor	$17, 1, $13
L$185:
	.loc 1 97
	ldq	$28, ($gp)												   # 000097
	lds	$f13, ($28)
	.loc 1 95
	beq	$13, L$190												   # 000095
	unop
L$188:
	.loc 1 97
	ldt	$f12, ($16)												   # 000097
	ldt	$f30, 8($16)
	.loc 1 98
	ldt	$f29, ($10)												   # 000098
	ldt	$f20, ($20)
	.loc 1 95
	addl	$2, 4, $2												   # 000095
	.loc 1 98
	lda	$10, 32($10)												   # 000098
	.loc 1 95
	cmplt	$2, $12, $13												   # 000095
	.loc 1 97
	lda	$20, 32($20)												   # 000097
	addt	$f12, $f30, $f0
	.loc 1 99
	lda	$14, 32($14)												   # 000099
	lda	$0, 32($0)
	.loc 1 98
	mult	$f29, $f12, $f12											   # 000098
	mult	$f20, $f30, $f20
	.loc 1 99
	lda	$4, 32($4)												   # 000099
	lda	$16, 32($16)
	.loc 1 95
	lda	$9, 32($9)												   # 000095
	.loc 1 97
	divt	$f13, $f0, $f0												   # 000097
	.loc 1 95
	cmplt	$2, $27, $7												   # 000095
	.loc 1 98
	addt	$f12, $f20, $f12											   # 000098
	mult	$f12, $f0, $f12
	stt	$f12, -32($14)
	.loc 1 99
	ldt	$f24, -32($0)												   # 000099
	ldt	$f16, -32($16)
	ldt	$f15, -32($4)
	ldt	$f19, -24($16)
	mult	$f24, $f16, $f16
	mult	$f15, $f19, $f15
	addt	$f16, $f15, $f15
	mult	$f15, $f0, $f0
	stt	$f0, -32($9)
	.loc 1 97
	ldt	$f26, -24($16)												   # 000097
	ldt	$f23, -16($16)
	.loc 1 98
	ldt	$f21, -24($10)												   # 000098
	ldt	$f17, -24($20)
	.loc 1 97
	addt	$f26, $f23, $f11											   # 000097
	.loc 1 98
	mult	$f21, $f26, $f21											   # 000098
	mult	$f17, $f23, $f17
	.loc 1 97
	divt	$f13, $f11, $f11											   # 000097
	.loc 1 98
	addt	$f21, $f17, $f17											   # 000098
	mult	$f17, $f11, $f17
	stt	$f17, -24($14)
	.loc 1 99
	ldt	$f27, -24($0)												   # 000099
	ldt	$f14, -24($16)
	ldt	$f25, -24($4)
	ldt	$f22, -16($16)
	mult	$f27, $f14, $f14
	mult	$f25, $f22, $f22
	addt	$f14, $f22, $f14
	mult	$f14, $f11, $f11
	stt	$f11, -24($9)
	.loc 1 97
	ldt	$f18, -16($16)												   # 000097
	ldt	$f10, -8($16)
	.loc 1 98
	ldt	$f28, -16($10)												   # 000098
	ldt	$f29, -16($20)
	.loc 1 97
	addt	$f18, $f10, $f1												   # 000097
	.loc 1 98
	mult	$f28, $f18, $f18											   # 000098
	mult	$f29, $f10, $f10
	.loc 1 97
	divt	$f13, $f1, $f1												   # 000097
	.loc 1 98
	addt	$f18, $f10, $f10											   # 000098
	mult	$f10, $f1, $f10
	stt	$f10, -16($14)
	.loc 1 99
	ldt	$f30, -16($0)												   # 000099
	ldt	$f20, -16($16)
	ldt	$f12, -16($4)
	ldt	$f24, -8($16)
	mult	$f30, $f20, $f20
	mult	$f12, $f24, $f12
	addt	$f20, $f12, $f12
	mult	$f12, $f1, $f1
	stt	$f1, -16($9)
	.loc 1 97
	ldt	$f19, -8($16)												   # 000097
	ldt	$f16, ($16)
	.loc 1 98
	ldt	$f0, -8($10)												   # 000098
	ldt	$f26, -8($20)
	.loc 1 97
	addt	$f19, $f16, $f15											   # 000097
	.loc 1 98
	mult	$f0, $f19, $f0												   # 000098
	mult	$f26, $f16, $f16
	.loc 1 97
	divt	$f13, $f15, $f15											   # 000097
	.loc 1 98
	addt	$f0, $f16, $f0												   # 000098
	mult	$f0, $f15, $f0
	stt	$f0, -8($14)
	.loc 1 99
	ldt	$f23, -8($0)												   # 000099
	ldt	$f21, -8($16)
	ldt	$f17, -8($4)
	ldt	$f27, ($16)
	mult	$f23, $f21, $f21
	mult	$f17, $f27, $f17
	addt	$f21, $f17, $f17
	mult	$f17, $f15, $f15
	stt	$f15, -8($9)
	.loc 1 95
	bne	$13, L$188												   # 000095
	beq	$7, L$183
L$190:
	.loc 1 97
	ldt	$f25, ($16)												   # 000097
	ldt	$f22, 8($16)
	.loc 1 98
	ldt	$f11, ($10)												   # 000098
	ldt	$f28, ($20)
	.loc 1 95
	addl	$2, 1, $2												   # 000095
	lda	$10, 8($10)
	cmplt	$2, $27, $25
	lda	$20, 8($20)
	.loc 1 97
	addt	$f25, $f22, $f14											   # 000097
	.loc 1 99
	lda	$14, 8($14)												   # 000099
	lda	$0, 8($0)
	.loc 1 98
	mult	$f11, $f25, $f11											   # 000098
	mult	$f28, $f22, $f22
	.loc 1 99
	lda	$4, 8($4)												   # 000099
	lda	$16, 8($16)
	.loc 1 95
	lda	$9, 8($9)												   # 000095
	.loc 1 97
	divt	$f13, $f14, $f14											   # 000097
	.loc 1 98
	addt	$f11, $f22, $f11											   # 000098
	mult	$f11, $f14, $f11
	stt	$f11, -8($14)
	.loc 1 99
	ldt	$f29, -8($0)												   # 000099
	ldt	$f18, -8($16)
	ldt	$f10, -8($4)
	ldt	$f30, ($16)
	mult	$f29, $f18, $f18
	mult	$f10, $f30, $f10
	addt	$f18, $f10, $f10
	mult	$f10, $f14, $f10
	stt	$f10, -8($9)
	.loc 1 95
	bne	$25, L$190												   # 000095
	.loc 1 100
 #    100             }
L$183:															   # 000100
	.loc 1 102
 #    101 
 #    102             riup[0]=rim[0];
	ldt	$f24, ($1)												   # 000102
	.loc 1 103
 #    103             riup[nd-1]=rim[nd-1];
	s8addq	$21, $22, $13												   # 000103
	.loc 1 105
 #    104             aiup[0]=aim[0];
 #    105             aiup[nd-1]=aim[nd-1];
	s8addq	$21, $24, $17												   # 000105
	.loc 1 109
 #    106 /*
 #    107  *           final symmetrized (Feautrier) intensity -- (riin+riup)/2
 #    108  */
 #    109             for(id=0;id<nd;id++)
	subl	$21, 3, $0												   # 000109
	.loc 1 102
	stt	$f24, ($22)												   # 000102
	.loc 1 109
	clr	$23													   # 000109
	.loc 1 103
	ldt	$f20, -8($5)												   # 000103
	stt	$f20, -8($13)
	.loc 1 104
	ldt	$f12, ($8)												   # 000104
	stt	$f12, ($24)
	.loc 1 105
	ldt	$f1, -8($11)												   # 000105
	stt	$f1, -8($17)
	.loc 1 109
	ble	$21, L$193												   # 000109
	cmple	$0, $21, $2
	beq	$2, L$195
	cmplt	$31, $0, $2
L$195:
	.loc 1 111
 #    110             {
 #    111              jm[id]   =(riin[id]+riup[id])/2;
	ldq	$28, ($gp)												   # 000111
	lds	$f19, 4($28)
	.loc 1 109
	beq	$2, L$200												   # 000109
L$198:
	.loc 1 111
	ldt	$f26, ($6)												   # 000111
	ldt	$f16, ($22)
	.loc 1 109
	addl	$23, 4, $23												   # 000109
	cmplt	$23, $0, $27
	.loc 1 111
	lda	$6, 32($6)												   # 000111
	lda	$22, 32($22)
	.loc 1 112
 #    112              diagm[id]=(aiin[id]+aiup[id])/2;
	lda	$18, 32($18)												   # 000112
	.loc 1 111
	addt	$f26, $f16, $f16											   # 000111
	.loc 1 112
	lda	$3, 32($3)												   # 000112
	lda	$24, 32($24)
	.loc 1 109
	lda	$19, 32($19)												   # 000109
	cmplt	$23, $21, $1
	.loc 1 111
	mult	$f16, $f19, $f16											   # 000111
	stt	$f16, -32($18)
	.loc 1 112
	ldt	$f0, -32($3)												   # 000112
	ldt	$f23, -32($24)
	addt	$f0, $f23, $f0
	mult	$f0, $f19, $f0
	stt	$f0, -32($19)
	.loc 1 111
	ldt	$f27, -24($6)												   # 000111
	ldt	$f21, -24($22)
	addt	$f27, $f21, $f21
	mult	$f21, $f19, $f21
	stt	$f21, -24($18)
	.loc 1 112
	ldt	$f17, -24($3)												   # 000112
	ldt	$f15, -24($24)
	addt	$f17, $f15, $f15
	mult	$f15, $f19, $f15
	stt	$f15, -24($19)
	.loc 1 111
	ldt	$f25, -16($6)												   # 000111
	ldt	$f28, -16($22)
	addt	$f25, $f28, $f25
	mult	$f25, $f19, $f25
	stt	$f25, -16($18)
	.loc 1 112
	ldt	$f22, -16($3)												   # 000112
	ldt	$f11, -16($24)
	addt	$f22, $f11, $f11
	mult	$f11, $f19, $f11
	stt	$f11, -16($19)
	.loc 1 111
	ldt	$f29, -8($6)												   # 000111
	ldt	$f30, -8($22)
	addt	$f29, $f30, $f29
	mult	$f29, $f19, $f29
	stt	$f29, -8($18)
	.loc 1 112
	ldt	$f18, -8($3)												   # 000112
	ldt	$f14, -8($24)
	addt	$f18, $f14, $f14
	mult	$f14, $f19, $f14
	stt	$f14, -8($19)
	.loc 1 109
	bne	$27, L$198												   # 000109
	beq	$1, L$193
L$200:
	.loc 1 111
	ldt	$f10, ($6)												   # 000111
	ldt	$f13, ($22)
	.loc 1 109
	addl	$23, 1, $23												   # 000109
	lda	$6, 8($6)
	cmplt	$23, $21, $17
	lda	$22, 8($22)
	.loc 1 112
	lda	$18, 8($18)												   # 000112
	lda	$3, 8($3)
	.loc 1 111
	addt	$f10, $f13, $f10											   # 000111
	.loc 1 112
	lda	$24, 8($24)												   # 000112
	.loc 1 109
	lda	$19, 8($19)												   # 000109
	.loc 1 111
	mult	$f10, $f19, $f10											   # 000111
	stt	$f10, -8($18)
	.loc 1 112
	ldt	$f24, -8($3)												   # 000112
	ldt	$f20, -8($24)
	addt	$f24, $f20, $f20
	mult	$f20, $f19, $f20
	stt	$f20, -8($19)
	.loc 1 109
	bne	$17, L$200												   # 000109
	unop
	.loc 1 113
 #    113             }
L$193:															   # 000113
	.loc 1 121
 #    114 
 #    115 #if 0
 #    116 /*c            dlam(nd)=dlam(nd-1)*/
 #    117             diagm[nd-1]=0.;
 #    118 #endif
 #    119 
 #    120  return 0;
 #    121 }
	ldq	$26, ($sp)												   # 000121
	ldq	$9, 8($sp)
	.loc 1 120
	clr	$0													   # 000120
	unop
	.loc 1 121
	ldq	$10, 16($sp)												   # 000121
	ldq	$11, 24($sp)
	ldq	$12, 32($sp)
	ldq	$13, 40($sp)
	ldq	$14, 48($sp)
	lda	$sp, 64($sp)
	ret	($26)
	.end 	dfe
	unop
	.loc 1 123
 #    122 
 #    123 double dfe_optlimb1(double *dtaum, double *sm, double *jm, 
	.globl  dfe_optlimb1
	.ent 	dfe_optlimb1
	.loc 1 123
dfe_optlimb1:														   # 000123
	ldah	$gp, ($27)
	unop
	lda	$gp, ($gp)
	unop
	.frame  $sp, 0, $26
	.prologue 1
L$122:
	.loc 1 125
 #    124 	            int nd,double *pool)
 #    125 {
	sextl	$19, $19												   # 000125
	.loc 1 146
 #    126 /*
 #    127  *     formal solution of the radiative transfer
 #    128  *     equation by the Discontinuous Finite Element method
 #    129  *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 #    130  */
 #    131 
 #    132  int	id;
 #    133  double	*rim, *rip, *riin, *riup;
 #    134  register double aa, bb, cc, dt0, dtaup1, dtau2, dtt;
 #    135  
 #    136 	rim=(double *) (pool);
 #    137 	rip=(double *) (pool+nd);
 #    138 	riin=(double *) (pool+2*nd);
 #    139 	riup=(double *) (pool+3*nd);
 #    140 
 #    141 /*            incoming intensity    
 #    142  *          
 #    143  *            upper boundary condition 
 #    144  */ 
 #    145    
 #    146             rim[0]=0.0;
	stt	$f31, ($20)												   # 000146
	.loc 1 138
	addq	$19, $19, $2												   # 000138
	.loc 1 139
	s4subq	$19, $19, $6												   # 000139
	.loc 1 152
 #    147 /*
 #    148  *           recurrence relation to determine I^+ and I^- 
 #    149  *           (which are called RIP and RIM),
 #    150  */
 #    151 
 #    152             for(id=0;id<nd-1;id++)
	subl	$19, 1, $7												   # 000152
	.loc 1 137
	s8addq	$19, $20, $1												   # 000137
	s8addq	$19, $20, $4
	.loc 1 138
	s8addq	$2, $20, $2												   # 000138
	.loc 1 139
	s8addq	$6, $20, $6												   # 000139
	.loc 1 152
	ble	$7, L$125												   # 000152
	subl	$19, 4, $18
	clr	$5
	.loc 1 154
 #    153             {
 #    154              dt0=dtaum[id];
	mov	$16, $8													   # 000154
	.loc 1 160
 #    155              dtaup1=dt0+1.0;
 #    156              dtau2=dt0*dt0;
 #    157              cc=2.0*dtaup1;
 #    158              bb=dt0*dtaup1;
 #    159              aa=1.0/(dtau2+cc);
 #    160              rim[id+1]=(2.*rim[id]+dt0*sm[id  ]+bb*sm[id+1])*aa;
	mov	$20, $21												   # 000160
	mov	$17, $22
	.loc 1 152
	cmple	$18, $7, $23												   # 000152
	.loc 1 161
 #    161              rip[id  ]=(cc*rim[id]-dt0*sm[id+1]+bb*sm[id  ])*aa;
	s8addq	$19, $20, $24												   # 000161
	.loc 1 152
	beq	$23, L$127												   # 000152
	cmplt	$31, $18, $23
L$127:
	.loc 1 155
	ldq	$28, ($gp)												   # 000155
	lds	$f0, ($28)
	.loc 1 152
	beq	$23, L$132												   # 000152
L$130:
	.loc 1 154
	ldt	$f1, ($8)												   # 000154
	.loc 1 160
	ldt	$f14, ($21)												   # 000160
	ldt	$f15, ($22)
	ldt	$f17, 8($22)
	.loc 1 152
	addl	$5, 4, $5												   # 000152
	.loc 1 160
	lda	$8, 32($8)												   # 000160
	.loc 1 152
	cmplt	$5, $18, $27												   # 000152
	.loc 1 161
	lda	$21, 32($21)												   # 000161
	.loc 1 155
	addt	$f1, $f0, $f11												   # 000155
	.loc 1 156
	mult	$f1, $f1, $f13												   # 000156
	.loc 1 160
	mult	$f1, $f15, $f15												   # 000160
	addt	$f14, $f14, $f16
	.loc 1 161
	lda	$22, 32($22)												   # 000161
	.loc 1 152
	lda	$24, 32($24)												   # 000152
	cmplt	$5, $7, $0
	.loc 1 157
	addt	$f11, $f11, $f12											   # 000157
	.loc 1 158
	mult	$f1, $f11, $f11												   # 000158
	.loc 1 160
	addt	$f16, $f15, $f15											   # 000160
	.loc 1 159
	addt	$f13, $f12, $f13											   # 000159
	.loc 1 160
	mult	$f11, $f17, $f17											   # 000160
	.loc 1 161
	mult	$f12, $f14, $f12											   # 000161
	.loc 1 159
	divt	$f0, $f13, $f13												   # 000159
	.loc 1 160
	addt	$f15, $f17, $f15											   # 000160
	mult	$f15, $f13, $f15
	stt	$f15, -24($21)
	.loc 1 161
	ldt	$f18, -24($22)												   # 000161
	ldt	$f19, -32($22)
	mult	$f1, $f18, $f10
	mult	$f11, $f19, $f11
	subt	$f12, $f10, $f10
	addt	$f10, $f11, $f10
	mult	$f10, $f13, $f10
	stt	$f10, -32($24)
	.loc 1 154
	ldt	$f20, -24($8)												   # 000154
	.loc 1 160
	ldt	$f25, -24($21)												   # 000160
	ldt	$f26, -24($22)
	ldt	$f28, -16($22)
	.loc 1 155
	addt	$f20, $f0, $f22												   # 000155
	.loc 1 156
	mult	$f20, $f20, $f24											   # 000156
	.loc 1 160
	mult	$f20, $f26, $f26											   # 000160
	addt	$f25, $f25, $f27
	.loc 1 157
	addt	$f22, $f22, $f23											   # 000157
	.loc 1 158
	mult	$f20, $f22, $f22											   # 000158
	.loc 1 160
	addt	$f27, $f26, $f26											   # 000160
	.loc 1 159
	addt	$f24, $f23, $f24											   # 000159
	.loc 1 161
	mult	$f23, $f25, $f23											   # 000161
	.loc 1 160
	mult	$f22, $f28, $f28											   # 000160
	.loc 1 159
	divt	$f0, $f24, $f24												   # 000159
	.loc 1 160
	addt	$f26, $f28, $f26											   # 000160
	mult	$f26, $f24, $f26
	stt	$f26, -16($21)
	.loc 1 161
	ldt	$f29, -16($22)												   # 000161
	ldt	$f30, -24($22)
	mult	$f20, $f29, $f21
	mult	$f22, $f30, $f22
	subt	$f23, $f21, $f21
	addt	$f21, $f22, $f21
	mult	$f21, $f24, $f21
	stt	$f21, -24($24)
	.loc 1 154
	ldt	$f1, -16($8)												   # 000154
	.loc 1 160
	ldt	$f18, -16($21)												   # 000160
	ldt	$f19, -16($22)
	ldt	$f11, -8($22)
	.loc 1 155
	addt	$f1, $f0, $f17												   # 000155
	.loc 1 156
	mult	$f1, $f1, $f14												   # 000156
	.loc 1 160
	addt	$f18, $f18, $f12											   # 000160
	mult	$f1, $f19, $f19
	.loc 1 157
	addt	$f17, $f17, $f15											   # 000157
	.loc 1 158
	mult	$f1, $f17, $f17												   # 000158
	.loc 1 160
	addt	$f12, $f19, $f12											   # 000160
	.loc 1 159
	addt	$f14, $f15, $f14											   # 000159
	.loc 1 161
	mult	$f15, $f18, $f15											   # 000161
	.loc 1 160
	mult	$f17, $f11, $f11											   # 000160
	.loc 1 159
	divt	$f0, $f14, $f14												   # 000159
	.loc 1 160
	addt	$f12, $f11, $f11											   # 000160
	mult	$f11, $f14, $f11
	stt	$f11, -8($21)
	.loc 1 161
	ldt	$f13, -8($22)												   # 000161
	ldt	$f10, -16($22)
	mult	$f1, $f13, $f13
	mult	$f17, $f10, $f10
	subt	$f15, $f13, $f13
	addt	$f13, $f10, $f10
	mult	$f10, $f14, $f10
	stt	$f10, -16($24)
	.loc 1 154
	ldt	$f20, -8($8)												   # 000154
	.loc 1 160
	ldt	$f29, -8($21)												   # 000160
	ldt	$f30, -8($22)
	ldt	$f22, ($22)
	.loc 1 155
	addt	$f20, $f0, $f28												   # 000155
	.loc 1 156
	mult	$f20, $f20, $f25											   # 000156
	.loc 1 160
	mult	$f20, $f30, $f30											   # 000160
	addt	$f29, $f29, $f23
	.loc 1 157
	addt	$f28, $f28, $f26											   # 000157
	.loc 1 158
	mult	$f20, $f28, $f28											   # 000158
	.loc 1 160
	addt	$f23, $f30, $f23											   # 000160
	.loc 1 159
	addt	$f25, $f26, $f25											   # 000159
	.loc 1 161
	mult	$f26, $f29, $f26											   # 000161
	.loc 1 160
	mult	$f28, $f22, $f22											   # 000160
	.loc 1 159
	divt	$f0, $f25, $f25												   # 000159
	.loc 1 160
	addt	$f23, $f22, $f22											   # 000160
	mult	$f22, $f25, $f22
	stt	$f22, ($21)
	.loc 1 161
	ldt	$f24, ($22)												   # 000161
	ldt	$f21, -8($22)
	mult	$f20, $f24, $f24
	mult	$f28, $f21, $f21
	subt	$f26, $f24, $f24
	addt	$f24, $f21, $f21
	mult	$f21, $f25, $f21
	stt	$f21, -8($24)
	.loc 1 152
	bne	$27, L$130												   # 000152
	beq	$0, L$125
	unop
L$132:
	.loc 1 154
	ldt	$f1, ($8)												   # 000154
	.loc 1 160
	ldt	$f16, ($21)												   # 000160
	ldt	$f17, ($22)
	ldt	$f13, 8($22)
	.loc 1 152
	addl	$5, 1, $5												   # 000152
	lda	$8, 8($8)
	cmplt	$5, $7, $0
	.loc 1 161
	lda	$21, 8($21)												   # 000161
	.loc 1 155
	addt	$f1, $f0, $f12												   # 000155
	.loc 1 156
	mult	$f1, $f1, $f18												   # 000156
	.loc 1 161
	lda	$22, 8($22)												   # 000161
	.loc 1 152
	lda	$24, 8($24)												   # 000152
	.loc 1 160
	mult	$f1, $f17, $f17												   # 000160
	addt	$f16, $f16, $f15
	.loc 1 157
	addt	$f12, $f12, $f11											   # 000157
	.loc 1 158
	mult	$f1, $f12, $f12												   # 000158
	.loc 1 160
	addt	$f15, $f17, $f15											   # 000160
	.loc 1 159
	addt	$f18, $f11, $f18											   # 000159
	.loc 1 160
	mult	$f12, $f13, $f13											   # 000160
	.loc 1 161
	mult	$f11, $f16, $f11											   # 000161
	.loc 1 159
	divt	$f0, $f18, $f18												   # 000159
	.loc 1 160
	addt	$f15, $f13, $f13											   # 000160
	mult	$f13, $f18, $f13
	stt	$f13, ($21)
	.loc 1 161
	ldt	$f14, ($22)												   # 000161
	ldt	$f10, -8($22)
	mult	$f1, $f14, $f14
	mult	$f12, $f10, $f10
	subt	$f11, $f14, $f11
	addt	$f11, $f10, $f10
	mult	$f10, $f18, $f10
	stt	$f10, -8($24)
	.loc 1 152
	bne	$0, L$132												   # 000152
	.loc 1 162
 #    162             }
L$125:															   # 000162
	.loc 1 164
 #    163 
 #    164             for(id=1;id<nd-1;id++)
	cmple	$7, 1, $25												   # 000164
	bne	$25, L$133
	subl	$19, 4, $5
	mov	1, $23
	.loc 1 167
 #    165             {
 #    166              dtt=1.0/(dtaum[id-1]+dtaum[id]);
 #    167              riin[id]=(rim[id]*dtaum[id]+rip[id]*dtaum[id-1])*dtt;
	lda	$18, 8($20)												   # 000167
	lda	$27, 8($4)
	lda	$0, 8($2)
	.loc 1 164
	cmple	$5, $7, $8												   # 000164
	.loc 1 166
	mov	$16, $21												   # 000166
	.loc 1 164
	beq	$8, L$135												   # 000164
	cmple	$5, 1, $22
	xor	$22, 1, $8
L$135:
	.loc 1 166
	ldq	$28, ($gp)												   # 000166
	lds	$f20, ($28)
	.loc 1 164
	beq	$8, L$140												   # 000164
L$138:
	.loc 1 166
	ldt	$f30, ($21)												   # 000166
	ldt	$f23, 8($21)
	.loc 1 167
	ldt	$f29, ($18)												   # 000167
	ldt	$f27, ($27)
	.loc 1 164
	addl	$23, 4, $23												   # 000164
	.loc 1 167
	lda	$21, 32($21)												   # 000167
	.loc 1 164
	cmplt	$23, $5, $22												   # 000164
	.loc 1 167
	lda	$18, 32($18)												   # 000167
	.loc 1 166
	addt	$f30, $f23, $f22											   # 000166
	lda	$27, 32($27)
	.loc 1 164
	lda	$0, 32($0)												   # 000164
	.loc 1 167
	mult	$f29, $f23, $f23											   # 000167
	mult	$f27, $f30, $f27
	.loc 1 164
	cmplt	$23, $7, $8												   # 000164
	.loc 1 166
	divt	$f20, $f22, $f22											   # 000166
	.loc 1 167
	addt	$f23, $f27, $f23											   # 000167
	mult	$f23, $f22, $f22
	stt	$f22, -32($0)
	.loc 1 166
	ldt	$f28, -24($21)												   # 000166
	ldt	$f26, -16($21)
	.loc 1 167
	ldt	$f25, -24($18)												   # 000167
	ldt	$f21, -24($27)
	.loc 1 166
	addt	$f28, $f26, $f24											   # 000166
	.loc 1 167
	mult	$f25, $f26, $f25											   # 000167
	mult	$f21, $f28, $f21
	.loc 1 166
	divt	$f20, $f24, $f24											   # 000166
	.loc 1 167
	addt	$f25, $f21, $f21											   # 000167
	mult	$f21, $f24, $f21
	stt	$f21, -24($0)
	.loc 1 166
	ldt	$f1, -16($21)												   # 000166
	ldt	$f17, -8($21)
	.loc 1 167
	ldt	$f13, -16($18)												   # 000167
	ldt	$f16, -16($27)
	.loc 1 166
	addt	$f1, $f17, $f15												   # 000166
	.loc 1 167
	mult	$f13, $f17, $f13											   # 000167
	mult	$f16, $f1, $f1
	.loc 1 166
	divt	$f20, $f15, $f15											   # 000166
	.loc 1 167
	addt	$f13, $f1, $f1												   # 000167
	mult	$f1, $f15, $f1
	stt	$f1, -16($0)
	.loc 1 166
	ldt	$f19, -8($21)												   # 000166
	ldt	$f12, ($21)
	.loc 1 167
	ldt	$f11, -8($18)												   # 000167
	ldt	$f18, -8($27)
	.loc 1 166
	addt	$f19, $f12, $f14											   # 000166
	.loc 1 167
	mult	$f11, $f12, $f11											   # 000167
	mult	$f18, $f19, $f18
	.loc 1 166
	divt	$f20, $f14, $f14											   # 000166
	.loc 1 167
	addt	$f11, $f18, $f11											   # 000167
	mult	$f11, $f14, $f11
	stt	$f11, -8($0)
	.loc 1 164
	bne	$22, L$138												   # 000164
	beq	$8, L$133
L$140:
	.loc 1 166
	ldt	$f10, ($21)												   # 000166
	ldt	$f0, 8($21)
	.loc 1 167
	ldt	$f30, ($18)												   # 000167
	ldt	$f27, ($27)
	.loc 1 164
	addl	$23, 1, $23												   # 000164
	lda	$18, 8($18)
	lda	$27, 8($27)
	.loc 1 166
	addt	$f10, $f0, $f29												   # 000166
	.loc 1 164
	cmplt	$23, $7, $8												   # 000164
	lda	$21, 8($21)
	.loc 1 167
	mult	$f30, $f0, $f0												   # 000167
	mult	$f27, $f10, $f10
	.loc 1 164
	lda	$0, 8($0)												   # 000164
	.loc 1 166
	divt	$f20, $f29, $f29											   # 000166
	.loc 1 167
	addt	$f0, $f10, $f0												   # 000167
	mult	$f0, $f29, $f0
	stt	$f0, -8($0)
	.loc 1 164
	bne	$8, L$140												   # 000164
	.loc 1 168
 #    168             }
L$133:															   # 000168
	.loc 1 170
 #    169 
 #    170             riin[0]=rim[0];
	ldt	$f23, ($20)												   # 000170
	.loc 1 184
 #    171             riin[nd-1]=rim[nd-1];
 #    172 
 #    173 /*
 #    174  *           outgoing intensity 
 #    175  *   
 #    176  *           symmetric boundary condition 
 #    177  */
 #    178             rim[nd-1]=riin[nd-1];
 #    179 
 #    180 /*
 #    181  *           recurrence relation to determine I^+ and I^-
 #    182  *
 #    183  */
 #    184             for(id=nd-2;id>=0;id--)
	subl	$19, 2, $22												   # 000184
	.loc 1 187
 #    185             {
 #    186              dt0=dtaum[id];
 #    187              dtaup1=dt0+1.0;
	ldq	$28, ($gp)												   # 000187
	.loc 1 170
	stt	$f23, ($2)												   # 000170
	.loc 1 171
	s8addq	$19, $2, $2												   # 000171
	ldt	$f22, -8($1)
	.loc 1 192
 #    188              dtau2=dt0*dt0;
 #    189              cc=2.0*dtaup1;
 #    190              bb=dt0*dtaup1;
 #    191              aa=1.0/(dtau2+cc);
 #    192              rim[id  ]=(2.*rim[id+1]+dt0*sm[id+1]+bb*sm[id  ])*aa;
	s8addq	$22, $20, $8												   # 000192
	s8addq	$22, $17, $17
	.loc 1 193
 #    193              rip[id+1]=(cc*rim[id+1]-dt0*sm[id  ]+bb*sm[id+1])*aa;
	s8addq	$22, $4, $18												   # 000193
	.loc 1 171
	stt	$f22, -8($2)												   # 000171
	.loc 1 186
	s8addq	$22, $16, $0												   # 000186
	.loc 1 178
	stt	$f22, -8($1)												   # 000178
	.loc 1 184
	blt	$22, L$141												   # 000184
	.loc 1 192
	lda	$8, 8($8)												   # 000192
	lda	$17, 8($17)
	.loc 1 184
	cmplt	$22, 3, $21												   # 000184
	.loc 1 193
	lda	$18, 8($18)												   # 000193
	.loc 1 187
	lds	$f26, ($28)												   # 000187
	.loc 1 184
	bne	$21, L$147												   # 000184
L$145:
	.loc 1 186
	ldt	$f28, ($0)												   # 000186
	.loc 1 192
	ldt	$f16, ($8)												   # 000192
	ldt	$f13, ($17)
	ldt	$f1, -8($17)
	.loc 1 184
	subl	$22, 4, $22												   # 000184
	.loc 1 192
	lda	$0, -32($0)												   # 000192
	.loc 1 184
	cmplt	$22, 3, $21												   # 000184
	.loc 1 193
	lda	$8, -32($8)												   # 000193
	.loc 1 187
	addt	$f28, $f26, $f24											   # 000187
	.loc 1 188
	mult	$f28, $f28, $f17											   # 000188
	.loc 1 192
	mult	$f28, $f13, $f13											   # 000192
	addt	$f16, $f16, $f15
	.loc 1 193
	lda	$17, -32($17)												   # 000193
	.loc 1 184
	lda	$18, -32($18)												   # 000184
	.loc 1 189
	addt	$f24, $f24, $f21											   # 000189
	.loc 1 190
	mult	$f28, $f24, $f24											   # 000190
	.loc 1 192
	addt	$f15, $f13, $f13											   # 000192
	.loc 1 191
	addt	$f17, $f21, $f17											   # 000191
	.loc 1 192
	mult	$f24, $f1, $f1												   # 000192
	.loc 1 193
	mult	$f21, $f16, $f16											   # 000193
	.loc 1 191
	divt	$f26, $f17, $f17											   # 000191
	.loc 1 192
	addt	$f13, $f1, $f1												   # 000192
	mult	$f1, $f17, $f1
	stt	$f1, 24($8)
	.loc 1 193
	ldt	$f12, 24($17)												   # 000193
	ldt	$f19, 32($17)
	mult	$f28, $f12, $f12
	mult	$f24, $f19, $f19
	subt	$f16, $f12, $f12
	addt	$f12, $f19, $f12
	mult	$f12, $f17, $f12
	stt	$f12, 32($18)
	.loc 1 186
	ldt	$f18, 24($0)												   # 000186
	.loc 1 192
	ldt	$f10, 24($8)												   # 000192
	ldt	$f29, 24($17)
	ldt	$f20, 16($17)
	.loc 1 187
	addt	$f18, $f26, $f11											   # 000187
	.loc 1 188
	mult	$f18, $f18, $f27											   # 000188
	.loc 1 192
	addt	$f10, $f10, $f0												   # 000192
	mult	$f18, $f29, $f29
	.loc 1 189
	addt	$f11, $f11, $f30											   # 000189
	.loc 1 190
	mult	$f18, $f11, $f11											   # 000190
	.loc 1 192
	addt	$f0, $f29, $f0												   # 000192
	.loc 1 191
	addt	$f27, $f30, $f27											   # 000191
	.loc 1 192
	mult	$f11, $f20, $f20											   # 000192
	.loc 1 193
	mult	$f30, $f10, $f10											   # 000193
	.loc 1 191
	divt	$f26, $f27, $f27											   # 000191
	.loc 1 192
	addt	$f0, $f20, $f0												   # 000192
	mult	$f0, $f27, $f0
	stt	$f0, 16($8)
	.loc 1 193
	ldt	$f23, 16($17)												   # 000193
	ldt	$f22, 24($17)
	mult	$f18, $f23, $f14
	mult	$f11, $f22, $f11
	subt	$f10, $f14, $f10
	addt	$f10, $f11, $f10
	mult	$f10, $f27, $f10
	stt	$f10, 24($18)
	.loc 1 186
	ldt	$f28, 16($0)												   # 000186
	.loc 1 192
	ldt	$f25, 16($8)												   # 000192
	ldt	$f24, 16($17)
	ldt	$f19, 8($17)
	.loc 1 187
	addt	$f28, $f26, $f13											   # 000187
	.loc 1 188
	mult	$f28, $f28, $f21											   # 000188
	.loc 1 192
	addt	$f25, $f25, $f16											   # 000192
	mult	$f28, $f24, $f24
	.loc 1 189
	addt	$f13, $f13, $f1												   # 000189
	.loc 1 190
	mult	$f28, $f13, $f13											   # 000190
	.loc 1 192
	addt	$f16, $f24, $f16											   # 000192
	.loc 1 191
	addt	$f21, $f1, $f21												   # 000191
	.loc 1 192
	mult	$f13, $f19, $f19											   # 000192
	.loc 1 193
	mult	$f1, $f25, $f1												   # 000193
	.loc 1 191
	divt	$f26, $f21, $f21											   # 000191
	.loc 1 192
	addt	$f16, $f19, $f16											   # 000192
	mult	$f16, $f21, $f16
	stt	$f16, 8($8)
	.loc 1 193
	ldt	$f17, 8($17)												   # 000193
	ldt	$f12, 16($17)
	mult	$f28, $f17, $f15
	mult	$f13, $f12, $f12
	subt	$f1, $f15, $f1
	addt	$f1, $f12, $f1
	mult	$f1, $f21, $f1
	stt	$f1, 16($18)
	.loc 1 186
	ldt	$f18, 8($0)												   # 000186
	.loc 1 192
	ldt	$f23, 8($8)												   # 000192
	ldt	$f22, 8($17)
	ldt	$f11, ($17)
	.loc 1 187
	addt	$f18, $f26, $f20											   # 000187
	.loc 1 188
	mult	$f18, $f18, $f30											   # 000188
	.loc 1 192
	addt	$f23, $f23, $f14											   # 000192
	mult	$f18, $f22, $f22
	.loc 1 189
	addt	$f20, $f20, $f0												   # 000189
	.loc 1 190
	mult	$f18, $f20, $f20											   # 000190
	.loc 1 192
	addt	$f14, $f22, $f14											   # 000192
	.loc 1 191
	addt	$f30, $f0, $f30												   # 000191
	.loc 1 192
	mult	$f20, $f11, $f11											   # 000192
	.loc 1 193
	mult	$f0, $f23, $f0												   # 000193
	.loc 1 191
	divt	$f26, $f30, $f30											   # 000191
	.loc 1 192
	addt	$f14, $f11, $f11											   # 000192
	mult	$f11, $f30, $f11
	stt	$f11, ($8)
	.loc 1 193
	ldt	$f27, ($17)												   # 000193
	ldt	$f10, 8($17)
	mult	$f18, $f27, $f27
	mult	$f20, $f10, $f10
	subt	$f0, $f27, $f0
	addt	$f0, $f10, $f0
	mult	$f0, $f30, $f0
	stt	$f0, 8($18)
	.loc 1 184
	beq	$21, L$145												   # 000184
	blt	$22, L$141
L$147:
	.loc 1 186
	ldt	$f28, ($0)												   # 000186
	.loc 1 192
	ldt	$f17, ($8)												   # 000192
	ldt	$f13, ($17)
	ldt	$f12, -8($17)
	.loc 1 184
	subl	$22, 1, $22												   # 000184
	lda	$0, -8($0)
	.loc 1 193
	lda	$8, -8($8)												   # 000193
	lda	$17, -8($17)
	.loc 1 187
	addt	$f28, $f26, $f19											   # 000187
	.loc 1 188
	mult	$f28, $f28, $f25											   # 000188
	.loc 1 192
	mult	$f28, $f13, $f13											   # 000192
	addt	$f17, $f17, $f15
	.loc 1 184
	lda	$18, -8($18)												   # 000184
	.loc 1 189
	addt	$f19, $f19, $f16											   # 000189
	.loc 1 190
	mult	$f28, $f19, $f19											   # 000190
	.loc 1 192
	addt	$f15, $f13, $f13											   # 000192
	.loc 1 191
	addt	$f25, $f16, $f25											   # 000191
	.loc 1 193
	mult	$f16, $f17, $f16											   # 000193
	.loc 1 192
	mult	$f19, $f12, $f12											   # 000192
	.loc 1 191
	divt	$f26, $f25, $f25											   # 000191
	.loc 1 192
	addt	$f13, $f12, $f12											   # 000192
	mult	$f12, $f25, $f12
	stt	$f12, ($8)
	.loc 1 193
	ldt	$f21, ($17)												   # 000193
	ldt	$f1, 8($17)
	mult	$f28, $f21, $f21
	mult	$f19, $f1, $f1
	subt	$f16, $f21, $f16
	addt	$f16, $f1, $f1
	mult	$f1, $f25, $f1
	stt	$f1, 8($18)
	.loc 1 184
	bge	$22, L$147												   # 000184
	.loc 1 194
 #    194             }
L$141:															   # 000194
	.loc 1 196
 #    195 
 #    196             for(id=1;id<nd-1;id++)
	bne	$25, L$148												   # 000196
	subl	$19, 4, $2
	mov	1, $21
	.loc 1 199
 #    197             {
 #    198              dtt=1.0/(dtaum[id-1]+dtaum[id]);
 #    199              riup[id]=(rim[id]*dtaum[id-1]+rip[id]*dtaum[id])*dtt;
	lda	$23, 8($20)												   # 000199
	lda	$27, 8($4)
	lda	$5, 8($6)
	.loc 1 196
	cmple	$2, $7, $0												   # 000196
	beq	$0, L$150
	cmple	$2, 1, $8
	xor	$8, 1, $0
L$150:
	.loc 1 198
	ldq	$28, ($gp)												   # 000198
	lds	$f18, ($28)
	.loc 1 196
	beq	$0, L$155												   # 000196
	unop
L$153:
	.loc 1 198
	ldt	$f22, ($16)												   # 000198
	ldt	$f14, 8($16)
	.loc 1 199
	ldt	$f23, ($23)												   # 000199
	ldt	$f29, ($27)
	.loc 1 196
	addl	$21, 4, $21												   # 000196
	.loc 1 199
	lda	$16, 32($16)												   # 000199
	.loc 1 196
	cmplt	$21, $2, $4												   # 000196
	.loc 1 199
	lda	$23, 32($23)												   # 000199
	.loc 1 198
	addt	$f22, $f14, $f11											   # 000198
	lda	$27, 32($27)
	.loc 1 196
	lda	$5, 32($5)												   # 000196
	.loc 1 199
	mult	$f23, $f22, $f22											   # 000199
	mult	$f29, $f14, $f14
	.loc 1 196
	cmplt	$21, $7, $8												   # 000196
	.loc 1 198
	divt	$f18, $f11, $f11											   # 000198
	.loc 1 199
	addt	$f22, $f14, $f14											   # 000199
	mult	$f14, $f11, $f11
	stt	$f11, -32($5)
	.loc 1 198
	ldt	$f20, -24($16)												   # 000198
	ldt	$f27, -16($16)
	.loc 1 199
	ldt	$f30, -24($23)												   # 000199
	ldt	$f0, -24($27)
	.loc 1 198
	addt	$f20, $f27, $f10											   # 000198
	.loc 1 199
	mult	$f30, $f20, $f20											   # 000199
	mult	$f0, $f27, $f0
	.loc 1 198
	divt	$f18, $f10, $f10											   # 000198
	.loc 1 199
	addt	$f20, $f0, $f0												   # 000199
	mult	$f0, $f10, $f0
	stt	$f0, -24($5)
	.loc 1 198
	ldt	$f28, -16($16)												   # 000198
	ldt	$f15, -8($16)
	.loc 1 199
	ldt	$f12, -16($23)												   # 000199
	ldt	$f17, -16($27)
	.loc 1 198
	addt	$f28, $f15, $f13											   # 000198
	.loc 1 199
	mult	$f12, $f28, $f12											   # 000199
	mult	$f17, $f15, $f15
	.loc 1 198
	divt	$f18, $f13, $f13											   # 000198
	.loc 1 199
	addt	$f12, $f15, $f12											   # 000199
	mult	$f12, $f13, $f12
	stt	$f12, -16($5)
	.loc 1 198
	ldt	$f24, -8($16)												   # 000198
	ldt	$f19, ($16)
	.loc 1 199
	ldt	$f16, -8($23)												   # 000199
	ldt	$f25, -8($27)
	.loc 1 198
	addt	$f24, $f19, $f21											   # 000198
	.loc 1 199
	mult	$f16, $f24, $f16											   # 000199
	mult	$f25, $f19, $f19
	.loc 1 198
	divt	$f18, $f21, $f21											   # 000198
	.loc 1 199
	addt	$f16, $f19, $f16											   # 000199
	mult	$f16, $f21, $f16
	stt	$f16, -8($5)
	.loc 1 196
	bne	$4, L$153												   # 000196
	beq	$8, L$148
L$155:
	.loc 1 198
	ldt	$f1, ($16)												   # 000198
	ldt	$f26, 8($16)
	unop
	.loc 1 199
	ldt	$f29, ($23)												   # 000199
	ldt	$f22, ($27)
	.loc 1 196
	addl	$21, 1, $21												   # 000196
	lda	$23, 8($23)
	lda	$27, 8($27)
	lda	$16, 8($16)
	.loc 1 198
	addt	$f1, $f26, $f23												   # 000198
	unop
	.loc 1 199
	mult	$f29, $f1, $f1												   # 000199
	.loc 1 196
	cmplt	$21, $7, $25												   # 000196
	lda	$5, 8($5)
	.loc 1 199
	mult	$f22, $f26, $f22											   # 000199
	.loc 1 198
	divt	$f18, $f23, $f23											   # 000198
	.loc 1 199
	addt	$f1, $f22, $f1												   # 000199
	mult	$f1, $f23, $f1
	stt	$f1, -8($5)
	.loc 1 196
	bne	$25, L$155												   # 000196
	.loc 1 200
 #    200             }
L$148:															   # 000200
	.loc 1 202
 #    201 
 #    202             riup[0]=rim[0];
	ldt	$f14, ($20)												   # 000202
	.loc 1 203
 #    203             riup[nd-1]=rim[nd-1];
	s8addq	$19, $6, $19												   # 000203
	.loc 1 202
	stt	$f14, ($6)												   # 000202
	.loc 1 203
	ldt	$f11, -8($1)												   # 000203
	stt	$f11, -8($19)
	.loc 1 205
 #    204 
 #    205  return riup[0];
	ldt	$f0, ($6)												   # 000205
	.loc 1 206
 #    206 }
	ret	($26)													   # 000206
	.end 	dfe_optlimb1
	.loc 1 208
 #    207 
 #    208 double dfe_optlimb2(double *dtaum, double *sm, int nd)
	.globl  dfe_optlimb2
	.ent 	dfe_optlimb2
	.loc 1 208
dfe_optlimb2:														   # 000208
	ldah	$gp, ($27)
	unop
	lda	$gp, ($gp)
	unop
	.frame  $sp, 0, $26
	.prologue 1
L$103:
	.loc 1 209
 #    209 {
	sextl	$18, $18												   # 000209
	.loc 1 225
 #    210 /*
 #    211  *     formal solution of the radiative transfer
 #    212  *     equation by the Discontinuous Finite Element method
 #    213  *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 #    214  */
 #    215 
 #    216  register int	id;
 #    217  register double rim0, aa, bb, cc, dt0, dtaup1, dtau2;
 #    218  
 #    219 
 #    220 /*            incoming intensity    
 #    221  *          
 #    222  *            upper boundary condition 
 #    223  */ 
 #    224    
 #    225             rim0=0.0;
	fclr	$f0													   # 000225
	.loc 1 230
 #    226 /*
 #    227  *           first half.
 #    228  */
 #    229 
 #    230             for(id=0;id<nd-1;id++)
	clr	$2													   # 000230
	subl	$18, 1, $1
	ble	$1, L$106
	subl	$18, 4, $3
	.loc 1 232
 #    231             {
 #    232              dt0=dtaum[id];
	mov	$16, $4													   # 000232
	.loc 1 230
	cmple	$3, $1, $5												   # 000230
	.loc 1 238
 #    233              dtaup1=dt0+1.0;
 #    234              dtau2=dt0*dt0;
 #    235              bb=dt0*dtaup1;
 #    236              cc=2.0*dtaup1;
 #    237              aa=1.0/(dtau2+cc);
 #    238              rim0=(2.*rim0+dt0*sm[id  ]+bb*sm[id+1])*aa;
	mov	$17, $6													   # 000238
	.loc 1 230
	beq	$5, L$108												   # 000230
	cmplt	$31, $3, $5
L$108:
	.loc 1 233
	ldq	$28, ($gp)												   # 000233
	lds	$f1, ($28)
	.loc 1 230
	beq	$5, L$113												   # 000230
	unop
	unop
L$111:
	.loc 1 232
	ldt	$f10, ($4)												   # 000232
	ldt	$f15, 8($4)
	.loc 1 238
	addt	$f0, $f0, $f0												   # 000238
	.loc 1 232
	ldt	$f20, 16($4)												   # 000232
	ldt	$f27, 24($4)
	.loc 1 238
	ldt	$f25, ($6)												   # 000238
	ldt	$f26, 8($6)
	.loc 1 230
	addl	$2, 4, $2												   # 000230
	.loc 1 233
	addt	$f10, $f1, $f12												   # 000233
	.loc 1 234
	mult	$f10, $f10, $f13											   # 000234
	.loc 1 230
	cmplt	$2, $3, $20												   # 000230
	lda	$4, 32($4)
	.loc 1 233
	addt	$f15, $f1, $f17												   # 000233
	.loc 1 234
	mult	$f15, $f15, $f18											   # 000234
	.loc 1 230
	cmplt	$2, $1, $21												   # 000230
	.loc 1 236
	lda	$6, 32($6)												   # 000236
	.loc 1 238
	mult	$f10, $f25, $f25											   # 000238
	.loc 1 233
	addt	$f20, $f1, $f22												   # 000233
	.loc 1 234
	mult	$f20, $f20, $f24											   # 000234
	.loc 1 233
	addt	$f27, $f1, $f29												   # 000233
	.loc 1 236
	addt	$f12, $f12, $f14											   # 000236
	.loc 1 235
	mult	$f10, $f12, $f11											   # 000235
	.loc 1 236
	addt	$f17, $f17, $f19											   # 000236
	.loc 1 235
	mult	$f15, $f17, $f16											   # 000235
	.loc 1 238
	addt	$f0, $f25, $f0												   # 000238
	.loc 1 234
	mult	$f27, $f27, $f10											   # 000234
	.loc 1 236
	addt	$f22, $f22, $f23											   # 000236
	.loc 1 235
	mult	$f20, $f22, $f22											   # 000235
	.loc 1 237
	addt	$f13, $f14, $f13											   # 000237
	.loc 1 238
	ldt	$f14, -16($6)												   # 000238
	mult	$f11, $f26, $f11
	.loc 1 237
	addt	$f18, $f19, $f18											   # 000237
	.loc 1 238
	ldt	$f19, ($6)												   # 000238
	mult	$f15, $f26, $f26
	ldt	$f15, -8($6)
	.loc 1 236
	addt	$f29, $f29, $f30											   # 000236
	.loc 1 237
	addt	$f24, $f23, $f23											   # 000237
	.loc 1 235
	mult	$f27, $f29, $f29											   # 000235
	.loc 1 237
	divt	$f1, $f13, $f13												   # 000237
	.loc 1 238
	mult	$f16, $f14, $f16											   # 000238
	addt	$f0, $f11, $f0
	mult	$f20, $f14, $f14
	.loc 1 237
	addt	$f10, $f30, $f10											   # 000237
	.loc 1 238
	mult	$f22, $f15, $f22											   # 000238
	mult	$f27, $f15, $f15
	mult	$f29, $f19, $f19
	.loc 1 237
	divt	$f1, $f18, $f18												   # 000237
	.loc 1 238
	mult	$f0, $f13, $f0												   # 000238
	addt	$f0, $f0, $f0
	addt	$f0, $f26, $f0
	addt	$f0, $f16, $f0
	.loc 1 237
	divt	$f1, $f23, $f23												   # 000237
	.loc 1 238
	mult	$f0, $f18, $f0												   # 000238
	addt	$f0, $f0, $f0
	addt	$f0, $f14, $f0
	addt	$f0, $f22, $f0
	.loc 1 237
	divt	$f1, $f10, $f10												   # 000237
	.loc 1 238
	mult	$f0, $f23, $f0												   # 000238
	addt	$f0, $f0, $f0
	addt	$f0, $f15, $f0
	addt	$f0, $f19, $f0
	mult	$f0, $f10, $f0
	.loc 1 230
	bne	$20, L$111												   # 000230
	beq	$21, L$106
L$113:
	.loc 1 232
	ldt	$f20, ($4)												   # 000232
	.loc 1 238
	ldt	$f11, ($6)												   # 000238
	addt	$f0, $f0, $f0
	ldt	$f13, 8($6)
	.loc 1 230
	addl	$2, 1, $2												   # 000230
	lda	$4, 8($4)
	cmplt	$2, $1, $24
	lda	$6, 8($6)
	.loc 1 233
	addt	$f20, $f1, $f12												   # 000233
	.loc 1 234
	mult	$f20, $f20, $f25											   # 000234
	.loc 1 238
	mult	$f20, $f11, $f11											   # 000238
	.loc 1 236
	addt	$f12, $f12, $f27											   # 000236
	.loc 1 235
	mult	$f20, $f12, $f12											   # 000235
	.loc 1 238
	addt	$f0, $f11, $f0												   # 000238
	.loc 1 237
	addt	$f25, $f27, $f25											   # 000237
	.loc 1 238
	mult	$f12, $f13, $f12											   # 000238
	.loc 1 237
	divt	$f1, $f25, $f25												   # 000237
	.loc 1 238
	addt	$f0, $f12, $f0												   # 000238
	mult	$f0, $f25, $f0
	.loc 1 230
	bne	$24, L$113												   # 000230
	.loc 1 239
 #    239             }
L$106:															   # 000239
	.loc 1 245
 #    240 
 #    241 /*
 #    242  *           outgoing radiation.
 #    243  *           we are reflected at tangent point.
 #    244  */
 #    245             for(id=nd-2;id>=0;id--)
	subl	$18, 2, $18												   # 000245
	.loc 1 248
 #    246             {
 #    247              dt0=dtaum[id];
 #    248              dtaup1=dt0+1.0;
	ldq	$28, ($gp)												   # 000248
	.loc 1 245
	blt	$18, L$114												   # 000245
	.loc 1 253
 #    249              dtau2=dt0*dt0;
 #    250              bb=dt0*dtaup1;
 #    251              cc=2.0*dtaup1;
 #    252              aa=1.0/(dtau2+cc);
 #    253              rim0=(2.*rim0+dt0*sm[id+1]+bb*sm[id  ])*aa;
	s8addq	$18, $17, $17												   # 000253
	.loc 1 248
	lds	$f30, ($28)												   # 000248
	.loc 1 247
	s8addq	$18, $16, $16												   # 000247
	.loc 1 245
	cmplt	$18, 3, $25												   # 000245
	.loc 1 253
	lda	$17, 8($17)												   # 000253
	.loc 1 245
	bne	$25, L$120												   # 000245
L$118:
	.loc 1 247
	ldt	$f17, ($16)												   # 000247
	ldt	$f14, -8($16)
	.loc 1 253
	addt	$f0, $f0, $f0												   # 000253
	.loc 1 247
	ldt	$f15, -16($16)												   # 000247
	ldt	$f13, -24($16)
	.loc 1 253
	ldt	$f24, ($17)												   # 000253
	ldt	$f11, -8($17)
	.loc 1 245
	subl	$18, 4, $18												   # 000245
	lda	$16, -32($16)
	.loc 1 248
	addt	$f17, $f30, $f16											   # 000248
	.loc 1 249
	mult	$f17, $f17, $f18											   # 000249
	.loc 1 248
	addt	$f14, $f30, $f23											   # 000248
	.loc 1 249
	mult	$f14, $f14, $f28											   # 000249
	.loc 1 245
	cmplt	$18, 3, $7												   # 000245
	.loc 1 251
	lda	$17, -32($17)												   # 000251
	.loc 1 253
	mult	$f17, $f24, $f24											   # 000253
	.loc 1 248
	addt	$f15, $f30, $f10											   # 000248
	.loc 1 249
	mult	$f15, $f15, $f27											   # 000249
	.loc 1 248
	addt	$f13, $f30, $f25											   # 000248
	.loc 1 251
	addt	$f16, $f16, $f21											   # 000251
	.loc 1 250
	mult	$f17, $f16, $f16											   # 000250
	.loc 1 251
	addt	$f23, $f23, $f29											   # 000251
	.loc 1 250
	mult	$f14, $f23, $f22											   # 000250
	.loc 1 253
	addt	$f0, $f24, $f0												   # 000253
	.loc 1 249
	mult	$f13, $f13, $f17											   # 000249
	.loc 1 251
	addt	$f10, $f10, $f20											   # 000251
	.loc 1 250
	mult	$f15, $f10, $f10											   # 000250
	.loc 1 252
	addt	$f18, $f21, $f18											   # 000252
	.loc 1 253
	ldt	$f21, 16($17)												   # 000253
	mult	$f16, $f11, $f16
	.loc 1 252
	addt	$f28, $f29, $f28											   # 000252
	.loc 1 253
	ldt	$f29, ($17)												   # 000253
	mult	$f14, $f11, $f11
	ldt	$f14, 8($17)
	.loc 1 251
	addt	$f25, $f25, $f1												   # 000251
	.loc 1 252
	addt	$f27, $f20, $f20											   # 000252
	.loc 1 250
	mult	$f13, $f25, $f25											   # 000250
	.loc 1 252
	divt	$f30, $f18, $f18											   # 000252
	.loc 1 253
	mult	$f22, $f21, $f22											   # 000253
	addt	$f0, $f16, $f0
	mult	$f15, $f21, $f19
	.loc 1 252
	addt	$f17, $f1, $f1												   # 000252
	.loc 1 253
	mult	$f10, $f14, $f10											   # 000253
	mult	$f13, $f14, $f12
	mult	$f25, $f29, $f25
	.loc 1 252
	divt	$f30, $f28, $f28											   # 000252
	.loc 1 253
	mult	$f0, $f18, $f0												   # 000253
	addt	$f0, $f0, $f0
	addt	$f0, $f11, $f0
	addt	$f0, $f22, $f0
	.loc 1 252
	divt	$f30, $f20, $f20											   # 000252
	.loc 1 253
	mult	$f0, $f28, $f0												   # 000253
	addt	$f0, $f0, $f0
	addt	$f0, $f19, $f0
	addt	$f0, $f10, $f0
	.loc 1 252
	divt	$f30, $f1, $f1												   # 000252
	.loc 1 253
	mult	$f0, $f20, $f0												   # 000253
	addt	$f0, $f0, $f0
	addt	$f0, $f12, $f0
	addt	$f0, $f25, $f0
	mult	$f0, $f1, $f0
	.loc 1 245
	beq	$7, L$118												   # 000245
	blt	$18, L$114
L$120:
	.loc 1 247
	ldt	$f15, ($16)												   # 000247
	.loc 1 253
	ldt	$f16, ($17)												   # 000253
	addt	$f0, $f0, $f0
	ldt	$f18, -8($17)
	.loc 1 245
	subl	$18, 1, $18												   # 000245
	lda	$16, -8($16)
	lda	$17, -8($17)
	.loc 1 248
	addt	$f15, $f30, $f26											   # 000248
	.loc 1 249
	mult	$f15, $f15, $f24											   # 000249
	.loc 1 253
	mult	$f15, $f16, $f16											   # 000253
	.loc 1 251
	addt	$f26, $f26, $f13											   # 000251
	.loc 1 250
	mult	$f15, $f26, $f26											   # 000250
	.loc 1 253
	addt	$f0, $f16, $f0												   # 000253
	.loc 1 252
	addt	$f24, $f13, $f13											   # 000252
	.loc 1 253
	mult	$f26, $f18, $f18											   # 000253
	.loc 1 252
	divt	$f30, $f13, $f13											   # 000252
	.loc 1 253
	addt	$f0, $f18, $f0												   # 000253
	mult	$f0, $f13, $f0
	.loc 1 245
	bge	$18, L$120												   # 000245
	.loc 1 254
 #    254             }
L$114:															   # 000254
	.loc 1 257
 #    255 
 #    256  return rim0;
 #    257 }
	ret	($26)													   # 000257
	.end 	dfe_optlimb2
	.loc 1 260
 #    258 
 #    259 
 #    260 int dfe_geom1(double *dtaum, double *emism, double *dlm, double *jm, 
	.globl  dfe_geom1
	.ent 	dfe_geom1
	.loc 1 260
dfe_geom1:														   # 000260
	ldah	$gp, ($27)
	unop
	lda	$gp, ($gp)
	unop
	.frame  $sp, 0, $26
	.prologue 1
L$56:
	ldq	$1, ($sp)
	.loc 1 262
 #    261 	      double fincd, int nd, double *pool)
 #    262 {
	sextl	$21, $21												   # 000262
	.loc 1 275
 #    263 /*
 #    264  *     formal solution of the radiative transfer
 #    265  *     equation by the Discontinuous Finite Element method
 #    266  *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 #    267  */
 #    268 
 #    269  int	id;
 #    270  double	*rim, *rip, *riin, *riup;
 #    271  register double aa, bb, cc, dt0, dtaup1, dtau2, dtt, dl0;
 #    272  
 #    273 	rim=(double *) (pool);
 #    274 	rip=(double *) (pool+nd);
 #    275 	riin=(double *) (pool+2*nd);
	addq	$21, $21, $4												   # 000275
	.loc 1 276
 #    276 	riup=(double *) (pool+3*nd);
	s4subq	$21, $21, $8												   # 000276
	.loc 1 289
 #    277 
 #    278 /*            incoming intensity    
 #    279  *          
 #    280  *            upper boundary condition 
 #    281  */ 
 #    282    
 #    283             rim[0]=0.0;
 #    284 /*
 #    285  *           recurrence relation to determine I^+ and I^- 
 #    286  *           (which are called RIP and RIM)
 #    287  */
 #    288 
 #    289             for(id=0;id<nd-1;id++)
	subl	$21, 1, $20												   # 000289
	.loc 1 274
	s8addq	$21, $1, $3												   # 000274
	.loc 1 283
	stt	$f31, ($1)												   # 000283
	.loc 1 274
	s8addq	$21, $1, $6												   # 000274
	.loc 1 275
	s8addq	$4, $1, $4												   # 000275
	.loc 1 276
	s8addq	$8, $1, $8												   # 000276
	.loc 1 289
	ble	$20, L$59												   # 000289
	subl	$21, 4, $24
	clr	$7
	.loc 1 291
 #    290             {
 #    291              dt0=dtaum[id];
	mov	$16, $22												   # 000291
	.loc 1 292
 #    292              dl0=dlm[id];
	mov	$18, $23												   # 000292
	.loc 1 298
 #    293              dtaup1=dt0+1.0;
 #    294              dtau2=dt0*dt0;
 #    295              cc=2.0*dtaup1;
 #    296              bb=dl0*dtaup1;
 #    297              aa=1.0/(dtau2+cc);
 #    298              rim[id+1]=(2.*rim[id]+dl0*emism[id  ]+bb*emism[id+1])*aa;
	mov	$1, $25													   # 000298
	mov	$17, $27
	.loc 1 289
	cmple	$24, $20, $0												   # 000289
	.loc 1 299
 #    299              rip[id  ]=(cc*rim[id]-dl0*emism[id+1]+bb*emism[id  ])*aa;
	s8addq	$21, $1, $2												   # 000299
	.loc 1 289
	beq	$0, L$61												   # 000289
	cmplt	$31, $24, $0
L$61:
	.loc 1 293
	ldq	$28, ($gp)												   # 000293
	lds	$f0, ($28)
	.loc 1 289
	beq	$0, L$66												   # 000289
L$64:
	.loc 1 291
	ldt	$f1, ($22)												   # 000291
	.loc 1 292
	ldt	$f13, ($23)												   # 000292
	.loc 1 298
	ldt	$f14, ($25)												   # 000298
	ldt	$f15, ($27)
	ldt	$f18, 8($27)
	.loc 1 289
	addl	$7, 4, $7												   # 000289
	cmplt	$7, $24, $0
	.loc 1 292
	lda	$22, 32($22)												   # 000292
	.loc 1 293
	addt	$f1, $f0, $f11												   # 000293
	.loc 1 294
	mult	$f1, $f1, $f10												   # 000294
	.loc 1 298
	lda	$23, 32($23)												   # 000298
	.loc 1 299
	lda	$25, 32($25)												   # 000299
	.loc 1 298
	mult	$f13, $f15, $f15											   # 000298
	addt	$f14, $f14, $f17
	.loc 1 299
	lda	$27, 32($27)												   # 000299
	.loc 1 289
	lda	$2, 32($2)												   # 000289
	cmplt	$7, $20, $5
	.loc 1 295
	addt	$f11, $f11, $f12											   # 000295
	.loc 1 296
	mult	$f13, $f11, $f11											   # 000296
	.loc 1 298
	addt	$f17, $f15, $f15											   # 000298
	.loc 1 297
	addt	$f10, $f12, $f10											   # 000297
	.loc 1 298
	mult	$f11, $f18, $f18											   # 000298
	.loc 1 299
	mult	$f12, $f14, $f12											   # 000299
	.loc 1 297
	divt	$f0, $f10, $f10												   # 000297
	.loc 1 298
	addt	$f15, $f18, $f15											   # 000298
	mult	$f15, $f10, $f15
	stt	$f15, -24($25)
	.loc 1 299
	ldt	$f19, -24($27)												   # 000299
	ldt	$f21, -32($27)
	mult	$f13, $f19, $f16
	mult	$f11, $f21, $f11
	subt	$f12, $f16, $f12
	addt	$f12, $f11, $f11
	mult	$f11, $f10, $f10
	stt	$f10, -32($2)
	.loc 1 291
	ldt	$f22, -24($22)												   # 000291
	.loc 1 292
	ldt	$f26, -24($23)												   # 000292
	.loc 1 298
	ldt	$f27, -24($25)												   # 000298
	ldt	$f28, -24($27)
	ldt	$f1, -16($27)
	.loc 1 293
	addt	$f22, $f0, $f24												   # 000293
	.loc 1 294
	mult	$f22, $f22, $f23											   # 000294
	.loc 1 298
	addt	$f27, $f27, $f30											   # 000298
	mult	$f26, $f28, $f28
	.loc 1 295
	addt	$f24, $f24, $f25											   # 000295
	.loc 1 296
	mult	$f26, $f24, $f24											   # 000296
	.loc 1 298
	addt	$f30, $f28, $f28											   # 000298
	.loc 1 297
	addt	$f23, $f25, $f23											   # 000297
	.loc 1 298
	mult	$f24, $f1, $f1												   # 000298
	.loc 1 299
	mult	$f25, $f27, $f25											   # 000299
	.loc 1 297
	divt	$f0, $f23, $f23												   # 000297
	.loc 1 298
	addt	$f28, $f1, $f1												   # 000298
	mult	$f1, $f23, $f1
	stt	$f1, -16($25)
	.loc 1 299
	ldt	$f13, -16($27)												   # 000299
	ldt	$f17, -24($27)
	mult	$f26, $f13, $f13
	mult	$f24, $f17, $f17
	subt	$f25, $f13, $f13
	addt	$f13, $f17, $f13
	mult	$f13, $f23, $f13
	stt	$f13, -24($2)
	.loc 1 291
	ldt	$f18, -16($22)												   # 000291
	.loc 1 292
	ldt	$f21, -16($23)												   # 000292
	.loc 1 298
	ldt	$f16, -16($25)												   # 000298
	ldt	$f12, -16($27)
	ldt	$f22, -8($27)
	.loc 1 293
	addt	$f18, $f0, $f14												   # 000293
	.loc 1 294
	mult	$f18, $f18, $f15											   # 000294
	.loc 1 298
	mult	$f21, $f12, $f12											   # 000298
	addt	$f16, $f16, $f10
	.loc 1 295
	addt	$f14, $f14, $f19											   # 000295
	.loc 1 296
	mult	$f21, $f14, $f14											   # 000296
	.loc 1 298
	addt	$f10, $f12, $f10											   # 000298
	.loc 1 297
	addt	$f15, $f19, $f15											   # 000297
	.loc 1 299
	mult	$f19, $f16, $f16											   # 000299
	.loc 1 298
	mult	$f14, $f22, $f22											   # 000298
	.loc 1 297
	divt	$f0, $f15, $f15												   # 000297
	.loc 1 298
	addt	$f10, $f22, $f10											   # 000298
	mult	$f10, $f15, $f10
	stt	$f10, -8($25)
	.loc 1 299
	ldt	$f26, -8($27)												   # 000299
	ldt	$f30, -16($27)
	mult	$f21, $f26, $f11
	mult	$f14, $f30, $f14
	subt	$f16, $f11, $f11
	addt	$f11, $f14, $f11
	mult	$f11, $f15, $f11
	stt	$f11, -16($2)
	.loc 1 291
	ldt	$f28, -8($22)												   # 000291
	.loc 1 292
	ldt	$f24, -8($23)												   # 000292
	.loc 1 298
	ldt	$f25, -8($25)												   # 000298
	ldt	$f17, -8($27)
	ldt	$f18, ($27)
	.loc 1 293
	addt	$f28, $f0, $f27												   # 000293
	.loc 1 294
	mult	$f28, $f28, $f1												   # 000294
	.loc 1 298
	addt	$f25, $f25, $f13											   # 000298
	mult	$f24, $f17, $f17
	.loc 1 295
	addt	$f27, $f27, $f29											   # 000295
	.loc 1 296
	mult	$f24, $f27, $f27											   # 000296
	.loc 1 298
	addt	$f13, $f17, $f13											   # 000298
	.loc 1 297
	addt	$f1, $f29, $f1												   # 000297
	.loc 1 298
	mult	$f27, $f18, $f18											   # 000298
	.loc 1 299
	mult	$f29, $f25, $f25											   # 000299
	.loc 1 297
	divt	$f0, $f1, $f1												   # 000297
	.loc 1 298
	addt	$f13, $f18, $f13											   # 000298
	mult	$f13, $f1, $f13
	stt	$f13, ($25)
	.loc 1 299
	ldt	$f21, ($27)												   # 000299
	ldt	$f12, -8($27)
	mult	$f24, $f21, $f21
	mult	$f27, $f12, $f12
	subt	$f25, $f21, $f21
	addt	$f21, $f12, $f12
	mult	$f12, $f1, $f1
	stt	$f1, -8($2)
	.loc 1 289
	bne	$0, L$64												   # 000289
	beq	$5, L$59
L$66:
	.loc 1 291
	ldt	$f22, ($22)												   # 000291
	.loc 1 292
	ldt	$f30, ($23)												   # 000292
	.loc 1 298
	ldt	$f16, ($25)												   # 000298
	ldt	$f14, ($27)
	ldt	$f28, 8($27)
	.loc 1 289
	addl	$7, 1, $7												   # 000289
	lda	$22, 8($22)
	lda	$23, 8($23)
	.loc 1 293
	addt	$f22, $f0, $f19												   # 000293
	.loc 1 294
	mult	$f22, $f22, $f10											   # 000294
	.loc 1 298
	mult	$f30, $f14, $f14											   # 000298
	addt	$f16, $f16, $f11
	.loc 1 289
	cmplt	$7, $20, $5												   # 000289
	.loc 1 299
	lda	$25, 8($25)												   # 000299
	lda	$27, 8($27)
	.loc 1 289
	lda	$2, 8($2)												   # 000289
	.loc 1 295
	addt	$f19, $f19, $f26											   # 000295
	.loc 1 296
	mult	$f30, $f19, $f19											   # 000296
	.loc 1 298
	addt	$f11, $f14, $f11											   # 000298
	.loc 1 297
	addt	$f10, $f26, $f10											   # 000297
	.loc 1 298
	mult	$f19, $f28, $f28											   # 000298
	.loc 1 299
	mult	$f26, $f16, $f16											   # 000299
	.loc 1 297
	divt	$f0, $f10, $f10												   # 000297
	.loc 1 298
	addt	$f11, $f28, $f11											   # 000298
	mult	$f11, $f10, $f11
	stt	$f11, ($25)
	.loc 1 299
	ldt	$f24, ($27)												   # 000299
	ldt	$f17, -8($27)
	mult	$f30, $f24, $f15
	mult	$f19, $f17, $f17
	subt	$f16, $f15, $f15
	addt	$f15, $f17, $f15
	mult	$f15, $f10, $f10
	stt	$f10, -8($2)
	.loc 1 289
	bne	$5, L$66												   # 000289
	.loc 1 300
 #    300             }
L$59:															   # 000300
	.loc 1 302
 #    301 
 #    302             for(id=1;id<nd-1;id++)
	cmple	$20, 1, $24												   # 000302
	bne	$24, L$67
	subl	$21, 4, $22
	mov	1, $0
	.loc 1 305
 #    303             {
 #    304              dtt=1.0/(dlm[id-1]+dlm[id]);
 #    305              riin[id]=(rim[id]*dlm[id]+rip[id]*dlm[id-1])*dtt;
	lda	$2, 8($1)												   # 000305
	lda	$5, 8($6)
	lda	$7, 8($4)
	.loc 1 302
	cmple	$22, $20, $23												   # 000302
	.loc 1 304
	mov	$18, $25												   # 000304
	.loc 1 302
	beq	$23, L$69												   # 000302
	cmple	$22, 1, $27
	xor	$27, 1, $23
L$69:
	.loc 1 304
	ldq	$28, ($gp)												   # 000304
	lds	$f18, ($28)
	.loc 1 302
	beq	$23, L$74												   # 000302
L$72:
	.loc 1 304
	ldt	$f13, ($25)												   # 000304
	ldt	$f29, 8($25)
	.loc 1 305
	ldt	$f27, ($2)												   # 000305
	ldt	$f25, ($5)
	.loc 1 302
	addl	$0, 4, $0												   # 000302
	.loc 1 305
	lda	$25, 32($25)												   # 000305
	.loc 1 302
	cmplt	$0, $22, $27												   # 000302
	.loc 1 305
	lda	$2, 32($2)												   # 000305
	.loc 1 304
	addt	$f13, $f29, $f23											   # 000304
	lda	$5, 32($5)
	.loc 1 302
	lda	$7, 32($7)												   # 000302
	.loc 1 305
	mult	$f27, $f29, $f27											   # 000305
	mult	$f25, $f13, $f13
	.loc 1 302
	cmplt	$0, $20, $23												   # 000302
	.loc 1 304
	divt	$f18, $f23, $f23											   # 000304
	.loc 1 305
	addt	$f27, $f13, $f13											   # 000305
	mult	$f13, $f23, $f13
	stt	$f13, -32($7)
	.loc 1 304
	ldt	$f21, -24($25)												   # 000304
	ldt	$f12, -16($25)
	.loc 1 305
	ldt	$f22, -24($2)												   # 000305
	ldt	$f30, -24($5)
	.loc 1 304
	addt	$f21, $f12, $f1												   # 000304
	.loc 1 305
	mult	$f22, $f12, $f12											   # 000305
	mult	$f30, $f21, $f21
	.loc 1 304
	divt	$f18, $f1, $f1												   # 000304
	.loc 1 305
	addt	$f12, $f21, $f12											   # 000305
	mult	$f12, $f1, $f1
	stt	$f1, -24($7)
	.loc 1 304
	ldt	$f14, -16($25)												   # 000304
	ldt	$f28, -8($25)
	.loc 1 305
	ldt	$f26, -16($2)												   # 000305
	ldt	$f24, -16($5)
	.loc 1 304
	addt	$f14, $f28, $f11											   # 000304
	.loc 1 305
	mult	$f26, $f28, $f26											   # 000305
	mult	$f24, $f14, $f14
	.loc 1 304
	divt	$f18, $f11, $f11											   # 000304
	.loc 1 305
	addt	$f26, $f14, $f14											   # 000305
	mult	$f14, $f11, $f11
	stt	$f11, -16($7)
	.loc 1 304
	ldt	$f19, -8($25)												   # 000304
	ldt	$f16, ($25)
	.loc 1 305
	ldt	$f15, -8($2)												   # 000305
	ldt	$f10, -8($5)
	.loc 1 304
	addt	$f19, $f16, $f17											   # 000304
	.loc 1 305
	mult	$f15, $f16, $f15											   # 000305
	mult	$f10, $f19, $f10
	.loc 1 304
	divt	$f18, $f17, $f17											   # 000304
	.loc 1 305
	addt	$f15, $f10, $f10											   # 000305
	mult	$f10, $f17, $f10
	stt	$f10, -8($7)
	.loc 1 302
	bne	$27, L$72												   # 000302
	beq	$23, L$67
L$74:
	.loc 1 304
	ldt	$f0, ($25)												   # 000304
	ldt	$f29, 8($25)
	.loc 1 305
	ldt	$f27, ($2)												   # 000305
	ldt	$f23, ($5)
	.loc 1 302
	addl	$0, 1, $0												   # 000302
	lda	$2, 8($2)
	lda	$5, 8($5)
	.loc 1 304
	addt	$f0, $f29, $f25												   # 000304
	.loc 1 302
	cmplt	$0, $20, $23												   # 000302
	lda	$25, 8($25)
	.loc 1 305
	mult	$f27, $f29, $f27											   # 000305
	mult	$f23, $f0, $f0
	.loc 1 302
	lda	$7, 8($7)												   # 000302
	.loc 1 304
	divt	$f18, $f25, $f25											   # 000304
	.loc 1 305
	addt	$f27, $f0, $f0												   # 000305
	mult	$f0, $f25, $f0
	stt	$f0, -8($7)
	.loc 1 302
	bne	$23, L$74												   # 000302
	.loc 1 306
 #    306             }
L$67:															   # 000306
	.loc 1 308
 #    307 
 #    308             riin[0]=rim[0];
	ldt	$f13, ($1)												   # 000308
	.loc 1 309
 #    309             riin[nd-1]=rim[nd-1];
	s8addq	$21, $4, $5												   # 000309
	.loc 1 322
 #    310 
 #    311 /*               
 #    312  *           outgoing intensity 
 #    313  *   
 #    314  *           lower boundary condition 
 #    315  */
 #    316             rim[nd-1]=fincd;
 #    317 
 #    318 /*
 #    319  *           recurrence relation to determine I^+ and I^-
 #    320  *
 #    321  */
 #    322             for(id=nd-2;id>=0;id--)
	subl	$21, 2, $2												   # 000322
	.loc 1 308
	stt	$f13, ($4)												   # 000308
	.loc 1 331
 #    323             {
 #    324              dt0=dtaum[id];
 #    325              dl0=dlm[id];
 #    326              dtaup1=dt0+1.0;
 #    327              dtau2=dt0*dt0;
 #    328              cc=2.0*dtaup1;
 #    329              bb=dl0*dtaup1;
 #    330              aa=1.0/(dtau2+cc);
 #    331              rim[id  ]=(2.*rim[id+1]+dl0*emism[id+1]+bb*emism[id  ])*aa;
	s8addq	$2, $1, $23												   # 000331
	.loc 1 309
	ldt	$f22, -8($3)												   # 000309
	.loc 1 331
	s8addq	$2, $17, $17												   # 000331
	.loc 1 332
 #    332              rip[id+1]=(cc*rim[id+1]-dl0*emism[id  ]+bb*emism[id+1])*aa;
	s8addq	$2, $6, $25												   # 000332
	.loc 1 326
	ldq	$28, ($gp)												   # 000326
	.loc 1 309
	stt	$f22, -8($5)												   # 000309
	.loc 1 324
	s8addq	$2, $16, $16												   # 000324
	.loc 1 316
	stt	$f20, -8($3)												   # 000316
	.loc 1 322
	blt	$2, L$75												   # 000322
	.loc 1 325
	s8addq	$2, $18, $7												   # 000325
	.loc 1 331
	lda	$23, 8($23)												   # 000331
	lda	$17, 8($17)
	.loc 1 332
	lda	$25, 8($25)												   # 000332
	.loc 1 326
	lds	$f30, ($28)												   # 000326
	.loc 1 322
	cmplt	$2, 3, $5												   # 000322
	bne	$5, L$81
	unop
L$79:
	.loc 1 324
	ldt	$f21, ($16)												   # 000324
	.loc 1 325
	ldt	$f24, ($7)												   # 000325
	.loc 1 331
	ldt	$f26, ($23)												   # 000331
	ldt	$f14, ($17)
	ldt	$f19, -8($17)
	.loc 1 322
	subl	$2, 4, $2												   # 000322
	cmplt	$2, 3, $5
	.loc 1 325
	lda	$16, -32($16)												   # 000325
	.loc 1 326
	addt	$f21, $f30, $f1												   # 000326
	.loc 1 327
	mult	$f21, $f21, $f12											   # 000327
	.loc 1 331
	lda	$7, -32($7)												   # 000331
	.loc 1 332
	lda	$23, -32($23)												   # 000332
	.loc 1 331
	mult	$f24, $f14, $f14											   # 000331
	addt	$f26, $f26, $f16
	.loc 1 332
	lda	$17, -32($17)												   # 000332
	.loc 1 322
	lda	$25, -32($25)												   # 000322
	.loc 1 328
	addt	$f1, $f1, $f28												   # 000328
	.loc 1 329
	mult	$f24, $f1, $f1												   # 000329
	.loc 1 331
	addt	$f16, $f14, $f14											   # 000331
	.loc 1 330
	addt	$f12, $f28, $f12											   # 000330
	.loc 1 331
	mult	$f1, $f19, $f19												   # 000331
	.loc 1 332
	mult	$f28, $f26, $f26											   # 000332
	.loc 1 330
	divt	$f30, $f12, $f12											   # 000330
	.loc 1 331
	addt	$f14, $f19, $f14											   # 000331
	mult	$f14, $f12, $f14
	stt	$f14, 24($23)
	.loc 1 332
	ldt	$f15, 24($17)												   # 000332
	ldt	$f17, 32($17)
	mult	$f24, $f15, $f11
	mult	$f1, $f17, $f1
	subt	$f26, $f11, $f11
	addt	$f11, $f1, $f1
	mult	$f1, $f12, $f1
	stt	$f1, 32($25)
	.loc 1 324
	ldt	$f10, 24($16)												   # 000324
	.loc 1 325
	ldt	$f25, 24($7)												   # 000325
	.loc 1 331
	ldt	$f0, 24($23)												   # 000331
	ldt	$f18, 24($17)
	ldt	$f20, 16($17)
	.loc 1 326
	addt	$f10, $f30, $f23											   # 000326
	.loc 1 327
	mult	$f10, $f10, $f29											   # 000327
	.loc 1 331
	mult	$f25, $f18, $f18											   # 000331
	addt	$f0, $f0, $f22
	.loc 1 328
	addt	$f23, $f23, $f27											   # 000328
	.loc 1 329
	mult	$f25, $f23, $f23											   # 000329
	.loc 1 331
	addt	$f22, $f18, $f18											   # 000331
	.loc 1 330
	addt	$f29, $f27, $f29											   # 000330
	.loc 1 332
	mult	$f27, $f0, $f0												   # 000332
	.loc 1 331
	mult	$f23, $f20, $f20											   # 000331
	.loc 1 330
	divt	$f30, $f29, $f29											   # 000330
	.loc 1 331
	addt	$f18, $f20, $f18											   # 000331
	mult	$f18, $f29, $f18
	stt	$f18, 16($23)
	.loc 1 332
	ldt	$f21, 16($17)												   # 000332
	ldt	$f24, 24($17)
	mult	$f25, $f21, $f13
	mult	$f23, $f24, $f23
	subt	$f0, $f13, $f0
	addt	$f0, $f23, $f0
	mult	$f0, $f29, $f0
	stt	$f0, 24($25)
	.loc 1 324
	ldt	$f16, 16($16)												   # 000324
	.loc 1 325
	ldt	$f15, 16($7)												   # 000325
	.loc 1 331
	ldt	$f17, 16($23)												   # 000331
	ldt	$f26, 16($17)
	ldt	$f1, 8($17)
	.loc 1 326
	addt	$f16, $f30, $f14											   # 000326
	.loc 1 327
	mult	$f16, $f16, $f19											   # 000327
	.loc 1 331
	addt	$f17, $f17, $f12											   # 000331
	mult	$f15, $f26, $f26
	.loc 1 328
	addt	$f14, $f14, $f28											   # 000328
	.loc 1 329
	mult	$f15, $f14, $f14											   # 000329
	.loc 1 331
	addt	$f12, $f26, $f12											   # 000331
	.loc 1 330
	addt	$f19, $f28, $f19											   # 000330
	.loc 1 331
	mult	$f14, $f1, $f1												   # 000331
	.loc 1 332
	mult	$f28, $f17, $f17											   # 000332
	.loc 1 330
	divt	$f30, $f19, $f19											   # 000330
	.loc 1 331
	addt	$f12, $f1, $f1												   # 000331
	mult	$f1, $f19, $f1
	stt	$f1, 8($23)
	.loc 1 332
	ldt	$f10, 8($17)												   # 000332
	ldt	$f25, 16($17)
	mult	$f15, $f10, $f10
	mult	$f14, $f25, $f14
	subt	$f17, $f10, $f10
	addt	$f10, $f14, $f10
	mult	$f10, $f19, $f10
	stt	$f10, 16($25)
	.loc 1 324
	ldt	$f22, 8($16)												   # 000324
	.loc 1 325
	ldt	$f21, 8($7)												   # 000325
	.loc 1 331
	ldt	$f24, 8($23)												   # 000331
	ldt	$f13, 8($17)
	ldt	$f0, ($17)
	.loc 1 326
	addt	$f22, $f30, $f18											   # 000326
	.loc 1 327
	mult	$f22, $f22, $f20											   # 000327
	.loc 1 331
	mult	$f21, $f13, $f13											   # 000331
	addt	$f24, $f24, $f29
	.loc 1 328
	addt	$f18, $f18, $f27											   # 000328
	.loc 1 329
	mult	$f21, $f18, $f18											   # 000329
	.loc 1 331
	addt	$f29, $f13, $f13											   # 000331
	.loc 1 330
	addt	$f20, $f27, $f20											   # 000330
	.loc 1 331
	mult	$f18, $f0, $f0												   # 000331
	.loc 1 332
	mult	$f27, $f24, $f24											   # 000332
	.loc 1 330
	divt	$f30, $f20, $f20											   # 000330
	.loc 1 331
	addt	$f13, $f0, $f0												   # 000331
	mult	$f0, $f20, $f0
	stt	$f0, ($23)
	.loc 1 332
	ldt	$f16, ($17)												   # 000332
	ldt	$f15, 8($17)
	mult	$f21, $f16, $f16
	mult	$f18, $f15, $f15
	subt	$f24, $f16, $f16
	addt	$f16, $f15, $f15
	mult	$f15, $f20, $f15
	stt	$f15, 8($25)
	.loc 1 322
	beq	$5, L$79												   # 000322
	blt	$2, L$75
L$81:
	.loc 1 324
	ldt	$f26, ($16)												   # 000324
	.loc 1 325
	ldt	$f11, ($7)												   # 000325
	.loc 1 331
	ldt	$f25, ($23)												   # 000331
	ldt	$f17, ($17)
	ldt	$f10, -8($17)
	.loc 1 322
	subl	$2, 1, $2												   # 000322
	lda	$16, -8($16)
	.loc 1 326
	addt	$f26, $f30, $f1												   # 000326
	.loc 1 327
	mult	$f26, $f26, $f12											   # 000327
	.loc 1 322
	lda	$7, -8($7)												   # 000322
	.loc 1 332
	lda	$23, -8($23)												   # 000332
	.loc 1 331
	addt	$f25, $f25, $f19											   # 000331
	.loc 1 332
	lda	$17, -8($17)												   # 000332
	.loc 1 322
	lda	$25, -8($25)												   # 000322
	.loc 1 331
	mult	$f11, $f17, $f17											   # 000331
	.loc 1 328
	addt	$f1, $f1, $f28												   # 000328
	.loc 1 329
	mult	$f11, $f1, $f1												   # 000329
	.loc 1 331
	addt	$f19, $f17, $f17											   # 000331
	.loc 1 330
	addt	$f12, $f28, $f12											   # 000330
	.loc 1 331
	mult	$f1, $f10, $f10												   # 000331
	.loc 1 332
	mult	$f28, $f25, $f25											   # 000332
	.loc 1 330
	divt	$f30, $f12, $f12											   # 000330
	.loc 1 331
	addt	$f17, $f10, $f10											   # 000331
	mult	$f10, $f12, $f10
	stt	$f10, ($23)
	.loc 1 332
	ldt	$f22, ($17)												   # 000332
	ldt	$f21, 8($17)
	mult	$f11, $f22, $f14
	mult	$f1, $f21, $f1
	subt	$f25, $f14, $f14
	addt	$f14, $f1, $f1
	mult	$f1, $f12, $f1
	stt	$f1, 8($25)
	.loc 1 322
	bge	$2, L$81												   # 000322
	.loc 1 333
 #    333             }
L$75:															   # 000333
	.loc 1 335
 #    334 
 #    335             for(id=1;id<nd-1;id++)
	bne	$24, L$82												   # 000335
	subl	$21, 4, $0
	mov	1, $27
	.loc 1 338
 #    336             {
 #    337              dtt=1.0/(dlm[id-1]+dlm[id]);
 #    338              riup[id]=(rim[id]*dlm[id-1]+rip[id]*dlm[id])*dtt;
	lda	$22, 8($1)												   # 000338
	lda	$6, 8($6)
	lda	$5, 8($8)
	.loc 1 335
	cmple	$0, $20, $2												   # 000335
	beq	$2, L$84
	cmple	$0, 1, $7
	xor	$7, 1, $2
L$84:
	.loc 1 337
	ldq	$28, ($gp)												   # 000337
	lds	$f29, ($28)
	.loc 1 335
	beq	$2, L$89												   # 000335
L$87:
	.loc 1 337
	ldt	$f13, ($18)												   # 000337
	ldt	$f0, 8($18)
	.loc 1 338
	ldt	$f23, ($22)												   # 000338
	ldt	$f18, ($6)
	.loc 1 335
	addl	$27, 4, $27												   # 000335
	.loc 1 338
	lda	$18, 32($18)												   # 000338
	.loc 1 335
	cmplt	$27, $0, $24												   # 000335
	.loc 1 338
	lda	$22, 32($22)												   # 000338
	.loc 1 337
	addt	$f13, $f0, $f27												   # 000337
	lda	$6, 32($6)
	.loc 1 335
	lda	$5, 32($5)												   # 000335
	.loc 1 338
	mult	$f23, $f13, $f13											   # 000338
	mult	$f18, $f0, $f0
	.loc 1 335
	cmplt	$27, $20, $7												   # 000335
	.loc 1 337
	divt	$f29, $f27, $f27											   # 000337
	.loc 1 338
	addt	$f13, $f0, $f0												   # 000338
	mult	$f0, $f27, $f0
	stt	$f0, -32($5)
	.loc 1 337
	ldt	$f24, -24($18)												   # 000337
	ldt	$f16, -16($18)
	.loc 1 338
	ldt	$f15, -24($22)												   # 000338
	ldt	$f26, -24($6)
	.loc 1 337
	addt	$f24, $f16, $f20											   # 000337
	.loc 1 338
	mult	$f15, $f24, $f15											   # 000338
	mult	$f26, $f16, $f16
	.loc 1 337
	divt	$f29, $f20, $f20											   # 000337
	.loc 1 338
	addt	$f15, $f16, $f15											   # 000338
	mult	$f15, $f20, $f15
	stt	$f15, -24($5)
	.loc 1 337
	ldt	$f11, -16($18)												   # 000337
	ldt	$f19, -8($18)
	.loc 1 338
	ldt	$f10, -16($22)												   # 000338
	ldt	$f28, -16($6)
	.loc 1 337
	addt	$f11, $f19, $f17											   # 000337
	.loc 1 338
	mult	$f10, $f11, $f10											   # 000338
	mult	$f28, $f19, $f19
	.loc 1 337
	divt	$f29, $f17, $f17											   # 000337
	.loc 1 338
	addt	$f10, $f19, $f10											   # 000338
	mult	$f10, $f17, $f10
	stt	$f10, -16($5)
	.loc 1 337
	ldt	$f22, -8($18)												   # 000337
	ldt	$f21, ($18)
	.loc 1 338
	ldt	$f14, -8($22)												   # 000338
	ldt	$f12, -8($6)
	.loc 1 337
	addt	$f22, $f21, $f25											   # 000337
	.loc 1 338
	mult	$f14, $f22, $f14											   # 000338
	mult	$f12, $f21, $f12
	.loc 1 337
	divt	$f29, $f25, $f25											   # 000337
	.loc 1 338
	addt	$f14, $f12, $f12											   # 000338
	mult	$f12, $f25, $f12
	stt	$f12, -8($5)
	.loc 1 335
	bne	$24, L$87												   # 000335
	beq	$7, L$82
L$89:
	.loc 1 337
	ldt	$f1, ($18)												   # 000337
	ldt	$f30, 8($18)
	.loc 1 338
	ldt	$f18, ($22)												   # 000338
	ldt	$f13, ($6)
	.loc 1 335
	addl	$27, 1, $27												   # 000335
	lda	$22, 8($22)
	lda	$6, 8($6)
	.loc 1 337
	addt	$f1, $f30, $f23												   # 000337
	.loc 1 335
	cmplt	$27, $20, $25												   # 000335
	lda	$18, 8($18)
	.loc 1 338
	mult	$f18, $f1, $f1												   # 000338
	mult	$f13, $f30, $f13
	.loc 1 335
	lda	$5, 8($5)												   # 000335
	.loc 1 337
	divt	$f29, $f23, $f23											   # 000337
	.loc 1 338
	addt	$f1, $f13, $f1												   # 000338
	mult	$f1, $f23, $f1
	stt	$f1, -8($5)
	.loc 1 335
	bne	$25, L$89												   # 000335
	.loc 1 339
 #    339             }
L$82:															   # 000339
	.loc 1 341
 #    340 
 #    341             riup[0]=rim[0];
	ldt	$f27, ($1)												   # 000341
	.loc 1 342
 #    342             riup[nd-1]=rim[nd-1];
	s8addq	$21, $8, $24												   # 000342
	.loc 1 347
 #    343 
 #    344 /*
 #    345  *           final symmetrized (Feautrier) intensity -- (riin+riup)/2
 #    346  */
 #    347             for(id=0;id<nd;id++)
	subl	$21, 3, $17												   # 000347
	.loc 1 341
	stt	$f27, ($8)												   # 000341
	.loc 1 348
 #    348              jm[id]=(riin[id]+riup[id])/2;
	mov	$8, $2													   # 000348
	.loc 1 342
	ldt	$f0, -8($3)												   # 000342
	.loc 1 347
	clr	$7													   # 000347
	.loc 1 348
	mov	$4, $23													   # 000348
	mov	$19, $5
	.loc 1 342
	stt	$f0, -8($24)												   # 000342
	.loc 1 347
	ble	$21, L$92												   # 000347
	cmple	$17, $21, $16
	.loc 1 348
	subq	$19, $8, $8												   # 000348
	.loc 1 347
	beq	$16, L$96												   # 000347
	.loc 1 348
	lda	$8, 31($8)												   # 000348
	.loc 1 347
	cmplt	$31, $17, $16												   # 000347
	.loc 1 348
	subq	$19, $4, $4												   # 000348
	beq	$16, L$96
	cmpule	$8, 62, $8
	xor	$8, 1, $16
	lda	$4, 31($4)
	beq	$16, L$96
	cmpule	$4, 62, $4
	xor	$4, 1, $16
L$96:
	ldq	$28, ($gp)
	lds	$f24, 4($28)
	.loc 1 347
	beq	$16, L$101												   # 000347
L$99:
	.loc 1 348
	ldt	$f26, ($23)												   # 000348
	ldt	$f16, ($2)
	ldt	$f20, 8($23)
	ldt	$f15, 8($2)
	ldt	$f11, 16($23)
	.loc 1 347
	addl	$7, 4, $7												   # 000347
	.loc 1 348
	ldt	$f28, 16($2)												   # 000348
	lda	$23, 32($23)
	addt	$f26, $f16, $f16
	addt	$f20, $f15, $f15
	.loc 1 347
	cmplt	$7, $17, $25												   # 000347
	.loc 1 348
	lda	$2, 32($2)												   # 000348
	addt	$f11, $f28, $f11
	ldt	$f19, -8($23)
	mult	$f16, $f24, $f16
	.loc 1 347
	cmplt	$7, $21, $27												   # 000347
	lda	$5, 32($5)
	.loc 1 348
	ldt	$f17, -8($2)												   # 000348
	mult	$f15, $f24, $f15
	mult	$f11, $f24, $f11
	stt	$f16, -32($5)
	addt	$f19, $f17, $f17
	stt	$f15, -24($5)
	stt	$f11, -16($5)
	mult	$f17, $f24, $f17
	stt	$f17, -8($5)
	.loc 1 347
	bne	$25, L$99												   # 000347
	beq	$27, L$92
L$101:
	.loc 1 348
	ldt	$f10, ($23)												   # 000348
	ldt	$f22, ($2)
	.loc 1 347
	addl	$7, 1, $7												   # 000347
	lda	$23, 8($23)
	cmplt	$7, $21, $24
	lda	$2, 8($2)
	lda	$5, 8($5)
	.loc 1 348
	addt	$f10, $f22, $f10											   # 000348
	mult	$f10, $f24, $f10
	unop
	stt	$f10, -8($5)
	.loc 1 347
	bne	$24, L$101												   # 000347
	.loc 1 348
L$92:															   # 000348
	.loc 1 350
 #    349 
 #    350  return 0;
	clr	$0													   # 000350
	.loc 1 351
 #    351 }
	ret	($26)													   # 000351
	.end 	dfe_geom1
	.loc 1 353
 #    352 
 #    353 int dfe_geomlimb1(double *dtaum, double *emism, double *dlm, double *jm, 
	.globl  dfe_geomlimb1
	.ent 	dfe_geomlimb1
	.loc 1 353
dfe_geomlimb1:														   # 000353
	ldah	$gp, ($27)
	unop
	lda	$gp, ($gp)
	unop
L$21:
	.loc 1 355
 #    354 	          int nd, double *pool)
 #    355 {
	sextl	$20, $20												   # 000355
	.loc 1 353
	lda	$sp, -16($sp)												   # 000353
	.frame  $sp, 16, $26
	.prologue 1
	.loc 1 368
 #    356 /*
 #    357  *     formal solution of the radiative transfer
 #    358  *     equation by the Discontinuous Finite Element method
 #    359  *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 #    360  */
 #    361 
 #    362  int	id;
 #    363  double	*rim, *rip, *riin, *riup;
 #    364  register double aa, bb, cc, dt0, dtaup1, dtau2, dtt, dl0;
 #    365  
 #    366 	rim=(double *) (pool);
 #    367 	rip=(double *) (pool+nd);
 #    368 	riin=(double *) (pool+2*nd);
	addq	$20, $20, $2												   # 000368
	.loc 1 369
 #    369 	riup=(double *) (pool+3*nd);
	s4subq	$20, $20, $6												   # 000369
	.loc 1 382
 #    370 
 #    371 /*            incoming intensity    
 #    372  *          
 #    373  *            upper boundary condition 
 #    374  */ 
 #    375    
 #    376             rim[0]=0.0;
 #    377 /*
 #    378  *           recurrence relation to determine I^+ and I^- 
 #    379  *           (which are called RIP and RIM)
 #    380  */
 #    381 
 #    382             for(id=0;id<nd-1;id++)
	subl	$20, 1, $7												   # 000382
	.loc 1 367
	s8addq	$20, $21, $1												   # 000367
	.loc 1 376
	stt	$f31, ($21)												   # 000376
	.loc 1 367
	s8addq	$20, $21, $4												   # 000367
	.loc 1 368
	s8addq	$2, $21, $2												   # 000368
	.loc 1 369
	s8addq	$6, $21, $6												   # 000369
	.loc 1 382
	ble	$7, L$24												   # 000382
	subl	$20, 4, $22
	clr	$5
	.loc 1 384
 #    383             {
 #    384              dt0=dtaum[id];
	mov	$16, $8													   # 000384
	.loc 1 385
 #    385              dl0=dlm[id];
	mov	$18, $19												   # 000385
	.loc 1 391
 #    386              dtaup1=dt0+1.0;
 #    387              dtau2=dt0*dt0;
 #    388              cc=2.0*dtaup1;
 #    389              bb=dl0*dtaup1;
 #    390              aa=1.0/(dtau2+cc);
 #    391              rim[id+1]=(2.*rim[id]+dl0*emism[id  ]+bb*emism[id+1])*aa;
	mov	$21, $23												   # 000391
	mov	$17, $24
	.loc 1 382
	cmple	$22, $7, $25												   # 000382
	.loc 1 392
 #    392              rip[id  ]=(cc*rim[id]-dl0*emism[id+1]+bb*emism[id  ])*aa;
	s8addq	$20, $21, $27												   # 000392
	.loc 1 382
	beq	$25, L$26												   # 000382
	cmplt	$31, $22, $25
L$26:
	.loc 1 386
	ldq	$28, ($gp)												   # 000386
	lds	$f0, ($28)
	.loc 1 382
	beq	$25, L$31												   # 000382
L$29:
	.loc 1 384
	ldt	$f1, ($8)												   # 000384
	.loc 1 385
	ldt	$f13, ($19)												   # 000385
	.loc 1 391
	ldt	$f14, ($23)												   # 000391
	ldt	$f15, ($24)
	ldt	$f18, 8($24)
	.loc 1 382
	addl	$5, 4, $5												   # 000382
	cmplt	$5, $22, $3
	.loc 1 385
	lda	$8, 32($8)												   # 000385
	.loc 1 386
	addt	$f1, $f0, $f11												   # 000386
	.loc 1 387
	mult	$f1, $f1, $f10												   # 000387
	.loc 1 391
	lda	$19, 32($19)												   # 000391
	.loc 1 392
	lda	$23, 32($23)												   # 000392
	.loc 1 391
	mult	$f13, $f15, $f15											   # 000391
	addt	$f14, $f14, $f17
	.loc 1 392
	lda	$24, 32($24)												   # 000392
	.loc 1 382
	lda	$27, 32($27)												   # 000382
	cmplt	$5, $7, $25
	.loc 1 388
	addt	$f11, $f11, $f12											   # 000388
	.loc 1 389
	mult	$f13, $f11, $f11											   # 000389
	.loc 1 391
	addt	$f17, $f15, $f15											   # 000391
	.loc 1 390
	addt	$f10, $f12, $f10											   # 000390
	.loc 1 391
	mult	$f11, $f18, $f18											   # 000391
	.loc 1 392
	mult	$f12, $f14, $f12											   # 000392
	.loc 1 390
	divt	$f0, $f10, $f10												   # 000390
	.loc 1 391
	addt	$f15, $f18, $f15											   # 000391
	mult	$f15, $f10, $f15
	stt	$f15, -24($23)
	.loc 1 392
	ldt	$f19, -24($24)												   # 000392
	ldt	$f20, -32($24)
	mult	$f13, $f19, $f16
	mult	$f11, $f20, $f11
	subt	$f12, $f16, $f12
	addt	$f12, $f11, $f11
	mult	$f11, $f10, $f10
	stt	$f10, -32($27)
	.loc 1 384
	ldt	$f21, -24($8)												   # 000384
	.loc 1 385
	ldt	$f25, -24($19)												   # 000385
	.loc 1 391
	ldt	$f26, -24($23)												   # 000391
	ldt	$f27, -24($24)
	ldt	$f30, -16($24)
	.loc 1 386
	addt	$f21, $f0, $f23												   # 000386
	.loc 1 387
	mult	$f21, $f21, $f22											   # 000387
	.loc 1 391
	addt	$f26, $f26, $f29											   # 000391
	mult	$f25, $f27, $f27
	.loc 1 388
	addt	$f23, $f23, $f24											   # 000388
	.loc 1 389
	mult	$f25, $f23, $f23											   # 000389
	.loc 1 391
	addt	$f29, $f27, $f27											   # 000391
	.loc 1 390
	addt	$f22, $f24, $f22											   # 000390
	.loc 1 391
	mult	$f23, $f30, $f30											   # 000391
	.loc 1 392
	mult	$f24, $f26, $f24											   # 000392
	.loc 1 390
	divt	$f0, $f22, $f22												   # 000390
	.loc 1 391
	addt	$f27, $f30, $f27											   # 000391
	mult	$f27, $f22, $f27
	stt	$f27, -16($23)
	.loc 1 392
	ldt	$f1, -16($24)												   # 000392
	ldt	$f13, -24($24)
	mult	$f25, $f1, $f1
	mult	$f23, $f13, $f13
	subt	$f24, $f1, $f1
	addt	$f1, $f13, $f1
	mult	$f1, $f22, $f1
	stt	$f1, -24($27)
	.loc 1 384
	ldt	$f17, -16($8)												   # 000384
	.loc 1 385
	ldt	$f19, -16($19)												   # 000385
	.loc 1 391
	ldt	$f20, -16($23)												   # 000391
	ldt	$f16, -16($24)
	ldt	$f10, -8($24)
	.loc 1 386
	addt	$f17, $f0, $f15												   # 000386
	.loc 1 387
	mult	$f17, $f17, $f18											   # 000387
	.loc 1 391
	mult	$f19, $f16, $f16											   # 000391
	addt	$f20, $f20, $f11
	.loc 1 388
	addt	$f15, $f15, $f14											   # 000388
	.loc 1 389
	mult	$f19, $f15, $f15											   # 000389
	.loc 1 391
	addt	$f11, $f16, $f11											   # 000391
	.loc 1 390
	addt	$f18, $f14, $f18											   # 000390
	.loc 1 392
	mult	$f14, $f20, $f14											   # 000392
	.loc 1 391
	mult	$f15, $f10, $f10											   # 000391
	.loc 1 390
	divt	$f0, $f18, $f18												   # 000390
	.loc 1 391
	addt	$f11, $f10, $f10											   # 000391
	mult	$f10, $f18, $f10
	stt	$f10, -8($23)
	.loc 1 392
	ldt	$f21, -8($24)												   # 000392
	ldt	$f25, -16($24)
	mult	$f19, $f21, $f12
	mult	$f15, $f25, $f15
	subt	$f14, $f12, $f12
	addt	$f12, $f15, $f12
	mult	$f12, $f18, $f12
	stt	$f12, -16($27)
	.loc 1 384
	ldt	$f29, -8($8)												   # 000384
	.loc 1 385
	ldt	$f28, -8($19)												   # 000385
	.loc 1 391
	ldt	$f23, -8($23)												   # 000391
	ldt	$f24, -8($24)
	ldt	$f1, ($24)
	.loc 1 386
	addt	$f29, $f0, $f27												   # 000386
	.loc 1 387
	mult	$f29, $f29, $f30											   # 000387
	.loc 1 391
	addt	$f23, $f23, $f22											   # 000391
	mult	$f28, $f24, $f24
	.loc 1 388
	addt	$f27, $f27, $f26											   # 000388
	.loc 1 389
	mult	$f28, $f27, $f27											   # 000389
	.loc 1 391
	addt	$f22, $f24, $f22											   # 000391
	.loc 1 390
	addt	$f30, $f26, $f30											   # 000390
	.loc 1 391
	mult	$f27, $f1, $f1												   # 000391
	.loc 1 392
	mult	$f26, $f23, $f23											   # 000392
	.loc 1 390
	divt	$f0, $f30, $f30												   # 000390
	.loc 1 391
	addt	$f22, $f1, $f1												   # 000391
	mult	$f1, $f30, $f1
	stt	$f1, ($23)
	.loc 1 392
	ldt	$f17, ($24)												   # 000392
	ldt	$f19, -8($24)
	mult	$f28, $f17, $f13
	mult	$f27, $f19, $f19
	subt	$f23, $f13, $f13
	addt	$f13, $f19, $f13
	mult	$f13, $f30, $f13
	stt	$f13, -8($27)
	.loc 1 382
	bne	$3, L$29												   # 000382
	beq	$25, L$24
L$31:
	.loc 1 384
	ldt	$f16, ($8)												   # 000384
	.loc 1 385
	ldt	$f21, ($19)												   # 000385
	.loc 1 391
	ldt	$f25, ($23)												   # 000391
	ldt	$f14, ($24)
	ldt	$f12, 8($24)
	.loc 1 382
	addl	$5, 1, $5												   # 000382
	lda	$8, 8($8)
	lda	$19, 8($19)
	.loc 1 386
	addt	$f16, $f0, $f10												   # 000386
	.loc 1 387
	mult	$f16, $f16, $f11											   # 000387
	.loc 1 391
	mult	$f21, $f14, $f14											   # 000391
	addt	$f25, $f25, $f18
	.loc 1 382
	cmplt	$5, $7, $3												   # 000382
	.loc 1 392
	lda	$23, 8($23)												   # 000392
	lda	$24, 8($24)
	.loc 1 382
	lda	$27, 8($27)												   # 000382
	.loc 1 388
	addt	$f10, $f10, $f20											   # 000388
	.loc 1 389
	mult	$f21, $f10, $f10											   # 000389
	.loc 1 391
	addt	$f18, $f14, $f14											   # 000391
	.loc 1 390
	addt	$f11, $f20, $f11											   # 000390
	.loc 1 391
	mult	$f10, $f12, $f12											   # 000391
	.loc 1 392
	mult	$f20, $f25, $f20											   # 000392
	.loc 1 390
	divt	$f0, $f11, $f11												   # 000390
	.loc 1 391
	addt	$f14, $f12, $f12											   # 000391
	mult	$f12, $f11, $f12
	stt	$f12, ($23)
	.loc 1 392
	ldt	$f29, ($24)												   # 000392
	ldt	$f28, -8($24)
	mult	$f21, $f29, $f15
	mult	$f10, $f28, $f10
	subt	$f20, $f15, $f15
	addt	$f15, $f10, $f10
	mult	$f10, $f11, $f10
	stt	$f10, -8($27)
	.loc 1 382
	bne	$3, L$31												   # 000382
	.loc 1 393
 #    393             }
L$24:															   # 000393
	.loc 1 395
 #    394 
 #    395             for(id=1;id<nd-1;id++)
	cmple	$7, 1, $22												   # 000395
	bne	$22, L$32
	subl	$20, 4, $8
	mov	1, $25
	.loc 1 398
 #    396             {
 #    397              dtt=1.0/(dlm[id-1]+dlm[id]);
 #    398              riin[id]=(rim[id]*dlm[id]+rip[id]*dlm[id-1])*dtt;
	lda	$0, 8($21)												   # 000398
	lda	$3, 8($4)
	lda	$5, 8($2)
	.loc 1 395
	cmple	$8, $7, $19												   # 000395
	.loc 1 397
	mov	$18, $23												   # 000397
	.loc 1 395
	beq	$19, L$34												   # 000395
	cmple	$8, 1, $24
	xor	$24, 1, $19
L$34:
	.loc 1 397
	ldq	$28, ($gp)												   # 000397
	lds	$f24, ($28)
	.loc 1 395
	beq	$19, L$39												   # 000395
L$37:
	.loc 1 397
	ldt	$f22, ($23)												   # 000397
	ldt	$f1, 8($23)
	.loc 1 398
	ldt	$f17, ($0)												   # 000398
	ldt	$f27, ($3)
	.loc 1 395
	addl	$25, 4, $25												   # 000395
	.loc 1 398
	lda	$23, 32($23)												   # 000398
	.loc 1 395
	cmplt	$25, $8, $24												   # 000395
	.loc 1 398
	lda	$0, 32($0)												   # 000398
	.loc 1 397
	addt	$f22, $f1, $f26												   # 000397
	lda	$3, 32($3)
	.loc 1 395
	lda	$5, 32($5)												   # 000395
	.loc 1 398
	mult	$f17, $f1, $f1												   # 000398
	mult	$f27, $f22, $f22
	.loc 1 395
	cmplt	$25, $7, $19												   # 000395
	.loc 1 397
	divt	$f24, $f26, $f26											   # 000397
	.loc 1 398
	addt	$f1, $f22, $f1												   # 000398
	mult	$f1, $f26, $f1
	stt	$f1, -32($5)
	.loc 1 397
	ldt	$f23, -24($23)												   # 000397
	ldt	$f19, -16($23)
	.loc 1 398
	ldt	$f13, -24($0)												   # 000398
	ldt	$f16, -24($3)
	.loc 1 397
	addt	$f23, $f19, $f30											   # 000397
	.loc 1 398
	mult	$f13, $f19, $f13											   # 000398
	mult	$f16, $f23, $f16
	.loc 1 397
	divt	$f24, $f30, $f30											   # 000397
	.loc 1 398
	addt	$f13, $f16, $f13											   # 000398
	mult	$f13, $f30, $f13
	stt	$f13, -24($5)
	.loc 1 397
	ldt	$f21, -16($23)												   # 000397
	ldt	$f18, -8($23)
	.loc 1 398
	ldt	$f12, -16($0)												   # 000398
	ldt	$f25, -16($3)
	.loc 1 397
	addt	$f21, $f18, $f14											   # 000397
	.loc 1 398
	mult	$f12, $f18, $f12											   # 000398
	mult	$f25, $f21, $f21
	.loc 1 397
	divt	$f24, $f14, $f14											   # 000397
	.loc 1 398
	addt	$f12, $f21, $f12											   # 000398
	mult	$f12, $f14, $f12
	stt	$f12, -16($5)
	.loc 1 397
	ldt	$f29, -8($23)												   # 000397
	ldt	$f28, ($23)
	.loc 1 398
	ldt	$f15, -8($0)												   # 000398
	ldt	$f11, -8($3)
	.loc 1 397
	addt	$f29, $f28, $f20											   # 000397
	.loc 1 398
	mult	$f15, $f28, $f15											   # 000398
	mult	$f11, $f29, $f11
	.loc 1 397
	divt	$f24, $f20, $f20											   # 000397
	.loc 1 398
	addt	$f15, $f11, $f11											   # 000398
	mult	$f11, $f20, $f11
	stt	$f11, -8($5)
	.loc 1 395
	bne	$24, L$37												   # 000395
	beq	$19, L$32
L$39:
	.loc 1 397
	ldt	$f10, ($23)												   # 000397
	ldt	$f0, 8($23)
	.loc 1 398
	ldt	$f27, ($0)												   # 000398
	ldt	$f22, ($3)
	.loc 1 395
	addl	$25, 1, $25												   # 000395
	lda	$0, 8($0)
	lda	$3, 8($3)
	.loc 1 397
	addt	$f10, $f0, $f17												   # 000397
	.loc 1 395
	cmplt	$25, $7, $8												   # 000395
	lda	$23, 8($23)
	.loc 1 398
	mult	$f27, $f0, $f0												   # 000398
	mult	$f22, $f10, $f10
	.loc 1 395
	lda	$5, 8($5)												   # 000395
	.loc 1 397
	divt	$f24, $f17, $f17											   # 000397
	.loc 1 398
	addt	$f0, $f10, $f0												   # 000398
	mult	$f0, $f17, $f0
	stt	$f0, -8($5)
	.loc 1 395
	bne	$8, L$39												   # 000395
	.loc 1 399
 #    399             }
L$32:															   # 000399
	.loc 1 401
 #    400 
 #    401             riin[0]=rim[0];
	ldt	$f26, ($21)												   # 000401
	.loc 1 415
 #    402             riin[nd-1]=rim[nd-1];
 #    403 
 #    404 /*               
 #    405  *           outgoing intensity 
 #    406  *   
 #    407  *           lower boundary condition 
 #    408  */
 #    409             rim[nd-1]=riin[nd-1];
 #    410 
 #    411 /*
 #    412  *           recurrence relation to determine I^+ and I^-
 #    413  *
 #    414  */
 #    415             for(id=nd-2;id>=0;id--)
	subl	$20, 2, $0												   # 000415
	.loc 1 419
 #    416             {
 #    417              dt0=dtaum[id];
 #    418              dl0=dlm[id];
 #    419              dtaup1=dt0+1.0;
	ldq	$28, ($gp)												   # 000419
	.loc 1 401
	stt	$f26, ($2)												   # 000401
	.loc 1 402
	s8addq	$20, $2, $2												   # 000402
	ldt	$f1, -8($1)
	.loc 1 424
 #    420              dtau2=dt0*dt0;
 #    421              cc=2.0*dtaup1;
 #    422              bb=dl0*dtaup1;
 #    423              aa=1.0/(dtau2+cc);
 #    424              rim[id  ]=(2.*rim[id+1]+dl0*emism[id+1]+bb*emism[id  ])*aa;
	s8addq	$0, $21, $5												   # 000424
	s8addq	$0, $17, $17
	.loc 1 425
 #    425              rip[id+1]=(cc*rim[id+1]-dl0*emism[id  ]+bb*emism[id+1])*aa;
	s8addq	$0, $4, $8												   # 000425
	.loc 1 402
	stt	$f1, -8($2)												   # 000402
	.loc 1 417
	s8addq	$0, $16, $16												   # 000417
	.loc 1 409
	stt	$f1, -8($1)												   # 000409
	.loc 1 415
	blt	$0, L$40												   # 000415
	.loc 1 418
	s8addq	$0, $18, $3												   # 000418
	.loc 1 424
	lda	$5, 8($5)												   # 000424
	lda	$17, 8($17)
	.loc 1 425
	lda	$8, 8($8)												   # 000425
	.loc 1 419
	lds	$f19, ($28)												   # 000419
	.loc 1 415
	cmplt	$0, 3, $23												   # 000415
	bne	$23, L$46
	unop
L$44:
	.loc 1 417
	ldt	$f23, ($16)												   # 000417
	.loc 1 418
	ldt	$f18, ($3)												   # 000418
	.loc 1 424
	ldt	$f25, ($5)												   # 000424
	ldt	$f21, ($17)
	ldt	$f28, -8($17)
	.loc 1 415
	subl	$0, 4, $0												   # 000415
	cmplt	$0, 3, $25
	.loc 1 418
	lda	$16, -32($16)												   # 000418
	.loc 1 419
	addt	$f23, $f19, $f30											   # 000419
	.loc 1 420
	mult	$f23, $f23, $f16											   # 000420
	.loc 1 424
	lda	$3, -32($3)												   # 000424
	.loc 1 425
	lda	$5, -32($5)												   # 000425
	.loc 1 424
	mult	$f18, $f21, $f21											   # 000424
	addt	$f25, $f25, $f12
	.loc 1 425
	lda	$17, -32($17)												   # 000425
	.loc 1 415
	lda	$8, -32($8)												   # 000415
	.loc 1 421
	addt	$f30, $f30, $f13											   # 000421
	.loc 1 422
	mult	$f18, $f30, $f30											   # 000422
	.loc 1 424
	addt	$f12, $f21, $f12											   # 000424
	.loc 1 423
	addt	$f16, $f13, $f16											   # 000423
	.loc 1 424
	mult	$f30, $f28, $f28											   # 000424
	.loc 1 425
	mult	$f13, $f25, $f13											   # 000425
	.loc 1 423
	divt	$f19, $f16, $f16											   # 000423
	.loc 1 424
	addt	$f12, $f28, $f12											   # 000424
	mult	$f12, $f16, $f12
	stt	$f12, 24($5)
	.loc 1 425
	ldt	$f29, 24($17)												   # 000425
	ldt	$f15, 32($17)
	mult	$f18, $f29, $f14
	mult	$f30, $f15, $f15
	subt	$f13, $f14, $f13
	addt	$f13, $f15, $f13
	mult	$f13, $f16, $f13
	stt	$f13, 32($8)
	.loc 1 417
	ldt	$f20, 24($16)												   # 000417
	.loc 1 418
	ldt	$f10, 24($3)												   # 000418
	.loc 1 424
	ldt	$f17, 24($5)												   # 000424
	ldt	$f0, 24($17)
	ldt	$f1, 16($17)
	.loc 1 419
	addt	$f20, $f19, $f27											   # 000419
	.loc 1 420
	mult	$f20, $f20, $f11											   # 000420
	.loc 1 424
	mult	$f10, $f0, $f0												   # 000424
	addt	$f17, $f17, $f26
	.loc 1 421
	addt	$f27, $f27, $f22											   # 000421
	.loc 1 422
	mult	$f10, $f27, $f27											   # 000422
	.loc 1 424
	addt	$f26, $f0, $f0												   # 000424
	.loc 1 423
	addt	$f11, $f22, $f11											   # 000423
	.loc 1 425
	mult	$f22, $f17, $f17											   # 000425
	.loc 1 424
	mult	$f27, $f1, $f1												   # 000424
	.loc 1 423
	divt	$f19, $f11, $f11											   # 000423
	.loc 1 424
	addt	$f0, $f1, $f0												   # 000424
	mult	$f0, $f11, $f0
	stt	$f0, 16($5)
	.loc 1 425
	ldt	$f23, 16($17)												   # 000425
	ldt	$f18, 24($17)
	mult	$f10, $f23, $f23
	mult	$f27, $f18, $f18
	subt	$f17, $f23, $f17
	addt	$f17, $f18, $f17
	mult	$f17, $f11, $f11
	stt	$f11, 24($8)
	.loc 1 417
	ldt	$f21, 16($16)												   # 000417
	.loc 1 418
	ldt	$f29, 16($3)												   # 000418
	.loc 1 424
	ldt	$f30, 16($5)												   # 000424
	ldt	$f14, 16($17)
	ldt	$f13, 8($17)
	.loc 1 419
	addt	$f21, $f19, $f12											   # 000419
	.loc 1 420
	mult	$f21, $f21, $f28											   # 000420
	.loc 1 424
	addt	$f30, $f30, $f16											   # 000424
	mult	$f29, $f14, $f14
	.loc 1 421
	addt	$f12, $f12, $f25											   # 000421
	.loc 1 422
	mult	$f29, $f12, $f12											   # 000422
	.loc 1 424
	addt	$f16, $f14, $f14											   # 000424
	.loc 1 423
	addt	$f28, $f25, $f28											   # 000423
	.loc 1 424
	mult	$f12, $f13, $f13											   # 000424
	.loc 1 425
	mult	$f25, $f30, $f25											   # 000425
	.loc 1 423
	divt	$f19, $f28, $f28											   # 000423
	.loc 1 424
	addt	$f14, $f13, $f13											   # 000424
	mult	$f13, $f28, $f13
	stt	$f13, 8($5)
	.loc 1 425
	ldt	$f20, 8($17)												   # 000425
	ldt	$f10, 16($17)
	mult	$f29, $f20, $f15
	mult	$f12, $f10, $f10
	subt	$f25, $f15, $f15
	addt	$f15, $f10, $f10
	mult	$f10, $f28, $f10
	stt	$f10, 16($8)
	.loc 1 417
	ldt	$f26, 8($16)												   # 000417
	.loc 1 418
	ldt	$f24, 8($3)												   # 000418
	.loc 1 424
	ldt	$f27, 8($5)												   # 000424
	ldt	$f23, 8($17)
	ldt	$f11, ($17)
	.loc 1 419
	addt	$f26, $f19, $f0												   # 000419
	.loc 1 420
	mult	$f26, $f26, $f1												   # 000420
	.loc 1 424
	mult	$f24, $f23, $f23											   # 000424
	addt	$f27, $f27, $f17
	.loc 1 421
	addt	$f0, $f0, $f22												   # 000421
	.loc 1 422
	mult	$f24, $f0, $f0												   # 000422
	.loc 1 424
	addt	$f17, $f23, $f17											   # 000424
	.loc 1 423
	addt	$f1, $f22, $f1												   # 000423
	.loc 1 424
	mult	$f0, $f11, $f11												   # 000424
	.loc 1 425
	mult	$f22, $f27, $f22											   # 000425
	.loc 1 423
	divt	$f19, $f1, $f1												   # 000423
	.loc 1 424
	addt	$f17, $f11, $f11											   # 000424
	mult	$f11, $f1, $f11
	stt	$f11, ($5)
	.loc 1 425
	ldt	$f21, ($17)												   # 000425
	ldt	$f29, 8($17)
	mult	$f24, $f21, $f18
	mult	$f0, $f29, $f0
	subt	$f22, $f18, $f18
	addt	$f18, $f0, $f0
	mult	$f0, $f1, $f0
	stt	$f0, 8($8)
	.loc 1 415
	beq	$25, L$44												   # 000415
	blt	$0, L$40
L$46:
	.loc 1 417
	ldt	$f16, ($16)												   # 000417
	.loc 1 418
	ldt	$f20, ($3)												   # 000418
	.loc 1 424
	ldt	$f12, ($5)												   # 000424
	ldt	$f25, ($17)
	ldt	$f10, -8($17)
	.loc 1 415
	subl	$0, 1, $0												   # 000415
	lda	$16, -8($16)
	.loc 1 419
	addt	$f16, $f19, $f13											   # 000419
	.loc 1 420
	mult	$f16, $f16, $f14											   # 000420
	.loc 1 415
	lda	$3, -8($3)												   # 000415
	.loc 1 425
	lda	$5, -8($5)												   # 000425
	.loc 1 424
	addt	$f12, $f12, $f28											   # 000424
	.loc 1 425
	lda	$17, -8($17)												   # 000425
	.loc 1 415
	lda	$8, -8($8)												   # 000415
	.loc 1 424
	mult	$f20, $f25, $f25											   # 000424
	.loc 1 421
	addt	$f13, $f13, $f30											   # 000421
	.loc 1 422
	mult	$f20, $f13, $f13											   # 000422
	.loc 1 424
	addt	$f28, $f25, $f25											   # 000424
	.loc 1 423
	addt	$f14, $f30, $f14											   # 000423
	.loc 1 424
	mult	$f13, $f10, $f10											   # 000424
	.loc 1 425
	mult	$f30, $f12, $f12											   # 000425
	.loc 1 423
	divt	$f19, $f14, $f14											   # 000423
	.loc 1 424
	addt	$f25, $f10, $f10											   # 000424
	mult	$f10, $f14, $f10
	stt	$f10, ($5)
	.loc 1 425
	ldt	$f26, ($17)												   # 000425
	ldt	$f24, 8($17)
	mult	$f20, $f26, $f15
	mult	$f13, $f24, $f13
	subt	$f12, $f15, $f12
	addt	$f12, $f13, $f12
	mult	$f12, $f14, $f12
	stt	$f12, 8($8)
	.loc 1 415
	bge	$0, L$46												   # 000415
	.loc 1 426
 #    426             }
L$40:															   # 000426
	.loc 1 428
 #    427 
 #    428             for(id=1;id<nd-1;id++)
	bne	$22, L$47												   # 000428
	subl	$20, 4, $19
	mov	1, $27
	.loc 1 431
 #    429             {
 #    430              dtt=1.0/(dlm[id-1]+dlm[id]);
 #    431              riup[id]=(rim[id]*dlm[id-1]+rip[id]*dlm[id])*dtt;
	lda	$2, 8($21)												   # 000431
	lda	$4, 8($4)
	lda	$23, 8($6)
	.loc 1 428
	cmple	$19, $7, $25												   # 000428
	beq	$25, L$49
	cmple	$19, 1, $0
	xor	$0, 1, $25
L$49:
	.loc 1 430
	ldq	$28, ($gp)												   # 000430
	lds	$f23, ($28)
	.loc 1 428
	beq	$25, L$54												   # 000428
L$52:
	.loc 1 430
	ldt	$f17, ($18)												   # 000430
	ldt	$f11, 8($18)
	.loc 1 431
	ldt	$f21, ($2)												   # 000431
	ldt	$f29, ($4)
	.loc 1 428
	addl	$27, 4, $27												   # 000428
	.loc 1 431
	lda	$18, 32($18)												   # 000431
	.loc 1 428
	cmplt	$27, $19, $17												   # 000428
	.loc 1 431
	lda	$2, 32($2)												   # 000431
	.loc 1 430
	addt	$f17, $f11, $f27											   # 000430
	lda	$4, 32($4)
	.loc 1 428
	lda	$23, 32($23)												   # 000428
	.loc 1 431
	mult	$f21, $f17, $f17											   # 000431
	mult	$f29, $f11, $f11
	.loc 1 428
	cmplt	$27, $7, $22												   # 000428
	.loc 1 430
	divt	$f23, $f27, $f27											   # 000430
	.loc 1 431
	addt	$f17, $f11, $f11											   # 000431
	mult	$f11, $f27, $f11
	stt	$f11, -32($23)
	.loc 1 430
	ldt	$f22, -24($18)												   # 000430
	ldt	$f18, -16($18)
	.loc 1 431
	ldt	$f0, -24($2)												   # 000431
	ldt	$f16, -24($4)
	.loc 1 430
	addt	$f22, $f18, $f1												   # 000430
	.loc 1 431
	mult	$f0, $f22, $f0												   # 000431
	mult	$f16, $f18, $f16
	.loc 1 430
	divt	$f23, $f1, $f1												   # 000430
	.loc 1 431
	addt	$f0, $f16, $f0												   # 000431
	mult	$f0, $f1, $f0
	stt	$f0, -24($23)
	.loc 1 430
	ldt	$f20, -16($18)												   # 000430
	ldt	$f28, -8($18)
	.loc 1 431
	ldt	$f10, -16($2)												   # 000431
	ldt	$f30, -16($4)
	.loc 1 430
	addt	$f20, $f28, $f25											   # 000430
	.loc 1 431
	mult	$f10, $f20, $f10											   # 000431
	mult	$f30, $f28, $f28
	.loc 1 430
	divt	$f23, $f25, $f25											   # 000430
	.loc 1 431
	addt	$f10, $f28, $f10											   # 000431
	mult	$f10, $f25, $f10
	stt	$f10, -16($23)
	.loc 1 430
	ldt	$f26, -8($18)												   # 000430
	ldt	$f24, ($18)
	.loc 1 431
	ldt	$f13, -8($2)												   # 000431
	ldt	$f14, -8($4)
	.loc 1 430
	addt	$f26, $f24, $f15											   # 000430
	.loc 1 431
	mult	$f13, $f26, $f13											   # 000431
	mult	$f14, $f24, $f14
	.loc 1 430
	divt	$f23, $f15, $f15											   # 000430
	.loc 1 431
	addt	$f13, $f14, $f13											   # 000431
	mult	$f13, $f15, $f13
	stt	$f13, -8($23)
	.loc 1 428
	bne	$17, L$52												   # 000428
	beq	$22, L$47
L$54:
	.loc 1 430
	ldt	$f12, ($18)												   # 000430
	ldt	$f19, 8($18)
	unop
	.loc 1 431
	ldt	$f29, ($2)												   # 000431
	ldt	$f17, ($4)
	.loc 1 428
	addl	$27, 1, $27												   # 000428
	lda	$2, 8($2)
	lda	$4, 8($4)
	lda	$18, 8($18)
	.loc 1 430
	addt	$f12, $f19, $f21											   # 000430
	unop
	.loc 1 431
	mult	$f29, $f12, $f12											   # 000431
	.loc 1 428
	cmplt	$27, $7, $3												   # 000428
	lda	$23, 8($23)
	.loc 1 431
	mult	$f17, $f19, $f17											   # 000431
	.loc 1 430
	divt	$f23, $f21, $f21											   # 000430
	.loc 1 431
	addt	$f12, $f17, $f12											   # 000431
	mult	$f12, $f21, $f12
	stt	$f12, -8($23)
	.loc 1 428
	bne	$3, L$54												   # 000428
	.loc 1 432
 #    432             }
L$47:															   # 000432
	.loc 1 434
 #    433 
 #    434             riup[0]=rim[0];
	ldt	$f27, ($21)												   # 000434
	.loc 1 435
 #    435             riup[nd-1]=rim[nd-1];
	s8addq	$20, $6, $20												   # 000435
	.loc 1 434
	stt	$f27, ($6)												   # 000434
	.loc 1 435
	ldt	$f11, -8($1)												   # 000435
	stt	$f11, -8($20)
	.loc 1 437
 #    436 
 #    437  return riup[0];
	ldt	$f22, ($6)												   # 000437
	cvttqc	$f22, $f22
	stt	$f22, ($sp)
	cmoveq	$31, $sp, $sp
	ldl	$0, ($sp)
	.loc 1 438
 #    438 }
	lda	$sp, 16($sp)												   # 000438
	ret	($26)
	.end 	dfe_geomlimb1
	unop
	unop
	unop
	.loc 1 440
 #    439 
 #    440 double dfe_geomlimb2(double *dtaum, double *emism, double *dlm, int nd )
	.globl  dfe_geomlimb2
	.ent 	dfe_geomlimb2
	.loc 1 440
dfe_geomlimb2:														   # 000440
	ldah	$gp, ($27)
	unop
	lda	$gp, ($gp)
	unop
	.frame  $sp, 0, $26
	.prologue 1
L$2:
	.loc 1 441
 #    441 {
	sextl	$19, $19												   # 000441
	.loc 1 457
 #    442 /*
 #    443  *     formal solution of the radiative transfer
 #    444  *     equation by the Discontinuous Finite Element method
 #    445  *     Castor, Dykema, Klein, 1992, ApJ 387, 561.
 #    446  */
 #    447 
 #    448  int	id;
 #    449  register double rim0, aa, bb, cc, dt0, dtaup1, dtau2, dl0;
 #    450  
 #    451 
 #    452 /*            incoming intensity    
 #    453  *          
 #    454  *            upper boundary condition 
 #    455  */ 
 #    456    
 #    457             rim0=0.0;
	fclr	$f0													   # 000457
	.loc 1 463
 #    458 /*
 #    459  *           recurrence relation to determine I^+ and I^- 
 #    460  *           (which are called RIP and RIM)
 #    461  */
 #    462 
 #    463             for(id=0;id<nd-1;id++)
	clr	$2													   # 000463
	subl	$19, 1, $1
	ble	$1, L$5
	subl	$19, 4, $3
	.loc 1 465
 #    464             {
 #    465              dt0=dtaum[id];
	mov	$16, $4													   # 000465
	.loc 1 466
 #    466              dl0=dlm[id];
	mov	$18, $5													   # 000466
	.loc 1 463
	cmple	$3, $1, $6												   # 000463
	.loc 1 472
 #    467              dtaup1=dt0+1.0;
 #    468              dtau2=dt0*dt0;
 #    469              cc=2.0*dtaup1;
 #    470              bb=dl0*dtaup1;
 #    471              aa=1.0/(dtau2+cc);
 #    472              rim0=(2.*rim0+dl0*emism[id  ]+bb*emism[id+1])*aa;
	mov	$17, $7													   # 000472
	.loc 1 463
	beq	$6, L$7													   # 000463
	cmplt	$31, $3, $6
L$7:
	.loc 1 467
	ldq	$28, ($gp)												   # 000467
	lds	$f1, ($28)
	.loc 1 463
	beq	$6, L$12												   # 000463
	unop
L$10:
	.loc 1 465
	ldt	$f10, ($4)												   # 000465
	ldt	$f14, 8($4)
	.loc 1 472
	addt	$f0, $f0, $f0												   # 000472
	.loc 1 465
	ldt	$f18, 16($4)												   # 000465
	ldt	$f26, 24($4)
	.loc 1 466
	ldt	$f22, ($5)												   # 000466
	ldt	$f30, 8($5)
	.loc 1 472
	ldt	$f23, ($7)												   # 000472
	ldt	$f25, 8($7)
	ldt	$f24, 32($7)
	.loc 1 467
	addt	$f10, $f1, $f12												   # 000467
	.loc 1 468
	mult	$f10, $f10, $f11											   # 000468
	.loc 1 467
	addt	$f14, $f1, $f16												   # 000467
	.loc 1 468
	mult	$f14, $f14, $f15											   # 000468
	.loc 1 466
	ldt	$f14, 16($5)												   # 000466
	.loc 1 463
	addl	$2, 4, $2												   # 000463
	.loc 1 467
	addt	$f18, $f1, $f20												   # 000467
	.loc 1 468
	mult	$f18, $f18, $f19											   # 000468
	.loc 1 463
	cmplt	$2, $3, $23												   # 000463
	lda	$4, 32($4)
	.loc 1 472
	mult	$f22, $f23, $f23											   # 000472
	.loc 1 467
	addt	$f26, $f1, $f28												   # 000467
	.loc 1 471
	lda	$7, 32($7)												   # 000471
	.loc 1 472
	lda	$5, 32($5)												   # 000472
	ldt	$f18, -8($7)
	.loc 1 469
	addt	$f12, $f12, $f13											   # 000469
	.loc 1 470
	mult	$f22, $f12, $f12											   # 000470
	.loc 1 463
	cmplt	$2, $1, $24												   # 000463
	.loc 1 469
	addt	$f16, $f16, $f17											   # 000469
	.loc 1 470
	mult	$f30, $f16, $f10											   # 000470
	.loc 1 469
	addt	$f20, $f20, $f21											   # 000469
	.loc 1 468
	mult	$f26, $f26, $f27											   # 000468
	.loc 1 472
	addt	$f0, $f23, $f0												   # 000472
	.loc 1 470
	mult	$f14, $f20, $f20											   # 000470
	.loc 1 471
	addt	$f11, $f13, $f11											   # 000471
	.loc 1 472
	ldt	$f13, -16($7)												   # 000472
	.loc 1 471
	addt	$f15, $f17, $f15											   # 000471
	.loc 1 472
	mult	$f12, $f25, $f12											   # 000472
	.loc 1 471
	addt	$f19, $f21, $f19											   # 000471
	.loc 1 466
	ldt	$f21, -8($5)												   # 000466
	.loc 1 472
	mult	$f30, $f25, $f25											   # 000472
	.loc 1 469
	addt	$f28, $f28, $f29											   # 000469
	.loc 1 471
	divt	$f1, $f11, $f11												   # 000471
	.loc 1 472
	mult	$f10, $f13, $f10											   # 000472
	addt	$f0, $f12, $f0
	mult	$f14, $f13, $f13
	mult	$f20, $f18, $f20
	.loc 1 471
	addt	$f27, $f29, $f27											   # 000471
	.loc 1 470
	mult	$f21, $f28, $f28											   # 000470
	.loc 1 472
	mult	$f21, $f18, $f18											   # 000472
	mult	$f28, $f24, $f24
	.loc 1 471
	divt	$f1, $f15, $f15												   # 000471
	.loc 1 472
	mult	$f0, $f11, $f0												   # 000472
	addt	$f0, $f0, $f0
	addt	$f0, $f25, $f0
	addt	$f0, $f10, $f0
	.loc 1 471
	divt	$f1, $f19, $f19												   # 000471
	.loc 1 472
	mult	$f0, $f15, $f0												   # 000472
	addt	$f0, $f0, $f0
	addt	$f0, $f13, $f0
	addt	$f0, $f20, $f0
	.loc 1 471
	divt	$f1, $f27, $f27												   # 000471
	.loc 1 472
	mult	$f0, $f19, $f0												   # 000472
	addt	$f0, $f0, $f0
	addt	$f0, $f18, $f0
	addt	$f0, $f24, $f0
	mult	$f0, $f27, $f0
	.loc 1 463
	bne	$23, L$10												   # 000463
	beq	$24, L$5
L$12:
	.loc 1 465
	ldt	$f23, ($4)												   # 000465
	.loc 1 466
	ldt	$f29, ($5)												   # 000466
	.loc 1 472
	addt	$f0, $f0, $f0												   # 000472
	ldt	$f30, ($7)
	ldt	$f25, 8($7)
	.loc 1 463
	addl	$2, 1, $2												   # 000463
	lda	$4, 8($4)
	lda	$5, 8($5)
	lda	$7, 8($7)
	.loc 1 467
	addt	$f23, $f1, $f12												   # 000467
	.loc 1 468
	mult	$f23, $f23, $f26											   # 000468
	.loc 1 472
	mult	$f29, $f30, $f30											   # 000472
	.loc 1 463
	cmplt	$2, $1, $8												   # 000463
	.loc 1 469
	addt	$f12, $f12, $f11											   # 000469
	.loc 1 470
	mult	$f29, $f12, $f12											   # 000470
	.loc 1 472
	addt	$f0, $f30, $f0												   # 000472
	.loc 1 471
	addt	$f26, $f11, $f11											   # 000471
	.loc 1 472
	mult	$f12, $f25, $f12											   # 000472
	.loc 1 471
	divt	$f1, $f11, $f11												   # 000471
	.loc 1 472
	addt	$f0, $f12, $f0												   # 000472
	mult	$f0, $f11, $f0
	.loc 1 463
	bne	$8, L$12												   # 000463
	.loc 1 473
 #    473             }
L$5:															   # 000473
	.loc 1 480
 #    474 
 #    475 /*               
 #    476  *           outgoing intensity 
 #    477  *   
 #    478  *           lower boundary condition 
 #    479  */
 #    480             for(id=nd-2;id>=0;id--)
	subl	$19, 2, $19												   # 000480
	blt	$19, L$13
	.loc 1 489
 #    481             {
 #    482              dt0=dtaum[id];
 #    483              dl0=dlm[id];
 #    484              dtaup1=dt0+1.0;
 #    485              dtau2=dt0*dt0;
 #    486              cc=2.0*dtaup1;
 #    487              bb=dl0*dtaup1;
 #    488              aa=1.0/(dtau2+cc);
 #    489              rim0=(2.*rim0+dl0*emism[id+1]+bb*emism[id  ])*aa;
	s8addq	$19, $17, $17												   # 000489
	.loc 1 484
	ldq	$28, ($gp)												   # 000484
	.loc 1 482
	s8addq	$19, $16, $16												   # 000482
	.loc 1 484
	lds	$f10, ($28)												   # 000484
	.loc 1 483
	s8addq	$19, $18, $18												   # 000483
	.loc 1 480
	cmplt	$19, 3, $6												   # 000480
	.loc 1 489
	lda	$17, 8($17)												   # 000489
	.loc 1 480
	bne	$6, L$19												   # 000480
L$17:
	.loc 1 482
	ldt	$f15, ($16)												   # 000482
	ldt	$f20, -8($16)
	.loc 1 489
	addt	$f0, $f0, $f0												   # 000489
	.loc 1 482
	ldt	$f28, -16($16)												   # 000482
	ldt	$f30, -24($16)
	.loc 1 483
	ldt	$f23, ($18)												   # 000483
	.loc 1 489
	ldt	$f26, ($17)												   # 000489
	ldt	$f16, -8($17)
	.loc 1 480
	subl	$19, 4, $19												   # 000480
	.loc 1 489
	ldt	$f29, -32($17)												   # 000489
	.loc 1 484
	addt	$f15, $f10, $f17											   # 000484
	.loc 1 483
	ldt	$f1, -8($18)												   # 000483
	.loc 1 485
	mult	$f15, $f15, $f14											   # 000485
	.loc 1 484
	addt	$f20, $f10, $f21											   # 000484
	.loc 1 480
	lda	$16, -32($16)												   # 000480
	.loc 1 485
	mult	$f20, $f20, $f19											   # 000485
	.loc 1 484
	addt	$f28, $f10, $f24											   # 000484
	.loc 1 480
	cmplt	$19, 3, $3												   # 000480
	.loc 1 489
	lda	$17, -32($17)												   # 000489
	mult	$f23, $f26, $f26
	.loc 1 484
	addt	$f30, $f10, $f12											   # 000484
	.loc 1 488
	lda	$18, -32($18)												   # 000488
	.loc 1 483
	ldt	$f20, 16($18)												   # 000483
	.loc 1 486
	addt	$f17, $f17, $f13											   # 000486
	.loc 1 487
	mult	$f23, $f17, $f17											   # 000487
	.loc 1 486
	addt	$f21, $f21, $f22											   # 000486
	.loc 1 485
	mult	$f28, $f28, $f18											   # 000485
	.loc 1 489
	ldt	$f28, 8($17)												   # 000489
	addt	$f0, $f26, $f0
	.loc 1 487
	mult	$f1, $f21, $f15												   # 000487
	.loc 1 486
	addt	$f24, $f24, $f27											   # 000486
	.loc 1 488
	addt	$f14, $f13, $f13											   # 000488
	.loc 1 489
	ldt	$f14, 16($17)												   # 000489
	mult	$f17, $f16, $f17
	.loc 1 488
	addt	$f19, $f22, $f19											   # 000488
	.loc 1 489
	mult	$f1, $f16, $f16												   # 000489
	.loc 1 486
	addt	$f12, $f12, $f11											   # 000486
	.loc 1 488
	addt	$f18, $f27, $f18											   # 000488
	.loc 1 483
	ldt	$f27, 8($18)												   # 000483
	.loc 1 488
	divt	$f10, $f13, $f13											   # 000488
	.loc 1 489
	mult	$f15, $f14, $f15											   # 000489
	addt	$f0, $f17, $f0
	.loc 1 485
	mult	$f30, $f30, $f25											   # 000485
	.loc 1 487
	mult	$f20, $f24, $f24											   # 000487
	.loc 1 489
	mult	$f20, $f14, $f14											   # 000489
	.loc 1 487
	mult	$f27, $f12, $f12											   # 000487
	.loc 1 488
	addt	$f25, $f11, $f11											   # 000488
	.loc 1 489
	mult	$f24, $f28, $f24											   # 000489
	mult	$f27, $f28, $f23
	mult	$f12, $f29, $f12
	.loc 1 488
	divt	$f10, $f19, $f19											   # 000488
	.loc 1 489
	mult	$f0, $f13, $f0												   # 000489
	addt	$f0, $f0, $f0
	addt	$f0, $f16, $f0
	addt	$f0, $f15, $f0
	.loc 1 488
	divt	$f10, $f18, $f18											   # 000488
	.loc 1 489
	mult	$f0, $f19, $f0												   # 000489
	addt	$f0, $f0, $f0
	addt	$f0, $f14, $f0
	addt	$f0, $f24, $f0
	.loc 1 488
	divt	$f10, $f11, $f11											   # 000488
	.loc 1 489
	mult	$f0, $f18, $f0												   # 000489
	addt	$f0, $f0, $f0
	addt	$f0, $f23, $f0
	addt	$f0, $f12, $f0
	mult	$f0, $f11, $f0
	.loc 1 480
	beq	$3, L$17												   # 000480
	blt	$19, L$13
L$19:
	.loc 1 482
	ldt	$f26, ($16)												   # 000482
	.loc 1 483
	ldt	$f25, ($18)												   # 000483
	.loc 1 489
	addt	$f0, $f0, $f0												   # 000489
	ldt	$f1, ($17)
	ldt	$f16, -8($17)
	.loc 1 480
	subl	$19, 1, $19												   # 000480
	lda	$16, -8($16)
	lda	$18, -8($18)
	lda	$17, -8($17)
	.loc 1 484
	addt	$f26, $f10, $f17											   # 000484
	.loc 1 485
	mult	$f26, $f26, $f30											   # 000485
	.loc 1 489
	mult	$f25, $f1, $f1												   # 000489
	.loc 1 486
	addt	$f17, $f17, $f13											   # 000486
	.loc 1 487
	mult	$f25, $f17, $f17											   # 000487
	.loc 1 489
	addt	$f0, $f1, $f0												   # 000489
	.loc 1 488
	addt	$f30, $f13, $f13											   # 000488
	.loc 1 489
	mult	$f17, $f16, $f16											   # 000489
	.loc 1 488
	divt	$f10, $f13, $f13											   # 000488
	.loc 1 489
	addt	$f0, $f16, $f0												   # 000489
	mult	$f0, $f13, $f0
	.loc 1 480
	bge	$19, L$19												   # 000480
	.loc 1 490
 #    490             }
L$13:															   # 000490
	.loc 1 494
 #    491 
 #    492 
 #    493  return rim0;
 #    494 }
	ret	($26)													   # 000494
	.end 	dfe_geomlimb2
$$1:
	.long	0x3F800000 # .float 1.000000
$$2:
	.long	0x3F000000 # .float 0.5000000
