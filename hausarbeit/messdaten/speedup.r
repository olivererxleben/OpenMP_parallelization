#!/usr/bin/R

source(file="output.R")

inp <- read.csv("intel-benchmark-13.csv", sep=";")
out.filename <- "s13_speedup"

aggr <- aggregate(inp$Walltime, by=list(inp$Implementierung, inp$Threads), FUN=median)

names(aggr)[1] <- "Implementierung"
names(aggr)[2] <- "Threads"
names(aggr)[3] <- "Walltime"

omp <- aggr[aggr$Implementierung=="OMP",]
tbb <- aggr[aggr$Implementierung=="TBB",]

omp_rseq <- max(omp$Walltime)
tbb_rseq <- max(tbb$Walltime)

#png("s13_speedup.png", width=1024, height=768, pointsize=24)
pdf(paste(c(out.filename,".pdf"),collapse=''), width=pdf.width, height=pdf.height, pointsize=pdf.pointsize, family=CM)
par(mar=c(4,4,1,1)+0.1)

omp_conv <- mean(omp_rseq/omp[omp$Threads>=12,]$Walltime)
tbb_conv <- mean(tbb_rseq/tbb[tbb$Threads>=12,]$Walltime)

plot(omp$Threads, omp_rseq/omp$Walltime, col="red", ylim=c(1, 24), xlab="Threads", ylab="Speed-Up", log="y")
points(tbb$Threads, tbb_rseq/tbb$Walltime, col="blue", pch=2)

omp_ideal <- function(x) x
curve(omp_ideal, add=TRUE, col="green", lty=2)
curve(0*x + omp_conv, add=TRUE, col="red", lty=3)
curve(0*x + tbb_conv, add=TRUE, col="blue", lty=3)

#title("Szenario 13, Speed-Up")
legend(x="topright", legend=c("OMP","TBB","Ideal"), col=c("red","blue","green"), pch=c(1,2,-1), lty=c(-1,-1,2), bg="white")

text(labels=c(paste(c("OMP: ",round(omp_conv,3)),collapse='')), x=20, y=omp_conv*1.2)
text(labels=c(paste(c("TBB: ",round(tbb_conv,3)),collapse='')), x=20, y=tbb_conv*0.8)

dev.off()
embedFonts(paste(c(out.filename,".pdf"),collapse=''), fontpaths=c("cm-lgc/fonts/type1/public/cm-lgc/", "."))