data <- read.table("/picb/humpopg-bigdata/zhangxi/cortex_pool/XJ_chr22/batch1/xinjiang.chr22.merged.uncleaned.k31.batch1.q20.ctx.covg",header=TRUE)
pdf("covg distribution.pdf")
plot(data[,1],data[,2],log="y",xlim=c(0,100),main="Kmer covg distribution",xlab="Kmer covg",ylab="Frequency")
dev.off()

