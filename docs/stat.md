# stat
Return per-sequence statistics as tab delimited list

Sequence statistics variables (seqlen, exp_err, charcount(...), etc.)
are supplied as comma-delimited list, e.g. `id,seqlen,exp_err`.
The stat command is equivalent to `st pass --to-tsv 'id,var1,var2,...' input`

See `st stat -V/--help-vars` for a list of all possible variables.


```
Usage: st stat [OPTIONS] <VAR> [INPUT]...

Options:
  -h, --help  Print help

'Stat' command options:
  <VAR>  Comma delimited list of statistics variables
```
[See this page](opts.md) for the options common to all commands.

`st stat <variables>` is a shorter equivalent of `st pass --to-tsv id,<variables>`.

Example:

```bash
st stat seqlen,gc_percent seqs.fasta
```

Example output:

```
seq1	291	50.51546391752577
seq2	297	57.57575757575758
...
```
