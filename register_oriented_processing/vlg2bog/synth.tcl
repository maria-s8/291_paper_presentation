design -reset # Clear out the loaded design
read_verilog ../../dataset_example/rtl/Rocket/*
hierarchy -top Rocket 

flatten
# Technology-agnostic Verilog-level optimizations
prep
# Synthesize to technology-agnostic gate-level primitives
synth
# Replace any agnostic DFF primitives that cannot be mapped directly to IHP 130's DFF cells
dfflibmap -liberty nangate45.lib
# Call into ABC to synthesize with a timing goal of 4000 ps = 4 ns  on the worst path.
abc -D 500 -liberty nangate45.lib
# Remove disconnected wire that ABC optimized away
opt_clean

write_verilog postmap.v

