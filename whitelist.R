wl<-clminwl_207736[,c(1,14)]
wl$avf<-wl$avncount/sum(wl$avncount)



###need separate for venn
cir<-list(clminA$barcode,clminB$barcode,clminC$barcode,clminD$barcode)
ggVennDiagram(cir, label_alpha=0, category.names = c("A","B","C","D"),label_size = 8,label_face = "bold",set_size=8,edge_size = 2) +
  ggplot2::scale_fill_gradient(low="white", high="grey")+
  ggplot2::scale_color_manual(values=c("black","black","black","black"))

##distribution 
clminD$type<-"D"
library(ggplot2)
concatenate<-rbind(clminA,clminB,clminC,clminD)
p<-ggplot(concatenate, aes(x=freq, fill=type)) +
  geom_histogram(binwidth=0.000001, alpha =0.5, position="dodge")+
  xlim(0,0.00005)
q<-p+labs(x="Barcode Frequency",y="Counts")
q+ theme_grey(base_size = 22)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "grey"))+
  theme(text = element_text(size = 40))


## bar
name<-c("A","B","C","D","Mean","Total")
number<-c(183754,
          164608,
          155345,
          168240,
          mean(183754,
               164608,
               155345,
               168240),
          207736
)
a1<-data.frame(name,number)
bp<-barplot(number~name, data=a1,
            ylab = "No. Unique Barcodes",beside=TRUE)
text(bp,220000,round(a1$number, 1),cex=1,pos=4)

mean(183754,
     164608,
     155345,
     168240)

#bhang: 95% with 2-12 reads?
wl$bcount<-wl$avf*5600000
wl95<-subset(wl,bcount<=90)
######################################wl_207736 seems wrong A&B same

sum(a95$freq)

#LM
library(stats)
ab<-merge(clminA,clminB,by="barcode")
lm <- lm(log2(clminwl_207736$countA)~log2(clminwl_207736$countB),clminwl_207736)
summary(lm)
abline(lm,col="blue")
plot.new
plot(rnac~dnac,data=clminrnalm)
abline(lm,col="blue")

#high ones
wl$vcount<-wl$avf*20000
wlv<-subset(wl,vcount>0.5)
sum(wlv)

#means
mean(clminwl_207736$countA)
med_d<-median(wld_min3$freq)
sd_d<-sd(wld_min3$freq)
