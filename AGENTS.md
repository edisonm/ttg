# AGENTS.md

TTG (Automatic Timetable Generator) — a Lazarus/Free Pascal GUI app (LCL) for
scheduling classes/resources, plus a headless solver build. Linux is the
primary target; a Cygwin/Windows flow also exists but is secondary.

## Build & run

- `make` at the root delegates to `src/Makefile`, which runs
  `lazbuild --build-mode=debug ttg.lpi` for the GUI (`bin/<cpu>-<os>-debug/ttg`)
  and `lazbuild --ws=nogui ttgsolve.lpi` for the headless binary
  (`bin/<cpu>-<os>-debug/ttgsolve`).
- Mode selection: `make BuildMode=release` (release also strips, and skips
  `upx` if it is not installed; debug is the default and is much slower —
  benchmarks need release). Release output goes to `bin/<cpu>-<os>/` and
  `obj/<cpu>-<os>/` (no `-debug` suffix).
- `make run` runs the GUI; `make ex1`..`ex5` open bundled example `.ttd`
  files; `make solve [EX=Herradura2013.ttd]` runs a headless solve of an
  example (default `Britanico2000.ttd`) with full config iteration counts —
  this takes a long time, prefer the CLI directly with `--max-iterations`.
- `make test` runs `tests/run-tests.sh` against `ttgsolve` (~30 s): headless
  solve, fixed-seed determinism, and `.ttd` round-trip. This is the only
  test suite; there are no unit tests.
- `make ide` opens `ttg.lpi` in lazarus-ide.
- CI (`.github/workflows/ci.yml`): `make && make test` with deps checked out
  as described below.

## Headless solving

`ttgsolve --solve <in.ttd> [out.ttd] [--seed=N] [--max-iterations=N]
[--no-downhill]` solves without any display; `ttg --solve` also works when a
display is available. Key facts:

- `ttgsolve.lpr` deliberately avoids pulling in the LCL `Interfaces` unit of
  a GUI widgetset; it is built `--ws=nogui` because in Lazarus 4.x the gtk2
  widgetset calls `gtk_init` from a unit `initialization` section, which
  kills any GUI-linked binary on a headless machine before `begin`.
- FPC's `TThread.Synchronize` only *enqueues* the method; it runs when the
  main thread calls `CheckSynchronize`. `UConsole.SolveFile` therefore runs
  the solver in a real worker thread and pumps `CheckSynchronize` on the
  main thread — all Zeos DB access happens in the main thread this way.
  (The debug GUI's "call `TThread.Execute` directly from the main thread"
  shortcut only works because of the LCL message pump; don't copy it into
  non-GUI code.)
- The `.ttd` ini section stores floats with a comma (`0,2`); `SolveFile`
  sets `DefaultFormatSettings.DecimalSeparator := ','` to match.
- Solver/model units contain many unguarded debug `WriteLn`s (e.g. in
  `UTTModel`); `SolveFile` redirects the default `Output` to stderr so CLI
  stdout stays parseable. Keep CLI reporting on `StdOut` explicitly.
- `--no-downhill` sets the config key `SkipDownHill`, which skips the
  iteration-unbounded down-hill refinement so test runs terminate;
  `SolveFile` strips that key before saving so it never leaks into a `.ttd`.

## External dependencies (outside this repo)

`src/ttg.lpi` required packages: `zdbc` (ZeosLib), `MultiThreadProcsLaz`,
`SynEdit`, FCL, LCL. Unit search paths are relative to `src/`:
`../../zeoslib/...` and `../../multithreadprocs`, i.e. sibling dirs of the
repo (`/home/edison/apps/zeoslib`, `/home/edison/apps/multithreadprocs`).
The ZeosLib checkout has **local patches applied** (copied into
`patches/zeoslib/` here); they are also upstream as commits in
`github.com/frones/ZeosLib` branch `8.0-patches`, which CI clones. Don't
swap in a vanilla ZeosLib without re-applying them. `multithreadprocs` and
`SynEdit` also ship inside the Lazarus installation
(`components/multithreadprocs`, `components/synedit`).

## Generated files — edit the source, not the output

- `UAbout.pas` is generated (into `obj/`) from `src/UAbout.pas.tmpl` via sed;
  edit the template.
- `src/ttg.lrs` embeds `dat/default.ttd` and `dat/ttg.sql` as lazres
  resources (`LazarusResources.Find('ttg','SQL')` / `('Default','TTD')` are
  how code reads them). Changing either `dat/` file invalidates `ttg.lrs`,
  whose rebuild needs `$(LAZBASE)/tools/lazres` — `LAZBASE` is pinned to
  `/usr/share/lazarus/4.8.0` in the root `COMMON`.
- Per-form `*.lrs` files and all compiler intermediates are generated into
  `obj/<buildid>/` by lazbuild; `bin/` and `obj/` are fully disposable
  (`make clean`).
- Version numbers live in `src/ttg.lpi` XML (`MajorVersionNr` etc.); the
  `COMMON` Makefile fragments parse them (plus copyright/app name from the
  `StringTable` line) with sed, so keep that XML shape intact.

## Project wiring quirks

- Entrypoints: `src/ttg.lpr` (GUI, main form `FMain.pas`) and
  `src/ttgsolve.lpr` (headless), both through `UConsole.pas`. Data modules:
  `DSource.pas` (in-memory SQLite via Zeos, schema from embedded `ttg.sql`)
  and `DMaster.pas` (load/save `.ttd`, solver config). Solver chain:
  `UMakeTT` (thread orchestration) → `UEvolElitist` (genetic) →
  `UDownHill`; model in `UTTModel.pas`.
- A unit is only compiled if registered in a `.lpi` `<Units>` list — the
  Makefile derives its file list from that XML. Adding a unit means editing
  `ttg.lpi` (and `ttgsolve.lpi` if the console build needs it).
- Both `.lpi` files share the `obj/` unit output dir: keep their compiler
  defines identical (`-dDEBUG` in debug mode etc.) or builds ping-pong full
  recompiles. `ttgsolve.lpi` mirrors `ttg.lpi`'s options deliberately.
- `src/ttg.inc` is `{$I}`-included by the programs: it defines `THREADED`
  in non-debug builds (only debug is a non-THREADED build — see the
  `Synchronize` note above). It is tracked; do not delete it.
- `TMasterDataModule.DataModuleCreate` seeds a default database when
  `Paramcount <> 1`; `DMaster`/`DSource` globals must be assigned
  (`SourceDataModule` first!) before calling into them outside the GUI.
- i18n: resource strings (`.lrt` files) + gettext catalogs in `src/locale/`.
  Team convention: ship the `.po` file directly (the Makefile install target
  copies `ttg.es.po`); compiled `.mo` was dropped as buggy. The template
  `src/locale/ttg.pot` is tracked and regenerated with `make pot` (needs a
  built project: it feeds the compiler-written `.rsj` + form `.lrj` files to
  Lazarus' `updatepofiles`, which also merges new strings into `ttg.*.po`).
- `src/backup/` contains **stale old copies** of units with the same names —
  never edit or `uses`-resolve into them.
- Root is full of untracked cruft (`*.log`, `*.diff`, `README.md~`); the
  `.gitignore` covers it — don't force-add any of it.

## Windows/Cygwin-only paths

`iss/` (Inno Setup installer via `make winsetup`/`runsetup`) and the
`dat/ttg.s3fpc` SQLite3 conversion (needs `sqlite3`, only built under Cygwin
per root `SETTINGS`). Ignore these for Linux work.
