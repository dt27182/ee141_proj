** EE 141 Term Project Fall 2012 Phase II - MUX and Vertical Logic Block **

*****************************************************************************
* Copy this spice deck and the digital vector file 'func_check.vec'
* into the same folder as your MUX and Vertical Logic Block deck. Make sure
* that your block is enclosed within a subckt module.
*****************************************************************************

.param vdd_val = 1.2
.param capval = 15f
.lib '/home/ff/ee141/MODELS/gpdk090_mos.sp' TT_s1v

** Include your MUX and Vertical Logic Block here
.include 'MUXVerticalLogic.sp'

** If you use a global Vdd in MUXVerticalLogic.sp, you need to add the
** following syntax
* .global vdd! 0
* vdd vdd! 0 dc vdd_val

** Or if Vdd is an input
* vdd vdd 0 dc vdd_val

** Wire the inputs L<15:0>, ina<5:4>, inb<5:4>, inc<5:4>, ind<5:4>, ax, bx,
** cx, cin, asout<1:0>, bsout<1:0>, csout<1:0>, dsout<1:0>, and outputs
** out<8:0>, cout, to an instance of your MUX/Vertical Logic block here. Only
** the names at this level of the deck need to be as you see them here. Make
** sure to order the inputs in accordance to the order of your implementation.

** MUX / Vertical Logic Block **
XMVB 
** Arrange these inputs in the order your subckt dictates
*+ L<15> L<14> ... L<1> L<0>
*+ ina<5> ina<4> ... ind<5> ind<4>
*+ asout<1> asout<0> ... dsout<1> dsout<0> 
*+ ax bx cx cin
*+ out<8> out<7> ... out<1> out<0>
*+ cout
+ MuxVerticalLogic

** Load Caps **
Cout0 out<0> 0 capval
Cout1 out<1> 0 capval
Cout2 out<2> 0 capval
Cout3 out<3> 0 capval
Cout4 out<4> 0 capval
Cout5 out<5> 0 capval
Cout6 out<6> 0 capval
Cout7 out<7> 0 capval
Ccout cout 0 capval

** Dummy Caps - Used for verification **
Cdum0 out_exp<0> 0 capval
Cdum1 out_exp<1> 0 capval
Cdum2 out_exp<2> 0 capval
Cdum3 out_exp<3> 0 capval
Cdum4 out_exp<4> 0 capval
Cdum5 out_exp<5> 0 capval
Cdum6 out_exp<6> 0 capval
Cdum7 out_exp<7> 0 capval
Cdumc cout_exp 0 capval

** Stimulus **
.vec 'func_check.vec'

** Control info **
.options post=2 nomod
.op

** Transient simulation
.tran .1ns 1.8us

.end