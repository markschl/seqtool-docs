# filter
Keep/exclude sequences based on different properties with a mathematical
(JavaScript) expression

```
Usage: st filter [OPTIONS] <EXPRESSION> [INPUT]...

Options:
  -h, --help  Print help

'Filter' command options:
  -d, --dropped <FILE>  Output file for sequences that were removed by
                        filtering. The output format is (currently) the same as
                        for the main output, regardless of the file extension
  <EXPRESSION>      Filter expression
```
[See this page](opts.md) for the options common to all commands.


## Examples

Removing sequences shorter than 100 bp:

```bash
st filter "seqlen >= 100" input.fasta > filtered.fasta
```

Removing DNA sequences with more than 10% of ambiguous bases:

```bash
st filter "charcount(ACGT) / seqlen >= 0.9" input.fasta > filtered.fasta
```

Quick and easy way to select certain sequences:

```bash
st filter "id == 'id1' " input.fasta > filtered.fasta

st filter "['id1', 'id2', 'id3'].contains(id)" input.fasta > filtered.fasta
```

> *Note*: this may not be the most efficient way, consider
> [a text file with an ID list](meta.md)


## Quality filtering

The [`exp_err` statistics variable](var_reference.md#sequence-statistics)
represents the total expected number of errors
in a sequence, as provided by the quality scores.
By default,
the [Sanger / Illumina 1.8+ format](https://en.wikipedia.org/wiki/FASTQ_format#Encoding)
(with ASCII offset 33) is assumed.
[See here](formats.md#quality-scores) for more information.

This example removes sequences with less than one expected error. The
output is the same as for `fastq_filter` if 
[USEARCH](https://www.drive5.com/usearch/manual/cmd_fastq_filter.html)
or [VSEARCH](https://github.com/torognes/vsearch).

```bash
st filter 'exp_err <= 1' input.fastq -o filtered.fasta
```

Normalization according to sequence length is easily possible with
a math formula (corresponding to `-fastq_maxee_rate` in USEARCH).

```bash
st filter 'exp_err / seqlen >= 0.002' input.fastq -o filtered.fasta
```

## More

[This page](comparison.md#filter) lists examples with execution times compared
to other tools.
