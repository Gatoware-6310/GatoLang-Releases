# GatoLang Releases

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

On many workloads, GatoLang is comparable to C and beats other popular programming languages.

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

## License

`gatoc` is proprietary software.

You may:

- Use the compiler
- Distribute programs produced by the compiler
- 
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
