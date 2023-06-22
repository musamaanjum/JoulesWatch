#!/usr/bin/bash 

if [[ $# -eq 0 ]] ; then
    echo "Error: Please pass the command you want to benchmark."
    echo "********************************************************"
    echo -e "Usage: \n\t $0 <cmd_to_benchmark>"
    echo "********************************************************"
    exit 0
fi

echo "Benchmarking:"
echo $*

sudo cpupower monitor -c $* > cstates.txt &
PID1=$!;

sudo perf stat -a --per-socket -I 1000 -e power/energy-pkg/ 2> power_usage.txt &
PID2=$!;

sudo trace-cmd record -e sched_wakeup > /dev/null &
PID3=$!;

wait $PID1;

kill -SIGINT $PID2
kill -SIGINT $PID3

wait $PID2;
wait $PID3;

echo "CStates:"
more cstates.txt | grep "||  " | awk '{c0 += $2; p += $5; c1 += $6; c2 += $7; c3 += $8} END {print "c0: "100-p/8-c1/8-c2/8-c3/8 " poll: "p/8 " c1: "c1/8 " c2: "c2/8 " c3: "c3/8}' >> cstates.txt;
cat cstates.txt

echo "Energy Consumed:"
cat power_usage.txt | tail -n +2 | awk '{s+=$4} END {print s " J"}'

echo "Per CPU wakeups:"
trace-cmd report > report.txt
grep "sched_wakeup" report.txt | awk -f count_cpu.awk | sort
