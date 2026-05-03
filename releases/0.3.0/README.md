# GatoLang gatoc 0.3.0

GatoLang `0.3.0` is a major performance and multithreading release.

Highlights:
- ID-based multithreading with `subroutine`, `.start(...)`, and `Threads.*`.
- Cooperative thread stopping with `Threads.stop(id)` and `Threads.shouldStop()`.
- Per-thread GC roots for threaded execution.
- Raw primitive-buffer lowering and shared read-only primitive array hot-loop optimization.
- Scalar replacement and tighter generated C for arrays, strings, classes, loops, and calls.
- Obfuscated release jars.
- Benchmarks against C, Python, and Java.

## Requirements
- Java 17

## Linux install
- System install: run `sudo bash linux/install.sh`
- User install: run `bash linux/install-user.sh`
  - The script adds `~/.local/bin` to your PATH if needed.

## Windows install
- System install (falls back to user install if not writable): run `windows\install.cmd`
- User install: run `windows\install-user.cmd`
  - The script adds the bin folder to PATH (or tells you to add it).

## Verify
- `gatoc --help`
- Compile/run a program:
  `gatoc examples\gc\bubble_sort.gw --run --out out`

## Obfuscated jar
- Releases are obfuscated by default.

## Benchmark snapshot

Measured on the release preparation machine with GatoLang `-O3 --native --lto`.

| Workload | GatoLang | C | Python | Java |
|---|---:|---:|---:|---:|
| loops_numeric | 48ms | 49ms | 3094ms | 49ms |
| function_calls | 39ms | 42ms | 1636ms | 37ms |
| arrays_append | 16ms | 14ms | 335ms | 10ms |
| string_concat | 19ms | 0ms measured | 4265ms | 1ms |
| thread_overhead | 35ms | 24ms | 74ms | 81ms |
| class_access | 14ms | 10ms | 933ms | 8ms |
| event_scheduler | 11ms | 9ms | 417ms | 9ms |
| state_machine | 22ms | 16ms | 2166ms | 27ms |

Black MIDI/event-processing benchmarks:

| Workload | Runtime | Setup | Hot Loop | Events/sec | Hot Events/sec |
|---|---:|---:|---:|---:|---:|
| GatoLang black_midi | 434ms | 282ms | 102ms | 46.08M | 196.08M |
| C black_midi | 366ms | 240ms | 101ms | 54.64M | 198.02M |
| Python black_midi | 11503ms | 6078ms | 4884ms | 1.74M | 4.10M |
| Java black_midi | 413ms | 257ms | 155ms | 48.43M | 129.03M |
| GatoLang parallel | 33ms | 0ms | 26ms | 606.06M | 769.23M |
| C parallel | 21ms | 0ms | 21ms | 952.38M | 952.38M |
| Python parallel | 8477ms | 0ms | 8477ms | 2.36M | 2.36M |
| Java parallel | 44ms | 0ms | 44ms | 454.55M | 454.55M |
| GatoLang shared parallel | 500ms | 339ms | 117ms | 40.00M | 170.94M |
| C shared parallel | 334ms | 243ms | 64ms | 59.88M | 312.50M |
| Python shared parallel | 12065ms | 6205ms | 5306ms | 1.66M | 3.77M |
| Java shared parallel | 317ms | 241ms | 75ms | 63.09M | 266.67M |
