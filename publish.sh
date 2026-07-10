#!/bin/bash
# publish.sh — publicerar senaste dashboarden till GitHub Pages
set -e

DOWNLOADS="$HOME/Downloads"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

LATEST=$(ls -t "$DOWNLOADS"/index.html "$DOWNLOADS"/ironman-kalmar-dashboard*.html 2>/dev/null | head -1)

if [ -z "$LATEST" ]; then
  echo "Hittar ingen dashboard-fil i $DOWNLOADS"
  echo "Ladda ner index.html från Claude först."
  exit 1
fi

echo "Publicerar: $LATEST"
cp "$LATEST" "$REPO_DIR/index.html"

cd "$REPO_DIR"
git add index.html
git commit -m "Dashboard-uppdatering $(date '+%Y-%m-%d %H:%M')"
git push

echo ""
echo "Klart! Sidan uppdateras inom 1-2 minuter."
