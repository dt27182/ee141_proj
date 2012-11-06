***	EE141 Fall 2010: Flash-ADC Lookup Table 	***
***	Functionality Check & Power Measurement Deck	***
***	Your Names Here 				***
***********************************************************

*** Models ***
.lib '/home/ff/ee141/MODELS/gpdk090_mos.sp' TT_s1v

*** Parameters ***
* You can change these if you would like.
.param SUP = 1.2
.param DUTY = 0.5

* These should not be changed.
.param TCYC = 10n
.param TDEL = 1n
.param RISE = 100p
.param FALL = 100p
.param NCYC = 20
.param CL   = 15f

*** Voltage Supplies ***
* You can add additional supplies here,
* but make sure you measure the power
* for each of them.
VDD vdd! 0 'SUP'

*** Inputs ***
* If necessary, adjust your naming convention to match what was given in the project spec.
* Do not change the input pattern given in func_chk.vec.
***********************

**** Include 'func_chk.vec' to check functionality
**** See 'testbench.err0' to check errors
**** Overlay OUT<0:5> waveform with OUT_EXP<0:5> to show your functionality
.VEC 'func_chk.vec'

*** Clock Subckt ***

.subckt clkgen clk vdd DEL=1n PW=5n MULT=1
* Clock generation
VCLK VCLK 0 PULSE('SUPPLY' 0 'DEL' 100p 100p 'PW-100p' 'CLOCKPERIOD')

* Buffer to drive the clock
M1 CLK VCLK 0   0   NMOS gpdk090_nmos1v L=100e-9 W=120e-9 M='MULT'
M2 CLK VCLK VDD VDD PMOS gpdk090_pmos1v L=100e-9 W=240e-9 M='MULT'
* Size the inverter for FO4 using the 'MULT' input parameter

.ENDS

* Sample instantiation of the clkgen subckt
* XCLK CLK vdd! clkgen DEL='TDEL' PW='TCYC*DUTY' MULT=100

* You can use multiple clocks, but each clock needs a clock subckt.

*** Lookup Table Unit ***
* This is your circuit. You can include multiple files if needed.
.include 'proj_phase3.sp'

* Sample instantiation of LUT
* X_PROJ_PHASE3 vdd! 0 T<0> T<1> T<2> T<3> T<4> T<5> T<6> T<7> T<8> T<9> T<10> T<11> T<12> T<13> T<14> T<15> T<16> T<17> T<18> T<19> T<20> T<21> T<22> T<23> T<24> T<25> T<26> T<27> T<28> T<29> T<30> T<31> T<32> T<33> T<34> T<35> T<36> T<37> T<38> T<39> T<40> T<41> T<42> T<43> T<44> T<45> T<46> T<47> T<48> T<49> T<50> T<51> T<52> T<53> T<54> T<55> T<56> T<57> T<58> T<59> T<60> T<61> T<62> W<0> W_b<0> W<1> W_b<1> W<2> W_b<2> W<3> W_b<3> W<4> W_b<4> W<5> W_b<5> WRITE_BUF EN_BUF OUT<0> DATA<0> DATA_b<0> OUT<1> DATA<1> DATA_b<1> OUT<2> DATA<2> DATA_b<2> OUT<3> DATA<3> DATA_b<3> OUT<4> DATA<4> DATA_b<4> PROJ_PHASE3

* Your circuit should have the following pins:
* 1. Thermometer inputs: T<0>, T<1>, ... , T<62> (if reqd, T_b<0>, T_b<1>, ... , T_b<62>)
* 2. Binary write-address inputs: W<0>, W<1>, ... , W<5> (if reqd, W_b<0>, W_b<1>, ... , W_b<5>)
* 3. Control Signal for Writing: WRITE_BUF (buffered version of the WRITE signal from func_chk.vec)
* 4. Control Signal for Enabling Read/Write: EN_BUF (buffered version of the EN signal from func_chk.vec)
* 5. Data written to LUT: DATA<0>, DATA<1>, ... , DATA<4>; DATA_b<0>, DATA_b<1>, ... , DATA_b<4>
* 6. Output of LUT: OUT<0>, OUT<1>, ... , OUT<4> (if needed, OUT_b<0>, OUT_b<1>, ... , OUT_b<4>)  

*** Load Capacitors ***
* Make sure you are following the naming convention.

CS<0> OUT<0> 0 'CL'
CS<1> OUT<1> 0 'CL'
CS<2> OUT<2> 0 'CL'
CS<3> OUT<3> 0 'CL'
CS<4> OUT<4> 0 'CL'

CS_b<0> OUT_b<0> 0 'CL'
CS_b<1> OUT_b<1> 0 'CL'
CS_b<2> OUT_b<2> 0 'CL'
CS_b<3> OUT_b<3> 0 'CL'
CS_b<4> OUT_b<4> 0 'CL'

***DUMMY CAPS
CSE<0> OUT_EXP<0> 0 'CL'
CSE<1> OUT_EXP<1> 0 'CL'
CSE<2> OUT_EXP<2> 0 'CL'
CSE<3> OUT_EXP<3> 0 'CL'
CSE<4> OUT_EXP<4> 0 'CL'

.tran 10p 'TDEL+NCYC*TCYC'

* If you have additional voltage supplies, make sure to add a .measure for each of them.
.measure TRAN avgI_VDD AVG I(VDD) from='TDEL' to='TDEL+NCYC*TCYC'
.measure TRAN avgP_VDD PARAM='-avgI_VDD*sup'

*** Options ***
.option post=2 nomod

.end