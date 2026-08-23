# Autoresearch: improve sakura & marigold, add user-selectable light/dark theme, remove APS wordmark

## Objective
Visual + functional improvement of the personal website (single-file `index.html`, three.js WebGL scene, ~4800 lines):

1. **Remove the giant "APS" wordmark** (3D letters built by `buildWordmark()` around line 3044; also `.word-fb` fallback div and `.hero-side` vertical "APS") and instead have the visitor's name ("Abhishek Pratap Singh") centered in the hero section.
2. **Improve the sakura** (foreground `fg-sakura` inline-SVG branches with pink radial-gradient petals) — better petal geometry, gradients, more organic branch composition.
3. **Improve the marigold** (`texLeaf()` petal texture at ~line 1736 + instanced falling-petal system `buildLeafFall()` at ~line 3209) — better lanceolate petal shape, richer warm golds, nicer tumble.
4. **Light/dark theme**: a user-facing toggle. Default follows time of day (daytime → light theme, night → dark theme), but the user's explicit choice wins and persists (localStorage). Theme must recolor page tokens AND the WebGL scene (sky, fog, materials) coherently.

## Metrics
- **Primary**: `checks_passed` (count, higher is better) — number of automated acceptance checks that pass in `.auto/measure.sh`
- Secondary: `console_errors` (lower better), `load_ms` (lower better), `checks_total`

## How to Run
`./.auto/measure.sh` — serves nothing external: opens `file://$PWD/index.html` in the user's Chrome via **browser-harness**, injects an acceptance-check script into the page, prints `METRIC name=value` lines. Screenshots of both themes are saved to `/tmp/autoresearch_shots/` for manual review.

## Files in Scope
- `index.html` — everything (CSS tokens in `:root` at top, markup for hero/foreground SVGs, JS scene builders). Single-file site; all edits go here.
- `.auto/*` — autoresearch session files.

## Off Limits
- Do NOT touch `secret-pathways-assets/` (fonts, three.min.js vendored lib).
- Do NOT deploy/push to origin or papi656.com — local work only.
- Do NOT break existing sections (About/Focus/Skills/Contact), nav, preloader, or the scroll-camera rig.

## Constraints
- All checks in measure.sh must pass before considering an experiment done.
- Theme default = time-of-day based; user toggle overrides + persists.
- Keep the site dependency-free (three.min.js is already vendored).
- Visual quality judged via screenshots saved by measure.sh — inspect them each iteration.

## What's Been Tried
- (baseline) Site as-is: dark-only theme, giant APS wordmark over hero, sakura/marigold from commit 357827b.
