# find
Search for pattern(s) in sequences or sequene headers for record filtering,
pattern replacement or passing hits to next command

There are different search modes:

1. Exact search
2. Regular expressions (`-r/--regex`)
3. DNA or protein patterns with ambiguous letters
4. Approximate matching up to a given edit distance
    (`-D/--diffs` or `-R/--max-diff-rate`)

Search results can be used in three different ways:

1. Keeping (`-f/--filter`) or excluding (`-e/--exclude`) matched
   sequences
2. Pattern replacement (`--rep`) with ambiguous/approximate
   matching (for exact/regex replacement, use the 'replace'
   command)
3. Passing the search results to the output in sequence
   headers (`-a/--attr`) or TSV/CSV fields (`--to-tsv/--to-csv`);
   see `st find --help-vars` for all possible variables/
   functions


```
Usage: st find [OPTIONS] <PATTERNS> [INPUT]...

Arguments:
  <PATTERNS>  Pattern string or 'file:<patterns.fasta>'

Options:
  -h, --help  Print help

Where to search (default: sequence):
  -i, --id    Search / replace in IDs instead of sequences
  -d, --desc  Search / replace in descriptions

Search options:
  -D, --max-diffs <N>      Return pattern matches up to a given maximum edit
                           distance of N differences (= substitutions,
                           insertions or deletions). Residues that go beyond the
                           sequence (partial matches) are always counted as
                           differences. [default: pefect match]
  -R, --max-diff-rate <R>  Return of matches up to a given maximum rate of
                           differences, that is the fraction of divergences
                           (edit distance = substitutions, insertions or
                           deletions) divided by the pattern length. If
                           searching a 20bp pattern at a difference rate of 0.2,
                           matches with up to 4 differences (see also
                           `-D/--max-diffs`) are returned. [default: pefect
                           match]
  -r, --regex              Interpret pattern(s) as regular expression(s). All
                           *non-overlapping* matches in are searched in headers
                           or sequences. The regex engine lacks some advanced
                           syntax features such as look-around and
                           backreferences (see https://docs.rs/regex/#syntax).
                           Capture groups can be extracted by functions such as
                           `match_group(number)`, or `match_group(name)` if
                           named: `(?<name>)` (see also `st find --help-vars`)
      --in-order           Report hits in the order of their occurrence instead
                           of sorting by distance. Note that this option only
                           has an effect with `-D/--max-dist` > 0, otherwise
                           matches are always reported in the order of their
                           occurrence
  -t, --threads <N>        Number of threads to use for searching [default: 1]
      --no-ambig           Don't interpret DNA ambiguity (IUPAC) characters
      --algo <NAME>        Override decision of algorithm for testing
                           (regex/exact/myers/auto) [default: auto]
      --gap-penalty <N>    Gap penalty used for prioritizing among multiple
                           matches with the same starting position and an
                           equally small edit distance. While substitutions have
                           a fixed penalty of 1, the gap penalty can be modified
                           to take values >1. The default of 2 prefers more
                           concise alignments. A high gap penalty does *not*
                           enforce ungapped alignments. Only perfect matches
                           (`-D/--max-diffs 0`) are ungapped [default: 2]

Search range:
      --rng <RANGE>          Search within the given range ('start:end',
                             'start:' or ':end'). Using variables is not
                             possible
      --max-shift-start <N>  Consider only matches with a maximum of <N> letters
                             preceding the start of the match (relative to the
                             sequence start or the start of the range `--rng`)
      --max-shift-end <N>    Consider only matches with a maximum of <N> letters
                             following the end of the match (relative to the
                             sequence end or the end of the range `--rng`)

Search command actions:
  -f, --filter          Keep only matching sequences
  -e, --exclude         Exclude sequences that matched
      --dropped <FILE>  Output file for sequences that were removed by
                        filtering. The format is auto-recognized from the
                        extension
      --rep <BY>        Replace by a string, which may also contain
                        {variables/functions}
```
[See this page](opts.md) for the options common to all commands.

## Searching in headers

Specify `-i/--id` to search in sequence IDs (everything before the first space)
or `-d/--desc` to search in the description part (everything *after* the space).

Example: selectively return sequences that have `label` in their description
(filtering with the `-f/--filter` flag):

```bash
st find -df 'label' gb_seqs.fasta
```

> *Note*: use `--dropped <not_matched_out>` to write unmatched sequences to 
> another file.

To match a certain pattern, use a regular expression (`-r/--regex`).
The following example extracts Genbank accessions from sequence headers that follow
the old-style Genbank format:

