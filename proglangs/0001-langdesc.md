# Language Description

## Description Layout

```
name of language terminal:
  description of terminal
    syntax description of terminal
```

## Syntax Description

```
    $name     this describes a required placeholder
    'x'       this represents exactly this string / character in source code
              (between single-quotes)
    ~         this describes that tokens aren't separated by spaces

    $name?    this describes an optional placeholder
    $name*    this describes zero-or-more placeholders
    $name+    this describes  one-or-more placeholders
    $name(X)  this describes a required placeholder with a specified non-terminal
```

## Example (taken from 0002)

```
function call:
  call function beginning at label, the different handling of syntax for
  "no arguments" is needed to distinguish between call ($label) and expand ($variable)

    $label '(' $arguments? ')'
```
