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
*.include 'slice.sp'

** If you use a global Vdd in MUXVerticalLogic.sp, you need to add the
** following syntax
.global vdd! 0
vdd vdd! 0 dc vdd_val

** Or if Vdd is an input
* vdd vdd 0 dc vdd_val

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

** Library name: sram
** Cell name: inv_en_delay
** View name: schematic
.subckt inv_en_delay in out
mpm0 out in vdd! vdd! gpdk090_pmos1v L=100e-9 W=980e-9 AD=274.4e-15 AS=274.4e-15 PD=2.52e-6 PS=2.52e-6 M=1
mnm0 out in 0 0 gpdk090_nmos1v L=100e-9 W=410e-9 AD=114.8e-15 AS=114.8e-15 PD=1.38e-6 PS=1.38e-6 M=1
.ends inv_en_delay
** End of subcircuit definition.

** Library name: sram
** Cell name: nand2
** View name: schematic
.subckt nand2 in1 in2 out
mnm1 net4 in2 0 0 gpdk090_nmos1v L=100e-9 W=500e-9 AD=140e-15 AS=140e-15 PD=1.56e-6 PS=1.56e-6 M=1
mnm0 out in1 net4 0 gpdk090_nmos1v L=100e-9 W=500e-9 AD=140e-15 AS=140e-15 PD=1.56e-6 PS=1.56e-6 M=1
mpm1 out in2 vdd! vdd! gpdk090_pmos1v L=100e-9 W=590e-9 AD=165.2e-15 AS=165.2e-15 PD=1.74e-6 PS=1.74e-6 M=1
mpm0 out in1 vdd! vdd! gpdk090_pmos1v L=100e-9 W=590e-9 AD=165.2e-15 AS=165.2e-15 PD=1.74e-6 PS=1.74e-6 M=1
.ends nand2
** End of subcircuit definition.

** Library name: sram
** Cell name: nor
** View name: schematic
.subckt nor in1 in2 out
mpm1 out in1 net028 vdd! gpdk090_pmos1v L=100e-9 W=565e-9 AD=158.2e-15 AS=158.2e-15 PD=1.69e-6 PS=1.69e-6 M=1
mpm0 net028 in2 vdd! vdd! gpdk090_pmos1v L=100e-9 W=565e-9 AD=158.2e-15 AS=158.2e-15 PD=1.69e-6 PS=1.69e-6 M=1
mnm1 out in2 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mnm0 out in1 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
.ends nor
** End of subcircuit definition.

** Library name: sram
** Cell name: nand
** View name: schematic
.subckt nand in1 in2 out
mpm1 out in2 vdd! vdd! gpdk090_pmos1v L=100e-9 W=710e-9 AD=198.8e-15 AS=198.8e-15 PD=1.98e-6 PS=1.98e-6 M=1
mpm0 out in1 vdd! vdd! gpdk090_pmos1v L=100e-9 W=710e-9 AD=198.8e-15 AS=198.8e-15 PD=1.98e-6 PS=1.98e-6 M=1
mnm1 net11 in2 0 0 gpdk090_nmos1v L=100e-9 W=600e-9 AD=168e-15 AS=168e-15 PD=1.76e-6 PS=1.76e-6 M=1
mnm0 out in1 net11 0 gpdk090_nmos1v L=100e-9 W=600e-9 AD=168e-15 AS=168e-15 PD=1.76e-6 PS=1.76e-6 M=1
.ends nand
** End of subcircuit definition.

