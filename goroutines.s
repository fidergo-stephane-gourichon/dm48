%%HP: T(0)A(R)F(.);
"%This file is licensed
%under GPL v2

%GOROUTINES.S
*GOLEVCb
%CHERCHE NIV Cb �
%�D1 POINTE 10� q

%MODIF:Aa,Ca,D1,1+1RSTK
A=0 A
A=C B
GOSBVL 6385D
%C=D1=TOS
RSTK=C
C=A A
A=A+A A
A=A+A A
A=A+C A

C=RSTK
A=A+C A
D1=A
C=DAT1 A %OK D1=A=OBJn
C=C+10 A
D1=C
RTN
*GOHOME
C=0 A
*GONLEV1Ca
%CHERCHE Ca� q NIV1�D1

%MODIF:Aa,Ca,D1,1+1RSTK
C=C+10 A
A=C A
GOSBVL 6385D
%C=D1=TOS
C=DAT1 A %OK D1=C=OBJ1
C=C+A A
D1=C
RTN
@"