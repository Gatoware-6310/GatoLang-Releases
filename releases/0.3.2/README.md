# GatoLang gatoc 0.3.2

## Requirements
- Java 17

## Linux install
- System install: run   `sudo bash linux/install.sh`
- User install: run   `bash linux/install-user.sh`
  - The script adds `~/.local/bin` to your PATH if needed.

## Windows install
- System install (falls back to user install if not writable): run   `windows\install.cmd`
- User install: run   `windows\install-user.cmd`
  - The script adds the bin folder to PATH (or tells you to add it).

## Verify
- `gatoc --help`
- Compile/run a program:
  `gatoc examples\gc\bubble_sort.gw --run --out out`

## Obfuscated jar
- Releases are obfuscated by default.
