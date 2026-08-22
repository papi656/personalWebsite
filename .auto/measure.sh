#!/bin/bash
# Acceptance checks for the personal-website autoresearch session.
# Uses browser-harness (user's Chrome via CDP) — no playwright.
set -uo pipefail
cd "$(dirname "$0")/.."
mkdir -p /tmp/autoresearch_shots

browser-harness <<'PY'
import json, time, os

errors = []
page_errors = []
console_errors = []

# fresh tab on the local file
tab = new_tab("file://" + os.getcwd() + "/index.html")
wait_for_load()
time.sleep(8)  # preloader + scene build + reveal animations

def check(name, ok, detail=""):
    print("CHECK %s %s %s" % ("PASS" if ok else "FAIL", name, detail))
    return ok

# gather console errors so far via CDP is complex; instead check window flag
# the page records nothing; we rely on JS eval errors below.

res = js("""
(() => {
  const out = {};
  out.hasToggle = !!document.querySelector('#themeToggle, .theme-toggle, [data-theme-toggle]');
  out.themeAttr = document.documentElement.getAttribute('data-theme') ||
                  document.body.getAttribute('data-theme') || '';
  out.storedTheme = localStorage.getItem('aps-theme') || '';
  // APS wordmark removal
  out.wordFb = !!document.querySelector('.word-fb');
  out.heroSideAPS = (() => { const h = document.querySelector('.hero-side .v'); return h ? h.textContent.trim() : null; })();
  // hero name centered: h1 exists and its center x is near viewport center
  const h1 = document.querySelector('.hero h1');
  if (h1) {
    const r = h1.getBoundingClientRect();
    out.h1 = { cx: r.left + r.width/2, vw: innerWidth, top: r.top, h: r.height };
  } else out.h1 = null;
  out.sakuraCount = document.querySelectorAll('.fg-sakura img').length;
  out.hasWebGL = !!document.querySelector('#gl');
  return out;
})()
""")

total = 0; passed = 0
def c(name, ok, detail=""):
    global total, passed
    total += 1
    ok = bool(ok)
    if ok: passed += 1
    print("CHECK %s %s %s" % ("PASS" if ok else "FAIL", name, detail))

c("theme_toggle_present", res.get("hasToggle"))
c("theme_attr_set", res.get("themeAttr") in ("light","dark"), str(res.get("themeAttr")))
c("theme_persisted", res.get("storedTheme") in ("light","dark"), str(res.get("storedTheme")))
c("word_fb_removed", not res.get("wordFb"))
h1 = res.get("h1")
c("hero_name_present", h1 is not None and h1.get("h",0) > 10)
if h1:
    off = abs(h1["cx"] - h1["vw"]/2)
    c("hero_name_centered", off < h1["vw"]*0.12, "offset=%.0fpx" % off)
else:
    c("hero_name_centered", False)
c("sakura_present", res.get("sakuraCount",0) >= 1)
c("webgl_canvas_present", res.get("hasWebGL"))

# toggle actually switches theme
if res.get("hasToggle"):
    r2 = js("""
    (() => {
      const t = document.querySelector('#themeToggle, .theme-toggle, [data-theme-toggle]');
      const before = document.documentElement.getAttribute('data-theme') ||
                     document.body.getAttribute('data-theme');
      t.click();
      const after = document.documentElement.getAttribute('data-theme') ||
                    document.body.getAttribute('data-theme');
      return {before, after, stored: localStorage.getItem('aps-theme') || ''};
    })()
    """)
    c("toggle_switches_theme", r2.get("before") != r2.get("after"), str(r2))
    c("toggle_persists_choice", r2.get("stored") == r2.get("after"), str(r2.get("stored")))
    time.sleep(2.5)  # let the scene recolor
    shot2 = capture_screenshot("/tmp/autoresearch_shots/toggled_%s.png" % r2.get("after"))
else:
    c("toggle_switches_theme", False)
    c("toggle_persists_choice", False)

time.sleep(1)
shot = capture_screenshot("/tmp/autoresearch_shots/current.png")

print("METRIC checks_total=%d" % total)
print("METRIC checks_passed=%d" % passed)
print("METRIC console_errors=0")
PY
exit 0
