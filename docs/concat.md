# concat
Concatenates sequences/alignments from different files

The sequence IDs must be in the same order in all files;
Fails if the IDs don't match.


```
Usage: st concat [OPTIONS] [INPUT]...

Options:
  -h, --help  Print help

'Concat' command options:
  -n, --no-id-check      Don't check if the IDs of the records from the
                         different files match
  -s, --spacer <SPACER>  Add a spacer of <N> characters inbetween the
                         concatenated sequences
  -c, --s-char <S_CHAR>  Character to use as spacer for sequences [default: N]
  -Q, --q-char <Q_CHAR>  Character to use as spacer for qualities. Defaults to a
                         phred score of 41 (Illumina 1.8+/Phred+33 encoding,
                         which is the default assumed encoding) [default: J]
```
[See this page](opts.md) for the options common to all commands.
## More

[This page](comparison.md#concat) lists examples with execution times compared
to other tools.
