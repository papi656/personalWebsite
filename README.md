# personalWebsite

A single-page personal website. The homepage is the **Kage** landing page — a
five-chapter "night walk through a Kyoto mountain temple" rendered live in
WebGL (Three.js). The scene is generated at runtime: no photographs, no video,
and no external assets beyond the bundled three.js and two subset fonts.

Live: https://www.papi656.com

## Structure

| Path | Description |
| --- | --- |
| `index.html` | The landing page (canonical source, byte-exact) |
| `secret-pathways-assets/fonts.css` | Self-contained WOFF2 subset fonts (Onest, NotoJP, Wordmark), base64-embedded |
| `secret-pathways-assets/three.min.js` | Three.js runtime (MIT, bundled locally) |

## Binary assets — procedural workaround

The page originally referenced 14 binary WebP images (chapter poster stills and
foreground parallax cut-outs) that could not be carried in the source bundle.
They are now replaced with procedural equivalents so the page is fully
self-contained:

- **Chapter posters** → layered CSS gradients (one mood per chapter).
- **Foreground cut-outs** → inline SVG silhouettes embedded as `data:` URIs
  (temple wall, pine, grass, sakura, maple, stone lantern, bush, basalt,
  hill, shrine ruins).

The original painted artwork can still be restored by dropping the binary
files into the paths below and verifying their SHA-256 — the page will use them
automatically (the `buildCardCloth` effect reads the poster `background-image`).

| Path | Bytes | SHA-256 |
| --- | ---: | --- |
| `secret-pathways-assets/generated/kage-sanmon-preview.webp` | 186398 | `23937f8c8350c55730c3bd17066a250548b2d29aad0e6ffb96218c1354b6db43` |
| `secret-pathways-assets/generated/kage-approach.webp` | 180064 | `39ff338936097e1bde0c4eadcf09805b9890862703186e67314942de7e0bc36c` |
| `secret-pathways-assets/generated/kage-lantern-court.webp` | 197940 | `c0a6ff7da1cd6909d66e2f3f690b0d524a693e01d2222ab846d0074a90f47471` |
| `secret-pathways-assets/generated/kage-moonwater.webp` | 102234 | `b8c8060c51c87a103bae619b3a4cc8b8b80632649d83f1f2c2299051e7f9b400` |
| `secret-pathways-assets/foreground/png/temple-wall.webp` | 86466 | `41c00f017e4ecf2147ee468d74da955bb4e2dad773f75a575022842eaf7609ce` |
| `secret-pathways-assets/foreground/png/pine-tree.webp` | 195918 | `79b233716d067bbc64c1507f79e4a30ba5f445995158c78562cc5b81f607ede7` |
| `secret-pathways-assets/foreground/png/tall-grass.webp` | 351644 | `8db0b5fbd160a7225391a6283a99681e346e205f24191031657285ef85ef12d2` |
| `secret-pathways-assets/foreground/png/sakura-branch.webp` | 252528 | `48564194d40496090dbf3bba2a68785cf91fafb655dc8d43ac16f6678aff196d` |
| `secret-pathways-assets/foreground/png/maple-leaves.webp` | 178208 | `35a90fec62c1a6bbfbbe73cd5d7b1acb889e80546d404182ef9a45fe417b531f` |
| `secret-pathways-assets/foreground/png/stone-lantern.webp` | 150108 | `d5f3c881bc9d92b72eaaff2b709614d66e21a19e14025d2b9b16a15ab52df3bc` |
| `secret-pathways-assets/foreground/png/garden-bush.webp` | 286406 | `707e2516ebc0108041fe0ddc26d8bff0a69dc9700641f837765018b64e9ff15e` |
| `secret-pathways-assets/foreground/png/basalt-stones.webp` | 167866 | `150f1c87e181d651c318168c271bb65c9c8abac6dea6f2421fdd081c5b740471` |
| `secret-pathways-assets/foreground/png/hill.webp` | 84142 | `ffba816244bcba98e4e33c6ee56165edfe4048db4af122ef3f5822180a85edbc` |
| `secret-pathways-assets/foreground/png/shrine-ruins.webp` | 145814 | `77006e58f2066e6fa9bfc504df396db49b1c7977858fa52d34dd2dad5feced77` |

## Source bundle

The page originated from a "Kage — Complete source" bundle. The three text
assets above were extracted from that bundle and verified byte-exact against
the manifest's SHA-256 hashes (`index.html` → `c8e06b90…`, `fonts.css` →
`985f85a9…`, `three.min.js` → `8a5f7249…`).
