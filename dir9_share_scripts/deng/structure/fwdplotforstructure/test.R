pdf('Ordered.structure.pdf',60,45)
par(mfrow=c(16,1),xpd=NA)
par('oma'=c(10,4,10,16))
par('mar'=c(0.5,4,0.5,4))

#col <- c('black', 'orange', 'red', 'green', 'blue', 'purple', 'brown', 'cyan', 'grey', 'gold4', 'seagreen', 'skyblue', 'chocolate', 'maroon3', 'green4')
col <- c('darkgreen', 'black', 'cyan', 'purple', 'green', 'red', 'chocolate', 'mediumseagreen', 'grey', 'gold4', 'orange', 'skyblue', 'brown', 'maroon3', 'blue')
first <- 4
for ( K in 2:15 ){
	name <- paste('/picb/humpopg6/share/denglian/Processed_Malay/STRUCTURE/test/K', K, sep="")
	data <- read.table(name)
	plot(0,0,xlim=c(0,nrow(data)),ylim=c(0,1),type='n',axes=F,ann=F,xaxs='i')
	mtext(paste('K=', K, sep=""), adj=0.0, side=4, cex=6, line=1, col='black', las=2)
	ypre <- rep(0,nrow(data))
	for ( i in first:ncol(data) ){
		rect(0:(nrow(data)-1),ypre,1:nrow(data),ypre+data[,i],col=col[i-(first-1)],border=NA)
		ypre <- ypre+data[,i]
	}
}
plot(0,0,xlim=c(0,nrow(data)),ylim=c(0,1),type='n',axes=F,ann=F,xaxs='i')
popsize <- read.table('/picb/humpopg6/share/denglian/Processed_Malay/STRUCTURE/results/popsize')
linepre <- 0
ymin <- 1.14
ymax <- 12.90
for ( i in 1:nrow(popsize) ){
	pop <- popsize[i,1]
	if ( pop == 'YRI' || pop == 'MalaysianNegrito' || pop == 'Senoi' || pop == 'Proto-Malay' || pop == 'Malay' || pop == 'CHB' || pop == 'CEU' ){
		color = 'black'
	} else {
		color = 'red'
	} 
	linefix <- linepre + popsize[i,2]
	lines(x=c(linepre, linepre, linefix, linefix, linepre), y=c(ymin, ymax, ymax, ymin, ymin), col='black',cex=0.5)
	text(mean(c(linepre, linefix)), 1.00, labels=popsize[i,1], cex=6, srt=90, col=color, adj=c(1,NA))
	linepre <- linefix
}
plot(0,0,xlim=c(0,nrow(data)),ylim=c(0,1),type='n',axes=F,ann=F,xaxs='i')
#consize <- read.table('../rplot.input/struct.continent.size')
#ymax <- 3.0
#ymin <- 0
#location <- 0
#cex <- 0
#for ( i in 1:nrow(consize) ){
#	if ( i == 1 || i == 2 ){
#		consize[consize[,1] == 'WestAsian',1] <- 'WA'
#		ymin <- 0.6
#		location <- 0.75
#		cex <- 5
#	}
#	else{
#		ymin <- 0
#		location <- 0.1
#		cex <- 9
#	}
#	lines(x=c(consize[i,2], consize[i,2]), y=c(ymin, ymax), col='black',cex=0.5)
#	lines(x=c(consize[i,3], consize[i,3]), y=c(ymin, ymax), col='black',cex=0.5)
#	lines(x=c(consize[i,2], consize[i,3]), y=c(ymin, ymin), col='black',cex=0.5)
#	text(mean(c(consize[i,2], consize[i,3])), location, labels=consize[i,1], cex=cex, srt=0, adj=c(0.5,0))
#}
dev.off()
