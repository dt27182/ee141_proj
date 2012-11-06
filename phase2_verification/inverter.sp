* Simple CMOS Inverter
.lib '/home/ff/ee141/MODELS/gpdk090_mos.sp' TT_S1V
.Param beta = 2
.Param nwidth = 1e-6
.Param pwidth = beta*nwidth
VIN in 0 PULSE 0 1.2 200ps 2ps 2ps 10ns 20ns
VCC vcc 0 1.2
VDD vout 0 1.2
VM vm 0 0
R1 vcc vg 4.2k
M0 vm vg vcc vcc gpdk090_pmos1v L=100e-9 W=pwidth
M4 vg vcc 0 0 gpdk090_nmos1v L=100e-9 W=nwidth
M5 0 vg 0 0 gpdk090_nmos1v L=100e-9 W=nwidth

**Control Information**
.options post=2 nomod
.op 

**Transient Analysis**
.tran .01ns 40ns SWEEP beta 2.5 2.6 0.01

**DC Analysis**
.dc VIN 0 1.2 0.001

.meas tran tphl trig V(in) val = 0.6 rise = 1 targ V(out1) val = 0.6 fall = 1
.meas tran tplh trig V(in) val = 0.6 fall = 1 targ V(out1) val = 0.6 rise = 1
.meas tran i_avg avg i(vm) from=5ns to=10ns
.END
