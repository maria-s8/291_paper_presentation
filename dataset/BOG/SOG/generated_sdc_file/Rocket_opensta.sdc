# SDC for OpenSTA
#set sdc_version 2.1

# Units
set_units -time ns -capacitance fF -voltage V -current mA

# Clock definition
create_clock [get_ports clock] -name CLK_clock -period 0.5 -waveform {0 0.25}

# Clock uncertainty
set_clock_uncertainty 0.15 [get_clocks CLK_clock]

# Input delays
set_input_delay 0.05 -clock CLK_clock [all_inputs]

# Output delays
set_output_delay 0.05 -clock CLK_clock [all_outputs]

# Set max transition for outputs (load transitions)
set_max_transition 0.5 [current_design]

# Set output pin loads (constant simplified load)
set_load 0.2 [all_outputs]

# Input transition (only one value, since OpenSTA doesn’t use -min/-max separately)
set_input_transition 0.2 [get_ports reset]
set_input_transition 0.2 [get_ports all_inputs]

# Clock groups (optional, left if multiple clocks exist)
set_clock_groups -asynchronous -group [get_clocks CLK_clock]