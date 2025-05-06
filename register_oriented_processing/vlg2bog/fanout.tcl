set f [open "timing_report.txt" r]
set lines [split [read $f] "\n"]
close $f


# Iterate over each line
foreach line $lines {
    # Check if this is a line with a net name ending in (net)
    if {[regexp {^\s*Cap\s+Slew\s+Delay\s+Time\s+Description\s*} $line]} {
        # Append fanout to the end of the line (align neatly)
        puts [format "%-85s Fanout" $line]
    } elseif {[regexp {^\s+([^\s]+) \(net\)} $line -> net_name]} {
        # Use OpenSTA to get fanout of the net
        set net [get_nets $net_name]
        set fanouts [get_fanout -from $net -levels 3 -trace_arcs timing] 
        set fanout_count [llength $fanouts]

        # Append fanout to the end of the line (align neatly)
        # puts [format "%-85s Fanout: %d" $line $fanout_count]
        puts [format "%-85s %d" $line $fanout_count]
    } else {
        # Print all other lines as-is
        puts $line
    }
}