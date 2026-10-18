# AGENTS.md

TTG (Automatic Timetable Generator) — a Lazarus/Free Pascal GUI app (LCL) for
scheduling classes/resources. Linux is the primary target; a Cygwin/Windows
flow also exists but is secondary.

## Build & run

- `make` at the root delegates to `src/Makefile`, which runs
  `lazbuild --build-mode=debug ttg.lpi`. Binary: `bin/<cpu>-<os>[-debug]/ttg`.
- Mode selection: `make BuildMode=release` (release also strips + upx's the
  binary). `make allmodes` loops over debug+release.
- `make run` runs the binary; `make ex1`..`ex5` open the bundled example
  `.ttd` files in `examples/` — these are the practical smoke tests.
- `make ide` opens `ttg.lpi` in lazarus-ide.
- There is **no test suite**: `make test` only echoes Make variables.
  Verification = clean compile + run an example.
- If compilation seems broken, verify the build works before suspecting code:
  `make` should be a fast no-op when up to date.

## External dependencies (outside this repo)

`src/ttg.lpi` required packages: `zdbc` (ZeosLib), `MultiThreadProcsLaz`,
`SynEdit`, FCL, LCL. Unit search paths are relative to `src/`:
`../../zeoslib/...` and `../../multithreadprocs`, i.e. sibling dirs of the
repo (`/home/edison/apps/zeoslib`, `/home/edison/apps/multithreadprocs`).
The ZeosLib checkout has **local patches applied** (see the `0001-*.patch` /
`0002-*.patch` files at its root); don't swap in a vanilla ZeosLib without
re-applying them.

## Generated files — edit the source, not the output

- `UAbout.pas` is generated from `src/UAbout.pas.tmpl` via sed; edit the
  template.
- `src/ttg.lrs` embeds `dat/default.ttd` and `dat/ttg.sql` as lazres
  resources. Changing either `dat/` file invalidates `ttg.lrs`, whose rebuild
  needs `$(LAZBASE)/tools/lazres` — `LAZBASE` is pinned to
  `/usr/share/lazarus/4.8.0` in the root `COMMON`.
- Version numbers live in `src/ttg.lpi` XML (`MajorVersionNr` etc.); the
  `COMMON` Makefile fragments parse them (plus copyright/app name from the
  `StringTable` line) with sed, so keep that XML shape intact.

## Project wiring quirks

- Entrypoint: `src/ttg.lpr` → main form `FMain.pas`; data modules
  `DMaster.pas`/`DSource.pas`. Scheduling algorithms: `USolver.pas`,
  `UEvolElitist.pas` (genetic), `UDownHill.pas`, `UMakeTT.pas`.
- A unit is only compiled if registered in `ttg.lpi`'s `<Units>` list — the
  Makefile derives its file list from that XML. Adding a unit means editing
  `ttg.lpi`.
- `src/ttg.inc` is `{$I}`-included by `ttg.lpr` but is **untracked**; never
  delete or commit it.
- i18n: resource strings (`.lrt` files) + gettext catalogs in `src/locale/`.
  Team convention: ship the `.po` file directly (the Makefile install target
  copies `ttg.es.po`); compiled `.mo` was dropped as buggy.
- `src/backup/` contains **stale old copies** of units with the same names —
  never edit or `uses`-resolve into them.
- Root is full of untracked cruft (`*.log`, `*.diff`, `README.md~`,
  `src/backup/`); don't commit it.

## Windows/Cygwin-only paths

`iss/` (Inno Setup installer via `make winsetup`/`runsetup`) and the
`dat/ttg.s3fpc` SQLite3 conversion (needs `sqlite3`, only built under Cygwin
per root `SETTINGS`). Ignore these for Linux work.
