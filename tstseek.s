%%HP: T(0)A(R)F(.);
"%This file is licensed
%under GPL v2

GOSBVL 0679B
B=0 A
B=B-1 A
B=B-1 A
P= 7
GOSUB FIND
$001000C100820020000050000030004000000040400040001020500000401040000031001050000000C32020440000002050218301112060400000C12070E100000010A0F1000000EFFF00000000EFFF00000000EFFF00000000EFFF00000000EFFF00000000FFFF
*FIND
C=RSTK
GOSUB SEEKB4ATFLUC
GOVLNG 05143
'SEEK.S
'ERREUR.S
@
"