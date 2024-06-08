**Seqtool** is a  fast and flexible command line program for dealing with
large amounts of biological sequences.
It provides different subcommands for *converting*, *inspecting* and *modifying*
sequences.
The standalone binary (~6 MB) is simply named `st` to save some typing.

> **Note:** this page describes the development version 0.4-beta.
> **The older stable version (v0.3.0) is [documented here](https://github.com/markschl/seqtool/wiki).**

> ⚠ Also note that **there are some bugs in v0.3.0**,
> see [CHANGELOG](https://github.com/markschl/seqtool/blob/main/CHANGELOG.md#important-bugfixes-).
> Alternatively, v0.4.0-beta should be pretty safe to use already.

**[📥 download stable release (v0.3.0)](https://github.com/markschl/seqtool/releases/latest)**

**[📥 download beta release (v0.4.0-beta)](https://github.com/markschl/seqtool/releases/tag/v0.4.0-beta.2)**

[![CI](https://github.com/markschl/seqtool/actions/workflows/ci.yaml/badge.svg)](https://github.com/markschl/seqtool/actions/workflows/ci.yaml)


## Feature overview

### File formats

[**Reads** and **writes**](pass.md) **FASTA, FASTQ** and **CSV/TSV**, optionally compressed
with [GZIP](https://en.wikipedia.org/wiki/Gzip), [BZIP2](https://en.wikipedia.org/wiki/Bzip2),
or the faster and more modern [Zstandard](http://facebook.github.io/zstd/) or [LZ4](https://lz4.org/)
formats

<details markdown>
<summary>
Example: compressed FASTQ to FASTA
</summary>

Combine multiple compressed FASTQ files, converting them to FASTA, using [pass](pass.md).

> **Note**: almost every command can read multiple input files and convert between formats,
> but *pass* does nothing other than reading and writing while other command perform certain actions.

```sh
st pass file1.fastq.gz file2.fastq.gz -o output.fasta
```

</details>

<details markdown>
<summary>
Example: FASTA to tab-separated list
</summary>

Aside from ID and sequence, any [variable/function](variables.md) such as
the sequence length (`seqlen`) can be written to  delimited text.

```sh
st pass input.fasta --to-tsv id,seq,seqlen
``` 

```
id1	ACG	3
id1	ACGTACGT	7
id1	ACGTA	5
``` 

</details>


### Commands for many different tasks

([see list below](#commands))

### Highly versatile

... thanks to **[variables/functions](variables.md)**

<details markdown>
<summary>
Example: count sequences in a large set of FASTQ files
</summary>

In [count](count.md), one or several categorical [variables/functions](variables.md)
can be specified with `-k/--key`.

```sh
st count -k path data/*.fastq.gz
```

```
data/sample1.fastq.gz	30601
data/sample2.fastq.gz	15702
data/sample3.fastq.gz	264965
data/sample4.fastq.gz	1120
data/sample5.fastq.gz	7021
(...)
```

</details>

<details markdown>
<summary>
Example: summarize the GC content in 10% intervals
</summary>

The function `bin(variable, interval)` groups continuous numeric values
into intervals

```sh
st count -k 'bin(gc_percent, 10)' sequences.fasta
```

```
(10, 20]	57
(20, 30]	2113
(30, 40]	11076
(40, 50]	7184
(50, 60]	12
```

</details>

<details markdown>
<summary>
Example: Assign new sequence IDs
</summary>

```sh
st set -i 'seq_{num}' seqs.fasta > renamed.fasta
```

```
>seq_1
SEQUENCE
>seq_2
SEQUENCE
>seq_3
SEQUENCE
(...)
```

</details>

<details markdown>
<summary>
Example: De-replicate by description and sequence
</summary>

`seqs.fasta` with a 'group' annotation in the header:

```
>id1 group1
SEQUENCE1
>id2 group1
SEQUENCE2
>id3 group1
SEQUENCE2
>id4 group2
SEQUENCE1
>id5 group2
SEQUENCE1
```

```sh
st unique 'desc,seq' seqs.fasta > grouped_uniques.fasta
```

```
>id1 group1
SEQUENCE1
>id2 group1
SEQUENCE2
>id4 group2
SEQUENCE1
```

</details>

### Expressions

From simple math to complicated filter [expressions](expressions.md), the tiny integrated JavaScript engine
([QuickJS](https://bellard.org/quickjs)) offers countless possibilities for customized
sequence processing.

<details markdown>
<summary>
Example: filter FASTQ sequences by quality and length
</summary>

This [filter](filter.md) command removes sequencing reads with more than one expected
sequencing error (like [USEARCH](https://www.drive5.com/usearch/manual/exp_errs.html) can do)
or sequence length of <100 bp.

```sh
st filter 'exp_err < 1 && seqlen >= 100' reads.fastq > filtered.fastq
```

</details>


### Header attributes

**`key=value` [header attributes](attributes.md)** allow storing and passing on
all kinds of information

<details markdown>
<summary>
Example: De-replicate by sequence (seq variable) and/or other properties  
</summary>

The [unique](unique.md) command returns all unique sequences and annotates
the number of records with the same sequence in the header:

```sh
st unique seq -a abund={n_duplicates} input.fasta > uniques.fasta
```

```
>id1 abund=3
TCTTTAATAACCTGATTAG
>id3 abund=1
GGAGGATCCGAGCG
(...)
```

It is also possible to de-replicate by multiple keys, e.g. by sequence,
but grouped by a `sample` attribute in the header:

```sh
st unique 'seq,attr(sample)' input.fasta > uniques.fasta
```

```
>id1 sample=1
SEQUENCE1
>id3 sample=2
SEQUENCE2
>id10 sample=1
SEQUENCE3
>id11 sample=3
SEQUENCE4
(...)
```

</details>

<details markdown>
<summary>
Example: pre-processing of mixed multi-marker amplicon sequences (primer trimming, grouping by amplicon)
</summary>

These steps could be part of an amplicon pipeline that de-multiplexes
multi-marker amplicons.
[find](find.md) searches for a set of primers, which are removed by [trim](trim.md),
and finally [split](split.md) distributes the sequences into different files named
by the forward primer.

`primers.fasta`

```
>prA
PRIMER
>prB
PRIMER
```

```sh
st find file:primers.fasta -a primer='{pattern_name}' -a end='{match_end}' sequences.fasta |
  st trim -e '{attr(end)}..' | 
  st split -o '{attr(primer)}'
```

<table>
<tr><th>prA.fasta </th><th>prB.fasta</th><th>undefined.fasta</th></tr>
<tr>
<td>

```
>id1 primer=prA end=22
SEQUENCE
>id4 primer=prA end=21
SEQUENCE
(...)
```

</td>
<td>

```
>id2 primer=prB end=20
SEQUENCE
>id3 primer=prB end=22
SEQUENCE
(...)
```

</td>
<td>

```
>id5 primer=undefined end=undefined
UNTRIMMEDSEQUENCE
(...)
```

*Note:* no primer, sequence **not** trimmed since `end=undefined` (see [ranges](ranges.md)).

</td>
</tr>
</table>

</details>


### Metadata integration

Integration of [**sequence metadata sources**](meta.md) in the form of delimited text

<details markdown>
<summary>
Example: Add Genus names from a separate tab-separated list
</summary>

<table>
<tr><th>input.fasta</th><th>genus.tsv</th></tr>
<tr>
<td>

```
>id1
SEQUENCE
>id2
SEQUENCE
(...)
```

</td>
<td>

```
id  genus
seq1  Actinomyces
seq2  Amycolatopsis
(...)
```

</td>
</tr>
</table>

Using `-m/--meta` to include `genus.tsv` as metadata source:

```sh
st set -m genus.tsv --desc '{meta(genus)}' input.fasta > with_genus.fasta
```

<table>
<tr><th>with_genus.fasta</th></tr>
<tr>
<td>

```
>seq1 Actinomyces
SEQUENCE
>seq2 Amycolatopsis
SEQUENCE
(...)
```

</td>
</tr>
</table>
</details>

<details markdown>
<summary>
Example: Choose specific sequences given a separate file with an ID list
</summary>

<table>
<tr><th>input.fasta</th><th>id_list.txt</th></tr>
<tr>
<td>

```
>id1
SEQUENCE
>id2
SEQUENCE
>id3
SEQUENCE
>id4
SEQUENCE
```

</td>
<td>

```
id1
id4
```

</td>
</tr>
</table>


```sh
st filter -m id_list.txt 'has_meta()' input.fasta > subset.fasta
```

<table>
<tr><th>subset.fasta</th></tr>
<tr>
<td>

```
>id1
SEQUENCE
>id4
SEQUENCE
```

</td>
</tr>
</table>
</details>
