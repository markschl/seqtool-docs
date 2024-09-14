
## Examples

Removing sequences shorter than 100 bp:

```sh
st filter "seqlen >= 100" input.fasta > filtered.fasta
```

Removing DNA sequences with more than 10% of ambiguous bases:

```sh
st filter "charcount(ATGC) / seqlen >= 0.9" input.fasta > filtered.fasta
```

Quick and easy way to select certain sequences:

```sh
st filter "id == 'id1' " input.fasta > filtered.fasta

st filter "['id1', 'id2', 'id3'].contains(id)" input.fasta > filtered.fasta
```

> *Note*: this may not be the most efficient way, consider
> [a text file with an ID list](meta.md)


## Quality filtering

The [`exp_err` statistics variable](var_reference.md#sequence-statistics)
represents the total expected number of errors
in a sequence, as provided by the quality scores.
By default, the Sanger / Illumina 1.8+ format (offset 33) is assumed.
[See here](pass.md#quality-scores) for more information.

This example removes sequences with less than one expected error. The
output is the same as for `fastq_filter` if 
[USEARCH](https://www.drive5.com/usearch/manual/cmd_fastq_filter.html)
or [VSEARCH](https://github.com/torognes/vsearch).

```sh
st filter 'exp_err <= 1' input.fastq -o filtered.fasta
```

Normalization according to sequence length is easily possible with
a math formula (corresponding to `-fastq_maxee_rate` in USEARCH).

```sh
st filter 'exp_err / seqlen >= 0.002' input.fastq -o filtered.fasta
```

## More

[This page](comparison.md#filter) lists examples with execution times compared
to other tools.
