# count
Count all records in the input (total or categorized by variables/functions)


The overall record count is returned for all input files collectively.
Optionally, grouping categories (text or numeric) can be specified using
`-k/--key`. The tab-delimited output is sorted by the categories.


```
Usage: st count [OPTIONS] [INPUT]...

Options:
  -h, --help  Print help

'Count' command options:
  -k, --key <KEY>
          Count sequences for each unique value of the given category. Can be a
          single variable/function such as 'filename', 'desc' or 'attr(name)',
          or a composed key such as '{filename}_{meta(species)}'. The `-k/--key`
          argument can be specified multiple times, in which case there will be
          multiple category columns, one per key. Alternatively, a
          comma-delimited list of keys can be provided
  -l, --category-limit <CATEGORY_LIMIT>
          Maximum number of categories to count before aborting with an error.
          This limit is a safety measure to prevent memory exhaustion. A very
          large number of categories could unintentionally occur with a
          condinuous numeric key (e.g. `gc_percent`). These can be grouped into
          regular intervals using `bin(<variable>, <interval>)` [default:
          1000000]
```
[See this page](opts.md) for the options common to all commands.

## Counting the overall record number

By default, the count command returns the overall number of records in all
of the input (even if multiple files are provided):

```bash
st count *.fastq
```

```
10648515
```

## Categorized counting


Print record counts per input file:

```bash
st count -k path input.fasta input2.fasta input3.fasta
```

```
input.fasta   1224818
input2.fasta  573
input3.fasta  99186
```

If the record count should be listed for each file separately, use the `path` or `filename`
variable:

```bash
st count -k path *.fasta
```
```
file1.fasta    6470547
file2.fasta    24022
file3.fasta    1771678
```

To print the sequence length distribution:

```bash
st count -k seqlen input.fasta
```
```
102 1
105 2
106 3
(...)
```

### Multiple keys

It is possible to use multiple keys.
Consider an example similar to the [primer finding example](find.md#multiple-patterns),
but in addition we also store the number of primer mismatches (edit distance)
in the `diffs` header attribute.
After trimming, we can visualize the mismatch distribution for each primer:

```bash
st find file:primers.fasta -a primer='{pattern_name}' -a end='{match_end}' -a diffs='{match_diffs}' sequences.fasta |
    st trim -e '{attr(end)}:' > trimmed.fasta
st count -k 'attr(primer)' -k 'attr(diffs)' trimmed.fasta
```
```
primer1	0	249640
primer1	1	23831
primer1	2	2940
primer1	3	123
primer1	4	36
primer1	5	2
primer2	0	448703
primer2	1	60373
primer2	2	8996
primer2	3	691
primer2	4	34
primer2	5	7
primer2	6	1
undefined	undefined	5029
```

### Expressions as keys

Assuming that we need to trim both the forward *and* reverse primer from a FASTQ
file, we might categorize by the *sum* of the forward and reverse mismatches
using an [expression](expressions.md).

```bash
# first, search and trim
st find file:f_primers.fasta sequences.fastq \
     -a f_primer='{pattern_name}' -a f_end='{match_end}' -a f_diffs='{match_diffs}' |
  st find --fq file:r_primers.fasta \
     -a r_primer='{pattern_name}' -a r_start='{match_start}' -a r_diffs='{match_diffs}' |
  st trim --fq -e '{attr(f_end)}:{attr(r_start)}' > trimmed.fastq
# then count
st count -k 'attr(f_primer)' -k 'attr(r_primer)' -k 'attr(diffs)' \
  -k '{ num(attr("f_diffs")) + num(attr("r_diffs")) }' trimmed.fastq
```
```
f_primer1	r_primer1	0	3457490
f_primer1	r_primer1	1	491811
f_primer1	r_primer1	2	6374
f_primer1	r_primer1	3	420
f_primer1	r_primer1	4	10
(...)
```

> **A few important points**
>
> ⚠ [JavaScript expressions](expressions.md) always need to be enclosed in
> `{curly braces}`, while simple variables/functions only require this
>  [in some cases](variables.md#use-of-braces).
>
> ⚠ Attribute names need to be in double or single quotes: `attr("f_dist")`.
>
> ⚠ The `f_dist` and `r_dist` attributes are numeric, but *seqtool* doesn't know
> that (see [below](#numbers-stored-as-text)), and the JavaScript expression would simply
> [concatenate them as strings](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Language_overview#strings)
> instead of adding the numbers up. Therefore we require the `num` function
> for conversion to numeric.

## Numeric keys

With numeric keys, it is possible to summarize over intervals using the 
`bin(number, interval)` function. Example summarizing the GC content:

```bash
st count -k '{bin(gc_percent, 10)}' seqs.fasta
```
```
(10, 15]    2
(15, 20]    9
(20, 25]    357
(25, 30]    1397
(30, 35]    3438
(35, 40]    2080
(40, 45]    1212
(45, 50]    1424
(50, 55]    81
```

The intervals `(start,end]` are open at the start and
closed at the end, meaning that
`start <= value < end`.

### Numbers stored as text

In case of a header attribute `attr(name)` or a value from
an associated list `meta(column)`, these are always interpreted
as text by default, unless the `num(...)` function is used,
which makes sure that the categories are correctly sorted:

```bash
st count -k 'num(attr(numeric_attr))' input.fasta
```

## More

[This page](comparison.md#count) lists examples with execution times compared
to other tools.
