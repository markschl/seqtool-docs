# mask
Soft or hard mask sequence ranges

Masks the sequence within a given range or comma delimited list of ranges
by converting to lowercase (soft mask) or replacing with a character (hard
masking). Reverting soft masking is also possible.


```
Usage: st mask [OPTIONS] <RANGES> [INPUT]...

Options:
  -h, --help  Print help

'Mask' command options:
      --hard <CHAR>  Do hard masking instead of soft masking, replacing
                     everything in the range(s) with the given character
      --unmask       Unmask (convert to uppercase instead of lowercase)
  -e, --exclusive    Exclusive range: excludes start and end positions from the
                     masked sequence. In the case of unbounded ranges (`start:`
                     or `:end`), the range still extends to the complete end or
                     the start of the sequence
  -0, --zero-based   Interpret range as 0-based, with the end not included
  <RANGES>           Range in the form 'start:end' or 'start:' or ':end', The
                     range start/end may be defined by varialbes/functions, or
                     the varialbe/function may contain a whole range
```
[See this page](opts.md) for the options common to all commands.

A comma delimited list of ranges can be supplied, which may contain
variables, or the [whole range may be a variable](find.md#variablesfunctions-provided-by-the-find-command).

Masking ranges always include the start and end coordinates unless `-0` is
specified.
Coordinates can be negative to indicate an offset from the end.
See [explanation of ranges](ranges.md) for more details.

## Example

In this example, we search all occurrences of a pattern using a regular expression
with the [find command](find.md) and store them as comma-delimited list using
[match_range(all)](find.md#match_range):

```bash
st find -r -a rng='{match_range(all)}' '[AG]GA' input.fasta \
  | st mask 'attr(rng)'
```

Possible output:

```
>seq1 rng=6:8,14:16
AGTTAagaCTTAAggaT
(...)
```
