# Also Starring

A tribute to the 1990s character actors who appeared in everything and were never the name on the poster.

Nineteen actors, each with three signature credits and the kind of role they were always called in to play.

## Live site

Once GitHub Pages is enabled, the site is at `https://seanlucano.github.io/also-starring/`

## Running locally

No build step. It's one self-contained HTML file.

Open `index.html` in a browser, or serve it:

```
python3 -m http.server 8000
```

Then visit `http://localhost:8000`.

## Photos

All nineteen actors currently have a photo.

Most load from Wikimedia Commons via `Special:FilePath`, which resolves a filename
to the current image; these are used under CC BY and CC BY-SA licenses. A few
actors have no freely-licensed photo on Commons, so the page points at a
low-resolution image hosted elsewhere (Wikipedia, a university site), used for
educational identification. Sources are credited collectively in the page footer.

If a photo fails to load for any reason, the card falls back to a monogram, so the
layout never breaks. An actor with no photo at all gets the same monogram card.

The `photo` value for each actor can be any of:

1. A Commons filename like `Bill_Duke.jpg` (resolved through `Special:FilePath`), or
2. A full URL like `https://upload.wikimedia.org/.../J.T._Walsh.jpg`, or
3. A relative path like `img/name.jpg` if you drop an image into an `img/` folder.

The loader handles all three.

## Structure

```
also-starring/
├── index.html    the whole site: markup, styles, and actor data
└── README.md
```

Actor data lives in the `actors` array near the bottom of `index.html`. Each entry
takes a name, a one-line specialty, a billing stamp, an optional photo, and three
credits as `[title, year, role]`.
