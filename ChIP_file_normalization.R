# Normalization of read depth and digestion

# LOAD INPUT AND CHIP DATAFILES FROM BEDTOOLS
In <- read.delim("~/Desktop/Input.bedgraph", header=FALSE, stringsAsFactors=FALSE)
Ch <- read.delim("~/Desktop/ChIP.bedgraph", header=FALSE, stringsAsFactors=FALSE)
​
# Splitting data
chr <- In$V1
start <- In$V2
stop <- In$V3
input <- In$V4
ChIP <- Ch$V4
​
# Normalization
#DO THIS PROCEDURE FOR CALCULATING THE NOTMALIZATION FACTOR INSTEAD
norm_input <- 1e6/sum(input)
norm_chip <- 1e6/sum(ChIP)
​
# The denominator is the sum
input_norm <- input*norm_input
ChIP_norm <- ChIP*norm_chip
​
# Calc
ratio <- ChIP_norm/input_norm
log <- log2(ratio)
tmp <- log
log2 <- replace(tmp,is.nan(tmp),0)
log2 <- replace(log2,is.infinite(tmp),0)
data <- cbind(chr, start, stop, log2)
write.table(data, file = "~/Desktop/your_normalized.bedgraph", sep = "\t", row.names = F, col.names = F, quote = FALSE)

