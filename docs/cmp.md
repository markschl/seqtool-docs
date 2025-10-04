# cmp
Compare two input files/streams

In the default mode, two files/streams are compared by *ID* (`id` variable) and
*sequence hash* (`seqhash` variable), ignoring descriptions in headers.
The number of common and unique record numbers are reported to STDERR,
unless `-q/--quiet` is specified.

Note that the comparison key can be completely customized with `-k/--key`
(see <KEY> help and `st cmp -V/--help-vars`).

If the memory limit is exceeded, two-pass scanning is activated. In this case,
seekable files must be provided.

If the the two input files/streams are known to be in sync, then `-O/--in-order`
can be specified for faster comparison and lower memory usage.
The key does not have to be unique in this mode.

Examples:

Compare records by ID and sequence (the default mode):

`st cmp file1.fasta file2.fasta`
common	6
unique1	3
unique2	3

Compare only by ID and visualize inconsistencies between sequences:

`st cmp -k id -d seq file1.fasta file2.fasta`
seq_3:
┌ CACTTTCAACAACGGATCTCTTGGTTCTCGCATCGATGAAGAACGT┐
└
CACTTTCAACAACGGATCTCTTG..TCTCGCATCGATGAAGAACGT┘

common	7
unique1	2
unique2	1


```
Usage: st cmp [OPTIONS] [INPUT]...

Options:
  -h, --help  Print help

'Cmp' command options:
  -k, --key <FIELDS>        The key used to compare the records in the two input
                            files/streams. Keys must be unique in each input
                            unless `-O/--in-order` is provided. Can be a single
                            variable/function such as 'id', a composed string
                            such as '{attr(a)}_{attr(b)}', or a comma-delimited
                            list of these. `-k/--key` may also be provided
                            multiple times, which is equivalent to a
                            comma-delimited list [default: id,seqhash]
  -d, --diff <FIELDS>       Print differences between the two inputs with
                            respect to one or multiple extra properties, for
                            records that are otherwise identical according to
                            the comparison key (`-k/--key`). If two records
                            differ by these extra given properties, a colored
                            alignment is printed to STDERR
  -O, --in-order            Provide this option if the two input files/streams
                            are in the same order. Instead of scanning the whole
                            output, reading and writing is done progressively.
                            The same key may occur multiple times. Two records
                            are assumed to be synchronized and idencical as long
                            as they have the same key
  -c, --check               Checks if the two files match exactly, and exits
                            with an error if not
      --common <OUT>        Write records from the first input to this output
                            file (or `-` for STDOUT) if *also* present in the
                            second input (according to the comparison of keys)
                            [aliases: --common1, --c1]
      --common2 <OUT>       Write records from the *second* input to the given
                            output (file or `-` for STDOUT) if *also* present in
                            the first input (according to the comparison of
                            keys) [aliases: --c2]
      --unique1 <OUT>       Write records from the first input to this output
                            file (or `-` for STDOUT) if *not* present in the
                            second input [aliases: --u1]
      --unique2 <OUT>       Write records from the second input to this output
                            file (or `-` for STDOUT) if *not* present in the
                            first input [aliases: --u2]
      --output2 <OUT>       Write the second input back to this output file (or
                            - for STDOUT). Useful if only certain aspects of a
                            record are compared, but records may still differ by
                            other parts [aliases: --o2]
  -2, --two-pass            Do the comparison in two passes (default:
                            automatically done if memory limit reached)
  -M, --max-mem <SIZE>      Maximum amount of memory (approximate) to use for
                            de-duplicating. Either a plain number (bytes) a
                            number with unit (K, M, G, T) based on powers of 2
                            [default: 5G]
      --diff-width <CHARS>  Maximum width of the `-d/--diff` output [default:
                            80]
```
[See this page](opts.md) for the options common to all commands.


## Variables/functions provided by the 'cmp' command
> see also `st cmp -V` or `st cmp --help-vars`



| | |
|-|-|
| <a name="category"></a>category | Record category: 'common' (record present in both files based on comparison of keys), 'unique1' (record only in first file), or 'unique2' (record only in second file).<br/>return type: text |
| <a name="category_short"></a>category_short | Short category code: 'c' for common, 'u1' for unique1, 'u2' for unique2<br/>return type: text |
| <a name="key"></a>key | The value of the compared key |

### Example
Compare two files by ID and sequence hash and store all commonly found records in a new file (some statistics is printed to STDERR)::
```bash
st cmp input1.fasta input2.fasta --common1 common.fasta
```
```
common  942
unique1  51
unique2  18
```