** Library name: sram
** Cell name: full_predecoder
** View name: schematic
.subckt full_predecoder en in0 in0b in1 in1b in2 in2b in3 in3b wl0 wl1 wl10 wl11 wl12 wl13 wl14 wl15 wl2 wl3 wl4 wl5 wl6 wl7 wl8 wl9
xi40 en net0165 inv_en_delay
xi41 net0165 net0163 inv_en_delay
xi39 net62 net0163 wl0 nand2
xi38 net65 net0163 wl1 nand2
xi37 net74 net0163 wl2 nand2
xi36 net77 net0163 wl3 nand2
xi35 net80 net0163 wl4 nand2
xi34 net83 net0163 wl5 nand2
xi33 net86 net0163 wl6 nand2
xi32 net89 net0163 wl7 nand2
xi31 net92 net0163 wl8 nand2
xi30 net95 net0163 wl9 nand2
xi29 net98 net0163 wl10 nand2
xi28 net101 net0163 wl11 nand2
xi27 net104 net0163 wl12 nand2
xi26 net71 net0163 wl13 nand2
xi25 net68 net0163 wl14 nand2
xi24 net59 net0163 wl15 nand2
xi23 net58 net99 net59 nor
xi22 net61 net90 net62 nor
xi21 net61 net81 net65 nor
xi20 net58 net96 net68 nor
xi19 net58 net81 net71 nor
xi18 net61 net96 net74 nor
xi17 net61 net99 net77 nor
xi16 net79 net90 net80 nor
xi15 net79 net81 net83 nor
xi14 net79 net96 net86 nor
xi13 net79 net99 net89 nor
xi12 net97 net90 net92 nor
xi11 net97 net81 net95 nor
xi10 net97 net96 net98 nor
xi9 net97 net99 net101 nor
xi8 net58 net90 net104 nor
xi7 in1b in0 net81 nand
xi6 in1b in0b net90 nand
xi5 in1 in0b net96 nand
xi4 in1 in0 net99 nand
xi3 in3b in2b net61 nand
xi2 in3b in2 net79 nand
xi1 in3 in2b net97 nand
xi0 in3 in2 net58 nand
.ends full_predecoder
** End of subcircuit definition.

** Library name: sram
** Cell name: output_buffer
** View name: schematic
.subckt output_buffer bl bl_out blb blb_out
mnm1 blb_out bl 0 0 gpdk090_nmos1v L=100e-9 W=280e-9 AD=44.8e-15 AS=78.4e-15 PD=600e-9 PS=1.12e-6 M=2
mnm0 bl_out blb 0 0 gpdk090_nmos1v L=100e-9 W=280e-9 AD=44.8e-15 AS=78.4e-15 PD=600e-9 PS=1.12e-6 M=2
mpm0 bl_out blb vdd! vdd! gpdk090_pmos1v L=100e-9 W=560e-9 AD=89.6e-15 AS=156.8e-15 PD=880e-9 PS=1.68e-6 M=2
mpm1 blb_out bl vdd! vdd! gpdk090_pmos1v L=100e-9 W=560e-9 AD=89.6e-15 AS=156.8e-15 PD=880e-9 PS=1.68e-6 M=2
.ends output_buffer
** End of subcircuit definition.

** Library name: sram
** Cell name: pulldown
** View name: schematic
.subckt pulldown bl data en write blb data_b
mnm2 blb en net022 0 gpdk090_nmos1v L=100e-9 W=550e-9 AD=154e-15 AS=154e-15 PD=1.66e-6 PS=1.66e-6 M=1
mnm4 net022 write net018 0 gpdk090_nmos1v L=100e-9 W=550e-9 AD=154e-15 AS=154e-15 PD=1.66e-6 PS=1.66e-6 M=1
mnm5 net018 data 0 0 gpdk090_nmos1v L=100e-9 W=550e-9 AD=154e-15 AS=154e-15 PD=1.66e-6 PS=1.66e-6 M=1
mnm1 bl en net9 0 gpdk090_nmos1v L=100e-9 W=550e-9 AD=154e-15 AS=154e-15 PD=1.66e-6 PS=1.66e-6 M=1
mnm0 net9 write net13 0 gpdk090_nmos1v L=100e-9 W=550e-9 AD=154e-15 AS=154e-15 PD=1.66e-6 PS=1.66e-6 M=1
mnm3 net13 data_b 0 0 gpdk090_nmos1v L=100e-9 W=550e-9 AD=154e-15 AS=154e-15 PD=1.66e-6 PS=1.66e-6 M=1
.ends pulldown
** End of subcircuit definition.

