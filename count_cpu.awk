#!/usr/bin/awk -f

{
	cpu = $NF
	count[cpu]++
} END {
	for (cpu in count) {
		print cpu, count[cpu]
	}
}
