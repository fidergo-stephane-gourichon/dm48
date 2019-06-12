%%HP: T(0)A(R)F(.);
"%This file is licensed
%under GPL v2

%SEEK.S

%SEEKB4ATFLUC
%RECHERCHE UN BLOC
%CONCERNANT LA CASE
%B4 DANS LE FLUX (C)
%P+1=TAILLE DATAS
%BLOC:ccccddddddd
%cccc=XXYYh,d=DATAS
%SORTIE:
%P=0
%NC�OK DATAS DANS (D0)
%(C)BLOC SUIVANT
%CARRY�NON (D0)FINFLUX
%APPEL:GOSUB
%USE 1+0 RSTK
%MODIF:
%Aa Ca B4 D0 P=0

*SEEKB4ATFLUC

A=0 A
A=A-1 A
ASR A %A=0FFFF

B=B&A A
%B=0YYXX OU 0FFFE POUR LIBRE
?A=B A
GOYES CASEFFFFINTERDITE
%B=0YYXX OU 0FFFE POUR LIBRE
D0=C
C=0 A
*CHERCHONS.FLU
C=DAT0 4
?C=A A
GOYES NOTFOUND
CD0EX
C+P+1
CD0EX
D0=D0+ 4
?C�B A
GOYES CHERCHONS.FLU
*FOUND
CD0EX
D0=C %NEXTB
C=-C A
C+P+1
C=-C A
CD0EX
%D0=DATAS
%ET C=NEXTBLOC
P= 0
RTNCC
*CASEFFFFINTERDITE
P= 0
LC F1
GOLONG ERRORCb
*NOTFOUND
P= 0
RTNSC

%*CCHERCHEBLOC4LIBRE
%RECHERCHE UN BLOC
%LIBRE DANS LE FLUX
%AU NIVEAU C DE LA PILE
%SI AUCUN LIBREERREUR!
%POUR GARANTIR BLOC LIBRE
%APPELER A L'AVANCE
%GARANTITBLOC4LIBRE
%(QUI MODIFIE TOUT)
%SORTIE:
%BLOC DANS (D0)
*NIVCCHERCHEBLOC4LIBRE
GOSUBL GOLEVCb
*ADRCCHERCHEBLOC4LIBRE
B=0 A
B=B-1 A
B=B-1 A
GOSUB SEEKB4ATFLUC
GOC PASDEPLACE
D0=D0- 4
RTN

*PASDEPLACE
LC 2A
GOLONG ERRORCb

%SEEKB4ATFLEC
%RECHERCHE UN BLEUC
%CONCERNANT LA CASE
%B4 DANS LE FLEUVE (C)

%BLEUC:cccctttddddddd
%cccc=XXYY,t=SIZE,d=DATAS
%SORTIE:
%NC�OK tttdddDANS(D0)
%(C)BLOC
%C�NON (C)=FINFLUX

%APPEL:GOSUB
%USE 1+0 RSTK
%MODIF:
%Aa Ca D0 P=0

%*SEEKBaATFLEC
A=0 A
A=A-1 A
ASR A %A=0FFFF

B=B&A A
%B=0YYXX OU 0FFFE POUR LIBRE
?A=B A
GOYES CASEFFFFINTERDITE
%B=0YYXX OU 0FFFE POUR LIBRE
D0=C
*CHERCHONS.FLE
C=DAT0 4
D0=D0+ 4
?C=B A
GOYES FOUND
A=DAT0 X
CD0EX
C=C+A A
A=0 X
A=-A-1 X
GOTO CHERCHONS.FLE

%GARANTITBLOC4LIBRE
%PREND C=NIVPILE
%ET ASSURE QUE
%CE NIVEAU CONTIENDRA
%UN BLOC LIBRE
%MODIFIE:
%R0a,R1a,ABCDD0D1.
*GARANTITBLOC4LIBRE
A=0 A
A=C B
A=A+1 A %NIV/PILE
R0=A A
C=0 A
C=P 0 %MEMORISETAILLEFLUX
C=C+5 A %4(XXYY)+1
R1=C A
C=A B
C=C-1 B
GOSUBL GOLEVCb
B=0 A
B=B-1 A
B=B-1 A
GOSUB SEEKB4ATFLUC
RTNNC %OK ILYAPLACE
%OK. ON VA ALLONGER
%LE FLUX ET ECRIRE
%DES BLOCS LIBRES
GOSUB PUT2SBEXTFOLLOW
$2C230 %NIV CONCERNE
$81316 %ROLL(S+2)
$2C230 %OVER
$C1C16 %ADD n q ZEROS
$EF116 %3PICK
$56316 %ROLLD(S+2)
$CCD20
GOIN5 FINBIGCODE
GOSBVL 03F5D %POP_C_A
%C=TAILLE
%A=NIV
C=C-5 A
CSRC
A=A-1 A
GOSBVL 0679B
P=C 15
C=A A
GOSUBL GOLEVCb
B=0 A
B=B-1 A
B=B-1 A
GOSUB SEEKB4ATFLUC
GOC AUCUNLIBRENORMAL
%????UN LIBRE MAINTENANT??
LC 2B
GOLONG ERRORCb
*AUCUNLIBRENORMAL
%D0�FFFF0000
%B=0FFFE
C=B A
DAT0=C 4 %EFFF
P=C 15
CD0EX
C+P+1
CD0EX
P= 0
D0=D0+ 4
DAT0=A 4 %FFFF
%VOILA!
RTN
*PUT2SBEXTFOLLOW
GOSBVL 067D2
C=RSTK
D0=C
GOSBVL 0679B
GOVLNG 03F14
@"