# If there is rtl_work lib -> clear rtl_work
transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}

# Create vlib named "rtl_work"
vlib rtl_work
vmap work rtl_work


# Compile into rtl_work lib
vcom -93 -work work \
"../test/testbench_utils_pkg.vhd" \
"../hdl/mux2.vhd" \
"../hdl/mux3.vhd" \
"../hdl/cu.vhd" \
"../hdl/gpreg_file.vhd" \
"../hdl/IR.vhd" \
"../hdl/LSU.vhd" \
"../hdl/memory16_bit.vhd" \
"../hdl/PC.vhd" \
"../hdl/alu.vhd" \
"../hdl/alu_out.vhd" \
"../hdl/cpu.vhd" \
"../test/RISC16_bit_tb.vhd" 
