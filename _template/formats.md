# Sequence formats and compression

All commands accept different formats and compressed input, and writing
to a different sequence and compression format is also possible.
The input and output formats are automatically inferred based on the file
extensions.

> **Note**: Currently, there is no auto-recognition of the formats

The following [pass](pass.md) command reads a GZIP compressed FASTQ file and
converts it to uncompressed FASTA.

```bash
st pass input.fastq.gz -o output.fasta
# or the equivalent shorthand:
st . input.fastq.gz -o output.fasta
```

If receiving from STDIN or writing to STDOUT, the format has to be
specified unless it is FASTA (which is the default):

```bash
wget -O - https://url/to/remote/seqs.fastq.gz | 
  st . --fmt fastq.gz --to fasta > output.fasta
```

The output format is always assumed to be the same as the input format
if not specified otherwise by using `--to <format>` or `-o <path>.<extension>`.

There also exist shorthand notations such as `--to-fa` (*shortcut* in table below).

## Recognized formats

The following extensions and format strings are auto-recognized:

sequence format      | recognized extensions | format string | shortcut (in) | ..out
-------------------- | --------------------- | ------------- | ------------- | ----------
FASTA                |  `.fasta`,`.fa`,`.fna`,`.fsa`| `fasta`,`fa`| `--fa`        | `--to-fa`
FASTQ                |  `.fastq`,`.fq`       | `fastq`,`fq`,`fq—illumina`,`fq—solexa`| `--fq`| `--to—fq`
CSV (`,` delimited)  |  `.csv`               | `csv`         | `--csv FIELDS`| `--to—csv FIELDS`
TSV (`tab` delimited)|  `.tsv`,`.tsv`        | `tsv`         | `--tsv FIELDS`| `--to—tsv FIELDS `

> **Note:** Multiline FASTA is parsed and written (`--wrap`), but only single-line
> FASTQ is parsed and written.

Besides FASTQ, quality scores can also be parsed from / written to 454 (Roche) style `QUAL`
files using `--qual <file>` and `--to-qual <file>`.

## Compression formats

No shortcuts are available for compression formats, therefore always use the
long form: `--fmt <input_format>` / `--to <output_format>`

format       | recognized extensions | format string (FASTA)
------------ | --------------------- | ---------------------
GZIP         |  `.gzip`,`.gz`        | `fasta.gz`
BZIP2        |  `.bzip2`,`.bz2`      | `fasta.bz2`
LZ4          |  `.lz4`               | `fasta.lz4`
ZSTD         |  `.zst`               | `fasta.zst`


## Delimited text (CSV, TSV, ...)

Comma / tab / ... delimited input and output can be configured providing the
`--fields` / `--outfields` argument, or directly using `--csv`/`--to-csv`
or `--tsv`/`--to-tsv`. The delimiter is configured with `--delim <delim>`

```bash
st . --outfields id,seq -o output.tsv input.fasta
```

equivalent shortcut:

```bash
st . --to-tsv id,seq > output.tsv
```

[Variables/functions](variables.md) can also be included:

```bash
st . --to-tsv "id,seq,length: {s:seqlen}" input.fasta
```

```
id1	ATGC(...)	length: 231
id2	TTGC(...)	length: 250
```

## Setting default format via environment variable

The `ST_FORMAT` environment variable can be used to set a default format other
than FASTA. This is especially useful if connecting many commands via pipe,
saving the need to specify `--fq` / `--tsv <fields>` / ... repeatedly. Example:

```bash
export ST_FORMAT=fastq

st trim :10 input.fastq | st revcomp > trimmed_revcomp.fastq
```

For delimited files (CSV or TSV), the input fields can be configured
additionally after a colon (`:`):

```bash
export ST_FORMAT=tsv:id,seq

## Input file:
# id1 ACGT...
# id2 ACGT...
# ...

st trim ':4' input.txt | st revcomp > trimmed_revcomp.txt

## Output:
# id1 ACGT...
# id2 ACGT...
#...
```

## Quality scores

Quality scores can be read from several sources.
[FASTQ](https://en.wikipedia.org/wiki/FASTQ_format) files are assumed to be
in the Sanger/Illumina 1.8+ format (ASCII offset of 33).
Older formats (Illumina 1.3+ and Solexa) with an offset of 64 can be
read and written using `--fmt/--to fq-illumina` or `fq-solexa`. Automatic
unambiguous recognition of the formats is not possible, therefore the formats have
to be explicitly specified. Invalid characters generate an error during conversion.

> **Note**: If no conversion is done (e.g. both input and output in
> Sanger/Illumina 1.8+ format), scores are *not automatically checked* for errors.

Quality scores can be visualized using the [view command](view.md).

The following example converts a legacy Illumina 1.3+ file to the
Sanger/Illumina 1.8+ format:

```bash
st . --fmt fq-illumina --to.fastq illumina_1_3.fastq > sanger.fastq
```

The [`exp_err` variable](var_reference.md#sequence-statistics)
uses the quality scores to calculate the total number of expected sequencing errors
(see [filter command](filter.md#quality-filtering)).
In order to correctly calculate the value of `exp_err` it is vital that the
format is correctly specified.

