# Normalize bedgraphs further with z-score normalization to improve comparability between samples.
`data` <- read.delim("~/Desktop/your_normalized.bedgraph", header=FALSE, stringsAsFactors=FALSE)

chrom <- data$V1
start <- data$V2
stp <- data$V3
signal <- data$V4
avg <- mean(signal)
stdev <- sd(signal)

signal2 <- signal-avg
signal3 <- signal2/stdev

export <- cbind(chrom, start, stp, signal3)
write.table(export, file = "~/Desktop/your_zscore.bedgraph", sep = "\t", row.names = F, col.names = F, quote = FALSE)
