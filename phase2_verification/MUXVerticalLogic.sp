** Library name: sram
** Cell name: inv_1x
** View name: schematic
.subckt inv_1x in out
mpm0 out in vdd! vdd! gpdk090_pmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
mnm0 out in 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
.ends inv_1x
** End of subcircuit definition.

** Library name: sram
** Cell name: mux2
** View name: schematic
.subckt mux2 sel selb in0 in1 out
mnm4 out net49 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mnm2 net32 in0 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mnm1 net36 sel net49 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mnm3 net36 in1 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mnm0 net32 selb net49 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mpm4 out net49 vdd! vdd! gpdk090_pmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
mpm2 net32 in0 vdd! vdd! gpdk090_pmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
mpm1 net49 selb net36 vdd! gpdk090_pmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
mpm3 net36 in1 vdd! vdd! gpdk090_pmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
mpm0 net49 sel net32 vdd! gpdk090_pmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
.ends mux2
** End of subcircuit definition.

** Library name: sram
** Cell name: 5_6_LUT_Output_Decoder
** View name: schematic
.subckt sram_5_6_LUT_Output_Decoder_schematic in4 in5 l0 l1 l2 l3 o5 o6
xi3 in5 net13 inv_1x
xi4 in4 net23 inv_1x
xi2 in5 net13 o5 net17 o6 mux2
xi1 in4 net23 l2 l3 net17 mux2
xi0 in4 net23 l0 l1 o5 mux2
.ends sram_5_6_LUT_Output_Decoder_schematic
** End of subcircuit definition.

** Library name: sram
** Cell name: xor
** View name: schematic
.subckt xor a abar b bbar out
mpm3 net21 abar vdd! vdd! gpdk090_pmos1v L=100e-9 W=480e-9 AD=134.4e-15 AS=134.4e-15 PD=1.52e-6 PS=1.52e-6 M=1
mpm2 net21 bbar vdd! vdd! gpdk090_pmos1v L=100e-9 W=480e-9 AD=134.4e-15 AS=134.4e-15 PD=1.52e-6 PS=1.52e-6 M=1
mpm1 out b net21 vdd! gpdk090_pmos1v L=100e-9 W=480e-9 AD=134.4e-15 AS=134.4e-15 PD=1.52e-6 PS=1.52e-6 M=1
mpm0 out a net21 vdd! gpdk090_pmos1v L=100e-9 W=480e-9 AD=134.4e-15 AS=134.4e-15 PD=1.52e-6 PS=1.52e-6 M=1
mnm3 net22 bbar 0 0 gpdk090_nmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
mnm2 net26 b 0 0 gpdk090_nmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
mnm1 out abar net22 0 gpdk090_nmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
mnm0 out a net26 0 gpdk090_nmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
.ends xor
** End of subcircuit definition.

** Library name: sram
** Cell name: mux_vertical_logic_sub
** View name: schematic
.subckt mux_vertical_logic_sub cin cout o5 o6 inputx out_0 sout0 sout1
xi5 o6 net52 cin net48 net42 xor
xi12 sout1 net57 inv_1x
xi10 sout0 net46 inv_1x
xi7 cin net48 inv_1x
xi1 o6 net72 inv_1x
xi6 o6 net52 inv_1x
xi11 sout1 net57 net66 net61 out_0 mux2
xi9 sout0 net46 net42 cout net61 mux2
xi8 sout0 net46 o5 inputx net66 mux2
xi0 o6 net72 o5 cin cout mux2
.ends mux_vertical_logic_sub
** End of subcircuit definition.

** Library name: sram
** Cell name: mux_vertical_logic
** View name: schematic
.subckt mux_vertical_logic asout0 asout1 ax bsout0 bsout1 bx cin cout csout0 csout1 cx dsout0 dsout1 ina4 ina5 inb4 inb5 inc4 inc5 ind4 ind5 l0 l1 l10 l11 l12 l13 l14 l15 l2 l3 l4 l5 l6 l7 l8 l9 out0 out1 out2 out3 out4 out5 out6 out7
xi17 cx net166 inv_1x
xi16 bx net171 inv_1x
xi15 ax net161 inv_1x
xi13 ax net161 out1 out3 net233 mux2
xi12 bx net171 out5 out7 net206 mux2
xi14 cx net166 net233 net206 net224 mux2
xi11 ind4 ind5 l12 l13 l14 l15 net179 out7 sram_5_6_LUT_Output_Decoder_schematic
xi10 inc4 inc5 l8 l9 l10 l11 net187 out5 sram_5_6_LUT_Output_Decoder_schematic
xi9 inb4 inb5 l4 l5 l6 l7 net195 out3 sram_5_6_LUT_Output_Decoder_schematic
xi8 ina4 ina5 l0 l1 l2 l3 net203 out1 sram_5_6_LUT_Output_Decoder_schematic
xi4 cin net227 net179 out7 net206 out6 dsout0 dsout1 mux_vertical_logic_sub
xi7 net218 cout net203 out1 net0241 out0 asout0 asout1 mux_vertical_logic_sub
xi5 net227 net236 net187 out5 net224 out4 csout0 csout1 mux_vertical_logic_sub
xi6 net236 net218 net195 out3 net233 out2 bsout0 bsout1 mux_vertical_logic_sub
.ends mux_vertical_logic
** End of subcircuit definition.
