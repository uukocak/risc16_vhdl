onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /risc16_bit_tb/clk
add wave -noupdate /risc16_bit_tb/rst
add wave -noupdate /risc16_bit_tb/mem_we
add wave -noupdate /risc16_bit_tb/mem_re
add wave -noupdate -label {Contributors: mem_re} -group {Contributors: sim:/risc16_bit_tb/mem_re} /risc16_bit_tb/cpu1/u_CU/opcodes
add wave -noupdate -label {Contributors: mem_re} -group {Contributors: sim:/risc16_bit_tb/mem_re} /risc16_bit_tb/cpu1/u_CU/state
add wave -noupdate -label {Contributors: mem_re} -group {Contributors: sim:/risc16_bit_tb/mem_re} /risc16_bit_tb/cpu1/u_LSU/clk
add wave -noupdate -label {Contributors: mem_re} -group {Contributors: sim:/risc16_bit_tb/mem_re} /risc16_bit_tb/cpu1/u_LSU/cmd_in
add wave -noupdate -label {Contributors: mem_re} -group {Contributors: sim:/risc16_bit_tb/mem_re} /risc16_bit_tb/cpu1/u_LSU/state_c
add wave -noupdate -radix unsigned /risc16_bit_tb/mem_addr
add wave -noupdate -radix hexadecimal /risc16_bit_tb/mem_w_data
add wave -noupdate -radix hexadecimal /risc16_bit_tb/mem_r_data
add wave -noupdate /risc16_bit_tb/CLK_PERIOD
add wave -noupdate /risc16_bit_tb/CLK_ON
add wave -noupdate /risc16_bit_tb/state_c
add wave -noupdate -group gpreg_file /risc16_bit_tb/cpu1/u_gpreg_file/rst
add wave -noupdate -group gpreg_file /risc16_bit_tb/cpu1/u_gpreg_file/clk
add wave -noupdate -group gpreg_file /risc16_bit_tb/cpu1/u_gpreg_file/we
add wave -noupdate -group gpreg_file /risc16_bit_tb/cpu1/u_gpreg_file/addr_a
add wave -noupdate -group gpreg_file /risc16_bit_tb/cpu1/u_gpreg_file/addr_b
add wave -noupdate -group gpreg_file /risc16_bit_tb/cpu1/u_gpreg_file/addr_in
add wave -noupdate -group gpreg_file -radix hexadecimal /risc16_bit_tb/cpu1/u_gpreg_file/data_in
add wave -noupdate -group gpreg_file -radix hexadecimal /risc16_bit_tb/cpu1/u_gpreg_file/data_a
add wave -noupdate -group gpreg_file -radix hexadecimal /risc16_bit_tb/cpu1/u_gpreg_file/data_b
add wave -noupdate -group gpreg_file -childformat {{/risc16_bit_tb/cpu1/u_gpreg_file/ram(15) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(14) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(13) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(12) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(11) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(10) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(9) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(8) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(7) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(6) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(5) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(4) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(3) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(2) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(1) -radix hexadecimal} {/risc16_bit_tb/cpu1/u_gpreg_file/ram(0) -radix hexadecimal}} -subitemconfig {/risc16_bit_tb/cpu1/u_gpreg_file/ram(15) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(14) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(13) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(12) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(11) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(10) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(9) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(8) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(7) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(6) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(5) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(4) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(3) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(2) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(1) {-height 15 -radix hexadecimal} /risc16_bit_tb/cpu1/u_gpreg_file/ram(0) {-height 15 -radix hexadecimal}} /risc16_bit_tb/cpu1/u_gpreg_file/ram
add wave -noupdate -group alu /risc16_bit_tb/cpu1/U_ALU/rst
add wave -noupdate -group alu -radix hexadecimal /risc16_bit_tb/cpu1/U_ALU/inp1
add wave -noupdate -group alu -radix hexadecimal /risc16_bit_tb/cpu1/U_ALU/inp2
add wave -noupdate -group alu /risc16_bit_tb/cpu1/U_ALU/ALU_op
add wave -noupdate -group alu /risc16_bit_tb/cpu1/U_ALU/cmp_S1_S2
add wave -noupdate -group alu -radix decimal /risc16_bit_tb/cpu1/U_ALU/outp
add wave -noupdate -group alu /risc16_bit_tb/cpu1/U_ALU/flags
add wave -noupdate -group alu /risc16_bit_tb/cpu1/U_ALU/flags_in
add wave -noupdate -group IR /risc16_bit_tb/cpu1/u_IR/clk
add wave -noupdate -group IR /risc16_bit_tb/cpu1/u_IR/rst
add wave -noupdate -group IR /risc16_bit_tb/cpu1/u_IR/instruction
add wave -noupdate -group IR /risc16_bit_tb/cpu1/u_IR/IR_wr_en
add wave -noupdate -group IR /risc16_bit_tb/cpu1/u_IR/sel_S1
add wave -noupdate -group IR /risc16_bit_tb/cpu1/u_IR/sel_S2
add wave -noupdate -group IR /risc16_bit_tb/cpu1/u_IR/sel_D
add wave -noupdate -group IR /risc16_bit_tb/cpu1/u_IR/opcodes
add wave -noupdate -group IR -radix hexadecimal /risc16_bit_tb/cpu1/u_IR/immediate
add wave -noupdate -group IR -radix hexadecimal /risc16_bit_tb/cpu1/u_IR/instruction_in
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/clk
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/rst
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/opcodes
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/GPRF_wr
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/IR_wr_en
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/S2_select
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/ALU_op
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/ALU_src_1
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/ALU_src_2
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/PC_WCond
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/PC_Write
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/PC_Source
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/mem_read
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/MemtoReg
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/cmd_in
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/state
add wave -noupdate -group CU /risc16_bit_tb/cpu1/u_CU/next_state
add wave -noupdate -group LSU /risc16_bit_tb/cpu1/u_LSU/clk
add wave -noupdate -group LSU /risc16_bit_tb/cpu1/u_LSU/cmd_in
add wave -noupdate -group LSU -radix hexadecimal /risc16_bit_tb/cpu1/u_LSU/mdr_in
add wave -noupdate -group LSU -radix hexadecimal /risc16_bit_tb/cpu1/u_LSU/data_a_in
add wave -noupdate -group LSU -radix hexadecimal /risc16_bit_tb/cpu1/u_LSU/data_b_in
add wave -noupdate -group LSU -radix hexadecimal /risc16_bit_tb/cpu1/u_LSU/imm_in
add wave -noupdate -group LSU -radix hexadecimal /risc16_bit_tb/cpu1/u_LSU/mdr_out
add wave -noupdate -group LSU -radix hexadecimal /risc16_bit_tb/cpu1/u_LSU/mem_data_w
add wave -noupdate -group LSU -radix hexadecimal /risc16_bit_tb/cpu1/u_LSU/addr_out
add wave -noupdate -group LSU /risc16_bit_tb/cpu1/u_LSU/memR
add wave -noupdate -group LSU /risc16_bit_tb/cpu1/u_LSU/memW
add wave -noupdate -group LSU /risc16_bit_tb/cpu1/u_LSU/regfileWR
add wave -noupdate -group LSU /risc16_bit_tb/cpu1/u_LSU/IorD
add wave -noupdate -group LSU -radix hexadecimal /risc16_bit_tb/cpu1/u_LSU/MDR
add wave -noupdate -group LSU /risc16_bit_tb/cpu1/u_LSU/state_c
add wave -noupdate -group PC /risc16_bit_tb/cpu1/u_PC/clk
add wave -noupdate -group PC /risc16_bit_tb/cpu1/u_PC/rst
add wave -noupdate -group PC -radix hexadecimal -radixshowbase 1 /risc16_bit_tb/cpu1/u_PC/inp
add wave -noupdate -group PC /risc16_bit_tb/cpu1/u_PC/en
add wave -noupdate -group PC -radix hexadecimal -radixshowbase 1 /risc16_bit_tb/cpu1/u_PC/outp
add wave -noupdate -group PC -radix hexadecimal -radixshowbase 1 /risc16_bit_tb/cpu1/u_PC/pc_in
add wave -noupdate -color {Dark Orchid} -radix unsigned /risc16_bit_tb/ACC_ADDR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {180000 ps} 1} {{Cursor 2} {424247 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 10
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {672 ns}
