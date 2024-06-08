# revcomp
Reverse complements DNA or RNA sequences

The sequence type is automatically detected based on the first record,
unless the `--seqtype` option is used.

*Note*: Unknown letters are not reversed, but left unchanged.

If quality scores are present, their order is just reversed


```
Usage: st revcomp [OPTIONS] [INPUT]...

Options:
  -h, --help  Print help

'Revcomp' command options:
  -t, --threads <THREADS>  Number of threads to use [default: 1]
```
[See this page](opts.md) for the options common to all commands.
