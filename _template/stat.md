`st stat <variables>` is a shorter equivalent of `st pass --to-tsv id,<variables>`.

Example:

```bash
st stat seqlen,gc_percent seqs.fasta
```

Example output:

```
seq1	291	50.51546391752577
seq2	297	57.57575757575758
...
```
