ihs<-function(score_file,save_file){
	dis=20000000
	read.table(gzfile(score_file),head=F)->data
	logp=data[,7] #value
	miny=min(logp)
	maxy=max(logp)
#	logp=-log10(logp) #value
	
	chr=data[,3] #chr col###########
	position<-data[,4] #position
	xaxis=0
#    cutoff=sort(logp,decreasing=T)[2949]
	flogp=numeric();
	whole_col=numeric(); #chr class
	xlabel=numeric();
	length_add=-4000000
	label=numeric();
	for(i in 1:22){

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

	}
	#plot the p_value distribution 
    pdf(save_file,height=7,width=14,pointsize=12)

#	bitmap(save_file,height=7,width=14,res=200)

	plot(xlabel,flogp,col=whole_col,ylim=c(miny,1),axes=F,xlab="",ylab="",pch=20)#ylim

	ytxt=expression("Fst");
	title(ylab=ytxt,line=1.6,cex.lab=1.5)
	#line is the position of axis
	title(xlab="Chromosome",cex.lab=1.5)

#	yaxis=seq(0,0.12,by=0.01)
	axis(2,las=1,cex.axis=1.3,line=-1)
	#las can change the directory of the axis character
	#las=0 always parallel to the axis
	#las=1 always horizontal

	a=xaxis[-1]
	b=xaxis[-length(xaxis)]
	x=(a+b)/2

	for(i in 1:22){
		mtext(label[i],side=1,at=x[i],las=2,font=1,cex=1.5)
		#cex magnified relative to the to the default
	}
#	abline(h=cutoff,col=2)
	dev.off()
	
}


#round(x,digits=3) keep the length of the digit
