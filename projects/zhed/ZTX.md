# Reflection on markup commands (of ztx/zxi)

Top-level commands were used to associate stuff and to influence layout.
Non-top-level commands were used to associate stuff inline.

`#` (varying count) was used similiar to Markdown, it denotes section headers including
the indention level. Sections should instead be represented via AST nesting instead.
Another feature taken from Markdown were nested enumerations, etc...

`.alias` was used for specifying shorthands of names. This shouldn't be necessary as-is,
it can be replaced with mappings, which are a more centralised way of doing that.
It is unrealistic to differentiate strongly between known symbols and misc text.
Other commands which also introduced mappings were `.lcl_def{}` and `\map()`.
They also served as index-table representations.

`.alt` was used once, as a reference to an alternative representation, similiar to
`<link rel="alternative" />` in HTML.

`.ctx` was used to specify a time-location context at a specific point in the text.

`.ex` was used to mark examples.

`.EOT` was used to terminate a flow of information which denoted a table.

`\lang=` was used to specify a language in use, while `.Sprache` was used to
specify specific attributes of language usage.

`.log` was used for emphasis and probably also create a reference.

`.mode` was used for specifying record formats.

`.oneof{}={}` was used once, the correct meaning is not completely recoverable.
Maybe it meant "one of the selected objects", but it also associated an alias. hmmm.

`\opposite` was used once in a `.lcl_def` definition, to specify an alternative format.
It seemed to denote oppositional pairs.

`.self=` was used once to specify an ordered list in a compact way. Obviously obsolete.

`´split` was used to specify and escape from the current block of information,
probably similiar to `<hr />` in HTML. Such escape commands were highlighted.

`.tabular` was used once to specfiy a table of commands. It becomes clear that the
denotation of different tables was widely inconsistent.

`\tag` was used for referencing known symbols (like time spans).

`.tag` was used for referencing figures of speech.

`.title` was used to specify the title of a document.

`-->` was used to represent reasonings, inferences and consequences.

`(`, `)` were sometimes used to denote alternative or more thorough explanations
or detailed names of things. At other places they were used to denote context restriction.

We need a way to represent holes, e.g. `...`.
