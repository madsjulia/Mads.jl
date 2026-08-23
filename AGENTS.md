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

## Architecture and dependency boundaries

`src/Mads.jl` is the composition root.
Keep problem parsing and serialized input semantics in the `MadsIO`, `MadsYAML`, `MadsJSON`, `MadsParameters`, and `MadsObservations` layers.
Keep external-model execution, working-directory behavior, restart handling, and command construction in `MadsForward`, `MadsExecute`, and `MadsSimulators` rather than embedding them in analysis algorithms.
Calibration, minimization, sensitivity, model-selection, Monte Carlo, and information-gap code consume those problem and execution contracts; they must not reinterpret parameter bounds, observation weights, or restart state independently.

Mads is intentionally usable in headless and reduced-feature environments.
Preserve the `MADS_NO_PLOT`, `MADS_NO_GADFLY`, and `MADS_NO_DISPLAY` gates, and do not make core parsing, execution, or analysis depend on a plotting backend.
Treat `SVR` and the other solver packages in `Project.toml` as coordinated public dependencies; review downstream compatibility and the checked-in manifest whenever their compat ranges change.

## Test and artifact boundaries

Use the focused files under `test/` for changes to coordinates, problem creation, filenames, I/O, observations, or parameters.
The root `test/runtests.jl` also discovers and runs example `runtests.jl` files, so a full suite is an integration and example-workflow run rather than only a unit suite.
External executables, distributed workers, optimization solvers, display backends, and long examples must be reported as separate environmental boundaries when unavailable.

Treat problem files, restart directories, calibration results, model outputs, and example result trees as user-owned scientific artifacts.
Documentation sources live under `docs/src/`; `html/`, generated figures, notebook outputs, and files under `work/` are derived artifacts and must not be hand-edited or refreshed incidentally.
When an artifact must be regenerated, use its owning example or documentation command and review the scientific and serialized diff separately from source changes.
