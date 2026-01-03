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
  NEED_SUDO=0
else
  PREFIX="/usr/local"
  NEED_SUDO=1
fi

LIB_DIR="$PREFIX/lib/gatoc"
BIN_DIR="$PREFIX/bin"
JAR_DST="$LIB_DIR/gatoc.jar"
WRAPPER_DST="$BIN_DIR/gatoc"

if [[ "$NEED_SUDO" -eq 1 ]]; then
  sudo install -d -m 755 "$LIB_DIR" "$BIN_DIR"
  sudo install -m 644 "$SRC_JAR" "$JAR_DST"
  sudo tee "$WRAPPER_DST" >/dev/null <<WRAP
#!/usr/bin/env bash
exec java -jar "$JAR_DST" "\$@"
WRAP
  sudo chmod 755 "$WRAPPER_DST"
else
  install -d -m 755 "$LIB_DIR" "$BIN_DIR"
  install -m 644 "$SRC_JAR" "$JAR_DST"
  cat >"$WRAPPER_DST" <<WRAP
#!/usr/bin/env bash
exec java -jar "$JAR_DST" "\$@"
WRAP
  chmod 755 "$WRAPPER_DST"
fi

echo "Installed gatoc to $JAR_DST"

add_path_user() {
  local marker="# Added by GatoLang installer"
  local line="export PATH=\"$BIN_DIR:\$PATH\""
  local file
  for file in "$HOME/.profile" "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [[ -f "$file" || "$file" == "$HOME/.profile" ]]; then
      if ! grep -Fqs "$BIN_DIR" "$file"; then
        printf '\n%s\n%s\n' "$marker" "$line" >>"$file"
      fi
    fi
  done
}

if [[ "$NEED_SUDO" -eq 1 ]]; then
  sudo tee /etc/profile.d/gatoc.sh >/dev/null <<PROFILE
# Added by GatoLang installer
case ":\$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) export PATH="$BIN_DIR:\$PATH" ;;
esac
PROFILE
  echo "Added $BIN_DIR to PATH for all users. Open a new terminal to use 'gatoc'."
else
  add_path_user
  echo "Added $BIN_DIR to PATH in your shell profiles. Open a new terminal to use 'gatoc'."
fi