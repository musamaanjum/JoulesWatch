#!/usr/bin/awk -f

{
	c0 += $2;
	p += $5;
	c1 += $6;
	c2 += $7;
	c3 += $8;
} END {
	print "\nOverall Cstates for all CPUs:"
	print "c0: "100-p/N-c1/N-c2/N-c3/N
	print "poll: "p/N
	print "c1: "c1/N
	print "c2: "c2/N
	print "c3: "c3/N
}