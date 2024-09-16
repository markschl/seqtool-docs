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
