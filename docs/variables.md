# Variables/functions

*Seqtool* offers many variables/functions providing information about
the sequence records or the results of some commands.


## Types of variables/functions

The following variable categories are provided:

* [General properties of sequence records](var_reference.md#general-properties-of-sequence-records-and-input-files):
  sequence header ([`id`](var_reference.md#id), [`desc`](var_reference.md#desc)),
  the sequence ([`seq`](var_reference.md#seq), [`upper_seq`](var_reference.md#upper_seq), ...),
  input file names/paths ([`filename`](var_reference.md#filename), [`path`](var_reference.md#path),
  ...), etc.
* [Sequence statistics](var_reference.md#sequence-statistics)
   such as the GC content ([`gc_percent`](var_reference.md#gc_percent)), etc.
* [Access to *key=value* attributes](var_reference.md#header-attributes)
  in sequence headers ([`attr(name)`](var_reference.md#attr), ...).
  More on attributes [here](attributes.md).
* Integration of 
  [metadata from delimited text files](var_reference.md#access-metadata-from-delimited-text-files)
  ([`meta(field)`](var_reference.md#meta), ...). More on metadata [here](meta.md).
* Some commands provide the results of some calculations in the form of variables/functions
  ([find](find.md#variablesfunctions-provided-by-the-find-command),
  [unique](unique.md#variablesfunctions-provided-by-the-unique-command),
  [sort](sort.md#variables-provided-by-the-sort-command),
  [split](split.md#variables-available-in-the-split-command))


## Complete reference

**[👉 Full reference](var_reference.md)** of variables/functions provided
by all commands (see command documentation for those provided by individual commands).


## Use in *seqtool* commands

Variables/functions are usually written in curly braces: `{variable}`, although
this is optional in some cases ([see below](#use-of-braces)).

### Simple example

The following command recodes IDs to `seq_1`, `seq_2`, `seq_3` etc.
using the [num](var_reference.md#num) variable:

```bash
st set -i seq_{num} seqs.fasta > renamed.fasta
```

### Grouping / categorization

The **[sort](sort.md)**, **[unique](unique.md)** and **[count](count.md)**
commands use variables/functions for grouping/categorization.

The keys can be single variable/function ([without braces](#use-of-braces)) or
composed of text with multiple variables/functions, e.g.: `{id}_{desc}`
([braces required](#use-of-braces)).

The following command sorts sequences by length:

```bash
st sort seqlen input.fasta > length_sorted.fasta
```


### Setting/editing header attributes

Variables/functions are needed for composing [header attributes](attributes.md)
(`-a/--attr` argument):

```bash
st find PATTERN input.fasta -a rng='{match_range}' > with_range.fasta
```

```
>id1 rng=3:10
SEQUENCE
>id2 rng=5:12
SEQUENCE
(...)
```


### Ranges (trim/mask)

The **[trim](trim.md)** and **[mask](mask.md)** commands accept ranges
or even lists of ranges in the form of variables.

In this command, we trim the sequence using start and end coordinates stored
in separate attributes:

```
>id1 start=3 end=10
SEQUENCE
(...)
```

```bash
st trim -e 'attr(start):attr(end)' input.fasta > trimmed.fasta
```

Or, we just use the range stored as a whole in the sequence header
([above example](#settingediting-header-attributes)).

```bash
st trim -e 'attr(rng)' input.fasta > trimmed.fasta
```

The handling *multiple* ranges is documented in a [sequence masking example](mask.md#example).


## Delimited text output

Variables/functions are also used to define the content of [delimited text files](formats.md#delimited-text-csv-tsv-).

This example searches a sequence ID prefix (everything before a dot `.`)
using a regular expression, and returns the matched text as TSV:

```bash
st find -ir '[^.]+' seqs.fasta --to-tsv 'id,match,seq' > out.tsv
```

`out.tsv`

```
seq1.suffix123	seq1	SEQUENCE`
seq2.suffix_abc	seq2	SEQUENCE`
...
```

> As with [sort/unique/count keys](#grouping--categorization),
> `{braces}` are not needed, unless a field is composed
> mixed text and/or other variables ([more details below](#use-of-braces))

### Expressions

[Expressions](expressions.md) can be used *everywhere* where variables/functions
are allowed. They must *always* be written in `{braces}`
(exception: [filter expressions](filter.md)).

Example: calculating the fraction of ambiguous bases for each sequence:

```bash
st stat '{ 1 - charcount("ATGC")/seqlen }'
```

```
id1	1
id2	0.99
id3	0.95
id4	1
...
```

## Use of braces

The braced `{variable}` notation is *always* necessary...

* when setting/composing [attributes](attributes.md) with `-a/--attr key=value`
* if variables/functions are *mixed with plain text* and/or other other variables
* in [set](set.md), output paths in [split](split.md), text replacements in [find](find.md) (`--repl`)
* with JavaScript [expressions](expressions.md)

The braces *can optionally* be omitted if only a *single* variable/function
is used as...

* [sort](sort.md), [unique](unique.md) and [count](count.md) key, e.g.: `st sort seq input.fasta`
* range bound in [trim](trim.md), [mask](mask.md), e.g.: `st trim 'attr(start):' input.fasta`
* delimited text field, e.g.: `st pass input.fasta --to-tsv id,desc,seq`
