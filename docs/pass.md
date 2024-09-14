# pass
Directly pass input to output without any processing, useful for converting and
attribute setting

```
Usage: st pass [OPTIONS] [INPUT]...

Options:
  -h, --help  Print help
```
[See this page](opts.md) for the options common to all commands.
The `pass` command does nothing to the sequence records, it just passes them
directly to the output. Still, this is an useful command for the following:

* [Format conversion](formats.md)
* Editing [header attributes](attributes.md)

## Examples

### Convert GZIP-compressed FASTQ to FASTA:

```bash
st pass input.fastq.gz -o output.fasta
```

equivalent, shorter notation:

```bash
st . input.fastq.gz -o output.fasta
```

## More

[This page](comparison.md#pass) lists examples with execution times compared
to other tools.
