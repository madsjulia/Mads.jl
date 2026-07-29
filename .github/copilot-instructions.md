# Repository coding instructions

Read and follow the repository-wide instructions in `AGENTS.md` before editing code, tests, scripts, examples, documentation, or configuration.

For Julia code, prefer explicit package imports with `import`.
Do not introduce `using` when `import` can provide the required names.
Qualify imported package names at call sites.
Preserve documented re-export and macro-loading exceptions.

Inspect the worktree before editing and preserve unrelated changes.
Respect the checked-in environment, public APIs, data formats, and generated-artifact boundaries.
Start with the narrowest relevant validation and report checks that were not run.
Use fixed random seeds for stochastic tests and examples.

Do not commit, push, publish, deploy, delete user data, or run destructive external operations unless explicitly requested.
Before completion, run `git diff --check` and `git status --short`.

