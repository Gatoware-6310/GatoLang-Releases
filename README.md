# GatoLang Releases

This repository contains binary releases of the GatoLang compiler, `gatoc`.

The compiler is closed source. You may use it to build and distribute programs written in GatoLang, but redistribution or modification of the compiler itself is not permitted. See `LICENSE`.

## Current Release

GatoLang `0.3.5` fixes the compiler/runtime GC root corruption that affected class-method encryption workloads.

Current version: `0.3.5`

GatoLang `0.3.5` is a correctness and release update:
- Fixed compiler/runtime GC root handling for class methods, final class fields, and allocation-heavy string workloads.
- Added `gatoc --version` for install verification.
- Preserved the earlier `final` class field resolution fix.

GatoLang `0.3.4` was a performance, correctness, and release-polish update:
- Fixed a critical GC root stack corruption bug where string temporaries and early returns caused memory corruption.

- Fixed `currentTimeMs()` so it reports wall-clock Unix-style milliseconds instead of a monotonic process timer.
- Improved byte-heavy generated C by tracking values known to be in byte range.
- Lowered byte-range `%` and `/` by powers of two into bit operations where semantics are provably identical.
- Lowered string `.length` directly without an extra runtime helper call.
- Improved guarded `byteAt(...)` and array access lowering in hot loops.
- Added real-file dense event parsing benchmarks with threaded C and Zig comparison programs.
- Kept the ID-based threading API unchanged.
- Kept release jars obfuscated.

Release files:

```text
releases/0.3.5/
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

Download the zip for your platform from `releases/0.3.5`.

### Linux

System install:

```bash
cd releases/0.3.5
sudo bash linux/install.sh
```

User install:

```bash
cd releases/0.3.5
bash linux/install-user.sh
```

The user install places files under:

- `~/.local/lib/gatoc/gatoc.jar`
- `~/.local/bin/gatoc`

### Windows

User install:

```cmd
cd releases\0.3.5
windows\install-user.cmd
```

System install, with user fallback:

```cmd
cd releases\0.3.5
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

## v0.3.5 Performance Snapshot

Measured on the release preparation machine with GatoLang optimized native builds. Times vary by hardware.

| Workload | GatoLang | C | Python | Java |
|---|---:|---:|---:|---:|
| loops_numeric | 47ms | 47ms | 3156ms | 66ms |
| function_calls | 40ms | 39ms | 1691ms | 36ms |
| arrays_append | 14ms | 12ms | 337ms | 13ms |
| string_concat | 16ms | 0ms measured | 3956ms | 1ms |
| thread_overhead | 25ms | 21ms | 73ms | 77ms |
| class_access | 14ms | 9ms | 897ms | 10ms |
| event_scheduler | 12ms | 17ms | 434ms | 12ms |
| state_machine | 21ms | 16ms | 2179ms | 25ms |

Dense event-processing snapshot:

| Workload | Runtime | Setup | Hot Loop | Events/sec | Hot Events/sec |
|---|---:|---:|---:|---:|---:|
| GatoLang threaded real-file parser | 691ms | 135ms | 550ms | 180.2M | 226.5M |
| GatoLang best isolated real-file parser run | 586ms | 97ms | 484ms | 212.5M | 257.3M |
| C threaded real-file parser | 661ms | 155ms | 505ms | 188.4M | 246.6M |
| Zig threaded real-file parser | 735ms | 232ms | 503ms | 169.5M | 247.6M |

## Checksums

Release checksums are in:

```text
releases/0.3.5/SHA256SUMS
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
