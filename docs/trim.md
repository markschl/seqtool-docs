# trim
Trim sequences on the left and/or right (single range) or extract and
concatenate several ranges

```
Usage: st trim [OPTIONS] <RANGES> [INPUT]...

Options:
  -h, --help  Print help

'Trim' command options:
  -e, --exclusive   Exclusive trim range: excludes start and end positions from
                    the output sequence. In the case of unbounded ranges
                    (`start:` or `:end`), the range still extends to the
                    complete end or the start of the sequence
  -0, --zero-based  Interpret range as 0-based, with the end not included
  <RANGES>          Range(s) in the form 'start:end' or 'start:' or ':end',
                    Multiple ranges can be supplied as comma-delimited list:
                    'start:end,start2:end2', etc. The start/end positions can be
                    defined by variables/functions (start_var:end_var), or
                    variables/functions may return the whole range (e.g. stored
                    as header attribute 'attr(range)'), or even a list of ranges
                    (e.g. 'attr(range_list)'). *Note* that with the FASTA
                    format, multiple trim ranges must be in order (from left to
                    right) and cannot overlap
```
[See this page](opts.md) for the options common to all commands.

The trim ranges always include the start and end coordinates unless `-0` is
specified.
Coordinates can be negative to indicate an offset from the end.
See [explanation of ranges](ranges.md) for more details.

## Example: primer trimming

Assuming the length of a primer is 20bp, we can remove it like this:

```bash
st trim ":20" input.fasta > output.fasta
```

However, primers may sometimes be incomplete or shifted, which is why tools such
as [Cutadapt](https://cutadapt.readthedocs.io) are usually used to trim primers.
*Seqtool* can do primer matching using the [find](find.md) command, followed by primer
trimming with [trim](trim.md).
The following example trims forward and reverse primers, storing the positions
as [attributes](attributes.md) in sequence headers:

```bash
st find FWDPRIMER -f -R 0.1 -a fwd_end={match_end} input.fasta |
  st find REVPRIMER -f -R 0.1 -a rev_start={match_start} |
  st trim --exclusive '{attr(fwd_end)}:{attr(rev_start)}' > primer_trimmed.fasta
```

The intermediate output before the *trim* command may look like this:

<pre>
>id f_end=15 r_start=24
BEFORE<span style="color:blue">FWDPRIMER</span><span style="color:brown">SEQUENCE</span><span style="color:blue">REVPRIMER</span>AFTER
</pre>

`primer_trimmed.fasta`:

<pre>
>id f_end=15 r_start=-15
<span style="color:brown">SEQUENCE</span>
</pre>

> **Note:** `-e/--exclusive` excludes the last base of the forward primer and the first
> base of the reverse primer.


## Using coordinates from *BED* files

The following is equivalent to
[bedtools getfasta](http://bedtools.readthedocs.io/en/latest/content/tools/getfasta.html)
(note that the BED format is 0-based, thus the `-0` option):

```bash
st trim -l coordinates.bed -0 '{meta(2)}:{meta(3)}' input.fasta > output.fasta
```

Instead of `-0` we could also use an expression to calculate `start + 1`,
matching the standard [range coordinate system](ranges.md) used by *seqtool*.

```bash
st trim -l coordinates.bed '{meta(2)+1}:{meta(3)}' input.fasta > output.fasta
```

## Multiple ranges

The trim command can also concatenate multiple parts of the sequence:

```bash
st trim '2:5,10:1' input.fasta > output.fasta
```

## More

[This page](comparison.md#trim) lists examples with execution times compared
to other tools.
