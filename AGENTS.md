# Agent Guidance

## Scope

These instructions apply to the entire Mads repository.

Follow more specific instructions if a nested `AGENTS.md` is added later.

## Julia style

- Use explicit package imports such as `import Dates`.
- Do not use `using`.
- Add explicit types to variables, arguments, and return values.
- Avoid introducing `try`/`catch` statements.
- Prefer small functions with explicit inputs and outputs over implicit global state.
- Preserve existing public APIs unless an API change is explicitly requested.
- Follow the repository formatting rules in `.JuliaFormatter.toml`.
- Do not perform unrelated formatting or mechanical rewrites.

## Julia environment

Use Julia 1.11 unless a task explicitly targets another version.

Run Julia without user startup-file customizations:

```powershell
julia +1.11 --startup-file=no --project=.
```

Respect the checked-in `Project.toml` and `Manifest.toml`.

Do not replace sibling development packages with registry versions merely to
make dependency resolution easier.

## Repository layout

- `src/` contains the active Mads implementation.
- `test/` contains package tests.
- `examples/` contains example-specific workflows and tests.
- `docs/src/` contains documentation sources.
- `scripts/` and `scripts-git/` contain operational utilities.
- `src-old/` and `deps_old/` are legacy directories.
- `html/` and `work/` may contain generated or temporary outputs.

Do not edit legacy, generated, or temporary directories unless the task
explicitly places them in scope.

## Testing

Start with the narrowest test that covers the change.

For a focused Mads test:

```powershell
julia +1.11 --startup-file=no --project=. -e 'import Mads; Mads.test("test_name"; madstest=false, plotting=false)'
```

For the complete package test suite:

```powershell
julia +1.11 --startup-file=no --project=. -e 'import Pkg; Pkg.test()'
```

The complete suite runs many example workflows and may be expensive.

Plotting, optimization, distributed execution, and external executables can
make some tests environment-sensitive.

When a failure is environmental, isolate and report it separately from a
source-code regression.

## Documentation

Update `docs/src/` when public behavior changes.

Keep examples consistent with the actual public API.

Do not manually edit generated documentation under `html/`.

Break Markdown prose into one sentence per line when practical so text changes
remain easy to review in Git.

## Compatibility and safety

Preserve existing Mads input dictionaries, problem files, output formats, and
restart behavior unless a migration is explicitly requested.

Do not delete or overwrite user data, result directories, or example outputs
without explicit authorization.

Keep changes narrowly scoped and inspect the worktree before editing.

After changes, run:

```powershell
git diff --check
git status --short
```
