# Rezepte

Rezeptsammlung im [Cooklang](https://cooklang.org)-Format: jedes Rezept ist eine `.cook`-Textdatei im Ordner [`recipes/`](recipes/), Bilder mit gleichem Dateinamen liegen daneben.

Live: **[cook.icken.eu](https://cook.icken.eu)**

## Deploy-Struktur

```
main  ──push──►  GitHub Action  ──►  deploy  ──Webhook──►  Plesk (Netcup)  ──►  cook.icken.eu
(.cook-Dateien)  cook build web      (fertige statische Seite)
```

- **`main`** ist die Quelle: Hier werden Rezepte unter `recipes/` angelegt und bearbeitet.
- **GitHub Action** ([`.github/workflows/deploy.yml`](.github/workflows/deploy.yml)): baut bei jedem Push auf `main` mit [CookCLI](https://github.com/cooklang/cookcli) (`cook build web`) eine statische Seite und pusht sie in den Branch `deploy`.
- **`deploy`** wird automatisch erzeugt und enthält nur die gebaute Seite. Nicht von Hand bearbeiten.
- **Plesk** holt den `deploy`-Branch per Webhook ab und stellt ihn unter `cook.icken.eu` bereit.

Die statische Seite ist nur zum Lesen und Suchen da. Einkaufsliste, Skalierung und Editor gibt es nur mit dem lokalen Server.

## Lokal nutzen

Voraussetzung: [CookCLI](https://cooklang.org/cli/) ist installiert.

```bash
# Web-Oberfläche mit allen Funktionen (Einkaufsliste, Skalierung, Editor)
cook server recipes
# → http://localhost:9080

# Statische Seite wie im Deploy bauen und ansehen
cook build web _site --base-path recipes --lang de-DE
python3 -m http.server 8000 --directory _site
```

## Links

- [Cooklang](https://cooklang.org) – Projektseite und [Syntax](https://cooklang.org/docs/spec/)
- [CookCLI](https://github.com/cooklang/cookcli) – Kommandozeilen-Tool für Server und Build
