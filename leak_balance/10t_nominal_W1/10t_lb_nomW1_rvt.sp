** 9T-SRAM 4X4 SRAM

.include '7nm_FF.pm'
.TEMP 0.0
.OPTION POST

********** BITLINE CONTROLLER ********** 

.subckt blcontroller vvdd clk bit 
MM1 vvdd clk bit vvdd pmos_rvt NFIN=1
.ends

********** SRAM CELL ********** 

.subckt cell vvdd vgnd bit wl wwl wlpu wlpd vvss

MM1 n1 yy xx vvdd pmos_rvt NFIN=1     
MM2 xx yy n2 vgnd nmos_rvt NFIN=3     
MM3 vvdd xx yy vvdd pmos_rvt NFIN=1   
MM4 yy xx vgnd vgnd nmos_rvt NFIN=3  

MM5 n1 wlpu vvdd vvdd pmos_rvt NFIN=1 
MM6 n2 wlpd vgnd vgnd nmos_rvt NFIN=3

MM7 xx wwl vx vgnd nmos_rvt NFIN=2    
MM8 vx wl bit vgnd nmos_rvt NFIN=2   
MM9 vx xx vvss vgnd nmos_rvt NFIN=2  

**MA1 xx vgnd vgnd vgnd nmos_rvt NFIN=2
MA2 yy vgnd bit vgnd nmos_rvt NFIN=2

.ends

********** INVERTER ********** 

.subckt inv vin vout vvdd vgnd
MM1 vvdd vin vout vvdd pmos_rvt NFIN=3
MM2 vgnd vin vout vgnd nmos_rvt NFIN=3
.ends

********** WRITE ********** 

.subckt write vvdd vgnd bit din we 

XINV din n1 vvdd vgnd inv

MM1 vgnd n1 n2 vgnd nmos_rvt NFIN=3
MM2 n2 we bit vgnd nmos_rvt NFIN=3

.ends

********** COMPLETE CIRCUIT ********** 

XBLC0 vdd clk bit0 blcontroller
XBLC1 vdd clk bit1 blcontroller
XBLC2 vdd clk bit2 blcontroller
XBLC3 vdd clk bit3 blcontroller

XCELL00 vdd 0 bit0 wl0 wwl0 wlpu0 wlpd0 vvss0 cell
XCELL10 vdd 0 bit0 wl1 wwl0 wlpu1 wlpd1 vvss0 cell
XCELL20 vdd 0 bit0 wl2 wwl0 wlpu2 wlpd2 vvss0 cell
XCELL30 vdd 0 bit0 wl3 wwl0 wlpu3 wlpd3 vvss0 cell
XCELL40 vdd 0 bit0 wl4 wwl0 wlpu4 wlpd4 vvss0 cell
XCELL50 vdd 0 bit0 wl5 wwl0 wlpu5 wlpd5 vvss0 cell
XCELL60 vdd 0 bit0 wl6 wwl0 wlpu6 wlpd6 vvss0 cell
XCELL70 vdd 0 bit0 wl7 wwl0 wlpu7 wlpd7 vvss0 cell

XCELL01 vdd 0 bit1 wl0 wwl1 wlpu0 wlpd0 vvss1 cell
XCELL11 vdd 0 bit1 wl1 wwl1 wlpu1 wlpd1 vvss1 cell
XCELL21 vdd 0 bit1 wl2 wwl1 wlpu2 wlpd2 vvss1 cell
XCELL31 vdd 0 bit1 wl3 wwl1 wlpu3 wlpd3 vvss1 cell
XCELL41 vdd 0 bit1 wl4 wwl1 wlpu4 wlpd4 vvss1 cell
XCELL51 vdd 0 bit1 wl5 wwl1 wlpu5 wlpd5 vvss1 cell
XCELL61 vdd 0 bit1 wl6 wwl1 wlpu6 wlpd6 vvss1 cell
XCELL71 vdd 0 bit1 wl7 wwl1 wlpu7 wlpd7 vvss1 cell

XCELL02 vdd 0 bit2 wl0 wwl2 wlpu0 wlpd0 vvss2 cell
XCELL12 vdd 0 bit2 wl1 wwl2 wlpu1 wlpd1 vvss2 cell
XCELL22 vdd 0 bit2 wl2 wwl2 wlpu2 wlpd2 vvss2 cell
XCELL32 vdd 0 bit2 wl3 wwl2 wlpu3 wlpd3 vvss2 cell
XCELL42 vdd 0 bit2 wl4 wwl2 wlpu4 wlpd4 vvss2 cell
XCELL52 vdd 0 bit2 wl5 wwl2 wlpu5 wlpd5 vvss2 cell
XCELL62 vdd 0 bit2 wl6 wwl2 wlpu6 wlpd6 vvss2 cell
XCELL72 vdd 0 bit2 wl7 wwl2 wlpu7 wlpd7 vvss2 cell

XCELL03 vdd 0 bit3 wl0 wwl3 wlpu0 wlpd0 vvss3 cell
XCELL13 vdd 0 bit3 wl1 wwl3 wlpu1 wlpd1 vvss3 cell
XCELL23 vdd 0 bit3 wl2 wwl3 wlpu2 wlpd2 vvss3 cell
XCELL33 vdd 0 bit3 wl3 wwl3 wlpu3 wlpd3 vvss3 cell
XCELL43 vdd 0 bit3 wl4 wwl3 wlpu4 wlpd4 vvss3 cell
XCELL53 vdd 0 bit3 wl5 wwl3 wlpu5 wlpd5 vvss3 cell
XCELL63 vdd 0 bit3 wl6 wwl3 wlpu6 wlpd6 vvss3 cell
XCELL73 vdd 0 bit3 wl7 wwl3 wlpu7 wlpd7 vvss3 cell

