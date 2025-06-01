set f [open "timing_temp.txt" r]
set lines [split [read $f] "\n"]
close $f

foreach line $lines {
    if {[regexp {^\s*Cap\s+Slew\s+Delay\s+Time\s+Description\s*} $line]} {
        puts [format "%-85s Fanout" $line]
    } elseif {[regexp {^\s+([^\s]+) \(net\)} $line -> net_name]} {
        set net [get_nets $net_name]
        set fanouts [get_fanout -from $net -levels 3 -trace_arcs timing] 
        set fanout_count [llength $fanouts]

        puts [format "%-85s %d" $line $fanout_count]
    } else {
        puts $line
    }
}