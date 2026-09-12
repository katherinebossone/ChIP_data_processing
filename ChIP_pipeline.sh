#!/bin/bash1

# Run bash ChIP_pipeline.sh [insert_file_name_location] 
# For example for path/to/file/H3K9me2_ChIP_rep1.fastq would be:    bash ChIP_pipeline.sh H3K9me2_ChIP_rep1

module load cutadapt/ samtools/ hisat/ bedtools/

# Trim adapters
echo "cutadapt trim"

cutadapt -u 10 -u -5 -o $1_trim.fastq $1.fastq

# Align fastq to genome
echo "hisat align"

hisat2 -p 8 -x /path/to/file/containing/genome -U $1_trim.fastq -S $1_trim.sam
rm $1_trim.fastq

# SAM -> BAM file
echo "samtools view"

samtools view -bS $1_trim.sam > $1_trim.bam
rm $1_trim.sam

# Sort BAM file for indexing
echo "samtools sort"

samtools sort $1_trim.bam -o $1_trim_sorted.bam
rm $1_trim.bam

# Index
echo "index"

samtools index $1_trim_sorted.bam

# BAM to bedgraph
# Window file contains genome broken into bins of a chosen size. Create with the line:
# bedtools makewindows -g path/to/genome/model.chrom.sizes -w [insert desired bin size] > windows.bed

echo "convert to bedgraph"

bedtools coverage -a /path/to/window/file -b $1_trim_sorted.bam | cut -f 1-4 > $1_.bedgraph
