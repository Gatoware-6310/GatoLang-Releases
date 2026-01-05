# GatoLang gatoc 0.2.1

## Requirements
- Java 17

## Linux install
- System install:
  - `sudo bash linux/install.sh`
- User install:
  - `bash linux/install-user.sh`
  - The script adds `~/.local/bin` to your PATH if needed.

## Windows install
- System install (falls back to user install if not writable):
  - `windows\install.cmd`
- User install:
  - `windows\install-user.cmd`
  - The script adds the bin folder to PATH (or tells you to add it).

## Verify
- `gatoc --help`
- Compile/run a program:
  - `gatoc examples\gc\stress_arrays.gw --run --out out`

## Obfuscated jar
- Releases are obfuscated by default.
