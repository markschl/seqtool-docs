## pass
<table>
<tr>
<td>Do nothing, just read and write FASTA<td>
<td><pre language="sh">st pass input.fasta > output.fasta</pre>
<details><summary><b>SeqKit</b> 🕓 <b>0.5 s</b> 🏆 (1.2x)</summary>
<table><tr><td>SeqKit</td><td><pre language="sh">seqkit seq  input.fasta > output.fasta</pre></td><td>🕓 <b>0.5 s</b> 🏆 (1.2x)<br/>📈 26.4 MB</td></tr>
</table>
</details>
</td>
<td>🕓 0.6 s 74% CPU<br/>📈 <b>6.5 MB</b> 🏆 (4.08x)</td>
</tr>
<tr>
<td>Convert FASTQ to FASTA<td>
<td><pre language="sh">st pass --to-fa input.fastq > output.fasta</pre>
<details><summary><b>FASTX-Toolkit</b> 🕓 388.4 s  ❙  <b>Seqtk</b> 🕓 2.5 s  ❙  <b>SeqKit</b> 🕓 1.8 s</summary>
<table><tr><td>FASTX-Toolkit</td><td><pre language="sh">fastq_to_fasta -Q33 -i input.fastq > output.fasta</pre></td><td>🕓 388.4 s<br/>📈 3.4 MB</td></tr>
<tr><td>Seqtk</td><td><pre language="sh">seqtk seq -A input.fastq > output.fasta</pre></td><td>🕓 2.5 s<br/>📈 <b>3.4 MB</b> 🏆 (1.00x)</td></tr>
<tr><td>SeqKit</td><td><pre language="sh">seqkit fq2fa input.fastq > output.fasta</pre></td><td>🕓 1.8 s<br/>📈 17.5 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>1.3 s</b> 🏆 (1.3x)<br/>📈 6.5 MB</td>
</tr>
<tr>
<td>Convert FASTQ quality scores<td>
<td><pre language="sh">st pass --to fastq-illumina input.fastq > output.fastq</pre>
<details><summary><b>SeqKit</b> 🕓 9.5 s</summary>
<table><tr><td>SeqKit</td><td><pre language="sh">seqkit convert --from 'Sanger' --to 'Illumina-1.3+' input.fastq > output.fastq</pre><details><summary> messages</summary><pre>[INFO][0m converting Sanger -> Illumina-1.3+
</pre></details></td><td>🕓 9.5 s<br/>📈 83.2 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>5.8 s</b> 🏆 (1.6x)<br/>📈 <b>6.6 MB</b> 🏆 (12.54x)</td>
</tr>
<tr>
<td>Write compressed FASTQ files in GZIP format<td>
<td><pre language="sh">st pass input.fastq -o output.fastq.gz </pre>
<details><summary><b>st (to file)</b> 🕓 39.8 s  ❙  <b>st + gzip</b> 🕓 168.7 s  ❙  <b>SeqKit (to file)</b> 🕓 <b>20.1 s</b> 🏆 (1.9x)</summary>
<table><tr><td>st (to file)</td><td><pre language="sh">st pass input.fastq -o output.fastq.gz</pre></td><td>🕓 39.8 s<br/>📈 27.1 MB</td></tr>
<tr><td>st + gzip</td><td><pre language="sh">st pass input.fastq | gzip -c > output.fastq.gz</pre></td><td>🕓 168.7 s<br/>📈 <b>6.6 MB</b> 🏆 (3.99x)</td></tr>
<tr><td>SeqKit (to file)</td><td><pre language="sh">seqkit seq input.fastq -o output.fastq.gz</pre></td><td>🕓 <b>20.1 s</b> 🏆 (1.9x)<br/>📈 26.4 MB</td></tr>
</table>
</details>
</td>
<td>🕓 38.7 s<br/>📈 27.1 MB</td>
</tr>
<tr>
<td>Write compressed FASTQ files in GZIP format<td>
<td><pre language="sh">st pass input.fastq > /dev/null</pre>
<details><summary><b>st to .gz</b> 🕓 39.0 s  ❙  <b>st | gzip piped</b> 🕓 168.5 s  ❙  <b>st to .zst</b> 🕓 7.5 s  ❙  <b>st | zstd piped</b> 🕓 6.9 s  ❙  <b>st to .lz4</b> 🕓 6.0 s  ❙  <b>st | lz4 piped</b> 🕓 7.5 s</summary>
<table><tr><td>st to .gz</td><td><pre language="sh">st pass input.fastq --to fq.gz > /dev/null</pre></td><td>🕓 39.0 s<br/>📈 27.2 MB</td></tr>
<tr><td>st | gzip piped</td><td><pre language="sh">st pass input.fastq | gzip -c > /dev/null</pre></td><td>🕓 168.5 s<br/>📈 6.7 MB</td></tr>
<tr><td>st to .zst</td><td><pre language="sh">st pass input.fastq --to fq.zst > /dev/null</pre></td><td>🕓 7.5 s 124% CPU<br/>📈 10.5 MB</td></tr>
<tr><td>st | zstd piped</td><td><pre language="sh">st pass input.fastq | zstd -c > /dev/null</pre></td><td>🕓 6.9 s 164% CPU<br/>📈 36.4 MB</td></tr>
<tr><td>st to .lz4</td><td><pre language="sh">st pass input.fastq --to fq.lz4 > /dev/null</pre></td><td>🕓 6.0 s 123% CPU<br/>📈 27.0 MB</td></tr>
<tr><td>st | lz4 piped</td><td><pre language="sh">st pass input.fastq | lz4 -c > /dev/null</pre></td><td>🕓 7.5 s 122% CPU<br/>📈 6.7 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>1.7 s</b> 🏆 (3.4x)<br/>📈 <b>6.6 MB</b> 🏆 (1.02x)</td>
</tr>
</table>

## replace
<table>
<tr>
<td>Convert DNA to RNA using the replace command<td>
<td><pre language="sh">st replace T U input.fasta > output.fasta</pre>
<details><summary><b>st (4 threads)</b> 🕓 <b>1.8 s</b> 🏆 (1.7x)  ❙  <b>st find</b> 🕓 6.8 s  ❙  <b>st find (4 threads)</b> 🕓 3.6 s  ❙  <b>SeqKit</b> 🕓 3.0 s  ❙  <b>FASTX-Toolkit</b> 🕓 148.0 s</summary>
<table><tr><td>st (4 threads)</td><td><pre language="sh">st replace -t4 T U input.fasta > output.fasta</pre></td><td>🕓 <b>1.8 s</b> 🏆 (1.7x) 335% CPU<br/>📈 8.0 MB</td></tr>
<tr><td>st find</td><td><pre language="sh">st find T --rep U input.fasta > output.fasta</pre><details><summary> messages</summary><pre>Note: the sequence type of the pattern was determined as 'dna'. If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
</pre></details></td><td>🕓 6.8 s<br/>📈 6.7 MB</td></tr>
<tr><td>st find (4 threads)</td><td><pre language="sh">st find -t4 T --rep U input.fasta > output.fasta</pre><details><summary> messages</summary><pre>Note: the sequence type of the pattern was determined as 'dna'. If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
</pre></details></td><td>🕓 3.6 s 257% CPU<br/>📈 24.8 MB</td></tr>
<tr><td>SeqKit</td><td><pre language="sh">seqkit seq --dna2rna  input.fasta > output.fasta</pre></td><td>🕓 3.0 s<br/>📈 15.9 MB</td></tr>
<tr><td>FASTX-Toolkit</td><td><pre language="sh">fasta_nucleotide_changer -r -i input.fasta > output.fasta</pre><details><summary> messages</summary><pre>fasta_nucleotide_changer: Failed to read complete record, missing 2nd line (nucleotides), on line 2593934

</pre></details></td><td>🕓 148.0 s<br/>📈 <b>3.4 MB</b> 🏆 (1.97x)</td></tr>
</table>
</details>
</td>
<td>🕓 4.7 s<br/>📈 6.6 MB</td>
</tr>
</table>

## sample
<table>
<tr>
<td>Random subsampling to 10% of sequences (approximately)<td>
<td><pre language="sh">st sample -p 0.1 input.fasta > output.fasta</pre>
<details><summary><b>Seqtk</b> 🕓 1.6 s  ❙  <b>SeqKit</b> 🕓 1.6 s</summary>
<table><tr><td>Seqtk</td><td><pre language="sh">seqtk sample input.fastq 0.1 > output.fasta</pre></td><td>🕓 1.6 s<br/>📈 <b>3.2 MB</b> 🏆 (2.07x)</td></tr>
<tr><td>SeqKit</td><td><pre language="sh">seqkit sample -p 0.1 input.fastq > output.fasta</pre><details><summary> messages</summary><pre>[INFO][0m sample by proportion
[INFO][0m 333956 sequences outputted
</pre></details></td><td>🕓 1.6 s<br/>📈 16.5 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>0.2 s</b> 🏆 (6.6x)<br/>📈 6.7 MB</td>
</tr>
</table>

## count
<table>
<tr>
<td>Count the number of FASTQ sequences in the input<td>
<td><pre language="sh">st count input.fastq</pre>
<details><summary><b>Seqtk</b> 🕓 <b>0.3 s</b> 🏆 (2.3x)  ❙  <b>GC content summary (10% intervals)</b> 🕓 7.0 s  ❙  <b>GC content summary (100% intervals with expression engine)</b> 🕓 10.3 s</summary>
<table><tr><td>Seqtk</td><td><pre language="sh">seqtk size input.fasta</pre></td><td>🕓 <b>0.3 s</b> 🏆 (2.3x)<br/>📈 <b>3.3 MB</b> 🏆 (2.02x)</td></tr>
<tr><td>GC content summary (10% intervals)</td><td><pre language="sh">st count -k 'bin(gc_percent, 10)' input.fastq</pre></td><td>🕓 7.0 s<br/>📈 6.7 MB</td></tr>
<tr><td>GC content summary (100% intervals with expression engine)</td><td><pre language="sh">st count -k '{bin(gc_percent/100*100, 100)}' input.fastq</pre></td><td>🕓 10.3 s<br/>📈 108.3 MB</td></tr>
</table>
</details>
</td>
<td>🕓 0.8 s<br/>📈 6.6 MB</td>
</tr>
</table>

## revcomp
<table>
<tr>
<td>Reverse complement sequences<td>
<td><pre language="sh">st revcomp input.fasta > output.fasta</pre>
<details><summary><b>Seqtk</b> 🕓 <b>1.3 s</b> 🏆 (1.5x)  ❙  <b>SeqKit</b> 🕓 3.2 s</summary>
<table><tr><td>Seqtk</td><td><pre language="sh">seqtk seq -r input.fasta > output.fasta</pre></td><td>🕓 <b>1.3 s</b> 🏆 (1.5x)<br/>📈 <b>3.4 MB</b> 🏆 (2.02x)</td></tr>
<tr><td>SeqKit</td><td><pre language="sh">seqkit seq -rp  input.fasta > output.fasta</pre><details><summary> messages</summary><pre>[33m[WARN][0m flag -t (--seq-type) (DNA/RNA) is recommended for computing complement sequences
</pre></details></td><td>🕓 3.2 s<br/>📈 24.3 MB</td></tr>
</table>
</details>
</td>
<td>🕓 2.0 s<br/>📈 6.9 MB</td>
</tr>
</table>

## upper
<table>
<tr>
<td>Convert sequences to uppercase<td>
<td><pre language="sh">st upper input.fasta > output.fasta</pre>
<details><summary><b>Seqtk</b> 🕓 1.3 s  ❙  <b>SeqKit</b> 🕓 1.8 s</summary>
<table><tr><td>Seqtk</td><td><pre language="sh">seqtk seq -U input.fasta > output.fasta</pre></td><td>🕓 1.3 s<br/>📈 <b>3.4 MB</b> 🏆 (2.00x)</td></tr>
<tr><td>SeqKit</td><td><pre language="sh">seqkit seq -u  input.fasta > output.fasta</pre></td><td>🕓 1.8 s<br/>📈 53.4 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>0.5 s</b> 🏆 (2.7x)<br/>📈 6.8 MB</td>
</tr>
</table>

## trim
<table>
<tr>
<td>Trim sequences<td>
<td><pre language="sh">st trim 100.. input.fasta > output.fasta</pre>
<details><summary><b>SeqKit</b> 🕓 5.6 s</summary>
<table><tr><td>SeqKit</td><td><pre language="sh">seqkit subseq -r '100:-1'  input.fasta > output.fasta</pre><details><summary> messages</summary><pre>[INFO][0m create or read FASTA index ...
[INFO][0m read FASTA index from input.fasta.seqkit.fai
[INFO][0m   1296967 records loaded from input.fasta.seqkit.fai
</pre></details></td><td>🕓 5.6 s<br/>📈 589.7 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>0.5 s</b> 🏆 (12.0x)<br/>📈 <b>6.7 MB</b> 🏆 (87.77x)</td>
</tr>
</table>

## unique
<table>
<tr>
<td>Remove duplicate sequences using sequence hashes. This is faster and more memory efficient than keeping the whole sequence around.
<td>
<td><pre language="sh">st unique seqhash input.fasta > output.fasta</pre>
<details><summary><b>SeqKit</b> 🕓 <b>1.0 s</b> 🏆 (1.0x)</summary>
<table><tr><td>SeqKit</td><td><pre language="sh">seqkit rmdup -sP  input.fasta > output.fasta</pre><details><summary> messages</summary><pre>[INFO][0m 259402 duplicated records removed
</pre></details></td><td>🕓 <b>1.0 s</b> 🏆 (1.0x)<br/>📈 93.7 MB</td></tr>
</table>
</details>
</td>
<td>🕓 1.1 s<br/>📈 <b>61.9 MB</b> 🏆 (1.51x)</td>
</tr>
<tr>
<td>Remove duplicate sequences (exact mode without hashing). The match is case-insensitive. VSEARCH additionally treats &#x27;T&#x27; and &#x27;U&#x27; in the same way (seqtool doesn&#x27;t).
<td>
<td><pre language="sh">st unique seq input.fasta > output.fasta</pre>
<details><summary><b>st (sorted by sequence)</b> 🕓 <b>0.3 s</b> 🏆 (3.8x)  ❙  <b>SeqKit</b> 🕓 1.0 s  ❙  <b>VSEARCH</b> 🕓 5.4 s</summary>
<table><tr><td>st (sorted by sequence)</td><td><pre language="sh">st unique -s seq_upper input.fasta > output.fasta</pre></td><td>🕓 <b>0.3 s</b> 🏆 (3.8x)<br/>📈 <b>6.8 MB</b> 🏆 (15.19x)</td></tr>
<tr><td>SeqKit</td><td><pre language="sh">seqkit rmdup -sP  input.fasta > output.fasta</pre><details><summary> messages</summary><pre>[INFO][0m 259402 duplicated records removed
</pre></details></td><td>🕓 1.0 s<br/>📈 103.5 MB</td></tr>
<tr><td>VSEARCH</td><td><pre language="sh">vsearch --derep_fulllength input.fasta --output output.fasta </pre><details><summary> messages</summary><pre>vsearch v2.28.1_linux_x86_64, 15.4GB RAM, 8 cores
https://github.com/torognes/vsearch

Dereplicating file input.fasta 100%
389970586 nt in 1296966 seqs, min 290, max 301, avg 301
minseqlength 32: 1 sequence discarded.
Sorting 100%
1037564 unique sequences, avg cluster 1.3, median 1, max 2134
Writing FASTA output file 100%
</pre></details></td><td>🕓 5.4 s<br/>📈 491.7 MB</td></tr>
</table>
</details>
</td>
<td>🕓 1.6 s<br/>📈 372.1 MB</td>
</tr>
<tr>
<td>Remove duplicate sequences (exact mode) using less memory<td>
<td><pre language="sh">st unique seq -M 50M input.fasta > output.fasta</pre>
<details><summary> messages</summary><pre>Memory limit reached after 133821 records, writing to temporary file(s). Consider raising the limit (-M/--max-mem) to speed up de-duplicating. Use -q/--quiet to silence this message.
</pre></details><details><summary><b>VSEARCH</b> 🕓 <b>0.0 s</b> 🏆 (812.0x)</summary>
<table><tr><td>VSEARCH</td><td><pre language="sh">vsearch --derep_smallmem input.fasta --output - > output.fasta</pre><details><summary> messages</summary><pre>Fatal error: Invalid options to command derep_smallmem
Invalid option(s): --output
The valid options for the derep_smallmem command are: --bzip2_decompress --fasta_width --fastaout --fastq_ascii --fastq_qmax --fastq_qmin --gzip_decompress --label_suffix --lengthout --log --maxseqlength --maxuniquesize --minseqlength --minuniquesize --no_progress --notrunclabels --quiet --relabel --relabel_keep --relabel_md5 --relabel_self --relabel_sha1 --sample --sizein --sizeout --strand --threads --xee --xlength --xsize
</pre></details></td><td>🕓 <b>0.0 s</b> 🏆 (812.0x) 37% CPU<br/>📈 <b>3.5 MB</b> 🏆 (15.82x)</td></tr>
</table>
</details>
</td>
<td>🕓 8.1 s<br/>📈 55.0 MB</td>
</tr>
<tr>
<td>Remove duplicate sequences, checking both strands<td>
<td><pre language="sh">st unique seqhash_both input.fasta > output.fasta</pre>
<details><summary><b>SeqKit</b> 🕓 6.6 s</summary>
<table><tr><td>SeqKit</td><td><pre language="sh">seqkit rmdup -s  input.fasta > output.fasta</pre><details><summary> messages</summary><pre>[INFO][0m 259402 duplicated records removed
</pre></details></td><td>🕓 6.6 s<br/>📈 171.5 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>2.9 s</b> 🏆 (2.3x)<br/>📈 <b>61.7 MB</b> 🏆 (2.78x)</td>
</tr>
<tr>
<td>Remove duplicate sequences, writing out USEARCH/VSEARCH-style abundance annotations in the headers: &#x27;&gt;id;size=NN&#x27;
<td>
<td><pre language="sh">st unique seq -a size={n_duplicates} --attr-fmt ';key=value' input.fasta > output.fasta</pre>
<details><summary><b>VSEARCH</b> 🕓 5.5 s</summary>
<table><tr><td>VSEARCH</td><td><pre language="sh">vsearch --derep_fulllength input.fasta --sizeout --output output.fasta </pre><details><summary> messages</summary><pre>vsearch v2.28.1_linux_x86_64, 15.4GB RAM, 8 cores
https://github.com/torognes/vsearch

Dereplicating file input.fasta 100%
389970586 nt in 1296966 seqs, min 290, max 301, avg 301
minseqlength 32: 1 sequence discarded.
Sorting 100%
1037564 unique sequences, avg cluster 1.3, median 1, max 2134
Writing FASTA output file 100%
</pre></details></td><td>🕓 5.5 s<br/>📈 <b>491.6 MB</b> 🏆 (1.66x)</td></tr>
</table>
</details>
</td>
<td>🕓 <b>3.0 s</b> 🏆 (1.8x)<br/>📈 815.5 MB</td>
</tr>
<tr>
<td>De-replicate both by sequence *and* record ID (the part before the first space in the header). The given benchmark actually has unique sequence IDs, so the result is the same as de-replication by sequence.
<td>
<td><pre language="sh">st unique id,seq input.fasta > output.fasta</pre>
<details><summary><b>SeqKit</b> 🕓 6.6 s  ❙  <b>VSEARCH</b> 🕓 7.2 s</summary>
<table><tr><td>SeqKit</td><td><pre language="sh">seqkit rmdup -s  input.fasta > output.fasta</pre><details><summary> messages</summary><pre>[INFO][0m 259402 duplicated records removed
</pre></details></td><td>🕓 6.6 s<br/>📈 <b>169.2 MB</b> 🏆 (3.41x)</td></tr>
<tr><td>VSEARCH</td><td><pre language="sh">vsearch --derep_id input.fasta --output output.fasta</pre><details><summary> messages</summary><pre>vsearch v2.28.1_linux_x86_64, 15.4GB RAM, 8 cores
https://github.com/torognes/vsearch

Dereplicating file input.fasta 100%
389970586 nt in 1296966 seqs, min 290, max 301, avg 301
minseqlength 32: 1 sequence discarded.
Sorting 100%
1296966 unique sequences, avg cluster 1.0, median 1, max 1
Writing FASTA output file 100%
</pre></details></td><td>🕓 7.2 s<br/>📈 715.7 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>2.1 s</b> 🏆 (3.2x)<br/>📈 577.9 MB</td>
</tr>
</table>

## filter
<table>
<tr>
<td>Filter sequences by length<td>
<td><pre language="sh">st filter 'seqlen >= 100' input.fastq > output.fastq</pre>
<details><summary><b>Seqtk</b> 🕓 3.0 s  ❙  <b>SeqKit</b> 🕓 <b>2.0 s</b> 🏆 (1.3x)</summary>
<table><tr><td>Seqtk</td><td><pre language="sh">seqtk seq -L 100 input.fastq > output.fastq</pre></td><td>🕓 3.0 s<br/>📈 <b>3.4 MB</b> 🏆 (1.98x)</td></tr>
<tr><td>SeqKit</td><td><pre language="sh">seqkit seq -m 100 input.fastq > output.fastq</pre><details><summary> messages</summary><pre>[33m[WARN][0m you may switch on flag -g/--remove-gaps to remove spaces
</pre></details></td><td>🕓 <b>2.0 s</b> 🏆 (1.3x)<br/>📈 16.6 MB</td></tr>
</table>
</details>
</td>
<td>🕓 2.5 s<br/>📈 6.8 MB</td>
</tr>
<tr>
<td>Filter sequences by quality<td>
<td><pre language="sh">st filter 'exp_err <= 1' input.fastq --to-fa</pre>
<details><summary><b>VSEARCH</b> 🕓 49.2 s  ❙  <b>USEARCH</b> 🕓 44.2 s</summary>
<table><tr><td>VSEARCH</td><td><pre language="sh">vsearch --fastq_filter input.fastq --fastq_maxee 1 --fastaout output.fasta </pre><details><summary> messages</summary><pre>vsearch v2.28.1_linux_x86_64, 15.4GB RAM, 8 cores
https://github.com/torognes/vsearch

Reading input file 100%
3348507 sequences kept (of which 0 truncated), 0 sequences discarded.
</pre></details></td><td>🕓 49.2 s<br/>📈 <b>3.5 MB</b> 🏆 (2.03x)</td></tr>
<tr><td>USEARCH</td><td><pre language="sh">usearch -fastq_filter input.fastq -fastq_maxee 1 -fastaout output.fasta</pre><details><summary>🟦 output</summary><pre>usearch v11.0.667_i86linux32, 4.0Gb RAM (16.1Gb total), 8 cores
(C) Copyright 2013-18 Robert C. Edgar, all rights reserved.
https://drive5.com/usearch

License: markus.schlegel@usys.ethz.ch

</pre></details><details><summary> messages</summary><pre>00:00 4.2Mb  FASTQ base 33 for file input.fastq
00:00 103Mb     0.1% Filtering00:01 104Mb     1.6% Filtering, 100.0% passed00:02 104Mb     3.9% Filtering, 100.0% passed00:03 104Mb     6.1% Filtering, 100.0% passed00:04 104Mb     8.4% Filtering, 100.0% passed00:05 104Mb    10.7% Filtering, 100.0% passed00:06 104Mb    13.0% Filtering, 100.0% passed00:07 104Mb    15.1% Filtering, 100.0% passed00:08 104Mb    17.4% Filtering, 100.0% passed00:09 104Mb    19.6% Filtering, 100.0% passed00:10 104Mb    21.9% Filtering, 100.0% passed00:11 104Mb    24.2% Filtering, 100.0% passed00:12 104Mb    26.4% Filtering, 100.0% passed00:13 104Mb    28.7% Filtering, 100.0% passed00:14 104Mb    31.0% Filtering, 100.0% passed00:15 104Mb    33.2% Filtering, 100.0% passed00:16 104Mb    35.5% Filtering, 100.0% passed00:17 104Mb    37.8% Filtering, 100.0% passed00:18 104Mb    40.1% Filtering, 100.0% passed00:19 104Mb    42.4% Filtering, 100.0% passed00:20 104Mb    44.7% Filtering, 100.0% passed00:21 104Mb    46.9% Filtering, 100.0% passed00:22 104Mb    49.2% Filtering, 100.0% passed00:23 104Mb    51.5% Filtering, 100.0% passed00:24 104Mb    53.7% Filtering, 100.0% passed00:25 104Mb    55.8% Filtering, 100.0% passed00:26 104Mb    58.1% Filtering, 100.0% passed00:27 104Mb    60.4% Filtering, 100.0% passed00:28 104Mb    62.6% Filtering, 100.0% passed00:29 104Mb    64.8% Filtering, 100.0% passed00:30 104Mb    67.1% Filtering, 100.0% passed00:31 104Mb    69.4% Filtering, 100.0% passed00:32 104Mb    71.6% Filtering, 100.0% passed00:33 104Mb    73.9% Filtering, 100.0% passed00:34 104Mb    76.2% Filtering, 100.0% passed00:35 104Mb    78.5% Filtering, 100.0% passed00:36 104Mb    80.8% Filtering, 100.0% passed00:37 104Mb    83.1% Filtering, 100.0% passed00:38 104Mb    85.4% Filtering, 100.0% passed00:39 104Mb    87.7% Filtering, 100.0% passed00:40 104Mb    90.0% Filtering, 100.0% passed00:41 104Mb    92.4% Filtering, 100.0% passed00:42 104Mb    94.6% Filtering, 100.0% passed00:43 104Mb    96.9% Filtering, 100.0% passed00:44 104Mb    99.2% Filtering, 100.0% passed00:44 71Mb    100.0% Filtering, 100.0% passed
   3348507  Reads (3.3M)                     
         0  Discarded reads with expected errs > 1.00
   3348507  Filtered reads (3.3M, 100.0%)
</pre></details></td><td>🕓 44.2 s 784% CPU<br/>📈 34.6 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>42.9 s</b> 🏆 (1.0x)<br/>📈 7.1 MB</td>
</tr>
<tr>
<td>Select 1000 records by their sequence IDs from a large set of sequences<td>
<td><pre language="sh">st filter -m ids_list.txt 'has_meta()' input.fasta > output.fasta</pre>
<details><summary><b>VSEARCH</b> 🕓 16.4 s</summary>
<table><tr><td>VSEARCH</td><td><pre language="sh">vsearch --fastx_getseqs input.fasta --labels ids_list.txt --fastaout output.fastq</pre><details><summary> messages</summary><pre>vsearch v2.28.1_linux_x86_64, 15.4GB RAM, 8 cores
https://github.com/torognes/vsearch

Reading labels 100%
Extracting sequences 100%
1000 of 1296967 sequences extracted (0.1%)
</pre></details></td><td>🕓 16.4 s<br/>📈 <b>3.6 MB</b> 🏆 (2.04x)</td></tr>
</table>
</details>
</td>
<td>🕓 <b>0.7 s</b> 🏆 (22.4x)<br/>📈 7.2 MB</td>
</tr>
</table>

## concat
<table>
<tr>
<td>Concatenate sequences, adding an `NNNNN` spacer inbetween<td>
<td><pre language="sh">st concat -s 5 -c N file1.fasta file2.fasta > output.fasta</pre>
<details><summary> messages</summary><pre>Error opening 'file1.fasta': No such file or directory (os error 2)
</pre></details><details><summary><b>VSEARCH</b> 🕓 0.0 s</summary>
<table><tr><td>VSEARCH</td><td><pre language="sh">vsearch --fastq_join file1.fasta --reverse file2.fasta --join_padgap NNNNN --fastaout output.fasta</pre><details><summary> messages</summary><pre>vsearch v2.28.1_linux_x86_64, 15.4GB RAM, 8 cores
https://github.com/torognes/vsearch



Fatal error: Unable to open file for reading (file1.fasta)
</pre></details></td><td>🕓 0.0 s<br/>📈 <b>3.5 MB</b> 🏆 (1.89x)</td></tr>
</table>
</details>
</td>
<td>🕓 0.0 s<br/>📈 6.7 MB</td>
</tr>
</table>

## find
<table>
<tr>
<td>Find the forward primer in the input reads<td>
<td><pre language="sh">st find -v -D4 file:primers.fasta input.fastq -a primer={pattern_name} -a rng={match_range}</pre>
<details><summary> messages</summary><pre>Note: the sequence type of the pattern 'primer1' was determined as 'dna' (with ambiguous letters). If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
</pre></details><details><summary><b>st (dist = 2)</b> 🕓 20.0 s  ❙  <b>st (dist = 4, 4 threads)</b> 🕓 <b>5.0 s</b> 🏆 (4.0x)  ❙  <b>st (dist = 8)</b> 🕓 24.0 s</summary>
<table><tr><td>st (dist = 2)</td><td><pre language="sh">st find -D2 file:primers.fasta input.fastq -a primer={pattern_name} -a rng={match_range}</pre><details><summary> messages</summary><pre>Note: the sequence type of the pattern 'primer1' was determined as 'dna' (with ambiguous letters). If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
</pre></details></td><td>🕓 20.0 s<br/>📈 <b>6.8 MB</b> 🏆 (1.03x)</td></tr>
<tr><td>st (dist = 4, 4 threads)</td><td><pre language="sh">st find -t4 -D4 file:primers.fasta input.fastq -a primer={pattern_name} -a rng={match_range}</pre><details><summary> messages</summary><pre>Note: the sequence type of the pattern 'primer1' was determined as 'dna' (with ambiguous letters). If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
</pre></details></td><td>🕓 <b>5.0 s</b> 🏆 (4.0x) 507% CPU<br/>📈 11.2 MB</td></tr>
<tr><td>st (dist = 8)</td><td><pre language="sh">st find -D8 file:primers.fasta input.fastq -a primer={pattern_name} -a rng={match_range}</pre><details><summary> messages</summary><pre>Note: the sequence type of the pattern 'primer1' was determined as 'dna' (with ambiguous letters). If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
</pre></details></td><td>🕓 24.0 s<br/>📈 7.0 MB</td></tr>
</table>
</details>
</td>
<td>🕓 20.6 s<br/>📈 7.0 MB</td>
</tr>
<tr>
<td>Find the forward primer in the input reads and remove it (4 threads)<td>
<td><pre language="sh">st find -D6 -t4 -f file:primers.fasta input.fastq -a primer={pattern_name} -a end={match_end} |
  st trim --fq -e '{attr("end")}..' > output.fastq
</pre>
<details><summary> messages</summary><pre>Note: the sequence type of the pattern 'primer1' was determined as 'dna' (with ambiguous letters). If incorrect, please provide the correct type with `--seqtype`. Use `-q/--quiet` to suppress this message.
</pre></details><details><summary><b>Cutadapt</b> 🕓 23.1 s</summary>
<table><tr><td>Cutadapt</td><td><pre language="sh">cutadapt -j4 -a file:primers.fasta input.fastq -e 0.2 -y ' primer={name}' --discard-untrimmed > output.fastq </pre><details><summary> messages</summary><pre>This is cutadapt 3.5 with Python 3.10.12
Command line parameters: -j4 -a file:primers.fasta input.fastq -e 0.2 -y  primer={name} --discard-untrimmed
Processing reads on 4 cores in single-end mode ...
Finished in 22.83 s (7 µs/read; 8.80 M reads/minute).

=== Summary ===

Total reads processed:               3,348,507
Reads with adapters:                 3,308,241 (98.8%)

== Read fate breakdown ==
Reads discarded as untrimmed:           40,266 (1.2%)
Reads written (passing filters):     3,308,241 (98.8%)

Total basepairs processed: 1,006,809,586 bp
Total written (filtered):     17,726,113 bp (1.8%)

=== Adapter primer1 ===

Sequence: GATGAAGAACGYAGYRAA; Type: regular 3'; Length: 18; Trimmed: 3308241 times

Minimum overlap: 3
No. of allowed errors:
1-4 bp: 0; 5-9 bp: 1; 10-14 bp: 2; 15-18 bp: 3

Bases preceding removed adapters:
  A: 0.1%
  C: 1.6%
  G: 98.2%
  T: 0.1%
  none/other: 0.0%
WARNING:
    The adapter is preceded by 'G' extremely often.
    The provided adapter sequence could be incomplete at its 5' end.
    Ignore this warning when trimming primers.

Overview of removed sequences
length	count	expect	max.err	error counts
3	606	52320.4	0	606
4	216	13080.1	0	81 135
5	253	3270.0	1	9 244
6	59	817.5	1	2 57
7	20	204.4	1	0 20
8	17	51.1	1	0 9 8
9	19	12.8	1	0 4 15
10	26	3.2	2	0 1 25
11	18	0.8	2	0 1 17
12	3	0.2	2	0 0 1 2
13	5	0.0	2	0 0 0 5
14	3	0.0	2	0 0 0 3
15	5	0.0	3	0 0 1 4
16	3	0.0	3	0 0 1 2
17	3	0.0	3	0 0 0 3
18	2	0.0	3	0 0 0 2
19	3	0.0	3	0 0 0 3
20	3	0.0	3	0 0 0 3
21	3	0.0	3	0 0 0 3
24	2	0.0	3	0 0 0 2
25	1	0.0	3	0 0 0 1
26	1	0.0	3	0 0 0 1
27	2	0.0	3	0 0 0 2
29	1	0.0	3	0 0 0 1
30	2	0.0	3	0 0 0 2
31	4	0.0	3	0 0 0 4
32	4	0.0	3	0 0 0 4
33	3	0.0	3	0 0 0 3
36	2	0.0	3	0 0 0 2
37	1	0.0	3	0 0 1
38	2	0.0	3	0 0 1 1
40	2	0.0	3	0 0 1 1
41	2	0.0	3	0 0 1 1
42	1	0.0	3	0 0 0 1
43	1	0.0	3	0 0 0 1
44	1	0.0	3	0 0 0 1
45	1	0.0	3	0 0 0 1
47	1	0.0	3	0 0 0 1
48	1	0.0	3	0 0 0 1
49	1	0.0	3	0 0 0 1
50	3	0.0	3	0 0 0 3
51	2	0.0	3	0 0 1 1
52	1	0.0	3	0 0 1
54	2	0.0	3	0 0 0 2
56	3	0.0	3	0 0 0 3
59	1	0.0	3	0 0 0 1
61	1	0.0	3	0 0 0 1
62	1	0.0	3	0 0 1
63	1	0.0	3	0 0 0 1
64	1	0.0	3	0 0 1
65	1	0.0	3	0 0 0 1
66	2	0.0	3	0 0 0 2
68	2	0.0	3	0 0 0 2
69	2	0.0	3	0 0 0 2
70	3	0.0	3	0 0 0 3
71	1	0.0	3	0 0 0 1
72	2	0.0	3	0 0 1 1
79	3	0.0	3	0 0 2 1
80	4	0.0	3	0 0 1 3
82	4	0.0	3	0 0 2 2
83	2	0.0	3	0 0 1 1
85	5	0.0	3	0 0 0 5
86	4	0.0	3	0 0 1 3
87	1	0.0	3	0 0 0 1
88	2	0.0	3	0 1 0 1
89	1	0.0	3	0 0 1
90	2	0.0	3	0 0 0 2
93	3	0.0	3	0 0 0 3
94	2	0.0	3	0 0 1 1
95	1	0.0	3	0 0 0 1
96	2	0.0	3	0 0 0 2
98	3	0.0	3	0 0 0 3
99	1	0.0	3	0 0 0 1
102	1	0.0	3	0 0 0 1
103	2	0.0	3	0 0 1 1
104	2	0.0	3	0 0 0 2
105	2	0.0	3	0 0 0 2
106	2	0.0	3	0 0 1 1
107	1	0.0	3	0 0 0 1
108	1	0.0	3	0 0 1
109	1	0.0	3	0 0 0 1
111	5	0.0	3	0 0 1 4
113	2	0.0	3	0 0 1 1
114	3	0.0	3	0 0 0 3
115	2	0.0	3	0 0 0 2
116	1	0.0	3	0 0 0 1
118	2	0.0	3	0 0 1 1
119	3	0.0	3	0 0 1 2
120	1	0.0	3	0 0 0 1
122	1	0.0	3	0 0 0 1
123	1	0.0	3	0 0 0 1
124	2	0.0	3	0 0 0 2
125	2	0.0	3	0 0 0 2
126	1	0.0	3	0 0 1
128	1	0.0	3	0 0 0 1
129	2	0.0	3	0 0 1 1
130	3	0.0	3	0 0 1 2
131	3	0.0	3	0 0 1 2
132	1	0.0	3	0 0 0 1
133	3	0.0	3	0 0 0 3
134	2	0.0	3	0 0 0 2
136	1	0.0	3	0 0 0 1
137	2	0.0	3	0 0 0 2
138	1	0.0	3	0 0 1
140	1	0.0	3	0 0 0 1
142	1	0.0	3	0 0 0 1
143	3	0.0	3	0 0 2 1
144	3	0.0	3	0 0 1 2
145	2	0.0	3	0 0 0 2
146	1	0.0	3	0 0 0 1
150	2	0.0	3	0 0 0 2
154	2	0.0	3	0 0 2
157	1	0.0	3	0 0 0 1
158	1	0.0	3	0 0 0 1
159	1	0.0	3	0 0 1
160	2	0.0	3	0 0 0 2
162	1	0.0	3	0 0 0 1
163	1	0.0	3	0 0 0 1
165	2	0.0	3	0 0 0 2
166	1	0.0	3	0 0 0 1
169	1	0.0	3	0 0 0 1
170	1	0.0	3	0 0 0 1
182	2	0.0	3	0 0 0 2
189	1	0.0	3	0 0 0 1
197	1	0.0	3	0 1
198	1	0.0	3	0 0 0 1
216	1	0.0	3	0 0 0 1
225	1	0.0	3	0 0 0 1
232	1	0.0	3	1
233	3	0.0	3	0 0 3
234	1	0.0	3	0 0 0 1
235	1	0.0	3	0 0 1
236	5	0.0	3	0 0 3 2
237	11	0.0	3	0 0 2 9
238	22	0.0	3	3 2 4 13
239	40	0.0	3	4 1 17 18
240	60	0.0	3	6 2 7 45
241	57	0.0	3	3 10 8 36
242	38	0.0	3	3 3 8 24
243	44	0.0	3	5 3 9 27
244	29	0.0	3	5 0 6 18
245	19	0.0	3	0 4 3 12
246	22	0.0	3	5 2 4 11
247	18	0.0	3	1 0 4 13
248	5	0.0	3	1 2 1 1
249	6	0.0	3	2 0 2 2
250	1	0.0	3	0 0 0 1
251	3	0.0	3	1 2
252	2	0.0	3	0 0 1 1
253	1	0.0	3	0 0 0 1
254	3	0.0	3	3
255	3	0.0	3	1 0 0 2
256	4	0.0	3	2 0 0 2
257	10	0.0	3	1 0 1 8
258	10	0.0	3	0 0 7 3
259	4	0.0	3	1 1 0 2
260	7	0.0	3	1 0 0 6
261	2	0.0	3	0 0 0 2
262	3	0.0	3	0 0 0 3
263	2	0.0	3	1 0 0 1
264	3	0.0	3	2 0 1
267	1	0.0	3	1
268	1	0.0	3	1
269	2	0.0	3	1 0 0 1
270	1	0.0	3	0 0 0 1
272	2	0.0	3	0 1 1
274	1	0.0	3	0 0 1
276	1	0.0	3	1
277	2	0.0	3	0 1 0 1
278	3	0.0	3	0 2 0 1
279	3	0.0	3	1 1 0 1
280	2	0.0	3	2
281	2	0.0	3	0 2
282	2	0.0	3	0 1 0 1
283	1	0.0	3	0 0 0 1
284	8	0.0	3	1 1 3 3
285	3	0.0	3	0 0 0 3
286	9	0.0	3	0 1 2 6
287	16	0.0	3	4 4 4 4
288	60	0.0	3	11 12 15 22
289	290	0.0	3	46 107 65 72
290	1208	0.0	3	127 402 325 354
291	23212	0.0	3	2451 17744 1813 1204
292	108412	0.0	3	27460 65554 9096 6302
293	355774	0.0	3	83566 212776 32046 27386
294	619600	0.0	3	319311 195867 46795 57627
295	824123	0.0	3	660400 71199 28629 63895
296	399355	0.0	3	334011 29521 12040 23783
297	358642	0.0	3	301140 25743 10714 21045
298	349069	0.0	3	287593 26507 11596 23373
299	264910	0.0	3	225337 18367 7271 13935
300	1220	0.0	3	692 268 141 119
301	403	0.0	3	78 85 121 119


WARNING:
    One or more of your adapter sequences may be incomplete.
    Please see the detailed output above.
</pre></details></td><td>🕓 23.1 s 418% CPU<br/>📈 27.7 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>6.7 s</b> 🏆 (3.5x) 522% CPU<br/>📈 <b>11.3 MB</b> 🏆 (2.46x)</td>
</tr>
</table>

## sort
<table>
<tr>
<td>Sort by sequence<td>
<td><pre language="sh">st sort seq input.fasta > output.fasta</pre>
<details><summary><b>st (50M memory limit)</b> 🕓 9.4 s  ❙  <b>st (100M memory limit)</b> 🕓 9.8 s  ❙  <b>SeqKit</b> 🕓 13.9 s</summary>
<table><tr><td>st (50M memory limit)</td><td><pre language="sh">st sort seq input.fasta -M 50M > output.fasta</pre><details><summary> messages</summary><pre>Memory limit reached after 66696 records, writing to temporary file(s). Consider raising the limit (-M/--max-mem) to speed up sorting. Use -q/--quiet to silence this message.
</pre></details></td><td>🕓 9.4 s 91% CPU<br/>📈 <b>54.8 MB</b> 🏆 (1.89x)</td></tr>
<tr><td>st (100M memory limit)</td><td><pre language="sh">st sort seq input.fasta -M 100M > output.fasta</pre><details><summary> messages</summary><pre>Memory limit reached after 133898 records, writing to temporary file(s). Consider raising the limit (-M/--max-mem) to speed up sorting. Use -q/--quiet to silence this message.
</pre></details></td><td>🕓 9.8 s 90% CPU<br/>📈 103.5 MB</td></tr>
<tr><td>SeqKit</td><td><pre language="sh">seqkit sort -s  input.fasta > output.fasta</pre><details><summary> messages</summary><pre>[INFO][0m read sequences ...
[INFO][0m 1296967 sequences loaded
[INFO][0m sorting ...
[INFO][0m output ...
</pre></details></td><td>🕓 13.9 s<br/>📈 2169.7 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>4.8 s</b> 🏆 (2.0x)<br/>📈 950.6 MB</td>
</tr>
<tr>
<td>Sort by ID<td>
<td><pre language="sh">st sort id input.fasta > output.fasta</pre>
<details><summary><b>SeqKit</b> 🕓 14.4 s</summary>
<table><tr><td>SeqKit</td><td><pre language="sh">seqkit sort  input.fasta > output.fasta</pre><details><summary> messages</summary><pre>[INFO][0m read sequences ...
[INFO][0m 1296967 sequences loaded
[INFO][0m sorting ...
[INFO][0m output ...
</pre></details></td><td>🕓 14.4 s<br/>📈 2380.4 MB</td></tr>
</table>
</details>
</td>
<td>🕓 <b>1.9 s</b> 🏆 (7.4x)<br/>📈 <b>587.1 MB</b> 🏆 (4.05x)</td>
</tr>
<tr>
<td>Sort by sequence length<td>
<td><pre language="sh">st sort seqlen input.fasta > output.fasta</pre>
<details><summary><b>SeqKit</b> 🕓 14.6 s  ❙  <b>VSEARCH</b> 🕓 3.1 s</summary>
<table><tr><td>SeqKit</td><td><pre language="sh">seqkit sort -l  input.fasta > output.fasta</pre><details><summary> messages</summary><pre>[INFO][0m read sequences ...
[INFO][0m 1296967 sequences loaded
[INFO][0m sorting ...
[INFO][0m output ...
</pre></details></td><td>🕓 14.6 s<br/>📈 2234.4 MB</td></tr>
<tr><td>VSEARCH</td><td><pre language="sh">vsearch --sortbylength input.fasta --output output.fasta </pre><details><summary> messages</summary><pre>vsearch v2.28.1_linux_x86_64, 15.4GB RAM, 8 cores
https://github.com/torognes/vsearch

Reading file input.fasta 100%
389970586 nt in 1296966 seqs, min 290, max 301, avg 301
minseqlength 1: 1 sequence discarded.
Getting lengths 100%
Sorting 100%
Median length: 301
Writing output 100%
</pre></details></td><td>🕓 3.1 s<br/>📈 <b>477.8 MB</b> 🏆 (1.15x)</td></tr>
</table>
</details>
</td>
<td>🕓 <b>1.7 s</b> 🏆 (1.8x)<br/>📈 549.7 MB</td>
</tr>
<tr>
<td>Sort sequences by size annotations<td>
<td><pre language="sh">ST_ATTR_FMT=';key=value' st unique seq -a size={n_duplicates} input.fasta |
  st sort '{-attr("size")}' > output.fasta
</pre>
<details><summary><b>VSEARCH</b> 🕓 7.3 s</summary>
<table><tr><td>VSEARCH</td><td><pre language="sh">vsearch --derep_fulllength input.fasta --output - --sizeout |   vsearch --sortbysize - --output output.fasta  </pre><details><summary> messages</summary><pre>vsearch v2.28.1_linux_x86_64, 15.4GB RAM, 8 cores
https://github.com/torognes/vsearch
vsearch v2.28.1_linux_x86_64, 15.4GB RAM, 8 cores

https://github.com/torognes/vsearch

Dereplicating file input.fasta 100%
389970586 nt in 1296966 seqs, min 290, max 301, avg 301
minseqlength 32: 1 sequence discarded.
Sorting 100%
1037564 unique sequences, avg cluster 1.3, median 1, max 2134
Writing FASTA output fileReading file - 100%
 100%
311977643 nt in 1037564 seqs, min 290, max 301, avg 301
Getting sizes 100%
Sorting 100%
Median abundance: 1
Writing output 100%
</pre></details></td><td>🕓 7.3 s 116% CPU<br/>📈 <b>491.7 MB</b> 🏆 (1.66x)</td></tr>
</table>
</details>
</td>
<td>🕓 <b>4.8 s</b> 🏆 (1.5x) 108% CPU<br/>📈 815.5 MB</td>
</tr>
</table>

