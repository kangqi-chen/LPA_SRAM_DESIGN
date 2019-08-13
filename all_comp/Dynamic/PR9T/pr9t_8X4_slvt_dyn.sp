** 9T-SRAM 8X4 LVT DYN

.include '7nm_FF.pm'
.TEMP 0.0
.PARAM vdd=0.77v
.OPTION POST


********** BITLINE CONTROLLER ********** 

.subckt blcontroller vvdd clk bit 
MM1 vvdd clk bit vvdd pmos_slvt NFIN=1
.ends

********** SRAM CELL ********** 

.subckt cell vvdd vgnd wbit rbit wl wlpu wlpd vvss

MM1 n1 yy xx vvdd pmos_slvt NFIN=1     
MM2 xx yy n2 vgnd nmos_slvt NFIN=3     
MM3 vvdd xx yy vvdd pmos_slvt NFIN=1   
MM4 yy xx vgnd vgnd nmos_slvt NFIN=3  

MM5 n1 wlpu vvdd vvdd pmos_slvt NFIN=1 
MM6 n2 wlpd vgnd vgnd nmos_slvt NFIN=3
  
MA1 xx wl wbit vgnd nmos_slvt NFIN=2   
MA2 rbit yy vvss vgnd pmos_slvt NFIN=2  

MAL yy vgnd wbit vgnd nmos_slvt NFIN=2

.ends

********** INVERTER ********** 

.subckt inv vin vout vvdd vgnd
MM1 vvdd vin vout vvdd pmos_slvt NFIN=3
MM2 vgnd vin vout vgnd nmos_slvt NFIN=3
.ends

********** WRITE ********** 

.subckt write vvdd vgnd bit din we 

XINV din n1 vvdd vgnd inv

MM1 vgnd n1 n2 vgnd nmos_slvt NFIN=3
MM2 n2 we bit vgnd nmos_slvt NFIN=3

.ends

********** SENSE AMPLIFIER ********** 

.subckt sa vvdd vgnd bit sae clk out

MPU vvdd sae out vvdd pmos_slvt NFIN=1
MPD out bit vgnd vgnd nmos_slvt NFIN=3
MM3 out clk vgnd vgnd nmos_slvt NFIN=3

XINV out pub vvdd vgnd inv

MM4 n1 pub out vvdd pmos_slvt NFIN=3
MM5 vvdd clk n1 vvdd pmos_slvt NFIN=3

.ends

********** COMPLETE CIRCUIT ********** 

XBLC0 vdd clk wbit0 blcontroller
XBLC1 vdd clk wbit1 blcontroller
XBLC2 vdd clk wbit2 blcontroller
XBLC3 vdd clk wbit3 blcontroller

XCELL00 vdd 0 wbit0 rbit0 wl0 wlpu0 wlpd0 vvss0 cell
XCELL10 vdd 0 wbit0 rbit0 wl1 wlpu1 wlpd1 vvss0 cell
XCELL20 vdd 0 wbit0 rbit0 wl2 wlpu2 wlpd2 vvss0 cell
XCELL30 vdd 0 wbit0 rbit0 wl3 wlpu3 wlpd3 vvss0 cell
XCELL40 vdd 0 wbit0 rbit0 wl4 wlpu4 wlpd4 vvss0 cell
XCELL50 vdd 0 wbit0 rbit0 wl5 wlpu5 wlpd5 vvss0 cell
XCELL60 vdd 0 wbit0 rbit0 wl6 wlpu6 wlpd6 vvss0 cell
XCELL70 vdd 0 wbit0 rbit0 wl7 wlpu7 wlpd7 vvss0 cell

XCELL01 vdd 0 wbit1 rbit1 wl0 wlpu0 wlpd0 vvss1 cell
XCELL11 vdd 0 wbit1 rbit1 wl1 wlpu1 wlpd1 vvss1 cell
XCELL21 vdd 0 wbit1 rbit1 wl2 wlpu2 wlpd2 vvss1 cell
XCELL31 vdd 0 wbit1 rbit1 wl3 wlpu3 wlpd3 vvss1 cell
XCELL41 vdd 0 wbit1 rbit1 wl4 wlpu4 wlpd4 vvss1 cell
XCELL51 vdd 0 wbit1 rbit1 wl5 wlpu5 wlpd5 vvss1 cell
XCELL61 vdd 0 wbit1 rbit1 wl6 wlpu6 wlpd6 vvss1 cell
XCELL71 vdd 0 wbit1 rbit1 wl7 wlpu7 wlpd7 vvss1 cell

XCELL02 vdd 0 wbit2 rbit2 wl0 wlpu0 wlpd0 vvss2 cell
XCELL12 vdd 0 wbit2 rbit2 wl1 wlpu1 wlpd1 vvss2 cell
XCELL22 vdd 0 wbit2 rbit2 wl2 wlpu2 wlpd2 vvss2 cell
XCELL32 vdd 0 wbit2 rbit2 wl3 wlpu3 wlpd3 vvss2 cell
XCELL42 vdd 0 wbit2 rbit2 wl4 wlpu4 wlpd4 vvss2 cell
XCELL52 vdd 0 wbit2 rbit2 wl5 wlpu5 wlpd5 vvss2 cell
XCELL62 vdd 0 wbit2 rbit2 wl6 wlpu6 wlpd6 vvss2 cell
XCELL72 vdd 0 wbit2 rbit2 wl7 wlpu7 wlpd7 vvss2 cell