** Library name: sram
** Cell name: precharge
** View name: schematic
.subckt precharge bl blb en
mpm0 bl en vdd! vdd! gpdk090_pmos1v L=100e-9 W=240e-9 AD=38.4e-15 AS=67.2e-15 PD=560e-9 PS=1.04e-6 M=2
mpm1 blb en vdd! vdd! gpdk090_pmos1v L=100e-9 W=240e-9 AD=38.4e-15 AS=67.2e-15 PD=560e-9 PS=1.04e-6 M=2
.ends precharge
** End of subcircuit definition.

** Library name: sram
** Cell name: sram_cell
** View name: schematic
.subckt sram_cell bl blb wl
mnm3 net18 net12 0 0 gpdk090_nmos1v L=100e-9 W=270e-9 AD=75.6e-15 AS=75.6e-15 PD=1.1e-6 PS=1.1e-6 M=1
mnm2 net18 wl blb 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mnm0 net12 wl bl 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mnm1 net12 net18 0 0 gpdk090_nmos1v L=100e-9 W=270e-9 AD=75.6e-15 AS=75.6e-15 PD=1.1e-6 PS=1.1e-6 M=1
mpm1 net18 net12 vdd! vdd! gpdk090_pmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mpm0 net12 net18 vdd! vdd! gpdk090_pmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
.ends sram_cell
** End of subcircuit definition.

** Library name: sram
** Cell name: sram_row
** View name: schematic
.subckt sram_row bl0 bl1 bl2 bl3 blb0 blb1 blb2 blb3 wl
xi3 bl3 blb3 wl sram_cell
xi2 bl2 blb2 wl sram_cell
xi1 bl1 blb1 wl sram_cell
xi0 bl0 blb0 wl sram_cell
.ends sram_row
** End of subcircuit definition.

** Library name: inv_1x
** Cell name: inv_1x
** View name: schematic
.subckt inv_1x_schematic in out
mnm1 out in 0 0 gpdk090_nmos1v L=100e-9 W=160e-9 AD=44.8e-15 AS=73.6e-15 PD=680e-9 PS=1.16e-6 M=2
mpm2 out in vdd! vdd! gpdk090_pmos1v L=100e-9 W=380e-9 AD=60.8e-15 AS=106.4e-15 PD=700e-9 PS=1.32e-6 M=2
.ends inv_1x_schematic
** End of subcircuit definition.

** Library name: sram
** Cell name: postdecoder
** View name: schematic
.subckt postdecoder in out
xi1 in out inv_1x_schematic
.ends postdecoder
** End of subcircuit definition.

** Library name: sram
** Cell name: sram_row_and_postdecoder
** View name: schematic
.subckt sram_row_and_postdecoder bl0 bl1 bl2 bl3 blb0 blb1 blb2 blb3 in
xi1 bl0 bl1 bl2 bl3 blb0 blb1 blb2 blb3 net1 sram_row
xi0 in net1 postdecoder
.ends sram_row_and_postdecoder
** End of subcircuit definition.

