# Agent guidance

## Scope

These instructions apply to the Mads-gh-pages repository.

## Generated-site policy

This repository contains generated and versioned Mads documentation.
Treat `dev/`, `stable/`, `v1/`, version-number directories, HTML files,
JavaScript indices, and symlinks as deployment artifacts.

Do not manually edit generated documentation to change Mads behavior or prose.
Make documentation-source changes in the Mads repository and regenerate the
site through its documented deployment workflow.

Only modify this repository when the task explicitly concerns documentation
deployment metadata, version aliases, or repair of a generated publication.
Do not delete historical versions or change stable-version targets without
explicit authorization.

If Julia helper code is introduced, use explicit `import` statements rather
than `using`.

## Validation

Check affected links, version aliases, and the generated site locally when
possible.
Inspect the complete diff for accidental regeneration of unrelated versions.

Before completion, run:

```powershell
git diff --check
git status --short
```

Do not commit, push, publish, or deploy unless explicitly requested.
