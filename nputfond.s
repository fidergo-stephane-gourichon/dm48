%%HP: T(0)A(R)F(.);
C$ 1495 %This file is licensed
%under GPL v2

%NPUTFOND.S
%METFOND,CLEANE TMPGRB

%MODIF:ABCw,Db,D01,0+1RSTK
%APPEL:GOSUB (UNIQUE)

*PREPFOND

%FOND: GROB 129*62
%Y=3�34 FOND

%D1=TOS

%FAISONS HASARD
C=DAT1 A
D0=C
D0=D0+ 10

A=DAT0 A %A=ADRHASARD
D0=A
A=DAT0 W
B=A W %B=HASARD W
D1=D1+ 5 %NIV2:GRBTMP
C=DAT1 A
D1=C
D1=D1+ 10
D1=D1+ 10 %D1=1stPix

LC 02
GOSUB BLANKLINES

GOSUB GETFDADR
�          @      @��   �  � JB�LH$ R�S���P ��Q���d��nv{OHC�S��@-�?sd�r��{2lx���FzE�u���6�m�k�{:����������ڭ�/h�?���T�ݯ�w��j��oU���?��]��z�����������m�n��������������n���^���������������������������������������������w�������������������������������������������������������������������������������������������������������������������������������������o��������������������������}������������G�������{�o����ٿ���y�~z�~����[g����O?������?�[,���������������`���uV.ڗ��Z=X��	-S h�J�0&Qh w٠ (D& 4nY"q �
$A0
�v�H@4
$A0
�B�D�@<D  � ��   A  �   
*GETFDADR
C=RSTK
A=C A

%Aa=ADRESSE LECTURE
%B=HASARD.NBRE,D1=DEST
%Db=COMPTEUR
%ON AJOUTE HASARD
%(LU DANS P)

LC 1F
D=C B
*LINEFOND
C=0 A
C=B S
BSLC
CSLC %C=0000hasard
C=C+A A
D0=C
C=DAT0 W
DAT1=C W
D0=D0+ 16
D1=D1+ 16
C=DAT0 A
DAT1=C A
D1=D1+ 16
D1=D1+ 2

LC 00024
A=A+C A
D=D-1 B
GONC LINEFOND
LC 1A
%GOSUB,RTN
*BLANKLINES
D=C B
C=0 W
A=0 A
LC 1
*ONEMORELINE
DAT1=C W
D1=D1+ 16
DAT1=A A
D1=D1+ 9
D1=D1+ 9
D=D-1 B
GONC ONEMORELINE
RTN
*CLS
%LC 02
%GOSUB GOLEVC
GOSBVL 01C31
AD0EX
LC 00022
C=C+A A
D1=C
LC 3D
GOTO BLANKLINES
@