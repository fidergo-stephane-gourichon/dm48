%%HP: T(0)A(R)F(.);
C$ 1314 %This file is licensed
%under GPL v2

%SWOOSH.S

%REMOVE THE FOLLOWING
%BEFORE OPERATING
%GOSBVL 0679B
GOSUB PQRAT
$1F1E1D1C1B1A19182F172D162B153E293D144F4E4D4C4B4A494847464544
$00
*PQRAT
C=RSTK
R4=C A

*OLE!
C=R4 A
CD0EX
A=DAT0 B
D0=D0+ 2
CD0EX
R4=C A

?A�0 B
GOYES CONTINUONS!
GOTO OH.FINI...
*CONTINUONS!

B=A B

GOSBVL 01C31
CD0EX
D=C A
LA 44
?A�B B
GOYES NOCLS
GOSUB EXCEPTIONS
$F421720942942B44D4000
%24F 271 490 492 4B2 4D4
*EXCEPTIONS
C=RSTK
D0=C
A=0 S
*NEXTEXC
C=0 A
C=DAT0 X
D0=D0+ 3
?C=0 X
GOYES FINEXC
C=C+D A
D1=C
DAT1=A S
GOTO NEXTEXC
*FINEXC
*NOCLS
LC 00450
C=C+D A
D1=C    %D1=DEST

GOSUBL SWDAT
����@�	��_`��18����������1���@��? t��  �� �� #�@0`? �؁�@	���P�� ����P��? :���1���: ~ �0���� 8�p�?�������p��������s�������p`�����@����bvt`��`v0|����xpx|0��	8���9�������p������l��8���8<pb�'0"�� ^� ��
$A0
� �p��  0
$A0
� 80��� �� �p����	
$A0
�n8��8`����s��� ����9p`p�����`0���q`6� 
*SWDAT
C=RSTK
CD0EX %D0=SOURCE
C=0 S %PRX=0
R1=C S %PRY=0
B=0 XS  %BORD DU q

%Bb=NUMDENOM
ST=1 4
ABEX B
ASRC
B=A S   %B=NUM
ASRC    %A=DENOM

GOSUBL BBCD01SZREPL
D0= 00128
LA 3F
*VSYNC
C=DAT0 B
C=C&A B
C=C-1 B
GONC VSYNC
GOTO OLE!

*OH.FINI...
%GOVLNG 05143
%FIN DU REMOVE
%'SZREPL.S
@