** Library name: sram
** Cell name: sram_block
** View name: schematic
.subckt sram_block bl0 bl1 bl2 bl3 blb0 blb1 blb2 blb3 data0 data1 data2 data3 data_b0 data_b1 data_b2 data_b3 en in0 in1 in10 in11 in12 in13 in14 in15 in2 in3 in4 in6 in7 in8 in9 write in5
xi28 net334 bl2 net333 blb2 output_buffer
xi27 net331 bl3 net330 blb3 output_buffer
xi24 net340 bl0 net339 blb0 output_buffer
xi25 net337 bl1 net336 blb1 output_buffer
xi20 net331 data3 en write net330 data_b3 pulldown
xi21 net334 data2 en write net333 data_b2 pulldown
xi22 net337 data1 en write net336 data_b1 pulldown
xi23 net340 data0 en write net339 data_b0 pulldown
xi16 net331 net330 en precharge
xi17 net334 net333 en precharge
xi18 net337 net336 en precharge
xi19 net340 net339 en precharge
xi15 net340 net337 net334 net331 net339 net336 net333 net330 in3 sram_row_and_postdecoder
xi14 net340 net337 net334 net331 net339 net336 net333 net330 in2 sram_row_and_postdecoder
xi13 net340 net337 net334 net331 net339 net336 net333 net330 in1 sram_row_and_postdecoder
xi12 net340 net337 net334 net331 net339 net336 net333 net330 in0 sram_row_and_postdecoder
xi11 net340 net337 net334 net331 net339 net336 net333 net330 in15 sram_row_and_postdecoder
xi10 net340 net337 net334 net331 net339 net336 net333 net330 in14 sram_row_and_postdecoder
xi9 net340 net337 net334 net331 net339 net336 net333 net330 in13 sram_row_and_postdecoder
xi8 net340 net337 net334 net331 net339 net336 net333 net330 in12 sram_row_and_postdecoder
xi7 net340 net337 net334 net331 net339 net336 net333 net330 in11 sram_row_and_postdecoder
xi6 net340 net337 net334 net331 net339 net336 net333 net330 in10 sram_row_and_postdecoder
xi5 net340 net337 net334 net331 net339 net336 net333 net330 in9 sram_row_and_postdecoder
xi4 net340 net337 net334 net331 net339 net336 net333 net330 in8 sram_row_and_postdecoder
xi3 net340 net337 net334 net331 net339 net336 net333 net330 in7 sram_row_and_postdecoder
xi2 net340 net337 net334 net331 net339 net336 net333 net330 in6 sram_row_and_postdecoder
xi1 net340 net337 net334 net331 net339 net336 net333 net330 in5 sram_row_and_postdecoder
xi0 net340 net337 net334 net331 net339 net336 net333 net330 in4 sram_row_and_postdecoder
.ends sram_block
** End of subcircuit definition.

** Library name: sram
** Cell name: 5_6_LUT
** View name: schematic
.subckt sram_5_6_LUT_schematic data0 data1 data2 data3 data_b0 data_b1 data_b2 data_b3 en in0 in1 in2 in3 out0 out1 out2 out3 write
xi15 en net086 inv_1x
xi14 net086 net088 inv_1x
xi13 in3 net090 inv_1x
xi12 in2 net092 inv_1x
xi11 in1 net094 inv_1x
xi10 in0 net096 inv_1x
xi9 net090 net098 inv_1x
xi8 net092 net0100 inv_1x
xi7 net094 net0102 inv_1x
xi6 net096 net0104 inv_1x
xi5 net098 net14 inv_1x
xi4 net0100 net16 inv_1x
xi3 net0102 net18 inv_1x
xi2 net0104 net20 inv_1x
xi1 net088 net0104 net20 net0102 net18 net0100 net16 net098 net14 net45 net44 net35 net34 net33 net32 net31 net30 net43 net42 net41 net0193 net39 net38 net37 net36 full_predecoder
xi0 out0 out1 out2 out3 net69 net68 net67 net66 data0 data1 data2 data3 data_b0 data_b1 data_b2 data_b3 net088 net45 net44 net35 net34 net33 net32 net31 net30 net43 net42 net41 net39 net38 net37 net36 write net0193 sram_block
.ends sram_5_6_LUT_schematic
** End of subcircuit definition.

