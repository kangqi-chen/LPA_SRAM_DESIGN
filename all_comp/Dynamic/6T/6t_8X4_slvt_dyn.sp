** SRAM 6T 8X4 125MHz(8ns) SLVT DYN

.include '7nm_FF.pm'
.TEMP 0.0
.PARAM vdd=0.77v
.OPTION POST

********** BITLINE CONTROLLER ********** 

.subckt blcontroller vvdd clk bit bitc 
MM1 vvdd clk bit vvdd pmos_slvt NFIN=1
MM2 vvdd clk bitc vvdd pmos_slvt NFIN=1
MM3 bit clk bitc vvdd pmos_slvt NFIN=1
.ends

********** SRAM CELL ********** 

.subckt cell vvdd bit bitc wl
MM1 vvdd yy xx vvdd pmos_slvt NFIN=1
MM2 bit wl xx 0 nmos_slvt NFIN=2
MM3 xx yy 0 0 nmos_slvt NFIN=3
MM4 vvdd xx yy vvdd pmos_slvt NFIN=1
MM5 bitc wl yy 0 nmos_slvt NFIN=2
MM6 yy xx 0 0 nmos_slvt NFIN=3
.ends

********** INVERTER ********** 

.subckt inv in out vvdd
MM1 vvdd in out vvdd pmos_slvt NFIN=3
MM2 0 in out 0 nmos_slvt NFIN=3
.ends

********** WRITE ********** 

.subckt write bit bitc din we vvdd
MM1 bitc we n1 0 nmos_slvt NFIN=3
MM2 n1 din 0 0 nmos_slvt NFIN=3
MM3 bit we n2 0 nmos_slvt NFIN=3
MM4 n2 n3 0 0 nmos_slvt NFIN=3
XINV din n3 vvdd inv
.ends

********** READ ********** 

.subckt read bit bitc dout vvdd
MM1 vvdd n1 qq vvdd pmos_slvt NFIN=3
MM2 qq bit 0 0 nmos_slvt NFIN=3
MM3 vvdd n1 n1 vvdd pmos_slvt NFIN=3
MM4 n1 bitc 0 0 nmos_slvt NFIN=3
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
XCELL40 vdd! bit0 bitc0 wl4 cell
XCELL50 vdd! bit0 bitc0 wl5 cell
XCELL60 vdd! bit0 bitc0 wl6 cell
XCELL70 vdd! bit0 bitc0 wl7 cell

XCELL01 vdd! bit1 bitc1 wl0 cell
XCELL11 vdd! bit1 bitc1 wl1 cell
XCELL21 vdd! bit1 bitc1 wl2 cell
XCELL31 vdd! bit1 bitc1 wl3 cell
XCELL41 vdd! bit1 bitc1 wl4 cell
XCELL51 vdd! bit1 bitc1 wl5 cell
XCELL61 vdd! bit1 bitc1 wl6 cell
XCELL71 vdd! bit1 bitc1 wl7 cell

XCELL02 vdd! bit2 bitc2 wl0 cell
XCELL12 vdd! bit2 bitc2 wl1 cell
XCELL22 vdd! bit2 bitc2 wl2 cell
XCELL32 vdd! bit2 bitc2 wl3 cell
XCELL42 vdd! bit2 bitc2 wl4 cell
XCELL52 vdd! bit2 bitc2 wl5 cell
XCELL62 vdd! bit2 bitc2 wl6 cell
XCELL72 vdd! bit2 bitc2 wl7 cell

XCELL03 vdd! bit3 bitc3 wl0 cell
XCELL13 vdd! bit3 bitc3 wl1 cell
XCELL23 vdd! bit3 bitc3 wl2 cell
XCELL33 vdd! bit3 bitc3 wl3 cell
XCELL43 vdd! bit3 bitc3 wl4 cell
XCELL53 vdd! bit3 bitc3 wl5 cell
XCELL63 vdd! bit3 bitc3 wl6 cell
XCELL73 vdd! bit3 bitc3 wl7 cell

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

Vwl0 wl0 0 pulse(0 vdd 0 10p 10p 3.98n 64n)
Vwl1 wl1 0 pulse(0 vdd 8n 10p 10p 3.98n 64n)
Vwl2 wl2 0 pulse(0 vdd 16n 10p 10p 3.98n 64n)
Vwl3 wl3 0 pulse(0 vdd 24n 10p 10p 3.98n 64n)
Vwl4 wl4 0 pulse(0 vdd 32n 10p 10p 3.98n 64n)
Vwl5 wl5 0 pulse(0 vdd 40n 10p 10p 3.98n 64n)
Vwl6 wl6 0 pulse(0 vdd 48n 10p 10p 3.98n 64n)
Vwl7 wl7 0 pulse(0 vdd 56n 10p 10p 3.98n 64n)

Vwe0 we0 0 pulse(0 vdd 0 10p 10p 63.98n 128n)
Vwe1 we1 0 pulse(0 vdd 0 10p 10p 63.98n 128n)
Vwe2 we2 0 pulse(0 vdd 0 10p 10p 63.98n 128n)
Vwe3 we3 0 pulse(0 vdd 0 10p 10p 63.98n 128n)

Vdin0 din0 0 pulse(vdd 0 0 10p 10p 127.98n 256n)
Vdin1 din1 0 pulse(vdd 0 0 10p 10p 127.98n 256n)
Vdin2 din2 0 pulse(vdd 0 0 10p 10p 127.98n 256n)
Vdin3 din3 0 pulse(vdd 0 0 10p 10p 127.98n 256n)

c0 dout0 0 1f
c1 dout1 0 1f
c2 dout2 0 1f
c3 dout3 0 1f

.tran 1p 1024n

.measure pwr avg p(vvdd)


.alter case 2:
.include '7nm_TT.pm'
.TEMP 25.0
.PARAM vdd=0.7v

.alter case 3:
.include '7nm_SS.pm'
.TEMP 100.0
.PARAM vdd=0.63v

.end











