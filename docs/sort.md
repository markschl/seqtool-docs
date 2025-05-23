# sort
Sort records by sequence or any other criterion

The sort key can be 'seq', 'id', or any variable/function, expression, or
text containing them (see <KEY> help and `st sort --help-vars`).

Records with identical keys are kept in input order.

The actual value of the key is available through the 'key' variable. It can
be written to a header attribute or TSV field.


```
Usage: st sort [OPTIONS] <KEY> [INPUT]...

Options:
  -h, --help  Print help (see more with '--help')

'Sort' command options:
  -r, --reverse              Sort in reverse order
  -M, --max-mem <SIZE>       Maximum amount of memory (approximate) to use for
                             sorting. Either a plain number (bytes) a number
                             with unit (K, M, G, T) based on powers of 2
                             [default: 5G]
      --temp-dir <PATH>      Path to temporary directory (only if memory limit
                             is exceeded)
      --temp-file-limit <N>  Maximum number of temporary files allowed [default:
                             1000]
  <KEY>                      The key used to sort the records. It can be a
                             single variable/function such as 'seq', 'id', a
                             composed string, e.g. '{id}_{desc}', or a
                             comma-delimited list of multiple
                             variables/functions to sort by, e.g. 'seq,attr(a)'.
                             In this case, the records are first sorted by
                             sequence, but in case of identical sequences,
                             records are sorted by the header attribute 'a'
```
[See this page](opts.md) for the options common to all commands.

### More

[This page](comparison.md#sort) lists more examples with execution times and
comparisons with other tools.
## Variables provided by the 'sort' command


| | |
|-|-|
| <a name="key"></a>key | The value of the key used for sorting |

### Example
Sort by part of the sequence ID, which is obtained using a JavaScript expression. We additionally keep this substring by writing the sort key to a header attribute::
```bash
st sort -n '{ id.slice(2, 5) }' -a id_num='{num(key)}' input.fasta
```
```
>id001 id_num=1
SEQ
>id002 id_num=2
SEQ
(...)
```
