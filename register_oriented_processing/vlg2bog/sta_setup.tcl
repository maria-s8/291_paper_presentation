read_verilog ../../dataset/BOG/SOG/mapped_netlist/Rocket_Rocket1_TYP.syn.v
read_liberty nangate45_SOG.lib
link_design Rocket
create_clock -name CLK_clock -period 0.5 {clock}

report_checks -slack_max 0 -sort_by_slack -fields "slew capacitance net input_pin" -group_path_count 2000 > timing_temp.txt