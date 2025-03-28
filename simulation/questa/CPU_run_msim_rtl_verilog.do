transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/sloth/ELEC374/CPU_Project {C:/Users/sloth/ELEC374/CPU_Project/adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/sloth/ELEC374/CPU_Project {C:/Users/sloth/ELEC374/CPU_Project/Bus.v}
vlog -vlog01compat -work work +incdir+C:/Users/sloth/ELEC374/CPU_Project {C:/Users/sloth/ELEC374/CPU_Project/DataPath.v}
vlog -vlog01compat -work work +incdir+C:/Users/sloth/ELEC374/CPU_Project {C:/Users/sloth/ELEC374/CPU_Project/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/sloth/ELEC374/CPU_Project {C:/Users/sloth/ELEC374/CPU_Project/mux2to1.v}

vlog -vlog01compat -work work +incdir+C:/Users/sloth/ELEC374/CPU_Project {C:/Users/sloth/ELEC374/CPU_Project/DataPath_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  DataPath_tb

add wave *
view structure
view signals
run -all
