# Metadata from delimited files

In all *seqtool* commands, it is possible to integrate external metadata
from delimited text files created manually or using another program.

Files are specified using the `-m/--meta` option and accessed using the [functions](variables.md)
`meta(column)`,  `opt_meta(column)` (with missing data) or `has_meta(column)`
(to check if the metadata is present).
*Column* is either a number or the header name of the given column.

> See also **[variable reference](var_reference.md/#access-metadata-from-delimited-text-files)**
> and detailed description of **[command-line options](opts.md)**

By default, files are assumed to be **tab-delimited**, and the
**first column should contain the ID**.
However, this can be changed with `--meta-delim` and `--id-col`.

## Examples

Consider this list containing taxonomic information about sequences (*genus.tsv*):

```
id  genus
seq1  Actinomyces
seq2  Amycolatopsis
(...)
```

The genus name can be added to the FASTA header using this command:

```bash
st set --meta genus.tsv --desc '{meta(genus)}' input.fasta > with_genus.fasta
# short:
st set -m genus.tsv -d '{meta(genus)}' input.fasta > with_genus.fasta
```

```
>seq1 Actinomyces
SEQUENCE
>seq2 Amycolatopsis
SEQUENCE
(...)
```

If any of the sequence IDs is not found in the metadata, there will be an error.
If missing data is expected, use `opt_meta` instead.
Missing entries are `undefined`:

```bash
st set -m genus.tsv --desc '{opt_meta(genus)}' input.fasta > with_genus.fasta
```

```
>seq1 Actinomyces
SEQUENCE
>seq2 Amycolatopsis
SEQUENCE
>seq3 undefined
SEQUENCE
(...)
```

### Filtering by ID

Sometimes it is necessary to select all sequence records present in a list of
sequence IDs. This can easily be achieved using this command:

```bash
st filter -m id_list.txt 'has_meta()' seqs.fasta > in_list.fasta
```

### Multiple metadata sources

Several sources can be simultaneously used in the same command with
`-m file1 -m file2 -m file3...`:

```bash
st filter -m source1.txt -m source2.txt 'meta("column", 1) == "value" && has_meta(2)' seqs.fasta > in_list.fasta
```

> Sources are referenced using `meta(column, file_number)` or `has_meta(file_number)`;
> see also **[variable reference](var_reference.md/#access-metadata-from-delimited-text-files)**
