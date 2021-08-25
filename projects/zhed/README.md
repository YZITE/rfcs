# zhed / high-level data management

- [Influences](#influences)
- [Paradigm change](#paradigm-change)
- [Goals](#goals)
- [Navigation](#navigation)
- [Reflection on ZEIK#](#reflection-on-zeik)
- [References](#references)

## Influences

The new data format was influenced by:
- `ghrc` ([GHR](./GHR.md) record format);
  Sadly, we can't really parse this format even though really few files which use it
  exist, because it is too diverse and complex...
- [`ztx`](./ZTX.md) (structured text format)
- `zxi` (index and link format);
  similar to ztx, but without most of the non-metadata

and a bunch of other formats, databases and esoteric programming languages I
have dealt with in the past.

## Paradigm change

Previously, I would focus solely on a text format with annotations.
Albeit being useful, it doesn't allow the level of type checking
and schema enforcement necessary to process such data on a larger scale.

An additional conclusion of previous efforts was to stop worrying about coming up
with a perfect format. Instead, the focus shifted to formats which were parsable,
and should be transformable once necessary.

Another focus which is established is the introduction of glue code and glue metadata
when transformation is not straight-forward.

## Goals

This project aims to provide 4 things:
- a linker, which gets a list of files as input and bundles them together
- a linter/validator, which checks files for consistency, both internally, and between multiple files
- an optimizer, which prunes unnecessary data from files (this could run as implicit passes)
- an editor, which integrates
  - the validator (to avoid saving corrupted files, overwriting the previous working one)
  - the linker + optimizer (automatically update generated files or statistics)

## Navigation

it should be possible to seamlessly move from one object to another via a chain of links,
maintaining multiple of them and bundling them together in a workspace.

## Reflection on ZEIK#

Don't force every variable to have the same underlying type.
In `ZEIK#` I made the mistake that every variable had the type "array of strings".
This meant that handles, which were basically the plugin system of the language,
had to use an entirely separate namespace for variables and somewhat unrelated
semantics, which made them an unnatural extension mechanism, it didn't fit well.
It basically ruined the extensibility of the language.
Additionally, I should put more effort into designing a scalable type system, which
I avoided in the past, but which hinders the ability to lint code and reason about
it without executing it.

## References

In `ztx`/`zxi`, `.link` and `.ref` were used for basically the same purpose,
although `.ref` was considered to be weaker than `.link`.
The keyword `extern` was used to mark references to documents outside of the
workspace. This was not completely consistent, sometimes links marked as non-extern
refered to worksheets, which although owned, are strictly still extern.

We don't need to store any `extern` or `owned` relationship because
it is only relevant if we can modify a document, or we can't.
If we can infact modify a document, storing that fact is useless.
If we can't, the same applies.
If we think we know that we can modify a document, we need to check that anyways.
Thus, we don't store that.

To make breaking references much harder, all references to internal objects
are done via UUIDs.
Maybe we also want `biber` support.
Often, is was possible to associate arbitrary key-value data to references
(often used for authors, which belong to the index, and for page data,
which requires nested indices).
We need a hierarchy of references to represent these properly.

## Reference date

Originally, I planned on saving a `reference_date` in each document which
specifically referenced a single date, like diary entries. But I managed
to implement a parser which extracts that information from my usual path
format, which encodes that, so I got rid of that.
