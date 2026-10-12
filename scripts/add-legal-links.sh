#!/usr/bin/env bash
# Fuegt Links zu Impressum und Datenschutz (zentral auf start.icken.eu) in den Footer
# jeder gebauten HTML-Seite ein. Aufruf: scripts/add-legal-links.sh _site
set -euo pipefail

dir="${1:?Verzeichnis der gebauten Seite angeben, z. B. _site}"
links='<p class="mt-2"><a href="https://start.icken.eu/impressum.html" class="text-accent-text hover:underline">Impressum</a> · <a href="https://start.icken.eu/datenschutz.html" class="text-accent-text hover:underline">Datenschutz</a></p>'

find "$dir" -name '*.html' -exec sed -i "s#</footer>#${links}</footer>#" {} +

# Schlaegt fehl, wenn eine Seite keinen Footer hatte (z. B. nach einem CookCLI-Update).
missing="$(grep -L 'start.icken.eu/impressum.html' $(find "$dir" -name '*.html') || true)"
if [ -n "$missing" ]; then
  echo "Footer-Links fehlen in:" >&2
  echo "$missing" >&2
  exit 1
fi
