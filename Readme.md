# Joules Watch

This is a tool to collect stats. It collects:
- C-States data of CPU
- Energy consumption of CPU
- Number of wakeups per CPU

The `jouleswatch` takes a argument in which the application to be benchmarked is specified.
For example:
- `jouleswatch sleep 1`
- `jouleswatch ./factorio --benchmark map9.zip --benchmark-ticks 100 --disable-audio`

## Contributions
Any kind of improvemetns and contributions are welcome.

## Notes
- This tool has only been tested on some AMD CPU systems.
