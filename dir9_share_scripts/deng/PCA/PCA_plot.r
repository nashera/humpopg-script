pdf("/picb/humpopg6/denglian/PCA/5Pops.pdf",width=9,height=9)
read.table("/picb/humpopg6/denglian/PCA/5Pops.evec.plot",head=F)->data
par(mar=c(6,6,4.1,2.1))
x=data[,2]
y=data[,3]
names(x)=c(1:length(x))
names(y)=c(1:length(y))
pop=data[,4]

## Malaysian Negrito
//x_plot=""
//y_plot=""
//for (i in 1:125) {
//	x_plot=c(x_plot,x[i])
//	y_plot=c(y_plot,y[i])
//}
//plot(x_plot,y_plot,pch=16,col='darkorange',xlim=c(-0.1,0.25),ylim=c(-0.2,0.3),xlab="PC1 (0.650)",ylab="PC2 (0.315)",cex.lab=1.6,xaxt="n",yaxt="n")
//axis(side=1,at=c(-2:5)*0.05,labels=c(-2:5)*0.05,cex.axis=1.3)
//axis(side=2,at=c(-4:6)*0.05,labels=c(-4:6)*0.05,cex.axis=1.3)
## Philippine Negrito
//x_plot=""
//y_plot=""
//for (i in 126:184) {
//	x_plot=c(x_plot,x[i])
//	y_plot=c(y_plot,y[i])
//}
//points(x_plot,y_plot,pch=17,col='darkorange4')
## Biaka Pygmy
x_plot=""
y_plot=""
for (i in 1:25) {
	x_plot=c(x_plot,x[i])
	y_plot=c(y_plot,y[i])
}
plot(x_plot,y_plot,pch=8,col='purple',xlim=c(-0.1,0.25),ylim=c(-0.2,0.3),xlab="PC1 (0.650)",ylab="PC2 (0.315)",cex.lab=1.6,xaxt="n",yaxt="n")
axis(side=1,at=c(-2:5)*0.05,labels=c(-2:5)*0.05,cex.axis=1.3)
axis(side=2,at=c(-4:6)*0.05,labels=c(-4:6)*0.05,cex.axis=1.3)
//points(x_plot,y_plot,pch=8,col='purple')
## Mbuti Pygmy
x_plot=""
y_plot=""
for (i in 26:43) {
	x_plot=c(x_plot,x[i])
	y_plot=c(y_plot,y[i])
}
points(x_plot,y_plot,pch=3,col='red')
## CHB
//x_plot=""
//y_plot=""
//for (i in 228:364) {
//	x_plot=c(x_plot,x[i])
//	y_plot=c(y_plot,y[i])
//}
//points(x_plot,y_plot,pch=15,col='green')
## JPT
//x_plot=""
//y_plot=""
//for (i in 365:477) {
//	x_plot=c(x_plot,x[i])
//	y_plot=c(y_plot,y[i])
//}
//points(x_plot,y_plot,pch=4,col='darkgreen')
## CEU
//x_plot=""
//y_plot=""
//for (i in 330:441) {
//	x_plot=c(x_plot,x[i])
//	y_plot=c(y_plot,y[i])
//}
//points(x_plot,y_plot,pch=5,col='blue')
## YRI
x_plot=""
y_plot=""
for (i in 44:length(x)) {
	x_plot=c(x_plot,x[i])
	y_plot=c(y_plot,y[i])
}
points(x_plot,y_plot,pch=6,col='black')

legend("bottomleft",legend=c("Biaka Pygmy","Mbuti Pygmy","YRI"),col=c("purple","red","black"),cex=1.5,pch=c(8,3,6))
dev.off()
