ihs<-function(score_file,save_file,maxy){
	read.table(score_file,head=T)->data
	logp=data[,5] #value
#	logp=-log10(logp) #value
	
	chr=data[,1] #chr col###########
	position<-data[,3] #position
	xaxis=0
#    cutoff=sort(logp,decreasing=T)[2949]
	flogp=numeric();
	whole_col=numeric(); #chr class
	xlabel=numeric();
	label=numeric();
	
	i=6
		position[chr==i]->chr_pos
		chr_num=length(chr_pos)
		print(chr_num)
		if(length(chr_pos)==0){
			next
		}
		flogp=c(flogp,logp[chr==i])
		label=c(label,i)
		whole_col=c(whole_col,rep(i,chr_num))
		chr_pos=length_add+chr_pos
		xlabel=c(xlabel,chr_pos)

		length_add=dis+chr_pos[chr_num]
		xaxis=c(xaxis,length_add)

	#plot the p_value distribution 
    pdf(save_file,height=7,width=7,pointsize=12)

#	bitmap(save_file,height=7,width=7,res=200)

	plot(xlabel,flogp,col=whole_col,ylim=c(0,maxy),axes=F,xlab="",ylab="",pch=20)#ylim

	ytxt=expression("Minor Allele Frequency");
	title(ylab=ytxt,line=1.6,cex.lab=1.5)
	#line is the position of axis
	title(xlab="Chromosome 6",cex.lab=1.5)

#	yaxis=seq(0,0.12,by=0.01)
	axis(2,las=1,cex.axis=1.3,line=-1)
	#las can change the directory of the axis character
	#las=0 always parallel to the axis
	#las=1 always horizontal

	a=xaxis[-1]
	b=xaxis[-length(xaxis)]
	x=(a+b)/2

#	for(i in 1:22){
#		mtext(label[i],side=1,at=x[i],las=2,font=1,cex=1.5)
		#cex magnified relative to the to the default
#	}
#	abline(h=cutoff,col=2)
	dev.off()
	
}


#round(x,digits=3) keep the length of the digit




ihs<-function(score_file,save_file,maxy){
	read.table(score_file,head=F)->data
	logp=data[,6] #value
#	logp=-log10(logp) #value
	
	position<-data[,3] #position
	
#plot the p_value distribution 
    pdf(save_file,height=7,width=7,pointsize=12)

	plot(position,logp,col='black',ylim=c(0,maxy),xlab="",ylab="",pch=20)#ylim
	
#	newdata=data[data[,3]>=31367561,]
#	newdata2=newdata[newdata[,3]<=31390410,]
#	x=newdata2[,3]
#	y=newdata2[,11]
#	points(x,y,col='green',pch=20)
	points(31390410,0,col='red',pch=20)
	
	ytxt=expression("Allele Frequency Difference");
	title(ylab=ytxt,line=1.6,cex.lab=1.5)
#line is the position of axis
	title(xlab="Chromosome 6",cex.lab=1.5)
	
	dev.off()
	
}


