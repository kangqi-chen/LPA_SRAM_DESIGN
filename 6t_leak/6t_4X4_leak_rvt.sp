** SRAM 6T 4X4 125MHz(8ns)

.include '7nm_FF.pm'
.PARAM vdd=0.47v
.OPTION POST

********** BITLINE CONTROLLER ********** 

.subckt blcontroller vvdd clk bit bitc 
MM1 vvdd clk bit vvdd pmos_rvt NFIN=1
MM2 vvdd clk bitc vvdd pmos_rvt NFIN=1
MM3 bit clk bitc vvdd pmos_rvt NFIN=1
.ends

********** SRAM CELL ********** 

.subckt cell vvdd bit bitc wl
MM1 vvdd yy xx vvdd pmos_rvt NFIN=1
MM2 bit wl xx 0 nmos_rvt NFIN=2
MM3 xx yy 0 0 nmos_rvt NFIN=3
MM4 vvdd xx yy vvdd pmos_rvt NFIN=1
MM5 bitc wl yy 0 nmos_rvt NFIN=2
MM6 yy xx 0 0 nmos_rvt NFIN=3
.ends

********** INVERTER ********** 

.subckt inv in out vvdd
MM1 vvdd in out vvdd pmos_rvt NFIN=3
MM2 0 in out 0 nmos_rvt NFIN=3
.ends

********** WRITE ********** 

.subckt write bit bitc din we vvdd
MM1 bitc we n1 0 nmos_rvt NFIN=3
MM2 n1 din 0 0 nmos_rvt NFIN=3
MM3 bit we n2 0 nmos_rvt NFIN=3
MM4 n2 n3 0 0 nmos_rvt NFIN=3
XINV din n3 vvdd inv
.ends

********** COMPLETE CIRCUIT ********** 

XBLC0 vdd! clk bit0 bitc0 blcontroller
XBLC1 vdd! clk bit1 bitc1 blcontroller
XBLC2 vdd! clk bit2 bitc2 blcontroller
XBLC3 vdd! clk bit3 bitc3 blcontroller

XCELL00 vdd! bit0 bitc0 wl0 cell
XCELL10 vdd! bit0 bitc0 wl1 cell
XCELL20 vdd! bit0 bitc0 wl2 cell
XCELL30 vdd! bit0 bitc0 wl3 cell

XCELL01 vdd! bit1 bitc1 wl0 cell
XCELL11 vdd! bit1 bitc1 wl1 cell
XCELL21 vdd! bit1 bitc1 wl2 cell
XCELL31 vdd! bit1 bitc1 wl3 cell

XCELL02 vdd! bit2 bitc2 wl0 cell
XCELL12 vdd! bit2 bitc2 wl1 cell
XCELL22 vdd! bit2 bitc2 wl2 cell
XCELL32 vdd! bit2 bitc2 wl3 cell

XCELL03 vdd! bit3 bitc3 wl0 cell
XCELL13 vdd! bit3 bitc3 wl1 cell
XCELL23 vdd! bit3 bitc3 wl2 cell
XCELL33 vdd! bit3 bitc3 wl3 cell

XW0 bit0 bitc0 din0 we0 vdd! write
XW1 bit1 bitc1 din1 we1 vdd! write
XW2 bit2 bitc2 din2 we2 vdd! write
XW3 bit3 bitc3 din3 we3 vdd! write

Vvdd vdd! 0 dc=vdd

Vclk clk 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd 8n vdd 8.01n 0 11.99n 0 12n vdd 16n vdd 16.01n 0 19.99n 0 20n vdd 24n vdd 24.01n 0)

Vwl0 wl0 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=0)
Vwl1 wl1 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=8n)
Vwl2 wl2 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=16n)
Vwl3 wl3 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=24n)

Vwe0 we0 0 pwl(0 0 10p vdd 27.99n vdd 28n 0)
Vwe1 we1 0 pwl(0 0 10p vdd 27.99n vdd 28n 0)
Vwe2 we2 0 pwl(0 0 10p vdd 27.99n vdd 28n 0)
Vwe3 we3 0 pwl(0 0 10p vdd 27.99n vdd 28n 0)

Vdin0 din0 0 dc=vdd
Vdin1 din1 0 dc=vdd
Vdin2 din2 0 dc=vdd
Vdin3 din3 0 dc=vdd

.tran 1p 10000n

.measure pwr avg p(vvdd) FROM=50n TO=10000n

.alter case 2:
.include '7nm_TT.pm'
.PARAM vdd=0.5v

.alter case 2:
.include '7nm_SS.pm'
.PARAM vdd=0.53v

.alter case 2:
.include '7nm_FF.pm'
.PARAM vdd=0.47v
Vdin0 din0 0 dc=0
Vdin1 din1 0 dc=0
Vdin2 din2 0 dc=0
Vdin3 din3 0 dc=0

.alter case 2:
.include '7nm_TT.pm'
.PARAM vdd=0.5v
Vdin0 din0 0 dc=0
Vdin1 din1 0 dc=0
Vdin2 din2 0 dc=0
Vdin3 din3 0 dc=0

.alter case 2:
.include '7nm_SS.pm'
.PARAM vdd=0.53v
Vdin0 din0 0 dc=0
Vdin1 din1 0 dc=0
Vdin2 din2 0 dc=0
Vdin3 din3 0 dc=0

.end




