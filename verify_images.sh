#!/usr/bin/env bash
set -uo pipefail

WORKDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HTML="$WORKDIR/index.html"
COMMONS="https://commons.wikimedia.org/wiki/Special:FilePath"
UA="also-starring-verify/1.0"

[ -f "$HTML" ] || { echo "index.html not found at $HTML"; exit 1; }

# Pull the quoted value of every `photo:` entry in the actors array.
photos=$(grep -oE 'photo: "[^"]+"' "$HTML" | sed -E 's/photo: "(.*)"/\1/')

fail=0
while IFS= read -r p; do
  [ -n "$p" ] || continue
  case "$p" in
    http*)
      url="$p" ;;
    img/*)
      if [ -f "$WORKDIR/$p" ]; then
        echo "ok    (local)  $p"
      else
        echo "MISS  (local)  $p"; fail=1
      fi
      continue ;;
    *)
      enc=$(printf '%s' "$p" | jq -sRr @uri)
      url="$COMMONS/$enc?width=500" ;;
  esac

  res=$(curl -s -o /dev/null -w '%{http_code} %{content_type}' -L -A "$UA" "$url" || echo "000 error")
  code=${res%% *}
  type=${res#* }
  if [ "$code" = "200" ] && [[ "$type" == image/* ]]; then
    echo "ok    ($code)    $p"
  else
    echo "FAIL  ($code $type)  $p"; fail=1
  fi
done <<< "$photos"

echo
if [ "$fail" -eq 0 ]; then
  echo "All images verified."
else
  echo "Some images failed to verify."
  exit 1
fi
