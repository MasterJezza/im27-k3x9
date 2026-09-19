#!/usr/bin/env bash
# Publicera den versionshanterade index.html i samma mapp som skriptet.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

if [[ ! -f index.html ]]; then
  echo "Saknar index.html i $REPO_DIR" >&2
  exit 1
fi

if [[ "$(git branch --show-current)" != "main" ]]; then
  echo "Avbryter: växla till main innan publicering." >&2
  exit 1
fi

top_date="$(sed -n 's/.*Uppdaterad <time datetime="\([0-9-]*\)".*/\1/p' index.html | head -n 1)"
footer_date="$(sed -n 's/.*Coach: Codex · uppdaterad <time datetime="\([0-9-]*\)".*/\1/p' index.html | head -n 1)"
if [[ -z "$top_date" || "$top_date" != "$footer_date" ]]; then
  echo "Avbryter: uppdateringsdatumen på framsidan och i sidfoten saknas eller skiljer sig." >&2
  exit 1
fi

if git diff --quiet HEAD -- index.html publish.sh; then
  echo "Inga nya ändringar att committa. Kontrollerar eventuell väntande push."
else
  git commit --only -m "Dashboard-uppdatering $(date '+%Y-%m-%d %H:%M')" -- index.html publish.sh
fi

git push origin main
echo "Klart! GitHub Pages uppdateras efter publiceringen."
