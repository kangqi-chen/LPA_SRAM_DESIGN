** 9T-SRAM 4X4 SRAM

.include '7nm_FF.pm'
.TEMP 0.0
.PARAM vdd=0.77v
.OPTION POST

MM1 n1 yy xx vdd pmos_rvt NFIN=1     
MM2 xx yy n2 0 nmos_rvt NFIN=3     
MM3 vdd xx yy vdd pmos_rvt NFIN=1   
MM4 yy xx 0 0 nmos_rvt NFIN=3  

MM5 n1 wlpu vdd vdd pmos_rvt NFIN=1 
MM6 n2 wlpd 0 0 nmos_rvt NFIN=3

MM7 xx wwl vx 0 nmos_rvt NFIN=2    
MM8 vx wl bit 0 nmos_rvt NFIN=2   
MM9 vx xx vvss 0 nmos_rvt NFIN=2  

**MA1 xx vgnd vgnd vgnd nmos_rvt NFIN=2
MA2 yy 0 bit 0 nmos_rvt NFIN=1


Vvdd vdd 0 dc=vdd

Vclk clk 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd 8n vdd 8.01n 0 TD=0)

Vwl wl 0 pwl(0 0 0.01n vdd 3.99n vdd 4n 0 TD=0)

Vwwl wwl 0 pwl(0 0 0.01n vdd 3.99n vdd 4n 0 8n 0 8.01n vdd TD=0)

Vwlpu wlpu 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=0)

Vwlpd wlpd 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd TD=0)

Vvss vvss 0 dc=vdd

Vbit bit 0 dc=pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=0)

.tran 1p 1000n

.measure pwr avg p(vvdd) FROM=20n TO=1000n 

.alter case 2:
.include '7nm_TT.pm'
.TEMP 25.0
.PARAM vdd=0.7v

.alter case 3:
.include '7nm_SS.pm'
.TEMP 100.0
.PARAM vdd=0.63v

.alter case 4:
.include '7nm_FF.pm'
.TEMP 0.0
.PARAM vdd=0.77v
Vbit bit 0 dc=0

.alter case 5:
.include '7nm_TT.pm'
.TEMP 25.0
.PARAM vdd=0.7v
Vbit bit 0 dc=0

.alter case 6:
.include '7nm_SS.pm'
.TEMP 100.0
.PARAM vdd=0.63v
Vbit bit 0 dc=0

.end




