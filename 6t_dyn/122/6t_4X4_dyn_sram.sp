** SRAM 6T 4X4 125MHz(8ns)

.include '7nm_FF.pm'
.PARAM vdd=0.62v
.OPTION POST

********** BITLINE CONTROLLER ********** 

.subckt blcontroller vvdd clk bit bitc 
MM1 vvdd clk bit vvdd pmos_sram NFIN=1
MM2 vvdd clk bitc vvdd pmos_sram NFIN=1
MM3 bit clk bitc vvdd pmos_sram NFIN=1
.ends

********** SRAM CELL ********** 

.subckt cell vvdd bit bitc wl
MM1 vvdd yy xx vvdd pmos_sram NFIN=1
MM2 bit wl xx 0 nmos_sram NFIN=2
MM3 xx yy 0 0 nmos_sram NFIN=2
MM4 vvdd xx yy vvdd pmos_sram NFIN=1
MM5 bitc wl yy 0 nmos_sram NFIN=2
MM6 yy xx 0 0 nmos_sram NFIN=2
.ends

********** INVERTER ********** 

.subckt inv in out vvdd
MM1 vvdd in out vvdd pmos_sram NFIN=3
MM2 0 in out 0 nmos_sram NFIN=3
.ends

********** WRITE ********** 

.subckt write bit bitc din we vvdd
MM1 bitc we n1 0 nmos_sram NFIN=3
MM2 n1 din 0 0 nmos_sram NFIN=3
MM3 bit we n2 0 nmos_sram NFIN=3
MM4 n2 n3 0 0 nmos_sram NFIN=3
XINV din n3 vvdd inv
.ends

********** READ ********** 

.subckt read bit bitc dout vvdd
MM1 vvdd n1 qq vvdd pmos_sram NFIN=3
MM2 qq bit 0 0 nmos_sram NFIN=3
MM3 vvdd n1 n1 vvdd pmos_sram NFIN=3
MM4 n1 bitc 0 0 nmos_sram NFIN=3
XINV qq dout vvdd inv
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

XR0 bit0 bitc0 dout0 vdd! read
XR1 bit1 bitc1 dout1 vdd! read
XR2 bit2 bitc2 dout2 vdd! read
XR3 bit3 bitc3 dout3 vdd! read

Vvdd vdd! 0 dc=vdd

Vclk clk 0 pulse(0 vdd 4n 10p 10p 3.98n 8n)

Vwl0 wl0 0 pulse(0 vdd 0 10p 10p 3.98n 32n)
Vwl1 wl1 0 pulse(0 vdd 8n 10p 10p 3.98n 32n)
Vwl2 wl2 0 pulse(0 vdd 16n 10p 10p 3.98n 32n)
Vwl3 wl3 0 pulse(0 vdd 24n 10p 10p 3.98n 32n)

Vwe0 we0 0 pulse(0 vdd 0 10p 10p 27.98n 64n)
Vwe1 we1 0 pulse(0 vdd 0 10p 10p 27.98n 64n)
Vwe2 we2 0 pulse(0 vdd 0 10p 10p 27.98n 64n)
Vwe3 we3 0 pulse(0 vdd 0 10p 10p 27.98n 64n)

Vdin0 din0 0 pulse(0 vdd 64n 10p 10p 63.98n 128n)
Vdin1 din1 0 pulse(0 vdd 64n 10p 10p 63.98n 128n)
Vdin2 din2 0 pulse(0 vdd 64n 10p 10p 63.98n 128n)
Vdin3 din3 0 pulse(0 vdd 64n 10p 10p 63.98n 128n)

c0 dout0 0 0.1p
c1 dout1 0 0.1p
c2 dout2 0 0.1p
c3 dout3 0 0.1p

.tran 100p 256n

.measure pwr avg p(vvdd)

.alter case 2:
.include '7nm_TT.pm'
.PARAM vdd=0.61v

.alter case 3:
.include '7nm_SS.pm'
.PARAM vdd=0.62v

.end