XWC0 vdd 0 bit0 din0 we0 write
XWC1 vdd 0 bit1 din1 we1 write
XWC2 vdd 0 bit2 din2 we2 write
XWC3 vdd 0 bit3 din3 we3 write

.PARAM vdd=0.77v

Vvdd vdd 0 dc=vdd

Vclk clk 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd 8n vdd 8.01n 0 11.99n 0 12n vdd 16n vdd 16.01n 0 19.99n 0 20n vdd 24n vdd 24.01n 0 27.99n 0 28n vdd 32n vdd 32.01n 0 35.99n 0 36n vdd 40n vdd 40.01n 0 43.99n 0 44n vdd 48n vdd 48.01n 0 51.99n 0 52n vdd 56n vdd 56.01n 0 59.99n 0 60n vdd 64n vdd 64.01n 0 TD=0)

Vwl0 wl0 0 pwl(0 0 0.01n vdd 3.99n vdd 4n 0 TD=0)
Vwl1 wl1 0 pwl(0 0 0.01n vdd 3.99n vdd 4n 0 TD=8n)
Vwl2 wl2 0 pwl(0 0 0.01n vdd 3.99n vdd 4n 0 TD=16n)
Vwl3 wl3 0 pwl(0 0 0.01n vdd 3.99n vdd 4n 0 TD=24n)
Vwl4 wl4 0 pwl(0 0 0.01n vdd 3.99n vdd 4n 0 TD=32n)
Vwl5 wl5 0 pwl(0 0 0.01n vdd 3.99n vdd 4n 0 TD=40n)
Vwl6 wl6 0 pwl(0 0 0.01n vdd 3.99n vdd 4n 0 TD=48n)
Vwl7 wl7 0 pwl(0 0 0.01n vdd 3.99n vdd 4n 0 TD=56n)

Vwe0 we0 0 pwl(0 0 10p vdd 63.99n vdd 64n 0 68n 0 68.01n vdd TD=0)
Vwe1 we1 0 pwl(0 0 10p vdd 63.99n vdd 64n 0 68n 0 68.01n vdd TD=0)
Vwe2 we2 0 pwl(0 0 10p vdd 63.99n vdd 64n 0 68n 0 68.01n vdd TD=0)
Vwe3 we3 0 pwl(0 0 10p vdd 63.99n vdd 64n 0 68n 0 68.01n vdd TD=0)

Vwwl0 wwl0 0 pwl(0 0 10p vdd 63.99n vdd 64n 0 68n 0 68.01n vdd TD=0)
Vwwl1 wwl1 0 pwl(0 0 10p vdd 63.99n vdd 64n 0 68n 0 68.01n vdd TD=0)
Vwwl2 wwl2 0 pwl(0 0 10p vdd 63.99n vdd 64n 0 68n 0 68.01n vdd TD=0)
Vwwl3 wwl3 0 pwl(0 0 10p vdd 63.99n vdd 64n 0 68n 0 68.01n vdd TD=0)

Vwlpu0 wlpu0 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=0)
Vwlpu1 wlpu1 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=8n)
Vwlpu2 wlpu2 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=16n)
Vwlpu3 wlpu3 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=24n)
Vwlpu4 wlpu4 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=32n)
Vwlpu5 wlpu5 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=40n)
Vwlpu6 wlpu6 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=48n)
Vwlpu7 wlpu7 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 TD=56n)

Vwlpd0 wlpd0 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd TD=0)
Vwlpd1 wlpd1 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd TD=8n)
Vwlpd2 wlpd2 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd TD=16n)
Vwlpd3 wlpd3 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd TD=24n)
Vwlpd4 wlpd4 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd TD=32n)
Vwlpd5 wlpd5 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd TD=40n)
Vwlpd6 wlpd6 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd TD=48n)
Vwlpd7 wlpd7 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd TD=56n)

*****vvss/sae keeps 1, never trigger reading*****

Vvss0 vvss0 0 dc=vdd
Vvss1 vvss1 0 dc=vdd
Vvss2 vvss2 0 dc=vdd
Vvss3 vvss3 0 dc=vdd

Vdin0 din0 0 dc=vdd
Vdin1 din1 0 dc=vdd
Vdin2 din2 0 dc=vdd
Vdin3 din3 0 dc=vdd

.tran 1p 10000n

.measure pwr avg p(vvdd) FROM=200n TO=10000n 

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
Vdin0 din0 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)
Vdin1 din1 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)
Vdin2 din2 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)
Vdin3 din3 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)

.alter case 5:
.include '7nm_TT.pm'
.TEMP 25.0
.PARAM vdd=0.7v
Vdin0 din0 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)
Vdin1 din1 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)
Vdin2 din2 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)
Vdin3 din3 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)

.alter case 6:
.include '7nm_SS.pm'
.TEMP 100.0
.PARAM vdd=0.63v
Vdin0 din0 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)
Vdin1 din1 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)
Vdin2 din2 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)
Vdin3 din3 0 pwl(0 vdd 10p 0 63.99n 0 64n vdd TD=0)

.end




