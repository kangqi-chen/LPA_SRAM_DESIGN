** 9T-SRAM 4X4 SLVT

.include '7nm_FF.pm'

.OPTION POST

********** BITLINE CONTROLLER ********** 

.subckt blcontroller vvdd clk bit 
MM1 vvdd clk bit vvdd pmos_slvt NFIN=1
.ends

********** SRAM CELL ********** 

.subckt cell vvdd vgnd bit wl wwl wlpu wlpd vvss

MM1 n1 yy xx vvdd pmos_slvt NFIN=1     
MM2 xx yy n2 vgnd nmos_slvt NFIN=1     
MM3 vvdd xx yy vvdd pmos_slvt NFIN=1   
MM4 yy xx vgnd vgnd nmos_slvt NFIN=1  

MM5 n1 wlpu vvdd vvdd pmos_slvt NFIN=1 
MM6 n2 wlpd vgnd vgnd nmos_slvt NFIN=1

MM7 xx wwl vx vgnd nmos_slvt NFIN=1    
MM8 vx wl bit vgnd nmos_slvt NFIN=1   
MM9 vx xx vvss vgnd nmos_slvt NFIN=1  

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
MPD out bit vgnd vgnd nmos_slvt NFIN=1
MM3 out clk vgnd vgnd nmos_slvt NFIN=3

XINV out pub vvdd vgnd inv

MM4 n1 pub out vvdd pmos_slvt NFIN=3
MM5 vvdd clk n1 vvdd pmos_slvt NFIN=3

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

XCELL01 vdd 0 bit1 wl0 wwl1 wlpu0 wlpd0 vvss1 cell
XCELL11 vdd 0 bit1 wl1 wwl1 wlpu1 wlpd1 vvss1 cell
XCELL21 vdd 0 bit1 wl2 wwl1 wlpu2 wlpd2 vvss1 cell
XCELL31 vdd 0 bit1 wl3 wwl1 wlpu3 wlpd3 vvss1 cell

XCELL02 vdd 0 bit2 wl0 wwl2 wlpu0 wlpd0 vvss2 cell
XCELL12 vdd 0 bit2 wl1 wwl2 wlpu1 wlpd1 vvss2 cell
XCELL22 vdd 0 bit2 wl2 wwl2 wlpu2 wlpd2 vvss2 cell
XCELL32 vdd 0 bit2 wl3 wwl2 wlpu3 wlpd3 vvss2 cell

XCELL03 vdd 0 bit3 wl0 wwl3 wlpu0 wlpd0 vvss3 cell
XCELL13 vdd 0 bit3 wl1 wwl3 wlpu1 wlpd1 vvss3 cell
XCELL23 vdd 0 bit3 wl2 wwl3 wlpu2 wlpd2 vvss3 cell
XCELL33 vdd 0 bit3 wl3 wwl3 wlpu3 wlpd3 vvss3 cell

XWC0 vdd 0 bit0 din0 we0 write
XWC1 vdd 0 bit1 din1 we1 write
XWC2 vdd 0 bit2 din2 we2 write
XWC3 vdd 0 bit3 din3 we3 write

XSA0 vdd 0 bit0 sae0 clk out0 sa
XSA1 vdd 0 bit1 sae1 clk out1 sa
XSA2 vdd 0 bit2 sae2 clk out2 sa
XSA3 vdd 0 bit3 sae3 clk out3 sa

Vvdd vdd 0 dc=0.17v

.PARAM vdd=0.17v

Vclk clk 0 pulse(0 vdd 50n 10p 10p 49.98n 100n)

Vwl0 wl0 0 pulse(0 vdd 0 10p 10p 49.98n 400n)
Vwl1 wl1 0 pulse(0 vdd 100n 10p 10p 49.98n 400n)
Vwl2 wl2 0 pulse(0 vdd 200n 10p 10p 49.98n 400n)
Vwl3 wl3 0 pulse(0 vdd 300n 10p 10p 49.98n 400n)

