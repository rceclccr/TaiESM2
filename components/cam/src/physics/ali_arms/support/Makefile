#C = gcc -ansi -pedantic -Wall -Wtraditional -Wpointer-arith -Wcast-qual \
#	-Wcast-align -Wwrite-strings -Wconversion -Wstrict-prototypes \
#	-Wmissing-prototypes -Waggregate-return -g -ffpe-trap=zero,overflow,invalid
C = gcc -g -ffpe-trap=zero,overflow,invalid


INCLUDES = -I. -I../include

#CSPEEDFLAGS = -finline-functions -fcaller-saves -fthread-jumps -funroll-loops

#CADDFLAGS = -D_REENTRANT

#CDEBUGFLAGS =  -g -DDEBUG -DNEW_FEATURES #-DPRINT #-DDUMP_CO2 #-DDEBUG_1 -ffpe-trap=zero,overflow,invalid

CFLAGS = -ansi -pedantic $(CSPEEDFLAGS) $(CDEBUGFLAGS) $(CADDFLAGS) $(INCLUDES) -g -ffpe-trap=zero,overflow,invalid

LIBS = -lm 

OBJS =  ../ali.o\
	../NAVV-odf1.o\
	../odf_init.o\
	../utils.o \
        ../mv_utils.o \
	../read_parameters.o \
	../print.o \
	../input_mol_data.o \
	../input_vl_data.o \
	../atmosphere.o \
	../init_F.o \
	../intheproblem.o \
	../Qrot.o \
	../init_CVV.o \
	../co2_DEBYE.o \
	../popul1.o \
	../NCVT.o \
	../NCVV.o \
	../solve.o \
	../inv.o \
	../ng.o \
	../ch.o \
	../subs/gauss.o \
	../subs/interpol.o \
	../subs/reflect.o \
	../subs/voigt.o \
	../subs/planck.o \
	../subs/dfe.o \
	../subs/shortc.o \
	../subs/fea_ih.o \
	../subs/exp_along.o \
	../subs/etime.o

all:	RadCoolHeat

RadCoolHeat: $(OBJS)
	gfortran  -ffpe-trap=zero,overflow,invalid -g main.f wrapper.f $(OBJS) -o RadCoolHeat.exe $(LIBS)

clean:
	/bin/rm -f RadCoolHeat.exe \
                $(OBJS) main.o *~\
		../include/*~ ../subs/*~
		
# DO NOT DELETE
