%%HP: T(0)A(R)F(.);
"%This file is licensed
%under GPL v2

%SZREPL.S

%As=DENOM=DISTACTUELLE
%D0=DATA SPRITE
%D1=QUARTET DEST
%Bxs=ofspp0�3
%Cs=posratX, R1s=CRY
%(Bs=NUM=DISTNOMINALE)
%SI ST=1 4 Bs=NUM
%SINON Bs LU DS SPRITE

*BBCD01SZREPL
%NUM INSCRIT/SPRITE
C=DAT0 B %NUM/RECOMMENDATIONS
D0=D0+ 2
?ST=1 4
GOYES NUM.IMPOSED
CSRC
B=C S
CSLC
*NUM.IMPOSED

%FORMAT DU SPRITE:
%(1q)DENOM
%(1q)RECOMM
%PUIS CODES/TRONCONS
%00�FIN 01�STOPOS
%FF�RCL FEXXYY�RMOVE
%CODE(2)NQ(1)DATAS(NQ)
%�TRONCON (NQ=0 OK)

*LIRECODE
C=DAT0 B
D0=D0+ 2
*CODELU
C=C-1 B
GONC PASSPRITEFINI
GOTO SPRITEFINI
*PASSPRITEFINI

C=C-1 B
GONC PAS.STO.POS
%*STO.POS
GOSUB SAUVERD1/Bxs/Cs/R1s
R3=C %DANS R3
C=D S %PAS OUBLIER!
GOTO LIRECODE
*PAS.STO.POS

C=C+4 B
C=C-1 B
GONC PAS.RECENTER
%RECENTRONS
C=DAT0 B
D0=D0+ 2
?CBIT=0 7
GOYES RECNTADROITE
C=-C B
GOSUB DECALAGAUCHE
GOTO NOWRCNT.Y
*RECNTADROITE
GOSUB DECALADROITE
*NOWRCNT.Y
C=DAT0 B
D0=D0+ 2
?CBIT=0 7
GOYES RECNTENBAS
C=-C B
GOSUB CbHAPP
GOTO LIRECODE
*RECNTENBAS
GOSUB CbBAPP
GOTO LIRECODE
*PAS.RECENTER

C=C-1 B
GONC PAS.RCL.POS
C=R3 %DEPUIS R1
GOSUB RECUPD1/Bxs/Cs/R1s
GOTO LIRECODE

*PAS.RCL.POS
%ALORS CODE STANDARD.
%DESSINONS

ST=0 4
SB=0
CSRB B
?SB=0
GOYES SERAVERSBAS
ST=1 4 %SERAVERSHAUT
*SERAVERSBAS

SB=0
CSRB B %Cb=nbgpix decal
%C=C-1 B
%GOC OKDECALE.X
%NON,PLUTOT:
?C=0 B
GOYES OKDECALE.X
%DANS LA SUITE Cb=NB
%ET PAS NB-1
?SB=0
GOYES VERSGAUCHE
%VERSDROITE
GOSUB DECALADROITE
GOTO OKDECALE.X
*VERSGAUCHE
GOSUB DECALAGAUCHE
*OKDECALE.X

%POSITION EN X BONNE
%MAINTENANT POS EN Y

LC 01 %1 LIGNE
?ST=1 4 
GOYES SERAVERSHAUT
%SERAVERSBAS
GOSUB CbBAPP
GOTO OKDECALE.Y
*SERAVERSHAUT
GOSUB CbHAPP
*OKDECALE.Y

%POSITION BONNE!
%MAINTENANT VOYONS
%SI ON DESSINE OU
%SI ON SKIPPE
CR1EX S
?C<B S
GOYES ONDESSINE!
CR1EX S
%ON SKIPPE
A=0 A
A=DAT0 1 %NBdeQdeDONNEES
D0=D0+ 1
CD0EX
C=C+A A
CD0EX
GOTO TRONCON.TERMINED

*ONDESSINE!
CR1EX S
GOTO DESSINETRONCON
*TRONCON.TERMINED
GOTO LIRECODE

*CbHAPP %SUBROUTINE
%Cb=NBLIGNES
CR1EX S %PRX��PRY
*CONT.HAPP
C=C-1 B
GOC HAPP.FINI
C=C-B S
GONC CONT.HAPP
C=C+A S
D1=D1- 16
D1=D1- 16
D1=D1- 2
GOTO CONT.HAPP
*HAPP.FINI
CR1EX S %PRX��PRY
RTN

