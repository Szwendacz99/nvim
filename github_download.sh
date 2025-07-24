#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <url-template> [output-path]"
  echo "  <url-template> should include the literal '{arch}' where the CPU arch belongs"
  echo "  [output-path]  defaults to the basename of the resolved URL in ./" 
  exit 1
fi

URL_TPL="$1"
OUT_PATH="${2:-}"

# 1) detect CPU arch and map to GitHub release naming
raw_arch="$(uname -m)"
case "$raw_arch" in
  x86_64)   arch="amd64" ;;
  i386|i686) arch="386" ;;
  aarch64|arm64) arch="arm64" ;;
  armv7l)   arch="arm" ;;
  *)
    echo "Unsupported architecture: $raw_arch"
    exit 1
    ;;
esac

# 2) substitute placeholder
if [[ "$URL_TPL" != *"{arch}"* ]]; then
  echo "Error: URL template must contain '{arch}'"
  exit 1
fi
URL="${URL_TPL//\{arch\}/$arch}"

# 3) determine output path
if [[ -z "$OUT_PATH" ]]; then
  OUT_PATH="$(basename "$URL")"
fi

# 4) download + make executable
echo "Downloading $URL → $OUT_PATH"
curl -fSL "$URL" -o "$OUT_PATH"
chmod +x "$OUT_PATH"

echo "Done: $OUT_PATH"
