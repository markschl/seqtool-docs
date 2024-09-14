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
how many times faster/less memory it uses compared to the command ranking second.
Click on the commands list to show more details.

<style>
.md-grid {
    max-width: 100rem !important;
}
</style>
