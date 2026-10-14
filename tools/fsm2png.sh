#!/bin/sh
# Render the code-driven FSM pages to PNG with headless Chrome.
# Usage: tools/fsm2png.sh <in.html> [out.png] [width] [height]
#   tools/fsm2png.sh httpdd.fsm.html                       -> httpdd.fsm.png
#   tools/fsm2png.sh httpdd-cache-retrieve.fsm.html out.png 900 600
# The page loads its JSON from the query string ('?name.json'), and the
# grid multiplier is the hash ('#20' is the diagram's shipped scale).
# Dependency-free: python3 (local static server) + Google Chrome.
set -euo pipefail
cd "$(dirname "$0")/.."

CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
HTML="${1:?in.html required}"
OUT="${2:-${HTML%.html}.png}"
WIDTH="${3:-3404}"
HEIGHT="${4:-2162}"

# Screen out stale defaults: cache pages have to point at their own JSON.
case "$HTML" in
  httpdd-cache-*.html) QUERY="?${HTML%.html}.json" ;;
  *) QUERY='' ;;
esac

PORT="$(python3 - <<'EOF'
import socket
s = socket.socket()
s.bind(("127.0.0.1", 0))
print(s.getsockname()[1])
s.close()
EOF
)"

python3 -m http.server "$PORT" --bind 127.0.0.1 >& /dev/null &
SERVER_PID=$!
trap 'kill $SERVER_PID 2>/dev/null || true; wait $SERVER_PID 2>/dev/null || true' EXIT

sleep 1
"$CHROME" \
  --headless --no-first-run --hide-scrollbars \
  --window-size="${WIDTH}x${HEIGHT}" \
  --virtual-time-budget=5000 \
  --screenshot="$PWD/$OUT" \
  "http://127.0.0.1:$PORT/$HTML${QUERY}#20" >/dev/null 2>&1

echo "$OUT"
