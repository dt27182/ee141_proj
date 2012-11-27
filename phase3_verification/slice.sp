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
** Cell name: decoder_2nd_nor
** View name: schematic
.subckt decoder_2nd_nor in1 in2 out
mnm1 out in2 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mnm0 out in1 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mpm1 out in1 net15 vdd! gpdk090_pmos1v L=100e-9 W=480e-9 AD=134.4e-15 AS=134.4e-15 PD=1.52e-6 PS=1.52e-6 M=1
mpm0 net15 in2 vdd! vdd! gpdk090_pmos1v L=100e-9 W=480e-9 AD=134.4e-15 AS=134.4e-15 PD=1.52e-6 PS=1.52e-6 M=1
.ends decoder_2nd_nor
** End of subcircuit definition.

** Library name: sram
** Cell name: decoder_nand
** View name: schematic
.subckt decoder_nand in1 in2 out
mpm1 out in2 vdd! vdd! gpdk090_pmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
mpm0 out in1 vdd! vdd! gpdk090_pmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
mnm1 out in1 net16 0 gpdk090_nmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
mnm0 net16 in2 0 0 gpdk090_nmos1v L=100e-9 W=240e-9 AD=67.2e-15 AS=67.2e-15 PD=1.04e-6 PS=1.04e-6 M=1
.ends decoder_nand
** End of subcircuit definition.

** Library name: sram
** Cell name: decoder_1st_nor
** View name: schematic
.subckt decoder_1st_nor in1 in2 out
mpm1 out in1 net8 vdd! gpdk090_pmos1v L=100e-9 W=480e-9 AD=134.4e-15 AS=134.4e-15 PD=1.52e-6 PS=1.52e-6 M=1
mpm0 net8 in2 vdd! vdd! gpdk090_pmos1v L=100e-9 W=480e-9 AD=134.4e-15 AS=134.4e-15 PD=1.52e-6 PS=1.52e-6 M=1
mnm1 out in2 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
mnm0 out in1 0 0 gpdk090_nmos1v L=100e-9 W=120e-9 AD=69.6e-15 AS=69.6e-15 PD=1.16e-6 PS=1.16e-6 M=1
.ends decoder_1st_nor
** End of subcircuit definition.

** Library name: sram
** Cell name: full_predecoder
** View name: schematic
.subckt full_predecoder en in0 in0b in1 in1b in2 in2b in3 in3b wl0 wl1 wl10 wl11 wl12 wl13 wl14 wl15 wl2 wl3 wl4 wl5 wl6 wl7 wl8 wl9
xi75 en net0142 inv_en_delay
xi74 net0142 net212 inv_en_delay
xi71 net226 net180 wl2 decoder_2nd_nor
xi72 net226 net183 wl1 decoder_2nd_nor
xi73 net226 net171 wl0 decoder_2nd_nor
xi70 net226 net177 wl3 decoder_2nd_nor
xi58 net214 net177 wl15 decoder_2nd_nor
xi59 net214 net180 wl14 decoder_2nd_nor
xi60 net214 net183 wl13 decoder_2nd_nor
xi61 net214 net171 wl12 decoder_2nd_nor
xi62 net220 net177 wl11 decoder_2nd_nor
xi63 net220 net180 wl10 decoder_2nd_nor
xi64 net220 net183 wl9 decoder_2nd_nor
xi65 net220 net171 wl8 decoder_2nd_nor
xi66 net223 net177 wl7 decoder_2nd_nor
xi67 net223 net180 wl6 decoder_2nd_nor
xi68 net223 net183 wl5 decoder_2nd_nor
xi69 net223 net171 wl4 decoder_2nd_nor
xi50 net238 net212 net214 decoder_nand
xi54 net0241 net212 net177 decoder_nand
xi51 net241 net212 net220 decoder_nand
xi52 net244 net212 net223 decoder_nand
xi53 net247 net212 net226 decoder_nand
xi55 net253 net212 net180 decoder_nand
xi56 net256 net212 net183 decoder_nand
xi57 net259 net212 net171 decoder_nand
xi42 in3b in2b net238 decoder_1st_nor
xi43 in3b in2 net241 decoder_1st_nor
xi44 in3 in2b net244 decoder_1st_nor
xi45 in3 in2 net247 decoder_1st_nor
xi46 in1b in0b net0241 decoder_1st_nor
xi47 in1b in0 net253 decoder_1st_nor
xi48 in1 in0b net256 decoder_1st_nor
xi49 in1 in0 net259 decoder_1st_nor
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
xi6 net096 net0104 inv_1x
xi7 net094 net0102 inv_1x
xi8 net092 net0100 inv_1x
xi9 net090 net098 inv_1x
xi10 in0 net096 inv_1x
xi11 in1 net094 inv_1x
xi12 in2 net092 inv_1x
xi13 in3 net090 inv_1x
xi14 net086 net088 inv_1x
xi15 en net086 inv_1x
xi5 net098 net14 inv_1x
xi4 net0100 net16 inv_1x
xi3 net0102 net18 inv_1x
xi2 net0104 net20 inv_1x
xi1 net088 net0104 net20 net0102 net18 net0100 net16 net098 net14 net45 net44 net35 net34 net33 net32 net31 net30 net43 net42 net41 net0193 net39 net38 net37 net36 full_predecoder
xi0 out0 out1 out2 out3 net69 net68 net67 net66 data0 data1 data2 data3 data_b0 data_b1 data_b2 data_b3 en net45 net44 net35 net34 net33 net32 net31 net30 net43 net42 net41 net39 net38 net37 net36 write net0193 sram_block
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