*CbBAPP %SUBROUTINE
%Cb=NBLIGNES
CR1EX S %PRX��PRY
C=C-A S %PLACER
%POUR RETENUE CORRECTE
*CONT.BAPP
C=C-1 B
GOC BAPP.FINI
C=C+B S
GONC CONT.BAPP
C=C-A S
D1=D1+ 16
D1=D1+ 16
D1=D1+ 2
GOTO CONT.BAPP
*BAPP.FINI
C=C+A S
CR1EX S %PRX��PRY
RTN


*DECALAGAUCHE
%C(0�6)=NBmpix ET PAS NB-1
%NORMALEMENT C�0 ICI
?C=0 B
RTNYES

A=0 B %LA 400 %Axs=4 & Ab=0
%A=A-1 S
ASLC
%A=A+1 B
CDEX B
C=A B
CDEX B  %Db=DENOM
ASRC

?C<D B
GOYES FINI.GAGP
B=0 B
BSLC    %Bb=NUM

*CONT.GAGP
A=A+B B
C=C-D B
GONC CONT.GAGP
A=A-B B %A=gPIX A DECAL
C=C+D B %C=mPIX A DECAL
%Ab PIX VERS GAUCHE
BSRC    %Bs et Bxs OK
BSR X
BSR X   %Bb=0�3

B=B-A B
GONC GAGP.REMETBx
D=C B   %SVG mPIX A DECAL
LC 03
C=C&B B
BCEX B  %Bb=FUTUR Bx
C=-C-1 B
CSRB B
CSRB B
C=C+1 B
A=0 A
A=C B
CD1EX
C=C-A A
D1=C
C=D B %nbmpix RESTANTs
*GAGP.REMETBx
BSL X
BSL X
*FINI.GAGP

*GAUCHEAPETITSPAS
*CONT.GAPP
C=C-1 B
GOC GAUCHECASSOS
C=C-B S
GONC CONT.GAPP
C=C+A S
B=B-1 XS
GONC CONT.GAPP
B=B+4 XS %B=A XS
D1=D1- 1
GOTO CONT.GAPP

*GAUCHECASSOS
RTN %GOTO OKDECALE.X










*DECALADROITE

%C(0�6)=NBmpix
%NORMALEMENT C�0 ICI
C=C-1 B
RTNC %GOC OKDECALE.X

A=0 B %LA 400 %Axs=4 & Ab=0
%A=A-1 S
ASLC
%A=A+1 B
CDEX B
C=A B
CDEX B  %Db=DENOM
ASRC

%?C<D B
%GOYES FINI.DAGP
B=0 B
BSLC    %Bb=NUM

*CONT.DAGP
A=A+B B
C=C-D B
GONC CONT.DAGP
%A=gPIX A DECAL D
%absC=mPIX A DECAL G�!
%Ab PIX VERS DROITE
BSRC    %Bs et Bxs OK
BSR X
BSR X   %Bb=0�3

B=B+A B
%GONC DAGP.REMETBx
D=C B   %SVG mPIX A DECAL
LC 03
C=C&B B
BCEX B  %Bb=FUTUR Bx
CSRB B
CSRB B %ICI C=NBQDECALAGE
A=0 A
A=C B
CD1EX
C=C+A A %+ DROITE
D1=C
*DAGP.REMETBx
BSL X
BSL X
C=D B %nbmpix RESTANTs
%Cb<0 ET ABS=NBPIX

C=-C-1 B %Cb=NBPIX ENCORE
%*FINI.DAGP

*DROITEAPETITSPAS
%Cb>0 ET Cb=NBPIX
%QU'IL FAUT DECALER
%VERS LA *GAUCHE*
%PARCE QU'ON EST
%PASS� EXPR�S UN CRAN
%TROP LOIN A GRANDS
%PAS.

*CONT.DAPP
C=C-1 B
GOC DROITECASSOS
C=C-B S
GONC CONT.DAPP
C=C+A S
B=B-1 XS
GONC CONT.DAPP
B=B+4 XS
D1=D1- 1
GOTO CONT.DAPP

*DROITECASSOS
RTN %GOTO OKDECALE.X












*DESSINETRONCON
GOSUB SAUVERD1/Bxs/Cs/R1s
R2=C %DANS R2
C=D S %PAS OUBLIER!

%LE BLOC QUI SUIT
%AFFICHE EN D1/Bxs/Cs/(R1s)
%LE TRONCON D0

