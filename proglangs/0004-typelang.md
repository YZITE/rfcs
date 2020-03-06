# YZITE Type Language

Category: Conceptual, Meta

## Motivation

Develop a description which provides a language to explain [0001-types](../libs/0001-types.md).

## Syntax

```
identifier (ID):
  $name must be alpha-numeric, but can't start with a number.
    $name

XID:
    $ident(INT | ID)

level definition:
  both $name and $id must be unique. hierarchy starts at highest id.
    "level" $name(ID) = $id(INT) ";"

data definition:
  both $name and $id must be unique. $level must be a valid, defined level identifier.
  if the level is followed by an "+", the definition lives at two levels, with the lower level given.
  if $derive_from is given, it must $derive_from must have at least one level equal to $level+1.
    "data" $name(ID) ("|" $alias(ID))* ("=" $id(INT))? ":" $level(XID) ("+")? ("=" $expr ";" | "<-" $derive_from(XID) ";" | ":" ("(" $args ")")? $block)

implementation:
    "impl" ($extra(XID) ("(" $xargs ")")?  "for")? $name(XID) ("(" $args ")")? $block
```

## Example

```
level value = 0;
level type = 1;
level kind = 2;

data std_kind = 0: kind;
data trait | interface = 1: kind;
data prototype = 1: type <- std_kind;
data integer: type <- std_kind;
data null_i: value <- integer;

data Hello: trait {
    fn hello();
}

data sht: type {
}

impl Hello for sht {
    fn hello() {
        "Hello"
    }
}
```
