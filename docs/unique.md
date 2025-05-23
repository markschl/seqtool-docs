# unique
De-replicate by sequence and/or other properties, returning only unique records

The unique key can be 'seq' or any variable/function, expression, or
text containing them (see <KEY> help and `st unique --help-vars`).

The order of the records is the same as in the input unless the memory limit
is exceeded, in which case temporary files are used and all remaining records
are sorted by the unique key. Use `-s/--sorted` to always sort the output
by key.


```
Usage: st unique [OPTIONS] <KEY> [INPUT]...

Options:
  -h, --help  Print help (see more with '--help')

'Unique' command options:
  -s, --sort                 Sort the output by key. Without this option, the
                             records are in input order if the memory limit is
                             *not* exceeded, but are sorted by key otherwise
      --map-out <MAP_OUT>    Write a map of all duplicate sequence IDs to the
                             given file (or '-' for stdout). The (optional)
                             compression format is auto-recognized from the
                             extension. By default, a two-column mapping of
                             sequence ID -> unique reference record ID is
                             written (`long` format). More formats can be
                             selected with `--map_format`
      --map-fmt <MAP_FMT>    Column format for the duplicate map `--map-out`
                             (use `--help` for details) [default: long]
                             [possible values: long, long-star, wide,
                             wide-comma, wide-key]
  -M, --max-mem <SIZE>       Maximum amount of memory (approximate) to use for
                             de-duplicating. Either a plain number (bytes) a
                             number with unit (K, M, G, T) based on powers of 2
                             [default: 5G]
      --temp-dir <PATH>      Path to temporary directory (only if memory limit
                             is exceeded)
      --temp-file-limit <N>  Maximum number of temporary files allowed [default:
                             1000]
  <KEY>                      The key used to determine, which records are
                             unique. The key can be a single variable/function
                             such as 'seq', a composed string such as
                             '{attr(a)}_{attr(b)}', or a comma-delimited list of
                             multiple variables/functions, whose values are all
                             taken into account, e.g. 'seq,num(attr(a))'. In
                             case of identical sequences, records are still
                             de-replicated by the header attribute 'a'. The
                             'num()' function turns text values into numbers,
                             which can speed up the de-replication. For each
                             key, the *first* encountered record is returned,
                             and all remaining ones with the same key are
                             discarded
```
[See this page](opts.md) for the options common to all commands.

### More

[This page](comparison.md#unique) lists examples with execution times compared
to other tools.

## Variables/functions provided by the 'unique' command
> see also `st unique --help-vars`



| | |
|-|-|
| <a name="key"></a>key | The value of the unique key |
| <a name="n_duplicates"></a>n_duplicates<br />n_duplicates(include_self) | The `n_duplicates` variable retuns the total number of duplicate records sharing the same unique key. It can also be used as a function `n_duplicates(false)` to exclude the returned unique record from the count. `n_duplicates` is short for `n_duplicates(true)`. |
| <a name="duplicates_list"></a>duplicates_list<br />duplicates_list(include_self) | Returns a comma-delimited list of record IDs that share the same unique key. Make sure that the record IDs don't have commas in them. The ID of the returned unique record is included by default (`duplicate_list` is short for `duplicate_list(true)`) but can be excluded with `duplicate_list(false)`. |

### Examples
De-replicate sequences using the sequence hash (faster than using the sequence `seq` itself), and also storing the number of duplicates (including the unique sequence itself) in the sequence header:
```bash
st unique seqhash -a abund={n_duplicates} input.fasta > uniques.fasta
```
```
>id1 abund=3
TCTTTAATAACCTGATTAG
>id3 abund=1
GGAGGATCCGAGCG
(...)
```
Store the complete list of duplicate IDs in the sequence header:
```bash
st unique seqhash -a duplicates={duplicate_list} input.fasta > uniques.fasta
```
```
>id1 duplicates=id1,id2,id4
TCTTTAATAACCTGATTAG
>id3 duplicates=id3
GGAGGATCCGAGCG
(...)
```
