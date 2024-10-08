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
