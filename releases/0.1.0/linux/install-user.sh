#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_JAR="$SRC_DIR/gatoc.jar"

if [[ ! -f "$SRC_JAR" ]]; then
  echo "Source jar not found: $SRC_JAR" >&2
  exit 1
fi

if [[ -n "${GATOC_PREFIX:-}" ]]; then
  PREFIX="$GATOC_PREFIX"
else
  PREFIX="$HOME/.local"
fi

LIB_DIR="$PREFIX/lib/gatoc"
BIN_DIR="$PREFIX/bin"
JAR_DST="$LIB_DIR/gatoc.jar"
WRAPPER_DST="$BIN_DIR/gatoc"

install -d -m 755 "$LIB_DIR" "$BIN_DIR"
install -m 644 "$SRC_JAR" "$JAR_DST"
cat >"$WRAPPER_DST" <<WRAP
#!/usr/bin/env bash
exec java -jar "$JAR_DST" "\$@"
WRAP
chmod 755 "$WRAPPER_DST"

echo "Installed gatoc to $JAR_DST"
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  echo "Add $BIN_DIR to your PATH to run 'gatoc'"
fi
