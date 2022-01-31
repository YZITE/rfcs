# the packlist file format

In general, my packlist files generally look like the following:
```
Packlist Title
[  ] some item
[  ] another item
[  ] 3x item with multiplier
[X ] marked item

other metadata, may be recognized as a section title
[  ] more items
[. ] may also be marked
```

A packlist file *must* be encoded in UTF-8.

## interpretation of each line

The most general form of this interprets files as follows:
- each line may start with spaces
- then a line can be either uninterpreted (meta/comment) or an item
- if it is an item, it must then (after possible whitespace) contain the following characters:
  `[` [then any character] ` ]` (a single space and then a closing bracket).
  There may be multiple such markers. A way to represent it as a regex may be `(\[. \] *)+`.
- after that may be more whitespace
- then, a multiplier might be present, which is a bunch of ascii digits directly followed by `x`.
- then, item text, maybe preceded by more whitespace, might follow

Because all elemens of the line are optional, a good way to represent each line is as follows:
```rust
struct Line {
    // this does not store the ` ` before the closing bracket.
    markers: Vec<Spaced<char>>,
    multiplier: Option<Spaced<u32>>,
    text: String,
}

struct Spaced<T> {
    pub val: T,
    // white space *preceding* the value
    pub space: String,
}
```
In particular, in contrast to previous implementations, it stores preceding spaces instead of
succeeding spaces, and omits storing the always-space character before the closing bracket.

This does not take into account that multipliers shouldn't be present if we have no markers,
but parsing them always isn't that bad.

An important property of the structure is that it is almost lossless, that means that any UTF-8
text file can be deserialized into this structure, checked if the contents make sense as a packlist,
and serialized back, yielding exactly the same contents per line, only the line termination chars
(e.g. `\n` and `\r`) may change (e.g. the mangler may drop the `\r` characters).
