# slice
Return a range of sequence records from the input

The range is specified as `start:end`, whereby start and end
are the sequence numbers (starting from 1). Open ranges are
possible, in the form `start:` or `:end`.

The following is equivalent with `st head input.fasta`:
`st slice ':10' input.fasta`

The following is equivalent with `st tail input.fasta`:
 `st slice '-10:' input.fasta`

The 'slice' command does not extract subsequences; see the
'trim' command for that.


```
Usage: st slice [OPTIONS] <FROM:TO> [INPUT]...

Options:
  -h, --help  Print help

'Slice' command options:
  <FROM:TO>  Range in form 'start:end' or ':end' or 'start:'
```
[See this page](opts.md) for the options common to all commands.
