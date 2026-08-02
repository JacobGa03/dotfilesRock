# AGENTS.md — chezmoi dotfiles repo

Instructions for any AI coding agent working in this repository. This is a
[chezmoi](https://www.chezmoi.io/) source directory managing dotfiles and
machine setup for macOS and Linux (a Windows branch exists but is a stub).

## What this repo is

- Source state for `chezmoi apply`, applied to `$HOME` on the target machine.
- Two supported OSes today: `darwin` (macOS, primary) and `linux`. Windows is
  a placeholder (`echo "Need to install package manger for windows"`) — not
  implemented.
- Managed apps/dotfiles: zsh, bash, tmux, nvim (NvChad-based), wezterm, git,
  yabai/skhd (macOS window management), starship, ssh config.

## Directory map

```
.chezmoi.toml.tmpl              # one-time prompts: name, email, editor (nvim/vim/code)
.chezmoiignore                  # OS-conditional ignores (skips /Users/... on non-darwin, AppData on non-windows, macOS-only configs like skhd/yabai on non-darwin)
.chezmoidata/
  packages.yaml                  # ALL package/tool data for install scripts — see below
.chezmoiscripts/
  run_once_00-install-tools.sh.tmpl   # entrypoint; OS-branches, then includes templates
.chezmoitemplates/
  installers-brew                # brew formula+cask loop, data-driven from packages.yaml
  installers-apt                 # apt packages+PPA loop, data-driven
  installers-snap                # snap install loop, data-driven (first-class Linux support)
  installers-script               # generic check/install/post loop for curl|sh-style installers
  install-tools-macos            # thin orchestrator -> installers-brew
  install-tools-linux            # thin orchestrator -> installers-apt + installers-snap
  setup-zsh / setup-bash         # shell version checks + chsh, via shell-chsh
  setup-font                     # Nerd Font install, OS-branched dirs, unified logic
  shell-chsh                      # shared chsh-if-not-current-shell helper
  dot_bashrc/, dot_bashrc_alias-*  # bashrc fragments included by dot_bashrc.tmpl
dot_*, private_dot_*             # standard chezmoi-managed dotfiles/dirs
```

## The install-script architecture (read this before touching install logic)

Package/tool lists live in **`.chezmoidata/packages.yaml`**, not inline in
templates. The shape:

- `packages.brew.formula` / `packages.brew.cask` — plain string lists.
- `packages.apt.packages` — plain string list; `packages.apt.ppas` — list of
  `{ppa, package}` for tools that need a PPA add before install.
- `packages.snap` — list of `{name, classic}`. Empty today (`[]`) but fully
  wired up — adding an entry is enough, no template edit needed.
- `packages.script_installers` — generic abstraction for any curl\|sh-style
  provider installer (rustup, tree-sitter-cli, tpm, starship live here today).
  Each entry: `{name, os: [linux, darwin, ...], check, install, post?}`.
  `check` is a shell condition (install runs only if it's false), `install`
  is a shell snippet (can be multiline via YAML `|`), `post` is optional and
  runs unconditionally every apply regardless of `check`. Entries may also
  carry an optional `computer: [personal|work]` list — the entry only
  installs on machines whose role (the `computer` data var, set by the
  `.chezmoi.toml.tmpl` init prompt, or added by hand as `computer = "<role>"`
  under `[data]` in `~/.config/chezmoi/chezmoi.toml`) is in the list. `installers-script` handles the gate; entries
  without a `computer` key install everywhere (backward compatible). Use this
  to decouple install decisions from OS (e.g. opencode → personal, claudecode
  → work) instead of narrowing `os`.

**To add a new tool**: add a data entry to the relevant list in
`packages.yaml`. Do not add bash logic to a template unless the install
method itself is new (i.e. not brew/apt/snap/generic-script).

**To add a new install method**: add a new `installers-<method>` template
that ranges over a new top-level key under `packages:`, and call it from the
relevant OS orchestrator (`install-tools-macos` / `install-tools-linux`) or
directly from the entrypoint if it's OS-agnostic (like `installers-script`).

## Hard-won chezmoi quirks (empirically confirmed in this repo — not obvious from docs)

1. **`.chezmoitemplates` files only register their `{{ define }}` name
   globally if the file is flat (top-level in `.chezmoitemplates/`) AND the
   internal `{{ define "X" }}` name exactly matches the filename.** Files in
   subdirectories (e.g. `.chezmoitemplates/installers/brew`) are *not* merged
   into the global template namespace under a short name — they're only
   callable by their full relative path as the template name
   (`{{ template "installers/brew" . }}`), matching the existing convention
   in `dot_bashrc/dot_bashrc-linux` (called as
   `{{ template "dot_bashrc/dot_bashrc-linux" . }}`). Because of this, all
   the installer templates in this repo are flat files with matching
   define/filename pairs (`installers-brew`, `installers-apt`,
   `installers-snap`, `installers-script`, `shell-chsh`) rather than nested
   under `installers/` or `shell/` — don't reintroduce subdirectories for
   these unless you also update every caller to the path-based name.
2. **Missing optional YAML keys error, they don't just evaluate falsy.**
   Chezmoi's template engine is strict (`missingkey=error`-like behavior) —
   `{{ if .post }}` on a map without a `post` key throws `map has no entry
   for key "post"`. Use `{{ if hasKey . "post" }}` for optional fields.
3. **`{{ ... -}}` / `{{- ... }}` trims ALL adjacent whitespace, not just the
   newline** — including leading spaces/indentation on the next line. Be
   careful with trim markers around indented shell blocks (bit us in
   `setup-font`); when in doubt, render both OS branches and diff before
   trusting the whitespace.
4. **`chezmoi cat <path>`** only works for normally target-managed files, not
   `run_once_*` scripts. For scripts, use
   `chezmoi execute-template < path/to/script.tmpl` instead.
5. **`chezmoi execute-template --override-data '{"chezmoi":{"os":"linux"}}'`**
   lets you render the Linux path from a macOS machine (and vice versa) —
   the standard way to sanity-check the other OS's output without a second
   machine. Follow with `bash -n` on the rendered output to catch shell
   syntax errors without executing anything.
6. **`.chezmoiremove` only removes files NOT in the source state.** If a file
   is in the source state (e.g. `private_dot_config/skhd/`) AND listed in
   `.chezmoiremove`, `chezmoi apply` will deploy it from source *after*
   scheduling removal — the file comes back. To suppress an OS-specific file
   on another OS, you need **both**: `.chezmoiignore` (excludes it from source
   state on that OS) **and** `.chezmoiremove` (cleans up any leftover copies).
   `.chezmoiremove` alone is a cleanup mechanism for orphaned files, not a
   suppression mechanism for managed files.
7. **`chezmoi apply --dry-run --verbose --include=scripts`** scopes a dry-run
   to just `run_once_*` scripts — useful if unrelated drift elsewhere in the
   managed file set (e.g. a manually-edited `.bashrc`) is blocking a full
   `chezmoi apply --dry-run`.

## Working conventions

- This is a structural/config repo — favor small, data-driven edits over
  bash logic sprawl. If you're editing shell inside a `.chezmoitemplates`
  file to add a package, stop: it almost certainly belongs in
  `packages.yaml` instead.
- Verify template changes by rendering before applying: standalone
  (`echo '{{ template "X" . }}' | chezmoi execute-template`), then the full
  entrypoint for both OS branches (native + `--override-data` override), then
  `bash -n` on each rendered script, then a scoped dry-run apply.
- Never run `chezmoi apply` for real against install scripts without dry-run
  verification first — `run_once_*` scripts execute real `brew
  install`/`apt install`/`snap install`/curl\|sh commands against the actual
  machine.
- Do not use `sudo` in any command you run yourself (the environment can't);
  it's fine for it to appear *inside* generated scripts that the user runs.
- Only commit when explicitly asked; this repo's git history should stay a
  clean, intentional record of dotfile/config changes.
