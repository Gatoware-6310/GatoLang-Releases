# GatoLang gatoc 0.1.0

## Requirements
- Java 17

## Linux install
- System install:
  - `sudo bash linux/install.sh`
- User install:
  - `bash linux/install-user.sh`

## Windows install
- System install (falls back to user install if not writable):
  - `windows\install.cmd`
- User install:
  - `windows\install-user.cmd`

## Verify
- `gatoc --help`
- Compile/run a program:
  - `gatoc examples\gc\stress_arrays.gw --run --out out`

## Obfuscated jar
- Releases are obfuscated by default.