XCELL03 vdd 0 wbit3 rbit3 wl0 wlpu0 wlpd0 vvss3 cell
XCELL13 vdd 0 wbit3 rbit3 wl1 wlpu1 wlpd1 vvss3 cell
XCELL23 vdd 0 wbit3 rbit3 wl2 wlpu2 wlpd2 vvss3 cell
XCELL33 vdd 0 wbit3 rbit3 wl3 wlpu3 wlpd3 vvss3 cell
XCELL43 vdd 0 wbit3 rbit3 wl4 wlpu4 wlpd4 vvss3 cell
XCELL53 vdd 0 wbit3 rbit3 wl5 wlpu5 wlpd5 vvss3 cell
XCELL63 vdd 0 wbit3 rbit3 wl6 wlpu6 wlpd6 vvss3 cell
XCELL73 vdd 0 wbit3 rbit3 wl7 wlpu7 wlpd7 vvss3 cell

XWC0 vdd 0 wbit0 din0 we0 write
XWC1 vdd 0 wbit1 din1 we1 write
XWC2 vdd 0 wbit2 din2 we2 write
XWC3 vdd 0 wbit3 din3 we3 write

XSA0 vdd 0 rbit0 sae0 clk out0 sa
XSA1 vdd 0 rbit1 sae1 clk out1 sa
XSA2 vdd 0 rbit2 sae2 clk out2 sa
XSA3 vdd 0 rbit3 sae3 clk out3 sa

Vvdd vdd 0 dc=vdd

Vclk clk 0 pulse(0 vdd 4n 10p 10p 3.98n 8n)

Vwl0 wl0 0 pulse(0 vdd 0 10p 10p 3.98n 128n)
Vwl1 wl1 0 pulse(0 vdd 8n 10p 10p 3.98n 128n)
Vwl2 wl2 0 pulse(0 vdd 16n 10p 10p 3.98n 128n)
Vwl3 wl3 0 pulse(0 vdd 24n 10p 10p 3.98n 128n)
Vwl4 wl4 0 pulse(0 vdd 32n 10p 10p 3.98n 128n)
Vwl5 wl5 0 pulse(0 vdd 40n 10p 10p 3.98n 128n)
Vwl6 wl6 0 pulse(0 vdd 48n 10p 10p 3.98n 128n)
Vwl7 wl7 0 pulse(0 vdd 56n 10p 10p 3.98n 128n)

Vwe0 we0 0 pulse(0 vdd 0 10p 10p 63.98n 128n)
Vwe1 we1 0 pulse(0 vdd 0 10p 10p 63.98n 128n)
Vwe2 we2 0 pulse(0 vdd 0 10p 10p 63.98n 128n)
Vwe3 we3 0 pulse(0 vdd 0 10p 10p 63.98n 128n)

Vwlpu0 wlpu0 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 128n 0 R TD=0)
Vwlpu1 wlpu1 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 128n 0 R TD=8n)
Vwlpu2 wlpu2 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 128n 0 R TD=16n)
Vwlpu3 wlpu3 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 128n 0 R TD=24n)
Vwlpu4 wlpu4 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 128n 0 R TD=32n)
Vwlpu5 wlpu5 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 128n 0 R TD=40n)
Vwlpu6 wlpu6 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 128n 0 R TD=48n)
Vwlpu7 wlpu7 0 pwl(0 0 10p vdd 3.99n vdd 4n 0 128n 0 R TD=56n)

Vwlpd0 wlpd0 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd 128n vdd R TD=0)
Vwlpd1 wlpd1 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd 128n vdd R TD=8n)
Vwlpd2 wlpd2 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd 128n vdd R TD=16n)
Vwlpd3 wlpd3 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd 128n vdd R TD=24n)
Vwlpd4 wlpd4 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd 128n vdd R TD=32n)
Vwlpd5 wlpd5 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd 128n vdd R TD=40n)
Vwlpd6 wlpd6 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd 128n vdd R TD=48n)
Vwlpd7 wlpd7 0 pwl(0 vdd 10p 0 3.99n 0 4n vdd 128n vdd R TD=56n)

Vvss0 vvss0 0 pulse(vdd 0 64n 10p 10p 63.98n 128n)
Vvss1 vvss1 0 pulse(vdd 0 64n 10p 10p 63.98n 128n)
Vvss2 vvss2 0 pulse(vdd 0 64n 10p 10p 63.98n 128n)
Vvss3 vvss3 0 pulse(vdd 0 64n 10p 10p 63.98n 128n)

Vsae0 sae0 0 pulse(vdd 0 64n 10p 10p 63.98n 128n)
Vsae1 sae1 0 pulse(vdd 0 64n 10p 10p 63.98n 128n)
Vsae2 sae2 0 pulse(vdd 0 64n 10p 10p 63.98n 128n)
Vsae3 sae3 0 pulse(vdd 0 64n 10p 10p 63.98n 128n)

Vdin0 din0 0 pulse(vdd 0 0 10p 10p 127.98n 256n)
Vdin1 din1 0 pulse(vdd 0 0 10p 10p 127.98n 256n)
Vdin2 din2 0 pulse(vdd 0 0 10p 10p 127.98n 256n)
Vdin3 din3 0 pulse(vdd 0 0 10p 10p 127.98n 256n)

C0 out0 0 1f
C1 out1 0 1f
C2 out2 0 1f
C3 out3 0 1f

.tran 1p 512n

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




