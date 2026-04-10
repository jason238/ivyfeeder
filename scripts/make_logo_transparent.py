"""One-off: JPG logo -> PNG with near-black background removed."""
from __future__ import annotations

from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "Company-Logo.jpg"
OUT = ROOT / "Company-Logo.png"


def main() -> None:
    im = Image.open(SRC).convert("RGBA")
    px = im.load()
    w, h = im.size
    # Near-neutral dark = background (black JPEG artifacts stay grayish).
    max_rgb = 52
    max_spread = 28
    for y in range(h):
        for x in range(w):
            r, g, b, a = px[x, y]
            spread = max(r, g, b) - min(r, g, b)
            if r <= max_rgb and g <= max_rgb and b <= max_rgb and spread <= max_spread:
                px[x, y] = (r, g, b, 0)
    im.save(OUT, optimize=True)
    print(f"Wrote {OUT}")


if __name__ == "__main__":
    main()
