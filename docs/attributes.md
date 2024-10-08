# FASTA/FASTQ header attributes

Attributes are **key-value annotations** stored in the FASTA/FASTQ definition
line.

## In a nutshell

* *Adding* attributes: `-a/--attr` key='`{variables/functions...}`'
  or `-A/--attr-append` (multiple possible), results in headers like
  this: `>id description attribute=value`
* *Accessing* attributes: `attr(name)` or `opt_attr(name)` if some records
   have missing/`undefined` attributes.
  To simultaneously delete the accessed value, use `attr_del(name)` or `opt_attr_del(name)`
* To change the default format of recognized and inserted attributes, use
  `--attr-fmt` or the `ST_ATTR_FORMAT` environment variable.
  Example: `st count -k 'attr(abund)' --attr-fmt ';key=value'`.

> See also **[variable reference](var_reference.md/#header-attributes)**
> and detailed description of **[command-line options](opts.md)**

## Adding attributes to headers

Attributes are added in *any command* by using the `-a/--attr` option:

```bash
st pass --attr key=value input.fasta
# shorter:
st . -a key=value input.fasta
```

Output:

```
>id1 key=value
SEQUENCE
>id2 key=value
SEQUENCE
(...)
```

The `-a/--attr` can be used **multiple times**:

```bash
st . -a a=1 -a b=2 input.fasta
```

```
>id1 a=1 b=2
SEQUENCE
>id2 a=1 b=2
SEQUENCE
(...)
```

Attributes become useful when using **[variables/functions](variables.md)**:

```bash
st pass -a num='{num}' -a gc_content='{gc_percent}' input.fasta
```

```
>id1 num=1 gc_content=54.3046357615894
SEQUENCE
>id2 num=2 gc_content=42.019867549668874
SEQUENCE
(...)
```

### Performance optimization

In the standard worklow with `-a/--attr`, *seqtool* has to check if an attribute
with the same name is already present. To omit this check, use `-A/--attr-append`.
However, this comes with the risk of duplicating the attribute with the same name,
resulting in the appended new attribute being ignored when accessing with `attr(...)`
(see below).

The user thus needs to be sure that an attribute with the same name is not already present.

## Accessing attributes

Attributes in the sequence headers are accessed using the internal function `attr(name)` at any place where [variables/functions](variables.md) can be used, that is:

**In a multitude of commands**:

*[count](count.md)*, *[stat](stat.md)*, *[sort](sort.md)*, *[unique](unique.md)*, *[filter](filter.md)*, *[split](split.md)*, *[set](set.md)*, *[trim](trim.md)*, *[mask](mask.md)*, *[find](find.md)*, *[replace](replace.md)*. Examples assuming `attribute` in headers, e.g. `>id1 attribute=value1`

```bash
st sort 'attr(attribute)' seqs.fasta
st split seqs.fasta -o '{attr(attribute)}.fasta'  # -> value1.fasta, value2.fasta, etc.
st find PRRIMERSEQUENCE -a pos='{match_start}' seqs.fasta |   # e.g. >id1 pos=2
  st count -k 'attr(pos)'
```

**When setting new attributes**:

```bash
# seqs.fasta: >id1 key=value
st pass -a new_key='{attr(key)}_with_suffix' seqs.fasta
# output: >id1 key=value new_key=value_with_suffix
```

**In delimited text output:**

```bash
# seqs.fasta: >id1 key=value
st pass seqs.fasta --to-tsv 'id,attr(key)'
# id1   value
# id2   value2
# (...)
```

## Interacting with other software (different attribute formats)

Some programs use some form of `key=value` attributes in headers, too. For instance, [USEARCH](https://drive5.com/usearch/) and [VSEARCH](https://github.com/torognes/vsearch) indicate the size (number of sequences) of clusters like this:


```bash
usearch -cluster_fast seqs.fasta -id 0.97 -sizeout -centroids clusters.fasta
```
```
>seq_1;size=343;
SEQUENCE
(...)
```

In this case, the `size` attribute is appended to the sequence ID (without space) and preceded by a semicolon. In order to recognize the attribute, we need to set the format:


Extract cluster ids and sizes into a tab delimited output

```bash
st . --to-tsv 'id,attr(size)' --attr-fmt ";key=value" clusters.fasta
```
```
seq_1 	343
(...)
```

Instead writing `attr-fmt` in every command, we can also define the format as environment variable (assuming it does not change too often):

```bash
export ST_ATTR_FORMAT=";key=value"
st . --to-tsv 'id,attr(size)' clusters.fasta
# to override just once given headers like this: >id;size=5 another_attr=somevalue
st . --to-tsv 'id,attr(another_attr)' --attr-fmt ' key=value' clusters.fasta
```

## More complicated header annotations

Advanced patterns not following the simple `key=value` format can be parsed
and converted standard header annotations using the 
[`-r/--regex` search feature](find.md#searching-in-headers) of the *find* command.


## Missing/undefined attributes

Attributes should normally not be missing. In the following `seqs.fasta`,
the attribute `a` is missing in one record and `undefined` in another:

```
>id1 a=1
SEQUENCE
>id2
SEQUENCE
>id3 a=undefined
SEQUENCE
```

```bash
st count -k 'attr(a)' seqs.fasta
```

```
Attribute 'a' not found in record 'id2'. Use 'opt_attr()' if attributes may be missing in some records.
Set the correct attribute format with --attr-format.
```

Instead, use `opt_attr()` to avoid the error:

```bash
st count -k 'opt_attr(a)' seqs.fasta
```

```
1	1
undefined	2
```

> `undefined` is a special keyword that indicates missing data, so
> `id3` is treated as missing like `id2`

The `has_attr()` function is useful for filtering or other checks:


```bash
st filter 'has_attr(a)' seqs.fasta
```
```
>id1 a=1
SEQUENCE
```

## Deleting attributes

Attributes can be deleted using `attr_del()` and `opt_attr_del()`, if they should only serve for transient message passing between commands. In this case, the intermediate output has `pos=start:end` annotations in the headers:

```bash
st find SUBSEQ -a pos='{match_range}' seqs.fasta |
    st mask 'attr_del(pos)' > masked.fasta
```

Alternatively, use the [del](del.md) command:

```bash
st del --attrs attr1,attr2 seqs.fasta > clean.fasta
```
