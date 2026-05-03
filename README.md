# GatoLang Releases

This repository contains binary releases of the GatoLang compiler, `gatoc`.

The compiler is closed source. You may use it to build and distribute programs written in GatoLang, but redistribution or modification of the compiler itself is not permitted. See `LICENSE`.

## Current Release

Current version: `0.3.0`

GatoLang `0.3.0` is a major performance and multithreading release:

- ID-based multithreading with `subroutine`, `.start(...)`, `Threads.join(id)`, `Threads.stop(id)`, `Threads.running(id)`, `Threads.done(id)`, `Threads.shouldStop()`, and `Threads.current()`.
- Cooperative thread stopping with low-overhead stop checks.
- Per-thread GC roots for threaded execution.
- Raw primitive-buffer lowering and shared read-only primitive array hot-loop optimizations.
- Scalar replacement and tighter generated C for arrays, strings, classes, loops, and calls.
- Obfuscated release jars.
- Benchmarks against C, Python, and Java.

Release files:

```text
releases/0.3.0/
+-- README.md
+-- SHA256SUMS
+-- linux.zip
+-- linux/
|   +-- gatoc.jar
|   +-- install.sh
|   +-- install-user.sh
+-- windows.zip
+-- windows/
    +-- gatoc.jar
    +-- install.cmd
    +-- install-user.cmd
```

## What is GatoLang?

GatoLang is a small, simple, Java-like programming language compiled by `gatoc` into native executables through a C backend. It is designed to stay explicit and approachable while producing fast native code.

- Statically typed
- Explicit declarations, no type inference
- Native executables through generated C
- Growable arrays, strings, classes, functions, native C integration, file I/O, HTTP helpers, and threading
- Designed and implemented by Gatoware

The language documentation is included in `GATOLANG-DOCS.md`.

## Requirements

- Java 17
- Linux or Windows
- A C compiler on `PATH` for native builds, such as `gcc` or `clang`
- libcurl on Linux for HTTP helpers; Windows builds use WinHTTP

Verify Java:

```bash
java --version
```

## Installation

Download the zip for your platform from `releases/0.3.0`.

### Linux

System install:

```bash
cd releases/0.3.0
sudo bash linux/install.sh
```

User install:

```bash
cd releases/0.3.0
bash linux/install-user.sh
```

The user install places files under:

- `~/.local/lib/gatoc/gatoc.jar`
- `~/.local/bin/gatoc`

### Windows

User install:

```cmd
cd releases\0.3.0
windows\install-user.cmd
```

System install, with user fallback:

```cmd
cd releases\0.3.0
windows\install.cmd
```

## Verify

After installation:

```bash
gatoc --help
```

Compile and run a simple program:

```gw
print("Hello, GatoLang!");
```

```bash
gatoc hello.gw --run
```

## v0.3.0 Benchmark Snapshot

Measured on the release preparation machine with GatoLang `-O3 --native --lto`. Times vary by hardware.

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

## Checksums

Release checksums are in:

```text
releases/0.3.0/SHA256SUMS
```

Verify from the release directory:

```bash
sha256sum -c SHA256SUMS
```

## License

`gatoc` is proprietary software.

You may:

- Use the compiler
- Distribute programs produced by the compiler

You may not:

- Redistribute the compiler except through official Gatoware release channels
- Reverse engineer or decompile it
- Modify or repackage it

See `LICENSE` for full terms.

## Support and Links

- Documentation: `GATOLANG-DOCS.md`
- Release packages: `releases/<version>/`
- VS Code extension: available on the VS Code Marketplace

GatoLang (c) Gatoware
