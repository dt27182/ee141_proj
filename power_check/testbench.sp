***	EE141 Fall 2012: SRAM-based SliceL		***
***	Power Measurement Deck				***
***	Your Names Here 				***
***********************************************************

*** Models ***
.lib '/home/ff/ee141/MODELS/gpdk090_mos.sp' TT_s1v

*** Parameters ***
* You can change these if you would like. You can
* add extra parameters for additional clocks as well.
.param vsup = 1.2
.param duty_cycle = 0.50

* These should not be changed.
.param t_period = 10n
.param t_delay = 0n
.param t_rise = 100p
.param t_fall = 100p
.param n_cyc = 80
.param capval = 15f

*** Global Nets ***
* Include this if you use a global vdd
.global 0 vdd!

*** Voltage Supplies ***
* You can add additional supplies here,
* but make sure you measure the power
* for each of them.
Vdd vdd! 0 'vsup'


*** Inputs ***
* If necessary, adjust your naming convention to match what was given in the project spec.
* Do not change the input pattern given in power_check.vec.
***********************

**** Include 'power_check.vec' to check functionality
**** See 'testbench.err0' to check errors
**** Overlay out<7:0> waveform with out_exp<7:0> to show your functionality
.vec 'power_check.vec'

*** Clock Subckt ***

.subckt clkgen clk vdd vdd_val=1.2 delay=1n pulse_width=5n mult=1
* Clock generation
Vclk vclk 0 pulse vdd_val 0 'delay' 100p 100p 'pulse_width - 100p' 't_period'

* Buffer to drive the clock
M1 clk vclk 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 M='mult'
M2 clk vclk vdd vdd gpdk090_pmos1v L=100e-9 W=240e-9 M='mult'
* Size the inverter for FO4 using the 'mult' input parameter

.ends

** Buffer Subckt **
* Use this buffer to drive your inputs, so that you can properly account for 
* their power. mult1, mult2 are the multipliers of the 1st and 2nd stages, 
* respectively. You should ensure that each stage does not have more than a 
* FO4 delay. You should also supply the supply voltage value, so that this
* subcircuit will not include the power spent to drive this buffer, since the
* point of this buffer is to account for the power from driving the capacitance
* associated with each input.

.subckt input_buf out in vdd vdd_val=1.2 mult1=2 mult2=8

* Internal supply so that input capacitance of 2nd inverter isn't included
* in the simulated power consumption.

Vdd_int vdd_int 0 vdd_val

* First Inverter
M0 int in 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 M='mult1'
M1 int in vdd_int vdd_int gpdk090_pmos1v L=100e-9 W=240e-9 M='mult1'

* Second Inverter
M2 out int 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 M='mult2'
M3 out int vdd vdd gpdk090_pmos1v L=100e-9 W=240e-9 M='mult2'

.ends

* Sample instantiation of the clkgen subckt
* Xen en vdd! clkgen vdd_val='vsup' delay='5n' pulse_width='t_period*duty_cycle' mult=50 

* You can use multiple clocks, but each clock needs a clock subckt. Make sure
* that you generate the enable and write signals, as well as any other clocks
* you need.

*** SliceL Unit ***
* This is your circuit. You can include multiple files if needed.
.include 'slice.sp'

* Sample instantiation of the SliceL - modify this to meet your implementation!
*xi0 asout<1> asout<0> ax bsout<1> bsout<0> bx cin cout csout<1> csout<0> cx dsout<1> dsout<0> out<7> out<6> out<5> out<4> out<3> out<2> out<1> out<0> data<15> data<14> data<13> data<12> data<11> data<10> data<9> data<8> data<7> data<6> data<5> data<4> data<3> data<2> data<1> data<0> data_b<15> data_b<14> data_b<13> data_b<12> data_b<11> data_b<10> data_b<9> data_b<8> data_b<7> data_b<6> data_b<5> data_b<4> data_b<3> data_b<2> data_b<1> data_b<0> en ina<5> ina<4> ina<3> ina<2> ina<1> ina<0> inb<5> inb<4> inb<3> inb<2> inb<1> inb<0> inc<5> inc<4> inc<3> inc<2> inc<1> inc<0> ind<5> ind<4> ind<3> ind<2> ind<1> ind<0> write SliceTop
*xi0 data<0> data<1> data<2> data<3> data_b<0> data_b<1> data_b<2> data_b<3> asout<0> asout<1> ax data<4> data<5> data<6> data<7> data_b<4> data_b<5> data_b<6> data_b<7> bsout<0> bsout<1> bx data<8> data<9> data<10> data<11> data_b<8> data_b<9> data_b<10> data_b<11> cin cout csout<0> csout<1> cx data<12> data<13> data<14> data<15> data_b<12> data_b<13> data_b<14> data_b<15> dsout<0> dsout<1> en ina<0> ina<1> ina<2> ina<3> ina<4> ina<5> inb<0> inb<1> inb<2> inb<3> inb<4> inb<5> inc<0> inc<1> inc<2> inc<3> inc<4> inc<5> ind<0> ind<1> ind<2> ind<3> ind<4> ind<5> out<0> out<1> out<2> out<3> out<4> out<5> out<6> out<7> write slice

* Your circuit should have the following pins:
* 1. Binary address inputs for each LUT: inA<0>, inA<1>, ..., inA<5>, ..., inD<5>
* 2. Write data, and complemented inputs: data<0>, ..., data<15>, data_b<0>, ..., data_b<15>
* 3. Control signal for writing: write
* 4. Control signal(s) for enabling read/write: en
* 5. Carry-in for addition: cin
* 6. Outputs of SliceL: out<0>, ..., out<7>, cout
* 7. Output select bits: asout<0>, asout<1>, bsout<0>, ..., dsout<1>

*** Load Capacitors ***
* Make sure you are following the naming convention.
Cout0 out<0> 0 capval
Cout1 out<1> 0 capval
Cout2 out<2> 0 capval
Cout3 out<3> 0 capval
Cout4 out<4> 0 capval
Cout5 out<5> 0 capval
Cout6 out<6> 0 capval
Cout7 out<7> 0 capval
Ccout cout 0 capval

*** Dummy Capacitors ***
Cdum0 out_exp<0> 0 capval
Cdum1 out_exp<1> 0 capval
Cdum2 out_exp<2> 0 capval
Cdum3 out_exp<3> 0 capval
Cdum4 out_exp<4> 0 capval
Cdum5 out_exp<5> 0 capval
Cdum6 out_exp<6> 0 capval
Cdum7 out_exp<7> 0 capval
Cdumc cout_exp 0 capval

.tran 10p 't_delay+n_cyc*t_period'

* If you have additional voltage supplies, make sure to add a .measure for each of them.
.measure tran i_vdd_avg avg I(Vdd) from='t_delay' to='t_delay+n_cyc*t_period'
.measure tran p_vdd_avg param='-i_vdd_avg*vsup'

*** Options ***
.option post=2 nomod

.end
