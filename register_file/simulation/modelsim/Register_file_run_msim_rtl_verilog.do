transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work {../../rtl/D_FF.sv}
vlog -sv -work work {../../rtl/reg32bit.sv}
vlog -sv -work work {../../rtl/Decode_5to32.sv}
vlog -sv -work work {../../rtl/Mux_32to1.sv}
vlog -sv -work work {../../rtl/Register_file.sv}
vlog -sv -work work {../../tb/tb_Register_file.sv}
