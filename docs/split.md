# split
Distribute sequences into multiple files based on a variable/function or
advanced expression

In contrast to other commands, the output argument (`-o/--output`) of the
'split' command can contain variables and advanced expressions to determine the
file path for each sequence. However, the output format will not be
automatically
determined from file extensions containing variables.


```
Usage: st split [OPTIONS] [INPUT]...

Options:
  -h, --help  Print help

'Split' command options:
  -n, --num-seqs <N>     Split into chunks of <N> sequences and writes each
                         chunk to a separate file with a numbered suffix. The
                         output path is: '{filestem}_{chunk}.{default_ext}',
                         e.g. 'input_name_1.fasta'. Change with `-o/--output`
  -p, --parents          Automatically create all parent directories of the
                         output path
  -c, --counts <COUNTS>  Write a tab-separated list of file path + record count
                         to the given file (or STDOUT if `-` is specified)
```
[See this page](opts.md) for the options common to all commands.

Immagine this FASTA file (`input.fa`):

```
>seq1 group=1
SEQUENCE
>seq2 group=2
SEQUENCE
>seq3 group=1
SEQUENCE
```

```bash
st split -o "group_{attr(group)}.fa" input.fasta
```

This will create the files `group_1.fa` and `group_2.fa`. In more
complicated scenarios, variables may be combined for creating nested subfolders
of any complexity.

An example of de-multiplexing sequences by forward primer is found in the
documetation of the [find](find.md#multiple-patterns) command.
## Variables available in the split command


| | |
|-|-|
| <a name="chunk"></a>chunk | If `-n/--num-seqs` was specified, the 'chunk' variable contains the number of the current sequence batch, starting with 1. *Note* that the 'chunk' variable is *only* available with `-n/--num-seqs`, otherwise there will be a message: "Unknown variable/function: chunk" |

### Example
Split input into chunks of 1000 sequences, which will be named outdir/file_1.fq, outdir/file_2.fq, etc.:
```bash
st split -n 1000 -po 'outdir/out_{chunk}.fq' input.fastq
```
```
Output files (`ls outdir/out_*.fq`):
outdir/out_1.fq
outdir/out_2.fq
(...)
```