** Library name: sram
** Cell name: slice
** View name: schematic
.subckt slice a_data_0 a_data_1 a_data_2 a_data_3 a_data_b0 a_data_b1 a_data_b2 a_data_b3 asout0 asout1 ax b_data_0 b_data_1 b_data_2 b_data_3 b_data_b0 b_data_b1 b_data_b2 b_data_b3 bsout0 bsout1 bx c_data_0 c_data_1 c_data_2 c_data_3 c_data_b0 c_data_b1 c_data_b2 c_data_b3 cin cout csout0 csout1 cx d_data_0 d_data_1 d_data_2 d_data_3 d_data_b0 d_data_b1 d_data_b2 d_data_b3 dsout0 dsout1 en ina0 ina1 ina2 ina3 ina4 ina5 inb0 inb1 inb2 inb3 inb4 inb5 inc0 inc1 inc2 inc3 inc4 inc5 ind0 ind1 ind2 ind3 ind4 ind5 out0 out1 out2 out3 out4 out5 out6 out7 write
xi4 asout0 asout1 ax bsout0 bsout1 bx cin cout csout0 csout1 cx dsout0 dsout1 ina4 ina5 inb4 inb5 inc4 inc5 ind4 ind5 net81 net80 net103 net102 net0228 net92 net91 net90 net79 net78 net0237 net116 net115 net0234 net0233 net104 out0 out1 out2 out3 out4 out5 out6 out7 mux_vertical_logic
xi3 a_data_0 a_data_1 a_data_2 a_data_3 a_data_b0 a_data_b1 a_data_b2 a_data_b3 en ina0 ina1 ina2 ina3 net81 net80 net79 net78 write sram_5_6_LUT_schematic
xi2 d_data_0 d_data_1 d_data_2 d_data_3 d_data_b0 d_data_b1 d_data_b2 d_data_b3 en ind0 ind1 ind2 ind3 net0228 net92 net91 net90 write sram_5_6_LUT_schematic
xi1 c_data_0 c_data_1 c_data_2 c_data_3 c_data_b0 c_data_b1 c_data_b2 c_data_b3 en inc0 inc1 inc2 inc3 net0233 net104 net103 net102 write sram_5_6_LUT_schematic
xi0 b_data_0 b_data_1 b_data_2 b_data_3 b_data_b0 b_data_b1 b_data_b2 b_data_b3 en inb0 inb1 inb2 inb3 net0237 net116 net115 net0234 write sram_5_6_LUT_schematic
.ends slice
** End of subcircuit definition.
** Wire the inputs L<15:0>, ina<5:4>, inb<5:4>, inc<5:4>, ind<5:4>, ax, bx,
** cx, cin, asout<1:0>, bsout<1:0>, csout<1:0>, dsout<1:0>, and outputs
** out<8:0>, cout, to an instance of your MUX/Vertical Logic block here. Only
** the names at this level of the deck need to be as you see them here. Make
** sure to order the inputs in accordance to the order of your implementation.

** MUX / Vertical Logic Block **
Xslice a_data<0> a_data<1> a_data<2> a_data<3> a_data_b<0> a_data_b<1> a_data_b<2> a_data_b<3> asout<0> asout<1> ax b_data<0> b_data<1> b_data<2> b_data<3> b_data_b<0> b_data_b<1> b_data_b<2> b_data_b<3> bsout<0> bsout<1> bx c_data<0> c_data<1> c_data<2> c_data<3> c_data_b<0> c_data_b<1> c_data_b<2> c_data_b<3> cin cout csout<0> csout<1> cx d_data<0> d_data<1> d_data<2> d_data<3> d_data_b<0> d_data_b<1> d_data_b<2> d_data_b<3> dsout<0> dsout<1> en ina<0> ina<1> ina<2> ina<3> ina<4> ina<5> inb<0> inb<1> inb<2> inb<3> inb<4> inb<5> inc<0> inc<1> inc<2> inc<3> inc<4> inc<5> ind<0> ind<1> ind<2> ind<3> ind<4> ind<5> out<0> out<1> out<2> out<3> out<4> out<5> out<6> out<7> write slice
** Arrange these inputs in the order your subckt dictates
*+ L<15> L<14> ... L<1> L<0>
*+ ina<5> ina<4> ... ind<5> ind<4>
*+ asout<1> asout<0> ... dsout<1> dsout<0> 
*+ ax bx cx cin
*+ out<8> out<7> ... out<1> out<0>
*+ cout
*+ slice

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
.vec 'input_checkpoint.vec'

** Control info **
*.options post=2 nomod
.option probe
.op
.probe tran V(out<0>) V(out<1>) V(out<2>) V(out<3>) V(out<4>) V(out<5>) V(out<6>) V(out<7>) V(out_exp<0>) V(out_exp<1>) V(out_exp<2>) V(out_exp<3>) V(out_exp<4>) V(out_exp<5>) V(out_exp<6>) V(out_exp<7>) V(cout) V(cout_exp)
** Transient simulation
.tran .1ns 200ns

.end
