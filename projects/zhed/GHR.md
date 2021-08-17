# Reflection on GHR (ghrc/ghri)

- [metadata](#metadata)
- [record and declarative commands](#record-and-declarative-commands)

## metadata

This was the most well-defined part of the whole ghrc/ghri format.
Curly braces (`{}`) can be used to repeat the (leading) statement command
over multiple lines without retyping it multiple times.
This part is mostly taken from the existing documentation which was present in the
`ghr/revised/SYNTAX.md` file.

### `type SPEC EXT VERSION`

Every GHR file must begin with this line to be recognized as parsable.
Known typelines:
- `type ghr_rep ghrc 0.5`: recorded trace
- `type ghr_def_inc ghri 0.2`: includable/library file

### `use OBJECT`

This statement includes the stated OBJECT, which might be a relative path
(resolved relative to the current file), or resolved using the [standard library](#standard-library),
or an absolute path prefixed with `/`.

### `history SPEC_DATA`

This statement defines the transition state of this file along the schema type versions (GSTV).

Known flags: `rev`, `updt`.
Both are placed directly after `history`, and seem to receive GSTVs as arguments,
measuring the impact of the transformation.

### `future SPEC_DATA`

This statement defines parser and linter mod flags.

Known flags (but I have absolutely no idea anymore what they meant):
- `verify chk:3672 no:285 xp:3`
- `subgrammer allow <>`

### `spec SPEC_DATA`

This statement defines the trace starting position, both in space and in time.
This also implies that this statement is only legal in `ghr_rep` files.

### `declare SPEC_DATA`

This statement declares new global variables using `use`d objects, which were present
at the time when the trace was recorded.
This also implies that this statement is only legal in `ghr_rep` files.

## record and declarative commands

As most stuff was actually defined in included files, and that the format still was
relatively free-form makes it difficult to reason about what is actual the foundation
of the language (e.g. built into the language or maybe into the standard library).

A few things however are not easily definable in the language itself without large
amounts of rewriting on-the-fly.

`*` (outside of macro patterns) is used to "dereference" some stuff, but the semantics
are completely unclear.

### standard library

It can be concluded that the standard library seemed to at least contain the
following objects/files:
- `at`: type of somewhat relative locations
- `base`: type for context for a relative location / absolute location
- [`foreach`](#foreach)
- `ghr_copress`: I have absolutely no idea what this did anymore
- [`interp`](#interp)
- `position`: location resolver, bundles absolute, relative, and "near" locations
   to refer to an exact or approximate location
- `report`: mixin and implicit function, receiving a template and data as arguments,
   printing the instantiation/evaluation of it when executed.
- `si`: contains unit types, e.g. `meter`, `second`
- `sy`: contains base types, e.g. `container`, `double`, `int`, `string`, `meta_`
- `ty`: describing involved objects, semantics unclear

### `foreach`

`^(foreach ^a)(...)` iterates over the array `^a` (which could also represent an inline array
like `{ ^b ^c }`, etc.) and it gets basically replaced with the expansion of `...`, which
may contain references to array content using e.g. `$1` (representing the first element of an inner array)
or `$obj` (named reference to an element of a macro input repeating pattern)

### `interp`

These subcommands affect the parser and preprocessor, which makes them a bit difficult
to handle, and very powerful.

`interp match`, `interp eval rewrite`, `interp rewrite`, `interp grammer`
introduce [rewriting pattern]/macros, the differences between these commands are
mostly aesthetical and sometimes semantic, but they don't have much influence on
the expansion, or at least I don't remember any real difference.

`interp alias ... = ...` introduces an alias, which is basically like a macro
without any parameters.

`interp dyn` introduces injectable classes, which are basically just mixins.
They can also define global methods, which are dispatched dynamically.

`interp optimize` introduces (usually unnamed) macros, which usually reduces AST
elements to more mimimal or more effective forms.