```bash
st find -ir "gi\|\d+\|[a-z]+\|(?<acc>.+?)\|.*" gb_seqs.fasta -a 'acc={match_group(acc)}'
```

```
>gi|1031916024|gb|KU317675.1| acc=KU317675.1
SEQUENCE
(...)
```

> You can use online tools such as https://regex101.com to build and debug your
> regular expression

> *Note:* You could also replace the whole header with the accession using
> the [replace](replace.md) command. This might be faster, but the original header
> will not be retained.


## Searching in sequences

Without the `-i` or `-d` flag, the default mode is to search in the sequence.
The pattern type is automatically recognized and usually reported to avoid
problems:

```bash
st find -f AATGRAAT seqs.fasta > filtered.fasta
```

```
Note: the sequence type of the pattern was determined as 'dna' (with ambiguous letters). If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
```

`R` stands for `A` or `G`. *Seqtool* recognizes the IUPAC ambiguity codes for
[DNA/RNA](https://iubmb.qmul.ac.uk/misc/naseq.html#500) and
[proteins](https://iupac.qmul.ac.uk/AminoAcid/A2021.html#AA212)
(with the exception of U = Selenocysteine).


**⚠** Matching is asymmetric: `R` in a search pattern matches [`A`, `G`, `R`]
in sequences, but `R` in a sequence will only match ambiguities sharing the same
set of bases (`R`, `V`, `D`, `N`) in the pattern. This should prevent false
positive matches in sequences with many ambiguous characters.


### Approximate matching

*Seqtool* can search for patterns such as adapter and primer sequences in an
error-tolerant way, up to a given [edit distance](https://en.wikipedia.org/wiki/Edit_distance)
(`-D/--diffs` argument). Alternatively, `-R/--diff-rate` specifies a distance
threshold relative to the length of the pattern (in other words, an "error rate").

In this example, the edit distance and range of the best match are stored
into [header attributes](attributes.md). If no hit is found, the attributes
are set to `undefined`.

```bash
st find -D 2 AATGRAAT seqs.fasta -a d='{match_diffs}' -a rng='{match_range}'
```

```
>seq1 d=1 rng=3:11
GGAACGAAATATCAGCGATCC
>seq2 d=undefined rng=undefined
TTATCGAATATGAGCGATCG
(...)
```

The second best hit (if any) can be returned with `{match_diffs(2)}` or
`{match_range(2)}`, etc.

> *Note:* Approximative matching is done using [Myers](https://doi.org/10.1145/316542.316550)
> bit-parallel algorithm, which is very fast with short patterns and reasonably
> short sequences. It may not be the fastest solution if searching in large
> genomes.
> 
> Recognizing adapter or primers should be very fast.
> Further speedups can be achieved by multithreading (`-t`) and
> restricting the search range (`--rng`).

> *Note 2*: To report all hits below the given distance threshold 
> *in order of occurrence* instead of *decreasing distance*, specify `--in-order`
> (this may be faster)

## Multiple patterns

The *find* command supports searching for several patterns at once.
They have to be supplied in a separate FASTA file (`file:path`).
The best matching pattern with the smallest edit distance is always reported first.

The following example de-multiplexes sequences amplified with different forward
primers and then uses [trim](trim.md) to remove the primers, and finally distributes
the sequences into different files named by the forward primer ([split](split.md)).

<table markdown>
<tr><th>

primers.fasta

</th></tr>
<tr markdown><td markdown>

```
>prA
PRIMER
>prB
PRIMER
```

</td></tr>
</table>


```bash
st find file:primers.fasta -a primer='{pattern_name}' -a end='{match_end}' sequences.fasta |
    st trim -e '{attr(end)}:' |
    st split -o '{attr(primer)}'
```

<table markdown>
<tr><th>prA.fasta </th><th>prB.fasta</th><th>undefined.fasta</th></tr>
<tr markdown>
<td>

```
>id1 primer=prA end=22
SEQUENCE
>id4 primer=prA end=21
SEQUENCE
(...)
```

</td>
<td>

```
>id2 primer=prB end=20
SEQUENCE
>id3 primer=prB end=22
SEQUENCE
(...)
```

</td>
<td markdown>

```
>id5 primer=undefined end=undefined
UNTRIMMEDSEQUENCE
(...)
```

> *Note:* no primer, sequence **not** trimmed since `end=undefined` (see [ranges](ranges.md)).

</td>
</tr>
</table>


## Selecting other hits

The find command is very versatile thanks to the large number of variables/functions
that provide information about the search results
(see [variable reference](#variablesfunctions-provided-by-the-find-command)).


For instance, the best hit from the *second best* matching pattern can be selected using
`{match_range(1, 2)}`.

It is also possible to return a comma-delimited list of matches, e.g.:
`{match_range(all)}`. See the [mask](mask.md) command for an example on how this could be useful.


## Replacing matches

Hits can be replaced by other text (`--repl`). Variables are allowed
as well (in contrast to the *replace* command). Backreferences to regex groups
(e.g. `$1`) are not supported like the *replace* command does.
Instead, they can be accessed using variables (`match_group()`, etc.)

## More

[This page](comparison.md#find) lists more examples with execution times and
comparisons with other tools.

## Variables/functions provided by the 'find' command
> see also `st find --help-vars`

The find command provides many variables/functions to obtain information about the pattern matches. These are either written to header attributes (`-a/--attr`) or CSV/TSV fields (e.g. `--to-tsv ...`). See also examples section below.

| | |
|-|-|
| <a name="match"></a>match<br />match(hit)<br />match(hit, pattern) | The text matched by the pattern. With approximate matching (`-D/--diffs` \> 0), this is the match with the smallest edit distance or the leftmost occurrence if `--in-order` was specified. With exact/regex matching, the leftmost hit is always returned. In case of multiple patterns in a pattern file, the best hit of the best-matching pattern is returned (fuzzy matching), or the first hit of the first pattern with an exact match.<br />`match(hit) returns the matched text of the given hit number, whereas `match(all)` or `match('all') returns a comma-delimited list of all hits. These are either sorted by the edit distance (default) or by occurrence (`--in-order` or exact matching).<br />`match(1, 2)`, `match(1, 3)`, etc. references the 2nd, 3rd, etc. best matching pattern in case multiple patterns were suplied in a file (default: hit=1, pattern=1)." |
| <a name="aligned_match"></a>aligned_match<br />aligned_match(hit)<br />aligned_match(hit, rank) | Text match aligned with the pattern, including gaps if needed. |
| <a name="match_start"></a>match_start<br />match_start(hit)<br />match_start(hit, pattern) | Start coordinate of the first/best match. Other hits/patterns are selected with `match_start(hit, [pattern])`, for details see `match` |
| <a name="match_end"></a>match_end<br />match_end(hit)<br />match_end(hit, pattern) | Start of the first/best match relative to sequence end (negative coordinate). Other hits/patterns are selected with `match_neg_start(hit, [pattern])`, for details see `match`. |
| <a name="match_neg_start"></a>match_neg_start<br />match_neg_start(hit)<br />match_neg_start(hit, pattern) | End of the first/best match relative to sequence end (negative coordinate). Other hits/patterns are selected with `match_neg_end(hit, [pattern])`, for details see `match`. |
| <a name="match_neg_end"></a>match_neg_end<br />match_neg_end(hit)<br />match_neg_end(hit, pattern) | End coordinate of the first/best match. Other hits/patterns are selected with `match_end(hit, [pattern])`, for details see `match` |
| <a name="match_len"></a>match_len<br />match_len(hit)<br />match_len(hit, rank) | Length of the match |
| <a name="match_range"></a>match_range<br />match_range(hit)<br />match_range(hit, pattern)<br />match_range(hit, pattern, delim) | Range (start:end) of the first/best match. Other hits/patterns are selected with `match_range(hit, [pattern])`, for details see `match`. The 3rd argument allows changing the range delimiter, e.g. to '-'. |
| <a name="match_group"></a>match_group(group)<br />match_group(group, hit)<br />match_group(group, hit, pattern) | Text matched by regex match group of given number (0 = entire match) or name in case of a named group: `(?\<name\>...)`. The hit number (sorted by edit distance or occurrence) and the pattern number can be specified as well (see `match` for details). |
| <a name="match_grp_start"></a>match_grp_start(group)<br />match_grp_start(group, hit)<br />match_grp_start(group, hit, pattern) | Start coordinate of the regex match group 'group' within the first/best match. See 'match_group' for options and details. |
| <a name="match_grp_end"></a>match_grp_end(group)<br />match_grp_end(group, hit)<br />match_grp_end(group, hit, pattern) | End coordinate of the regex match group 'group' within the first/best match. See 'match_group' for options and details. |
| <a name="match_grp_neg_start"></a>match_grp_neg_start(group)<br />match_grp_neg_start(group, hit)<br />match_grp_neg_start(group, hit, pattern) | Start coordinate of regex match group 'group' relative to the sequence end (negative number). See 'match_group' for options and details. |
| <a name="match_grp_neg_end"></a>match_grp_neg_end(group)<br />match_grp_neg_end(group, hit)<br />match_grp_neg_end(group, hit, pattern) | Start coordinate of regex match group 'group' relative to the sequence end (negative number). See 'match_group' for options and details. |
| <a name="match_grp_range"></a>match_grp_range(group)<br />match_grp_range(group, hit)<br />match_grp_range(group, hit, pattern)<br />match_grp_range(group, hit, pattern, delim) | Range (start-end) of regex match group 'group' relative to the sequence end. See 'match_group' for options and details. The 4th argument allows changing the range delimiter, e.g. to '-'. |
| <a name="match_diffs"></a>match_diffs<br />match_diffs(hit)<br />match_diffs(hit, pattern) | Number of mismatches/insertions/deletions of the search pattern compared to the sequence (corresponds to edit distance). Either just `match_diffs` for the best match, or `match_diffs(h, [p])` to get the edit distance of the h-th best hit of the p-th pattern. `match_diffs('all', [p]) will return a comma delimited list of distances for all hits of a pattern. |
| <a name="match_diff_rate"></a>match_diff_rate<br />match_diff_rate(hit)<br />match_diff_rate(hit, pattern) | Number of insertions in the sequence compared to the search pattern. Proportion of differences between the search pattern and the matched sequence, relative to the pattern length. See `match_diffs` for details on hit/pattern arguments. |
| <a name="match_ins"></a>match_ins<br />match_ins(hit)<br />match_ins(hit, pattern) | Number of insertions in the matched sequence compared to the search pattern. |
| <a name="match_del"></a>match_del<br />match_del(hit)<br />match_del(hit, pattern) | Number of deletions in the matched text sequence to the search pattern. |
| <a name="match_subst"></a>match_subst<br />match_subst(hit)<br />match_subst(hit, pattern) | Number of substitutions (non-matching letters) in the matched sequence compared to the pattern |
| <a name="pattern_name"></a>pattern_name<br />pattern_name(rank) | Name of the matching pattern (patterns supplied with `file:patterns.fasta`). In case a single pattern was specified in the commandline, this will just be *\<pattern\>*. `pattern_name(rank)` selects the n-th matching pattern, sorted by edit distance and/or pattern number (depending on `-D/-R` and `--in-order`). |
| <a name="pattern"></a>pattern<br />pattern(rank) | The best-matching pattern sequence, or the n-th matching pattern if `rank` is given, sorted by edit distance or by occurrence (depending on `-D/-R` and `--in-order`). |
| <a name="aligned_pattern"></a>aligned_pattern<br />aligned_pattern(hit)<br />aligned_pattern(hit, rank) | The aligned pattern, including gaps if needed. Regex patterns are returned as-is. |
| <a name="pattern_len"></a>pattern_len<br />pattern_len(rank) | Length of the matching pattern (see also `pattern`). For regex patterns, the length of the complete regular expression is returned. |

### Examples
Find a primer sequence with up to 2 mismatches (`-d/--dist`) and write the match range and the mismatches ('dist') to the header as attributes. The result will be 'undefined' (=undefined in JavaScript) if there are > 2 mismatches:
```bash
st find -d 2 CTTGGTCATTTAGAGGAAGTAA -a rng={match_range} -a dist={match_diffs} reads.fasta
```
```
>id1 rng=2:21 dist=1
SEQUENCE
>id2 rng=1:20 dist=0
SEQUENCE
>id3 rng=undefined dist=undefined
SEQUENCE
(...)
```
Find a primer sequence and if found, remove it using the 'trim' command, while non-matching sequences are written to 'no_primer.fasta':
```bash
st find -f -d 2 CTTGGTCATTTAGAGGAAGTAA --dropped no_primer.fasta -a end={match_end} reads.fasta |
   st trim -e '{attr(match_end)}:' > primer_trimmed.fasta
```
Search for several primers with up to 2 mismatches and write the name and mismatches of the best-matching primer to the header:
```bash
st find -d 2 file:primers.fasta -a primer={pattern_name} -a dist={match_diffs} reads.fasta
```
```
>id1 primer=primer_1 dist=1
SEQUENCE
>id1 primer=primer_2 dist=0
SEQUENCE
>id1 primer=undefined dist=undefined
SEQUENCE
(...)
```
