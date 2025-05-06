set f [open "timing_report.txt" r]
set lines [split [read $f] "\n"]
close $f

puts "Startpoint\tEndpoint\tSlack\t\tNet\tFanout"

set start ""
set end ""
set slack ""
set net ""

foreach line $lines {
    if {[regexp {Startpoint: (\S+)} $line -> s]} {
        set start $s
    }
    if {[regexp {Endpoint: (\S+)} $line -> e]} {
        set end $e
    }
    if {[regexp {Slack:\s+(-?\d+\.\d+)} $line -> sl]} {
        puts $line
        set slack $sl
    }
    if {[regexp {Net:\s+(\S+)} $line -> netname]} {
        set net $netname

        # Compute fanout
        set fanout_objs [get_fanout -from $net]
        set fanout [llength $fanout_objs]

        # Print the final row
        puts "$start\t$end\t$slack\t$net\t$fanout"
    }
}