Vwe0 we0 0 pulse(0 vdd 0 10p 10p 399.98n 1600n)
Vwe1 we1 0 pulse(0 vdd 400n 10p 10p 399.98n 1600n)
Vwe2 we2 0 pulse(0 vdd 0 10p 10p 399.98n 1600n)
Vwe3 we3 0 pulse(0 vdd 400n 10p 10p 399.98n 1600n)

Vwwl0 wwl0 0 pulse(0 vdd 0 10p 10p 399.98n 1600n)
Vwwl1 wwl1 0 pulse(0 vdd 400n 10p 10p 399.98n 1600n)
Vwwl2 wwl2 0 pulse(0 vdd 0 10p 10p 399.98n 1600n)
Vwwl3 wwl3 0 pulse(0 vdd 400n 10p 10p 399.98n 1600n)

Vwlpu0 wlpu0 0 pwl(0 0 10p vdd 49.99n vdd 50n 0 400n 0 400.01n vdd 449.99n vdd 450n 0 1599.99n 0 R TD=0)
Vwlpu1 wlpu1 0 pwl(0 0 10p vdd 49.99n vdd 50n 0 400n 0 400.01n vdd 449.99n vdd 450n 0 1599.99n 0 R TD=100n)
Vwlpu2 wlpu2 0 pwl(0 0 10p vdd 49.99n vdd 50n 0 400n 0 400.01n vdd 449.99n vdd 450n 0 1599.99n 0 R TD=200n)
Vwlpu3 wlpu3 0 pwl(0 0 10p vdd 49.99n vdd 50n 0 400n 0 400.01n vdd 449.99n vdd 450n 0 1599.99n 0 R TD=300n)

Vwlpd0 wlpd0 0 pwl(0 vdd 10p 0 49.99n 0 50n vdd 400n vdd 400.01n 0 449.99n 0 450n vdd 1600n vdd R TD=0)
Vwlpd1 wlpd1 0 pwl(0 vdd 10p 0 49.99n 0 50n vdd 400n vdd 400.01n 0 449.99n 0 450n vdd 1600n vdd R TD=100n)
Vwlpd2 wlpd2 0 pwl(0 vdd 10p 0 49.99n 0 50n vdd 400n vdd 400.01n 0 449.99n 0 450n vdd 1600n vdd R TD=200n)
Vwlpd3 wlpd3 0 pwl(0 vdd 10p 0 49.99n 0 50n vdd 400n vdd 400.01n 0 449.99n 0 450n vdd 1600n vdd R TD=300n)

Vvss0 vvss0 0 pulse(vdd 0 800n 10p 10p 399.98n 1600n)
Vvss1 vvss1 0 pulse(vdd 0 1200n 10p 10p 399.98n 1600n)
Vvss2 vvss2 0 pulse(vdd 0 800n 10p 10p 399.98n 1600n)
Vvss3 vvss3 0 pulse(vdd 0 1200n 10p 10p 399.98n 1600n)

Vsae0 sae0 0 pulse(vdd 0 800n 10p 10p 399.98n 1600n)
Vsae1 sae1 0 pulse(vdd 0 1200n 10p 10p 399.98n 1600n)
Vsae2 sae2 0 pulse(vdd 0 800n 10p 10p 399.98n 1600n)
Vsae3 sae3 0 pulse(vdd 0 1200n 10p 10p 399.98n 1600n)

Vdin0 din0 0 pulse(vdd 0 0 10p 10p 1599.98n 3200n)
Vdin1 din1 0 pulse(vdd 0 0 10p 10p 1599.98n 3200n)
Vdin2 din2 0 pulse(vdd 0 0 10p 10p 1599.98n 3200n)
Vdin3 din3 0 pulse(vdd 0 0 10p 10p 1599.98n 3200n)

C0 out0 0 0.1p
C1 out1 0 0.1p
C2 out2 0 0.1p
C3 out3 0 0.1p

.tran 1p 6400n

.measure pwr avg p(vvdd)

.alter case 2:
.include '7nm_TT.pm'
Vvdd vdd 0 dc=0.19v
.PARAM vdd=0.19v

.alter case 3:
.include '7nm_SS.pm'
Vvdd vdd 0 dc=0.22v
.PARAM vdd=0.22v

.end




