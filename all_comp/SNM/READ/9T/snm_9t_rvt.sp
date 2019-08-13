** SRAM SNM RVT

.include '7nm_FF.pm'
.GLOBAL VDD
.PARAM VDD=0.77V
.TEMP 0.0
.options list post

.PARAM U=0
.PARAM UL='-VDD/sqrt(2)'
.PARAM UH='VDD/sqrt(2)'

MPL QD QB n1 VDD pmos_rvt NFIN=1     
MNL QD QB n2 0 nmos_rvt NFIN=3     
MPR QBD Q VDD VDD pmos_rvt NFIN=1   
MNR QBD Q 0 0 nmos_rvt NFIN=3  

MWU n1 WLPU VDD VDD pmos_rvt NFIN=1 
MWD n2 WLPD 0 0 nmos_rvt NFIN=3 

MA1 QD WWL VX 0 nmos_rvt NFIN=2    
MA2 VX WL BL 0 nmos_rvt NFIN=2   
MDR VX QD VVSS 0 nmos_rvt NFIN=2   

VVDD VDD 0 DC=VDD
VWL WL 0 DC=VDD
VWWL WWL 0 DC=0
VVSS VVSS 0 DC=0
VWLPU WLPU 0 DC=0
VWLPD WLPD 0 DC=VDD 

CBL BL 0 1p
.IC V(BL)=VDD

****** Behavioral Voltage Source ******
EQ  Q  0 VOL='1/sqrt(2)*U+1/sqrt(2)*V(V1)'
EQB QB 0 VOL='-1/sqrt(2)*U+1/sqrt(2)*V(V2)'
EV1 V1 0 VOL=' U + sqrt(2)*V(QBD)'
EV2 V2 0 VOL='-U + sqrt(2)*V(QD)'
EVD VD 0 VOL='ABS(V(V1) - V(V2))'

.DC U UL UH 0.01

.PRINT DC V(QD) V(QBD) V(QB) V(Q) V(V1) V(V2)
.MEASURE DC MAXVD MAX V(VD)
.MEASURE DC SNM param='1/sqrt(2)*MAXVD'

.alter case 2:
.include '7nm_TT.pm'
.TEMP 25.0
.PARAM VDD=0.7v

.alter case 3:
.include '7nm_SS.pm'
.TEMP 100.0
.PARAM VDD=0.63v

.END 