%D0=nbq,datas
C=DAT0 1
D0=D0+ 1
P=C 0 %WP=LARGEUR GPIX
P=P-1 %CAR NQ=P+1
GONC OKpourP %SI 0 DATAS
GOTO STOP.TRONCON
*OKpourP

%CHANGEONS posratx
%EN CRX
C=C-A S
C=-C-1 S %ET VOILA


C=DAT0 WP
CD0EX
C+P+1
CD0EX

?A�B S
GOYES REDUISONS
D=C WP
C=0 B
C=P 0
A=C B
A=A+1 B 
A=A+A B
A=A+A B
SB=0
*JUSTEDECALER
A=A-1 B
D=D+D WP
GONC JUSTEDECALER
DSRB WP
D=D+8 P
A=A+1 B
GOTO LIGNESHRINKED

*REDUISONS
A=0 B %COMPTEUR PPIX

%Cwp = GPIX LUS
%Dwp = PPIX ECRITS

D=0 WP
*FAST.NORMAL
SB=0

*FASTEST.NORMAL
CSRB WP
C=C-B S
GONC FASTEST.NORMAL
C=C+A S

%ICI NORMAL
DSRB WP
?SB=0
GOYES PASDENOIR.NORMAL
D=D+8 P
*PASDENOIR.NORMAL
A=A+1 B

?C�0 WP
GOYES FAST.NORMAL

%Ab=NBRE ppix (PAS -1)
*LIGNESHRINKED
%LISERET BLANC
%CELUI HI EST DEJA
%FAIT.
%POUR LE LOW,
%ON L'INSERE
P=P+1   %DE LA PLACE
DSL WP
A=A+1 B %ET VOILA

%IL FAUT DECALER
%VERS LA DROITE
%DE 4(P+1)-Ab
%Ab=NBPIX,Bb=LIBRE
%Ca LIBRE
C=0 B
C=P 0
C=C+1 B
C=C+C B
C=C+C B
C=C-A B %NBPIXADECALER

C=C-4 B
GOC NOBIGSHIFT
*SHIFTONSPAR4

DSR WP
P=P-1
C=C-4 B
GONC SHIFTONSPAR4
*NOBIGSHIFT
C=C+4 B
C=C-1 B
GOC PILEPOIL
*SHIFTONSPAR1
DSRB WP
C=C-1 B
GONC SHIFTONSPAR1
*PILEPOIL

%MAINTENANT RESTE A
%DECALER DE Bxs EN
%INSERANT LE DECOR
%(TOUJOURS Ab PIXS)
C=B XS %0�3
CSR X
CSR X
C=C+A B
B=C B %Bb=NBPIXAVMK-1
CSRB B
CSRB B
P=C 0

C=0 B %PREPARE MASQUE
B=B-1 XS
GOC PASBESOINofsppZERO
*MKMASKLO
D=D+D WP
C=C+C B
C=C+1 B
B=B-1 XS
GONC MKMASKLO

%ON PEUT FAIRE 1ERS
%QUARTETS
A=DAT1 1
C=C&A B
D=D!C B %COTE LOW OK

*PASBESOINofsppZERO

%COMBIEN DE PIX A HI ?
A=0 B
A=A+3 B
B=B&A B
B=B-3 B
B=-B B

A=0 P
B=B-1 B
GOC PASDEMASKHI
*MKMASKHI
ASRB P
A=A+8 P
B=B-1 B
GONC MKMASKHI
*PASDEMASKHI
C=A P
A=DAT1 WP
C=C&A P
D=D!C P
C=D WP
DAT1=C WP %PFOUF!


*STOP.TRONCON

%RECUP DEPUIS R2
C=R2 %S et W7
GOSUB RECUPD1/Bxs/Cs/R1s

P= 0

%GOVLNG 05143
GOTO TRONCON.TERMINED
%FIN DE DESSINETRONCON


*SAUVERD1/Bxs/Cs/R1s
%MODIF Cw
%ET Ds=SAVEDCs
D=C S
CSLC
CSLC
C=B XS
CSLC
CSLC
CSLC
CSLC
CD1EX
D1=C
C=R1 S
RTN

*RECUPD1/Bxs/Cs/R1s
R1=C S
D1=C
CSRC
CSRC
CSRC
CSRC
B=C XS
CSRC
CSRC
RTN

*SPRITEFINI
RTN
@"