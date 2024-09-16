# Comparison of tools

In the following list, we show the execution time, memory footprint and CPU usage
of *seqtool* v0.4.0-beta on a selection of tasks, compared with the following tools:

* [Seqtk](https://github.com/lh3/seqtk) v1.4
* [SeqKit](https://github.com/shenwei356/seqkit) v2.7.0
* [FASTX-Toolkit](https://github.com/agordon/fastx_toolkit)
* [USEARCH](https://www.drive5.com/usearch) v11.0.667
* [VSEARCH](https://github.com/torognes/vsearch) v2.28.1
* [Cutadapt](https://cutadapt.readthedocs.io/en/stable) v4.6

Details on the approach are [found here](https://github.com/markschl/seqtool/profile/README.md).
The input file is a FASTQ or FASTA file containing 2.6 M reads (Illumina MiSeq, 300 bp).
The comparison was run on a Ryzen 4750U CPU with frequency boost disabled, writing
files to a RAM instead of the disk.

The fastest/most memory-efficient commands are highlighted by '🏆' and an indication,
how many times faster / less memory they use compared to the commands ranking second.
To show more details, click on the alternative commands list.

<style>
.md-grid {
    max-width: 100rem !important;
}
table.cmd {
    table-layout: fixed;
    width: 100%;
}
table.cmd td {
    padding: 0.2rem 0.5rem;
}
table.cmd td:first-child {
    width: 25%;
}
table.cmd td:last-child {
    width: 15%;
}
</style>
## pass
<table markdown class="cmd">

<tr markdown>
<td markdown>

Do nothing, just read and write FASTA

</td>

<td markdown>

```bash
st pass input.fasta > output.fasta
```


<details markdown><summary><b>SeqKit</b> 🕓 <b>2.2 s</b> 🏆 (1.2x)</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit seq  input.fasta > output.fasta
```

</td>

<td markdown>🕓 <b>2.2 s</b> 🏆 (1.2x) 106% CPU<br/>📈 18.0 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 2.6 s<br/>📈 <b>7.1 MiB</b> 🏆 (2.53x)</td>

</tr>

<tr markdown>
<td markdown>

Convert FASTQ to FASTA

</td>

<td markdown>

```bash
st pass --to-fa input.fastq > output.fasta
```


<details markdown><summary><b>FASTX-Toolkit</b> 🕓 287.9 s  ❙  <b>Seqtk</b> 🕓 4.3 s  ❙  <b>SeqKit</b> 🕓 3.1 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>FASTX-Toolkit</td>

<td markdown>

```bash
fastq_to_fasta -Q33 -i input.fastq > output.fasta
```

</td>

<td markdown>🕓 287.9 s<br/>📈 <b>3.5 MiB</b> 🏆 (1.00x)</td>

</tr>


<tr markdown>
<td markdown>Seqtk</td>

<td markdown>

```bash
seqtk seq -A input.fastq > output.fasta
```

</td>

<td markdown>🕓 4.3 s<br/>📈 3.5 MiB</td>

</tr>


<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit fq2fa input.fastq > output.fasta
```

</td>

<td markdown>🕓 3.1 s<br/>📈 18.4 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>3.1 s</b> 🏆 (1.0x)<br/>📈 7.1 MiB</td>

</tr>

<tr markdown>
<td markdown>

Convert FASTQ quality scores

</td>

<td markdown>

```bash
st pass --to fastq-illumina input.fastq > output.fastq
```


<details markdown><summary><b>VSEARCH</b> 🕓 12.9 s  ❙  <b>SeqKit</b> 🕓 48.8 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --fastq_convert input.fastq --fastq_asciiout 64 --fastqout output.fastq
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Reading FASTQ file 100%
```

</details>
</td>

<td markdown>🕓 12.9 s<br/>📈 <b>4.2 MiB</b> 🏆 (1.65x)</td>

</tr>


<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit convert --from 'Sanger' --to 'Illumina-1.3+' input.fastq > output.fastq
```

<details><summary> messages</summary>

```
[INFO][0m converting Sanger -> Illumina-1.3+
```

</details>
</td>

<td markdown>🕓 48.8 s<br/>📈 47.9 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>7.4 s</b> 🏆 (1.8x)<br/>📈 7.0 MiB</td>

</tr>

<tr markdown>
<td markdown>

Write compressed FASTQ files in GZIP format

</td>

<td markdown>

```bash
st pass input.fastq -o output.fastq.gz
```


<details markdown><summary><b>SeqKit</b> 🕓 <b>30.3 s</b> 🏆 (1.3x)  ❙  <b>seqtool | gzip</b> 🕓 159.1 s  ❙  <b>gzip directly</b> 🕓 158.6 s  ❙  <b>pigz directly (4 threads)</b> 🕓 39.0 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit seq input.fastq -o output.fastq.gz
```

</td>

<td markdown>🕓 <b>30.3 s</b> 🏆 (1.3x)<br/>📈 37.5 MiB</td>

</tr>


<tr markdown>
<td markdown>seqtool | gzip</td>

<td markdown>

```bash
st pass input.fastq | gzip -c > output.fastq.gz
```

</td>

<td markdown>🕓 159.1 s<br/>📈 7.2 MiB</td>

</tr>


<tr markdown>
<td markdown>gzip directly</td>

<td markdown>

```bash
gzip -kf input.fastq
```

</td>

<td markdown>🕓 158.6 s<br/>📈 <b>3.5 MiB</b> 🏆 (1.21x)</td>

</tr>


<tr markdown>
<td markdown>pigz directly (4 threads)</td>

<td markdown>

```bash
pigz -p4 -kf input.fastq
```

</td>

<td markdown>🕓 39.0 s 405% CPU<br/>📈 4.2 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 55.8 s<br/>📈 27.5 MiB</td>

</tr>

<tr markdown>
<td markdown>

Write compressed FASTQ files in Zstandard format

</td>

<td markdown>

```bash
st pass input.fastq -o output.fastq.zst
```


<details markdown><summary><b>seqtool | zstd piped</b> 🕓 <b>12.8 s</b> 🏆 (1.2x)</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>seqtool | zstd piped</td>

<td markdown>

```bash
st pass input.fastq | zstd -c > output.fastq.zst
```

</td>

<td markdown>🕓 <b>12.8 s</b> 🏆 (1.2x) 147% CPU<br/>📈 38.8 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 15.5 s 114% CPU<br/>📈 <b>11.0 MiB</b> 🏆 (3.52x)</td>

</tr>

<tr markdown>
<td markdown>

Write compressed FASTQ files in Lz4 format

</td>

<td markdown>

```bash
st pass input.fastq -o output.fastq.lz4
```


<details markdown><summary><b>seqtool | lz4 piped</b> 🕓 9.9 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>seqtool | lz4 piped</td>

<td markdown>

```bash
st pass input.fastq | lz4 -c > output.fastq.lz4
```

</td>

<td markdown>🕓 9.9 s 116% CPU<br/>📈 <b>7.4 MiB</b> 🏆 (3.75x)</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>9.4 s</b> 🏆 (1.1x) 116% CPU<br/>📈 27.6 MiB</td>

</tr>

</table>

## count
<table markdown class="cmd">

<tr markdown>
<td markdown>

Count the number of FASTQ sequences in the input

</td>

<td markdown>

```bash
st count input.fastq
```

<details><summary>🟦 output</summary>

```
2610480
```

</details>

<details markdown><summary><b>Seqtk</b> 🕓 0.7 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>Seqtk</td>

<td markdown>

```bash
seqtk size input.fasta
```

<details><summary>🟦 output</summary>

```
2610480	712939424
```

</details>
</td>

<td markdown>🕓 0.7 s<br/>📈 <b>3.4 MiB</b> 🏆 (2.11x)</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>0.6 s</b> 🏆 (1.2x)<br/>📈 7.1 MiB</td>

</tr>

<tr markdown>
<td markdown>

Count the number of FASTQ sequences, grouped by GC content (in 10% intervals)

</td>

<td markdown>

```bash
st count -k 'bin(gc_percent, 10)' input.fastq
```

<details><summary>🟦 output</summary>

```
(10, 20]	16
(20, 30]	3004
(30, 40]	51945
(40, 50]	1149946
(50, 60]	1248702
(60, 70]	20439
(70, 80]	120
(80, 90]	63
(90, 100]	37
(100, 110]	11
(NaN, NaN]	136197
```

</details>

<details markdown><summary><b>st with math expression</b> 🕓 7.0 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>st with math expression</td>

<td markdown>

```bash
st count -k '{bin(gc_percent/100*100, 10)}' input.fastq
```

<details><summary>🟦 output</summary>

```
(10, 20]	16
(20, 30]	3004
(30, 40]	51945
(40, 50]	1149946
(50, 60]	1248702
(60, 70]	20439
(70, 80]	120
(80, 90]	63
(90, 100]	37
(100, 110]	11
(NaN, NaN]	136197
```

</details>
</td>

<td markdown>🕓 7.0 s<br/>📈 86.0 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>4.2 s</b> 🏆 (1.6x)<br/>📈 <b>7.4 MiB</b> 🏆 (11.66x)</td>

</tr>

</table>

## sort
<table markdown class="cmd">

<tr markdown>
<td markdown>

Sort by sequence

</td>

<td markdown>

```bash
st sort seq input.fasta > output.fasta
```


<details markdown><summary><b>SeqKit</b> 🕓 42.3 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit sort -s  input.fasta > output.fasta
```

<details><summary> messages</summary>

```
[INFO][0m read sequences ...
[INFO][0m 2610480 sequences loaded
[INFO][0m sorting ...
[INFO][0m output ...
```

</details>
</td>

<td markdown>🕓 42.3 s<br/>📈 4595.1 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>13.6 s</b> 🏆 (3.1x)<br/>📈 <b>1771.4 MiB</b> 🏆 (2.59x)</td>

</tr>

<tr markdown>
<td markdown>

Sort by sequence with ~ 50 MiB memory limit

</td>

<td markdown>

```bash
st sort seq input.fasta -M 50M > output.fasta
```

<details><summary> messages</summary>

```
Memory limit reached after 78050 records, writing to temporary file(s). Consider raising the limit (-M/--max-mem) to speed up sorting. Use -q/--quiet to silence this message.
```

</details>

<details markdown><summary><b>100 MiB memory limit</b> 🕓 20.6 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>100 MiB memory limit</td>

<td markdown>

```bash
st sort seq input.fasta -M 100M > output.fasta
```

<details><summary> messages</summary>

```
Memory limit reached after 155392 records, writing to temporary file(s). Consider raising the limit (-M/--max-mem) to speed up sorting. Use -q/--quiet to silence this message.
```

</details>
</td>

<td markdown>🕓 20.6 s<br/>📈 108.7 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>20.3 s</b> 🏆 (1.0x)<br/>📈 <b>58.5 MiB</b> 🏆 (1.86x)</td>

</tr>

<tr markdown>
<td markdown>

Sort by record ID

</td>

<td markdown>

```bash
st sort id input.fasta > output.fasta
```


<details markdown><summary><b>SeqKit</b> 🕓 34.2 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit sort  input.fasta > output.fasta
```

<details><summary> messages</summary>

```
[INFO][0m read sequences ...
[INFO][0m 2610480 sequences loaded
[INFO][0m sorting ...
[INFO][0m output ...
```

</details>
</td>

<td markdown>🕓 34.2 s<br/>📈 4436.4 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>6.5 s</b> 🏆 (5.3x)<br/>📈 <b>1119.2 MiB</b> 🏆 (3.96x)</td>

</tr>

<tr markdown>
<td markdown>

Sort by sequence length

</td>

<td markdown>

```bash
st sort seqlen input.fasta > output.fasta
```


<details markdown><summary><b>SeqKit</b> 🕓 33.7 s  ❙  <b>VSEARCH</b> 🕓 9.4 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit sort -l  input.fasta > output.fasta
```

<details><summary> messages</summary>

```
[INFO][0m read sequences ...
[INFO][0m 2610480 sequences loaded
[INFO][0m sorting ...
[INFO][0m output ...
```

</details>
</td>

<td markdown>🕓 33.7 s<br/>📈 4153.5 MiB</td>

</tr>


<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --sortbylength input.fasta --output output.fasta 
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Reading file input.fasta 100%
712939424 nt in 2610480 seqs, min 35, max 301, avg 273
Getting lengths 100%
Sorting 100%
Median length: 301
Writing output 100%
```

</details>
</td>

<td markdown>🕓 9.4 s<br/>📈 <b>891.4 MiB</b> 🏆 (1.17x)</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>5.9 s</b> 🏆 (1.6x)<br/>📈 1042.4 MiB</td>

</tr>

<tr markdown>
<td markdown>

Sort sequences by USEARCH/VSEARCH-style abundance annotations

</td>

<td markdown>

```bash
ST_ATTR_FMT=';key=value' st unique seq -a size={n_duplicates} input.fasta |
  st sort '{-attr("size")}' > output.fasta

```


<details markdown><summary><b>VSEARCH</b> 🕓 20.4 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --derep_fulllength input.fasta --output - --sizeout |   vsearch --sortbysize - --output output.fasta  
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Dereplicating file input.fasta 100%
712939424 nt in 2610480 seqs, min 35, max 301, avg 273
Sorting 100%
2134929 unique sequences, avg cluster 1.2, median 1, max 136182
Writing FASTA output fileReading file - 100%
 100%
606287856 nt in 2134929 seqs, min 35, max 301, avg 284
Getting sizes 100%
Sorting 100%
Median abundance: 1
Writing output 100%
```

</details>
</td>

<td markdown>🕓 20.4 s 113% CPU<br/>📈 <b>1345.8 MiB</b> 🏆 (1.19x)</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>13.3 s</b> 🏆 (1.5x) 110% CPU<br/>📈 1606.5 MiB</td>

</tr>

</table>

## unique
<table markdown class="cmd">

<tr markdown>
<td markdown>

Remove duplicate sequences using sequence hashes. This is more memory efficient and usually faster than keeping the whole  sequence around.


</td>

<td markdown>

```bash
st unique seqhash input.fasta > output.fasta
```


<details markdown><summary><b>SeqKit</b> 🕓 <b>3.3 s</b> 🏆 (1.2x)</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit rmdup -sP  input.fasta > output.fasta
```

<details><summary> messages</summary>

```
[INFO][0m 475551 duplicated records removed
```

</details>
</td>

<td markdown>🕓 <b>3.3 s</b> 🏆 (1.2x)<br/>📈 180.1 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 4.2 s<br/>📈 <b>117.1 MiB</b> 🏆 (1.54x)</td>

</tr>

<tr markdown>
<td markdown>

Remove duplicate sequences using sequence hashes (case-insensitive).


</td>

<td markdown>

```bash
st unique 'seqhash(true)' input.fasta > output.fasta
```


<details markdown><summary><b>VSEARCH</b> 🕓 12.1 s  ❙  <b>SeqKit</b> 🕓 6.2 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --derep_smallmem input.fasta --fastaout output.fasta 
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Dereplicating file input.fasta 100%
712939424 nt in 2610480 seqs, min 35, max 301, avg 273
2134929 unique sequences, avg cluster 1.2, median 1, max 136182
Writing FASTA output file 100%
```

</details>
</td>

<td markdown>🕓 12.1 s<br/>📈 <b>90.7 MiB</b> 🏆 (1.29x)</td>

</tr>


<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit rmdup -sPi  input.fasta > output.fasta
```

<details><summary> messages</summary>

```
[INFO][0m 475551 duplicated records removed
```

</details>
</td>

<td markdown>🕓 6.2 s<br/>📈 289.8 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>4.3 s</b> 🏆 (1.4x)<br/>📈 117.2 MiB</td>

</tr>

<tr markdown>
<td markdown>

Remove duplicate sequences that are exactly identical (case-insensitive); comparing full sequences instead of not hashes (requires more memory). VSEARCH additionally treats &#x27;T&#x27; and &#x27;U&#x27; in the same way (seqtool doesn&#x27;t).


</td>

<td markdown>

```bash
st unique upper_seq input.fasta > output.fasta
```


<details markdown><summary><b>seqtool (sorted by sequence)</b> 🕓 13.5 s  ❙  <b>VSEARCH</b> 🕓 15.8 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>seqtool (sorted by sequence)</td>

<td markdown>

```bash
st unique -s upper_seq input.fasta > output.fasta
```

</td>

<td markdown>🕓 13.5 s<br/>📈 1640.7 MiB</td>

</tr>


<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --derep_fulllength input.fasta --output output.fasta 
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Dereplicating file input.fasta 100%
712939424 nt in 2610480 seqs, min 35, max 301, avg 273
Sorting 100%
2134929 unique sequences, avg cluster 1.2, median 1, max 136182
Writing FASTA output file 100%
```

</details>
</td>

<td markdown>🕓 15.8 s<br/>📈 1345.7 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>5.4 s</b> 🏆 (2.5x)<br/>📈 <b>729.0 MiB</b> 🏆 (1.85x)</td>

</tr>

<tr markdown>
<td markdown>

Remove duplicate sequences (exact mode) with a memory limit of ~50 MiB

</td>

<td markdown>

```bash
st unique seq -M 50M input.fasta > output.fasta
```

<details><summary> messages</summary>

```
Memory limit reached after 151512 records, writing to temporary file(s). Consider raising the limit (-M/--max-mem) to speed up de-duplicating. Use -q/--quiet to silence this message.
```

</details>

</td>

<td>🕓 19.5 s<br/>📈 56.6 MiB</td>

</tr>

<tr markdown>
<td markdown>

Remove duplicate sequences, checking both strands

</td>

<td markdown>

```bash
st unique seqhash_both input.fasta > output.fasta
```


<details markdown><summary><b>SeqKit</b> 🕓 14.8 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit rmdup -s  input.fasta > output.fasta
```

<details><summary> messages</summary>

```
[INFO][0m 475687 duplicated records removed
```

</details>
</td>

<td markdown>🕓 14.8 s<br/>📈 293.6 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>7.5 s</b> 🏆 (2.0x)<br/>📈 <b>117.1 MiB</b> 🏆 (2.51x)</td>

</tr>

<tr markdown>
<td markdown>

Remove duplicate sequences, appending USEARCH/VSEARCH-style abundance annotations to the headers: *&gt;id;size=NN*


</td>

<td markdown>

```bash
st unique seq -a size={n_duplicates} --attr-fmt ';key=value' input.fasta > output.fasta
```


<details markdown><summary><b>VSEARCH</b> 🕓 16.1 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --derep_fulllength input.fasta --sizeout --output output.fasta 
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Dereplicating file input.fasta 100%
712939424 nt in 2610480 seqs, min 35, max 301, avg 273
Sorting 100%
2134929 unique sequences, avg cluster 1.2, median 1, max 136182
Writing FASTA output file 100%
```

</details>
</td>

<td markdown>🕓 16.1 s<br/>📈 <b>1345.9 MiB</b> 🏆 (1.19x)</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>9.3 s</b> 🏆 (1.7x)<br/>📈 1606.2 MiB</td>

</tr>

<tr markdown>
<td markdown>

De-replicate both by sequence *and* record ID (the part before the first space in the header). The given benchmark actually has unique sequence IDs, so the result is the same as de-replication by sequence.


</td>

<td markdown>

```bash
st unique id,seq input.fasta > output.fasta
```


<details markdown><summary><b>VSEARCH</b> 🕓 17.7 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --derep_id input.fasta --output output.fasta
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Dereplicating file input.fasta 100%
712939424 nt in 2610480 seqs, min 35, max 301, avg 273
Sorting 100%
2610480 unique sequences, avg cluster 1.0, median 1, max 1
Writing FASTA output file 100%
```

</details>
</td>

<td markdown>🕓 17.7 s<br/>📈 1364.4 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>7.5 s</b> 🏆 (2.3x)<br/>📈 <b>1090.6 MiB</b> 🏆 (1.25x)</td>

</tr>

</table>

## filter
<table markdown class="cmd">

<tr markdown>
<td markdown>

Filter sequences by length

</td>

<td markdown>

```bash
st filter 'seqlen >= 100' input.fastq > output.fastq
```


<details markdown><summary><b>Seqtk</b> 🕓 6.5 s  ❙  <b>SeqKit</b> 🕓 <b>4.1 s</b> 🏆 (1.3x)</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>Seqtk</td>

<td markdown>

```bash
seqtk seq -L 100 input.fastq > output.fastq
```

</td>

<td markdown>🕓 6.5 s<br/>📈 <b>3.5 MiB</b> 🏆 (2.07x)</td>

</tr>


<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit seq -m 100 input.fastq > output.fastq
```

<details><summary> messages</summary>

```
[33m[WARN][0m you may switch on flag -g/--remove-gaps to remove spaces
```

</details>
</td>

<td markdown>🕓 <b>4.1 s</b> 🏆 (1.3x)<br/>📈 28.1 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 5.4 s<br/>📈 7.2 MiB</td>

</tr>

<tr markdown>
<td markdown>

Filter sequences by the total expected error as calculated from the quality scores


</td>

<td markdown>

```bash
st filter 'exp_err <= 1' input.fastq --to-fa > output.fastq
```


<details markdown><summary><b>VSEARCH</b> 🕓 32.9 s  ❙  <b>USEARCH</b> 🕓 <b>16.0 s</b> 🏆 (1.7x)</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --fastq_filter input.fastq --fastq_maxee 1 --fastaout output.fasta 
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Reading input file 100%
1408755 sequences kept (of which 0 truncated), 1201725 sequences discarded.
```

</details>
</td>

<td markdown>🕓 32.9 s<br/>📈 <b>4.4 MiB</b> 🏆 (1.66x)</td>

</tr>


<tr markdown>
<td markdown>USEARCH</td>

<td markdown>

```bash
usearch -fastq_filter input.fastq -fastq_maxee 1 -fastaout output.fasta
```

<details><summary>🟦 output</summary>

```
usearch v11.0.667_i86linux32, 4.0Gb RAM (32.1Gb total), 16 cores
(C) Copyright 2013-18 Robert C. Edgar, all rights reserved.
https://drive5.com/usearch
License: personal use only
```

</details>
<details><summary> messages</summary>

```
00:00 4.2Mb  FASTQ base 33 for file input.fastq
00:00 38Mb   CPU has 16 cores, defaulting to 10 threads
00:00 115Mb     0.1% Filtering00:01 123Mb     1.0% Filtering, 31.4% passed00:02 123Mb     8.7% Filtering, 31.5% passed00:03 123Mb    16.4% Filtering, 31.8% passed00:04 123Mb    22.1% Filtering, 40.1% passed00:05 123Mb    26.7% Filtering, 47.6% passed00:06 123Mb    31.5% Filtering, 52.6% passed00:07 123Mb    36.4% Filtering, 56.2% passed00:08 123Mb    41.3% Filtering, 59.1% passed00:09 123Mb    47.2% Filtering, 60.1% passed00:10 123Mb    53.5% Filtering, 60.1% passed00:11 123Mb    61.1% Filtering, 56.6% passed00:12 123Mb    68.7% Filtering, 53.5% passed00:13 123Mb    75.4% Filtering, 53.7% passed00:14 123Mb    83.4% Filtering, 51.4% passed00:15 123Mb    89.4% Filtering, 52.2% passed00:16 123Mb    95.1% Filtering, 53.2% passed00:16 90Mb    100.0% Filtering, 54.0% passed
   2610480  Reads (2.6M)
   1201725  Discarded reads with expected errs > 1.00
   1408755  Filtered reads (1.4M, 54.0%)
```

</details>
</td>

<td markdown>🕓 <b>16.0 s</b> 🏆 (1.7x) 997% CPU<br/>📈 34.9 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 27.9 s<br/>📈 7.2 MiB</td>

</tr>

<tr markdown>
<td markdown>

Select records from a large set of sequences given a list of 1000 sequence IDs

</td>

<td markdown>

```bash
st filter -m ids_list.txt 'has_meta()' input.fasta > output.fasta
```


<details markdown><summary><b>VSEARCH</b> 🕓 28.1 s  ❙  <b>SeqKit</b> 🕓 <b>1.0 s</b> 🏆 (1.6x)</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --fastx_getseqs input.fasta --labels ids_list.txt --fastaout output.fasta
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Reading labels 100%
Extracting sequences 100%
1000 of 2610480 sequences extracted (0.0%)
```

</details>
</td>

<td markdown>🕓 28.1 s<br/>📈 <b>4.2 MiB</b> 🏆 (1.85x)</td>

</tr>


<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit grep -f ids_list.txt input.fasta > output.fasta
```

<details><summary> messages</summary>

```
[INFO][0m 1000 patterns loaded from file
```

</details>
</td>

<td markdown>🕓 <b>1.0 s</b> 🏆 (1.6x)<br/>📈 21.8 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 1.6 s<br/>📈 7.9 MiB</td>

</tr>

</table>

## sample
<table markdown class="cmd">

<tr markdown>
<td markdown>

Random subsampling to 1000 of sequences

</td>

<td markdown>

```bash
st sample -n 1000 input.fasta > output.fasta
```


<details markdown><summary><b>VSEARCH</b> 🕓 4.3 s  ❙  <b>Seqtk</b> 🕓 0.8 s  ❙  <b>SeqKit</b> 🕓 11.5 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --fastx_subsample input.fasta --sample_size 1000 --fastaout output.fasta
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Reading file input.fasta 100%
712939424 nt in 2610480 seqs, min 35, max 301, avg 273
Got 2610480 reads from 2610480 amplicons
Subsampling 100%
Writing output 100%
Subsampled 1000 reads from 1000 amplicons
```

</details>
</td>

<td markdown>🕓 4.3 s<br/>📈 841.5 MiB</td>

</tr>


<tr markdown>
<td markdown>Seqtk</td>

<td markdown>

```bash
seqtk sample input.fasta 1000 > output.fasta
```

</td>

<td markdown>🕓 0.8 s<br/>📈 <b>3.5 MiB</b> 🏆 (2.07x)</td>

</tr>


<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit sample -n 1000 input.fasta > output.fasta
```

<details><summary> messages</summary>

```
[INFO][0m sample by number
[INFO][0m loading all sequences into memory...
[INFO][0m 1000 sequences outputted
```

</details>
</td>

<td markdown>🕓 11.5 s<br/>📈 3112.7 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>0.5 s</b> 🏆 (1.4x)<br/>📈 7.2 MiB</td>

</tr>

<tr markdown>
<td markdown>

Random subsampling to ~10% of sequences

</td>

<td markdown>

```bash
st sample -p 0.1 input.fasta > output.fasta
```


<details markdown><summary><b>Seqtk</b> 🕓 1.7 s  ❙  <b>SeqKit</b> 🕓 2.0 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>Seqtk</td>

<td markdown>

```bash
seqtk sample input.fastq 0.1 > output.fasta
```

</td>

<td markdown>🕓 1.7 s<br/>📈 <b>3.5 MiB</b> 🏆 (2.04x)</td>

</tr>


<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit sample -p 0.1 input.fastq > output.fasta
```

<details><summary> messages</summary>

```
[INFO][0m sample by proportion
[INFO][0m 260463 sequences outputted
```

</details>
</td>

<td markdown>🕓 2.0 s<br/>📈 27.6 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>0.8 s</b> 🏆 (2.2x)<br/>📈 7.1 MiB</td>

</tr>

</table>

## find
<table markdown class="cmd">

<tr markdown>
<td markdown>

Find the forward primer location in the input reads with up to 4 mismatches

</td>

<td markdown>

```bash
st find -D4 file:primers.fasta input.fastq -a primer={pattern_name} -a rng={match_range} > output.fastq
```

<details><summary> messages</summary>

```
Note: the sequence type of the pattern 'ITS4' was determined as 'dna'. If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
```

</details>

<details markdown><summary><b>st (4 threads)</b> 🕓 <b>6.0 s</b> 🏆 (3.5x)  ❙  <b>st (max. mismatches = 2)</b> 🕓 21.1 s  ❙  <b>st (max. mismatches = 8)</b> 🕓 26.7 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>st (4 threads)</td>

<td markdown>

```bash
st find -t4 -D4 file:primers.fasta input.fastq -a primer={pattern_name} -a rng={match_range} > output.fastq
```

<details><summary> messages</summary>

```
Note: the sequence type of the pattern 'ITS4' was determined as 'dna'. If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
```

</details>
</td>

<td markdown>🕓 <b>6.0 s</b> 🏆 (3.5x) 402% CPU<br/>📈 17.6 MiB</td>

</tr>


<tr markdown>
<td markdown>st (max. mismatches = 2)</td>

<td markdown>

```bash
st find -D2 file:primers.fasta input.fastq -a primer={pattern_name} -a rng={match_range} > output.fastq
```

<details><summary> messages</summary>

```
Note: the sequence type of the pattern 'ITS4' was determined as 'dna'. If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
```

</details>
</td>

<td markdown>🕓 21.1 s<br/>📈 7.5 MiB</td>

</tr>


<tr markdown>
<td markdown>st (max. mismatches = 8)</td>

<td markdown>

```bash
st find -D8 file:primers.fasta input.fastq -a primer={pattern_name} -a rng={match_range} > output.fastq
```

<details><summary> messages</summary>

```
Note: the sequence type of the pattern 'ITS4' was determined as 'dna'. If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
```

</details>
</td>

<td markdown>🕓 26.7 s<br/>📈 7.4 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 21.3 s<br/>📈 <b>7.4 MiB</b> 🏆 (1.00x)</td>

</tr>

<tr markdown>
<td markdown>

Find and trim the forward primer up to an error rate (edit distance) of 20%, discarding unmatched reads. *Note:* Unlike Cutadapt, seqtool currently does not offer ungapped alignments (`--no-indels`).


</td>

<td markdown>

```bash
st find -f file:primers.fasta -R 0.2 input.fastq -a primer={pattern_name} -a end={match_end} |
  st trim -e '{attr(end)}:' --fq > output.fastq

```

<details><summary> messages</summary>

```
Note: the sequence type of the pattern 'ITS4' was determined as 'dna'. If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
```

</details>

<details markdown><summary><b>Cutadapt</b> 🕓 67.1 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>Cutadapt</td>

<td markdown>

```bash
cutadapt -g 'file:primers.fasta;min_overlap=15' input.fastq -e 0.2 --rename '{id} primer={adapter_name}' --discard-untrimmed > output.fastq 
```

<details><summary> messages</summary>

```
This is cutadapt 4.6 with Python 3.12.2
Command line parameters: -g file:primers.fasta;min_overlap=15 input.fastq -e 0.2 --rename {id} primer={adapter_name} --discard-untrimmed
Processing single-end reads on 1 core ...
Finished in 66.906 s (25.630 µs/read; 2.34 M reads/minute).
=== Summary ===
Total reads processed:               2,610,480
Reads with adapters:                   828,740 (31.7%)
== Read fate breakdown ==
Reads discarded as untrimmed:        1,781,740 (68.3%)
Reads written (passing filters):       828,740 (31.7%)
Total basepairs processed:   712,939,424 bp
Total written (filtered):    209,047,405 bp (29.3%)
=== Adapter ITS4 ===
Sequence: GTCCTCCGCTTATTGATATGC; Type: regular 5'; Length: 21; Trimmed: 828740 times
Minimum overlap: 15
No. of allowed errors:
1-4 bp: 0; 5-9 bp: 1; 10-14 bp: 2; 15-19 bp: 3; 20-21 bp: 4
Overview of removed sequences
length	count	expect	max.err	error counts
15	8	0.0	3	3 1 3 1
16	12	0.0	3	1 3 4 4
17	7	0.0	3	3 0 0 4
18	11	0.0	3	2 6 1 2
19	12	0.0	3	1 2 6 1 2
20	15	0.0	4	3 5 3 2 2
21	29	0.0	4	2 11 4 2 10
22	73	0.0	4	5 23 8 15 22
23	221	0.0	4	10 46 39 53 73
24	723	0.0	4	27 96 180 381 39
25	8858	0.0	4	439 2961 4797 468 193
26	816649	0.0	4	202089 581641 27831 3348 1740
27	1926	0.0	4	184 840 797 74 31
28	33	0.0	4	4 22 2 3 2
29	15	0.0	4	1 11 1 1 1
30	4	0.0	4	1 3
31	1	0.0	4	1
32	3	0.0	4	2 1
33	1	0.0	4	1
34	1	0.0	4	1
35	2	0.0	4	0 2
40	2	0.0	4	0 2
41	2	0.0	4	0 2
42	3	0.0	4	1 2
45	1	0.0	4	0 1
47	1	0.0	4	0 0 0 0 1
48	1	0.0	4	1
51	6	0.0	4	0 0 0 0 6
54	1	0.0	4	0 0 0 0 1
58	16	0.0	4	0 0 0 0 16
59	2	0.0	4	0 1 0 0 1
60	2	0.0	4	0 0 0 0 2
61	20	0.0	4	0 1 0 0 19
62	1	0.0	4	0 0 0 0 1
63	12	0.0	4	0 1 0 1 10
64	2	0.0	4	0 0 0 0 2
66	2	0.0	4	0 0 0 1 1
67	24	0.0	4	0 0 3 5 16
68	4	0.0	4	0 0 1 0 3
69	1	0.0	4	0 0 0 0 1
85	2	0.0	4	0 2
86	5	0.0	4	1 3 0 0 1
105	4	0.0	4	0 0 0 0 4
138	1	0.0	4	0 0 0 0 1
190	2	0.0	4	0 0 0 0 2
203	1	0.0	4	0 0 0 0 1
226	2	0.0	4	0 0 0 0 2
227	1	0.0	4	0 0 0 0 1
228	3	0.0	4	0 0 0 0 3
230	1	0.0	4	0 0 0 0 1
247	1	0.0	4	0 0 0 0 1
249	1	0.0	4	0 0 0 0 1
251	5	0.0	4	0 0 0 0 5
252	1	0.0	4	0 0 0 0 1
255	1	0.0	4	0 0 0 0 1
258	1	0.0	4	0 0 0 0 1
290	1	0.0	4	0 0 0 0 1
```

</details>
</td>

<td markdown>🕓 67.1 s<br/>📈 20.9 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>16.9 s</b> 🏆 (4.0x) 120% CPU<br/>📈 <b>7.4 MiB</b> 🏆 (2.83x)</td>

</tr>

<tr markdown>
<td markdown>

Find and trim the forward primer in parallel using 4 threads (cores).


</td>

<td markdown>

```bash
st find -f file:primers.fasta -R 0.2 -t4 input.fastq -a primer={pattern_name} -a end={match_end} |
  st trim -e '{attr(end)}:' --fq > output.fastq

```

<details><summary> messages</summary>

```
Note: the sequence type of the pattern 'ITS4' was determined as 'dna'. If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
```

</details>

<details markdown><summary><b>Cutadapt</b> 🕓 18.1 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>Cutadapt</td>

<td markdown>

```bash
cutadapt -j4 -g 'file:primers.fasta;min_overlap=15' input.fastq -e 0.2 --rename '{id} primer={adapter_name}' --discard-untrimmed > output.fastq 
```

<details><summary> messages</summary>

```
This is cutadapt 4.6 with Python 3.12.2
Command line parameters: -j4 -g file:primers.fasta;min_overlap=15 input.fastq -e 0.2 --rename {id} primer={adapter_name} --discard-untrimmed
Processing single-end reads on 4 cores ...
Finished in 17.956 s (6.878 µs/read; 8.72 M reads/minute).
=== Summary ===
Total reads processed:               2,610,480
Reads with adapters:                   828,740 (31.7%)
== Read fate breakdown ==
Reads discarded as untrimmed:        1,781,740 (68.3%)
Reads written (passing filters):       828,740 (31.7%)
Total basepairs processed:   712,939,424 bp
Total written (filtered):    209,047,405 bp (29.3%)
=== Adapter ITS4 ===
Sequence: GTCCTCCGCTTATTGATATGC; Type: regular 5'; Length: 21; Trimmed: 828740 times
Minimum overlap: 15
No. of allowed errors:
1-4 bp: 0; 5-9 bp: 1; 10-14 bp: 2; 15-19 bp: 3; 20-21 bp: 4
Overview of removed sequences
length	count	expect	max.err	error counts
15	8	0.0	3	3 1 3 1
16	12	0.0	3	1 3 4 4
17	7	0.0	3	3 0 0 4
18	11	0.0	3	2 6 1 2
19	12	0.0	3	1 2 6 1 2
20	15	0.0	4	3 5 3 2 2
21	29	0.0	4	2 11 4 2 10
22	73	0.0	4	5 23 8 15 22
23	221	0.0	4	10 46 39 53 73
24	723	0.0	4	27 96 180 381 39
25	8858	0.0	4	439 2961 4797 468 193
26	816649	0.0	4	202089 581641 27831 3348 1740
27	1926	0.0	4	184 840 797 74 31
28	33	0.0	4	4 22 2 3 2
29	15	0.0	4	1 11 1 1 1
30	4	0.0	4	1 3
31	1	0.0	4	1
32	3	0.0	4	2 1
33	1	0.0	4	1
34	1	0.0	4	1
35	2	0.0	4	0 2
40	2	0.0	4	0 2
41	2	0.0	4	0 2
42	3	0.0	4	1 2
45	1	0.0	4	0 1
47	1	0.0	4	0 0 0 0 1
48	1	0.0	4	1
51	6	0.0	4	0 0 0 0 6
54	1	0.0	4	0 0 0 0 1
58	16	0.0	4	0 0 0 0 16
59	2	0.0	4	0 1 0 0 1
60	2	0.0	4	0 0 0 0 2
61	20	0.0	4	0 1 0 0 19
62	1	0.0	4	0 0 0 0 1
63	12	0.0	4	0 1 0 1 10
64	2	0.0	4	0 0 0 0 2
66	2	0.0	4	0 0 0 1 1
67	24	0.0	4	0 0 3 5 16
68	4	0.0	4	0 0 1 0 3
69	1	0.0	4	0 0 0 0 1
85	2	0.0	4	0 2
86	5	0.0	4	1 3 0 0 1
105	4	0.0	4	0 0 0 0 4
138	1	0.0	4	0 0 0 0 1
190	2	0.0	4	0 0 0 0 2
203	1	0.0	4	0 0 0 0 1
226	2	0.0	4	0 0 0 0 2
227	1	0.0	4	0 0 0 0 1
228	3	0.0	4	0 0 0 0 3
230	1	0.0	4	0 0 0 0 1
247	1	0.0	4	0 0 0 0 1
249	1	0.0	4	0 0 0 0 1
251	5	0.0	4	0 0 0 0 5
252	1	0.0	4	0 0 0 0 1
255	1	0.0	4	0 0 0 0 1
258	1	0.0	4	0 0 0 0 1
290	1	0.0	4	0 0 0 0 1
```

</details>
</td>

<td markdown>🕓 18.1 s 413% CPU<br/>📈 39.4 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>4.9 s</b> 🏆 (3.7x) 448% CPU<br/>📈 <b>17.8 MiB</b> 🏆 (2.22x)</td>

</tr>

</table>

## replace
<table markdown class="cmd">

<tr markdown>
<td markdown>

Convert DNA to RNA using the replace command

</td>

<td markdown>

```bash
st replace T U input.fasta > output.fasta
```


<details markdown><summary><b>st find</b> 🕓 14.3 s  ❙  <b>SeqKit</b> 🕓 <b>4.8 s</b> 🏆 (2.1x)  ❙  <b>FASTX-Toolkit</b> 🕓 283.5 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>st find</td>

<td markdown>

```bash
st find T --rep U input.fasta > output.fasta
```

<details><summary> messages</summary>

```
Note: the sequence type of the pattern was determined as 'dna'. If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
```

</details>
</td>

<td markdown>🕓 14.3 s<br/>📈 7.2 MiB</td>

</tr>


<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit seq --dna2rna  input.fasta > output.fasta
```

</td>

<td markdown>🕓 <b>4.8 s</b> 🏆 (2.1x)<br/>📈 27.3 MiB</td>

</tr>


<tr markdown>
<td markdown>FASTX-Toolkit</td>

<td markdown>

```bash
fasta_nucleotide_changer -r -i input.fasta > output.fasta
```

</td>

<td markdown>🕓 283.5 s<br/>📈 <b>3.5 MiB</b> 🏆 (2.07x)</td>

</tr>

</table>

</details>

</td>

<td>🕓 10.1 s<br/>📈 7.2 MiB</td>

</tr>

<tr markdown>
<td markdown>

Convert DNA to RNA using 4 threads

</td>

<td markdown>

```bash
st replace -t4 T U input.fasta > output.fasta
```


<details markdown><summary><b>st find</b> 🕓 8.4 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>st find</td>

<td markdown>

```bash
st find -t4 T --rep U input.fasta > output.fasta
```

<details><summary> messages</summary>

```
Note: the sequence type of the pattern was determined as 'dna'. If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
```

</details>
</td>

<td markdown>🕓 8.4 s 282% CPU<br/>📈 24.6 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>2.7 s</b> 🏆 (3.1x) 418% CPU<br/>📈 <b>9.0 MiB</b> 🏆 (2.74x)</td>

</tr>

</table>

## trim
<table markdown class="cmd">

<tr markdown>
<td markdown>

Trim the leading 99 bp from the sequences

</td>

<td markdown>

```bash
st trim 100: input.fasta > output.fasta
```


<details markdown><summary><b>SeqKit (creates FASTA index)</b> 🕓 44.8 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>SeqKit (creates FASTA index)</td>

<td markdown>

```bash
seqkit subseq -r '100:-1'  input.fasta > output.fasta
```

<details><summary> messages</summary>

```
[INFO][0m create or read FASTA index ...
[INFO][0m create FASTA index for input.fasta
[INFO][0m   2610480 records loaded from input.fasta.seqkit.fai
```

</details>
</td>

<td markdown>🕓 44.8 s<br/>📈 1254.5 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>2.8 s</b> 🏆 (16.0x)<br/>📈 <b>7.4 MiB</b> 🏆 (170.10x)</td>

</tr>

</table>

## upper
<table markdown class="cmd">

<tr markdown>
<td markdown>

Convert sequences to uppercase

</td>

<td markdown>

```bash
st upper input.fasta > output.fasta
```


<details markdown><summary><b>Seqtk</b> 🕓 5.2 s  ❙  <b>SeqKit</b> 🕓 4.2 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>Seqtk</td>

<td markdown>

```bash
seqtk seq -U input.fasta > output.fasta
```

</td>

<td markdown>🕓 5.2 s<br/>📈 <b>3.5 MiB</b> 🏆 (2.11x)</td>

</tr>


<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit seq -u  input.fasta > output.fasta
```

</td>

<td markdown>🕓 4.2 s<br/>📈 62.2 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>3.0 s</b> 🏆 (1.4x)<br/>📈 7.4 MiB</td>

</tr>

</table>

## revcomp
<table markdown class="cmd">

<tr markdown>
<td markdown>

Reverse complement sequences

</td>

<td markdown>

```bash
st revcomp input.fasta > output.fasta
```


<details markdown><summary><b>Seqtk</b> 🕓 <b>5.3 s</b> 🏆 (1.1x)  ❙  <b>VSEARCH</b> 🕓 7.7 s  ❙  <b>SeqKit</b> 🕓 7.8 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>Seqtk</td>

<td markdown>

```bash
seqtk seq -r input.fasta > output.fasta
```

</td>

<td markdown>🕓 <b>5.3 s</b> 🏆 (1.1x)<br/>📈 <b>3.5 MiB</b> 🏆 (1.21x)</td>

</tr>


<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --fastx_revcomp input.fasta --fastaout output.fasta 
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Reading FASTA file 100%
```

</details>
</td>

<td markdown>🕓 7.7 s<br/>📈 4.2 MiB</td>

</tr>


<tr markdown>
<td markdown>SeqKit</td>

<td markdown>

```bash
seqkit seq -rp  input.fasta > output.fasta
```

<details><summary> messages</summary>

```
[33m[WARN][0m flag -t (--seq-type) (DNA/RNA) is recommended for computing complement sequences
```

</details>
</td>

<td markdown>🕓 7.8 s<br/>📈 28.1 MiB</td>

</tr>

</table>

</details>

</td>

<td>🕓 6.0 s<br/>📈 7.2 MiB</td>

</tr>

</table>

## concat
<table markdown class="cmd">

<tr markdown>
<td markdown>

Concatenate sequences, adding an `NNNNN` spacer inbetween

</td>

<td markdown>

```bash
st concat -s 5 -c N file1.fastq file2.fastq > output.fastq
```


<details markdown><summary><b>VSEARCH</b> 🕓 20.5 s</summary>

<table markdown class="cmd">

<tr markdown>
<td markdown>VSEARCH</td>

<td markdown>

```bash
vsearch --fastq_join file1.fastq --reverse file2.fastq --join_padgap NNNNN --fastqout output.fastq
```

<details><summary> messages</summary>

```
vsearch v2.28.1_linux_x86_64, 30.6GB RAM, 16 cores
https://github.com/torognes/vsearch
Joining reads 100%
2610480 pairs joined
```

</details>
</td>

<td markdown>🕓 20.5 s<br/>📈 <b>4.2 MiB</b> 🏆 (1.74x)</td>

</tr>

</table>

</details>

</td>

<td>🕓 <b>9.9 s</b> 🏆 (2.1x)<br/>📈 7.4 MiB</td>

</tr>

</table>

