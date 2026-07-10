# Dashboard på GitHub Pages — komplett setup från noll

Slutresultat: dashboarden ligger på en fast webbadress som fungerar i
Chrome på datorn och Safari i mobilen. Efter varje avstämning med Claude
laddar du upp den nya filen — adressen är alltid densamma, du bara
refreshar fliken.

**Tid för setup: ca 15 minuter. Kostnad: 0 kr.**

---

## Viktigt att veta först: sidan blir publik

GitHub Pages på gratiskontot kräver ett publikt repository. Det betyder
att **vem som helst som känner till adressen kan se dashboarden** —
inklusive din puls, vikt och träningsdata. Den dyker inte upp i
Google-sökningar av sig själv, men den är inte lösenordsskyddad.

Två sätt att hantera det:
- **Ogissbart namn:** döp repot till något anonymt med slumptecken,
  t.ex. `im27-k3x9` istället för `ironman-kalmar`. Då är adressen i
  praktiken privat för alla som inte fått den av dig.
- **OK med öppenhet:** många triathleter delar exakt denna typ av data
  öppet på Strava ändå. Ditt val.

Instruktionerna nedan använder exempelnamnet `im27-k3x9` — byt till
ditt eget.

---

## Del 1 — Skapa konto (5 min, en gång)

1. Gå till **github.com** → **Sign up**
2. Ange e-post, lösenord, användarnamn
   - Användarnamnet syns i adressen: `användarnamn.github.io/...`
   - Välj något neutralt, t.ex. `carlw-fogdon` eller liknande
3. Verifiera e-posten. Klart — gratiskontot räcker.

## Del 2 — Skapa repository (3 min, en gång)

1. Uppe till höger: **+** → **New repository**
2. **Repository name:** `im27-k3x9` (eller ditt eget ogissbara namn)
3. **Public** (krävs för Pages på gratiskonto)
4. Bocka i **"Add a README file"** (gör att repot går att använda
   direkt i webbläsaren utan terminal)
5. **Create repository**

## Del 3 — Ladda upp dashboarden (2 min, samma varje gång)

1. Inne i repot: **Add file** → **Upload files**
2. Dra in **`index.html`** (filen från Claude)
3. Klicka **Commit changes** (grön knapp)

*Detta är också hela uppdateringsflödet framöver: samma tre klick,
GitHub ersätter den gamla filen automatiskt när namnet är samma.*

## Del 4 — Aktivera Pages (2 min, en gång)

1. I repot: **Settings** (kugghjulet) → **Pages** (vänstermenyn)
2. Under **Build and deployment → Source:** välj **Deploy from a branch**
3. **Branch:** `main` · **Folder:** `/ (root)` → **Save**
4. Vänta 1–2 minuter, ladda om sidan. Överst visas nu adressen:

```
https://DITT-ANVÄNDARNAMN.github.io/im27-k3x9/
```

Öppna den — dashboarden är live.

## Del 5 — Mobilen (1 min, en gång)

1. Öppna adressen i **Safari** på iPhone
2. **Dela-knappen** (fyrkanten med pil) → **Lägg till på hemskärmen**
3. Nu ligger dashboarden som app-ikon bredvid Strava, öppnas i helskärm.

---

## Arbetsflödet framöver

```
1. python3 strava_sync.py            → ladda upp JSON till Claude
2. Claude analyserar + uppdaterar    → ladda ner nya index.html
3. github.com → repot → Upload files → dra in filen → Commit
4. Refresha fliken/appen (1–2 min efter commit)
```

Steg 3 tar ~20 sekunder i webbläsaren. Ingen terminal, inget git-konto
lokalt, fungerar från vilken dator som helst.

## Valfritt: en-kommandos-publicering med terminalen

Om du hellre pushar från terminalen (som med strava_sync.py):

1. Installera git: `xcode-select --install` (Mac) eller git-scm.com (Windows)
2. Klona repot en gång:
   ```bash
   git clone https://github.com/DITT-ANVÄNDARNAMN/im27-k3x9.git
   cd im27-k3x9
   ```
   (GitHub ber dig logga in via webbläsaren första gången)
3. Lägg `publish.sh` (medföljer) i repomappen och gör den körbar:
   ```bash
   chmod +x publish.sh
   ```
4. Varje uppdatering därefter:
   ```bash
   ./publish.sh
   ```
   Skriptet hämtar senaste `index.html` från ~/Downloads, committar
   och pushar. Klart på 5 sekunder.

## Felsökning

| Problem | Lösning |
|---|---|
| 404 på adressen | Pages inte aktiverat (Del 4) eller vänta 2 min till |
| Gammal version visas | Hård refresh: Cmd+Shift+R (Chrome) / håll in reload-knappen |
| "Upload files" saknas | Du är inte inloggad, eller fel repo |
| Sidan ser trasig ut i mobilen | Kolla att hela filen laddades upp (ska vara ~27 kB) |
