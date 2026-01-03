# GatoLang Releases

This repository contains **binary-only releases** of the **GatoLang compiler (`gatoc`)**.

The compiler is **closed source**. You are free to use it to build and distribute programs written in GatoLang, but redistribution or modification of the compiler itself is not permitted (see LICENSE).

---

## What is GatoLang?

GatoLang is a small, Java-like programming language compiled by `gatoc` into native executables via a C backend.  
It is designed to be simple, explicit, and low-level where it matters, while still feeling familiar.

- Statically typed
- No type inference
- No for-loops (custom loop constructs instead)
- Designed and implemented by **Ammar Adil**

The **language specification and tooling (VS Code extension)** are public.  
The **compiler implementation is proprietary**.

---

## Contents of a Release

Each versioned release contains **prebuilt, obfuscated binaries** and install scripts.

Example layout:
```

0.1.0/
├── linux/
│   ├── gatoc-obf.jar
│   ├── install.sh
│   └── install-user.sh
├── windows/
│   ├── gatoc-obf.jar
│   ├── install.cmd
│   └── install-user.cmd
├── linux.zip
└── windows.zip

````

> ⚠️ Only the **obfuscated jar** is shipped and used.  
> There is no unobfuscated compiler binary in the release.

---

## Requirements

- **Java 17** (required)
- Linux or Windows
- A C compiler (`gcc` or `clang`) available on PATH for native builds

Verify Java:
```bash
java --version
````

---

## Installation

### Linux (recommended)

#### System-wide install (requires sudo)

```bash
sudo bash linux/install.sh
```

Installs:

* Compiler: `/usr/local/lib/gatoc/gatoc.jar`
* Command: `/usr/local/bin/gatoc`

#### User-only install (no sudo)

```bash
bash linux/install-user.sh
```

Installs to:

* `~/.local/lib/gatoc/gatoc.jar`
* `~/.local/bin/gatoc`

If `~/.local/bin` is not on your PATH, the script will tell you how to add it.

---

### Windows

#### User install (recommended)

Run:

```
windows\install-user.cmd
```

Installs to:

* `%LOCALAPPDATA%\GatoLang\gatoc.jar`
* `%LOCALAPPDATA%\GatoLang\bin\gatoc.cmd`

You will be prompted to add the bin folder to PATH manually.

#### System install (with fallback)

Run:

```
windows\install.cmd
```

Attempts installation under `Program Files`, and falls back to `%LOCALAPPDATA%` if permissions are insufficient.

---

## Verifying the Installation

After installation:

```bash
gatoc --help
```

You should see the compiler help output.

Test with a simple program:

```gw
print("Hello, GatoLang!");
```

Compile and run:

```bash
gatoc hello.gw --run
```

---

## Notes on GitHub Releases

Nothing inside this repository is published automatically.

For files to appear on the **GitHub Releases page**, you must:

1. Create a Git tag (e.g. `v0.1.0`)
2. Create a GitHub Release for that tag
3. Upload `linux.zip` and `windows.zip` as **release assets**

Only uploaded assets appear on the Releases page — repository files do not.

---

## License

`gatoc` is proprietary software.

You may:

* Use the compiler
* Distribute programs produced by the compiler

You may not:

* Redistribute the compiler
* Reverse engineer or decompile it
* Modify or repackage it

See the LICENSE file for full terms.

---

## Support & Links

* VS Code extension: available on the VS Code Marketplace
* Documentation: see the GatoLang docs repository
* Issues: report problems in the appropriate public issue tracker

---

**GatoLang © Ammar Adil**

```
