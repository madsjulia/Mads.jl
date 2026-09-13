# DocumentFunction.jl

DocumentFunction.jl extracts source-faithful metadata and helps authors create and maintain ordinary Julia docstrings.
It complements [Documenter.jl](https://documenter.juliadocs.org), which renders and deploys those docstrings as this website.

For new documentation work, `scanfunctions` inspects Julia source without loading the target package and preserves positional arguments, keywords, types, defaults, required keywords, varargs, return annotations, visibility, and source spans.
`draftdocumentation` combines those facts with reviewed descriptions and marks unsupported descriptions as explicit `TODO` items instead of inventing behavior.
`checkdocs` provides deterministic offline checks for missing, incomplete, untracked, or stale documentation, while `verifyexamples` runs complete examples twice in fresh Julia processes before they are promoted as verified.

The original `documentfunction`, `getfunctionmethods`, `getfunctionarguments`, and `getfunctionkeywords` APIs remain available for compatibility with Mads' existing generated docstrings.
New or substantially revised docstrings should use source scanning and reviewable static drafts so Julia help mode and Documenter consume the same source-controlled text.

DocumentFunction.jl module functions:

```@autodocs
Modules = [DocumentFunction]
Order   = [:function, :macro, :type]
```
