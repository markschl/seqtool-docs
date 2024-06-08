# tail
Return the last N sequences

This only works for files (not STDIN), since records are counted in a first
step, and only returned after reading a second time.


```
Usage: st tail [OPTIONS] [INPUT]...

Options:
  -h, --help  Print help

'Tail' command options:
  -n, --num-seqs <N>  Number of sequences to return [default: 10]
```
[See this page](opts.md) for the options common to all commands.
