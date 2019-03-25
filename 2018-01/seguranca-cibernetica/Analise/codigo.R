setwd("~/Documents/Grad_e_IC/7o_Semestre/Seguranca/BGP")
library(iptools)
library(plyr)
library(binaryLogic)
library(ggplot2)


findClass = function(ip){
  octetos = strsplit(ip,"\\.")
  binarios = as.binary(octetos[[1]][1],n=0)
  if(length(binarios)>=1 & sign(as.integer(binarios[1]) - 0)==0){
    return("A")
  }
  else if(length(binarios)>=2 & (sign(as.integer(binarios[1]) - 1)==0 && sign(as.integer(binarios[2]) - 0)==0)){
    return("B")
  }
  else if(length(binarios)>=3 & (sign(as.integer(binarios[1]) - 1)==0 && sign(as.integer(binarios[2]) - 1)==0 && sign(as.integer(binarios[3]) - 0)==0)){
    return("C")
  }
  else if(length(binarios)>=4 & (sign(as.integer(binarios[1]) - 1)==0 && sign(as.integer(binarios[2]) - 1)==0 && sign(as.integer(binarios[3]) - 1)==0 && sign(as.integer(binarios[4]) - 0)==0)){
    return("D")
  }
  else{
    return("E")
  }
}

ipTable = read.csv("saida.csv", sep=",", header=TRUE)
ipTable = ipTable[,-1]
qntd_original = nrow(ipTable)
ips = rep('0',qntd_original)

for(i in 1:qntd_original){
  ips[i] = numeric_to_ip(ipTable[i,1])
}

freqIpTable = count(ipTable,"ips")
freqIpTable2 = count(ipTable,"ip")

diff = qntd_original - nrow(freqIpTable)
classes = rep("", nrow(freqIpTable))

for(i in i:nrow(freqIpTable)){
  classes[i] = findClass(toString(freqIpTable[i,1]))
}
freqIpTable = cbind(freqIpTable,classes)

write.csv(ipTable,"iptable.csv")
write.csv(freqIpTable,"freqIpTable.csv")
write.csv(freqIpTable2,"freqIpTable2.csv")

ipTable = read.csv("iptable.csv")
freqIpTable = read.csv("freqIpTable.csv")
freqIpTable2 = read.csv("freqIpTable2.csv")

barplot(freqIpTable$freq, names.arg = freqIpTable$ips)
hist(freqIpTable2$ip)

d = freqIpTable[(freqIpTable$freq==1),]
#d = d[!(d$freq==2),]
#d = d[!(d$freq==3),]
#d = d[!(d$freq==4),]
#ggplot(d, aes(freq, fill = d$classes)) + geom_histogram(binwidth = 1)
ggplot(freqIpTable, aes(freq, fill = freqIpTable$classes)) + geom_histogram(binwidth = 1) + ggtitle("") + theme(plot.title = element_text(hjust=0, size=16)) + xlab("Tamanho dos Blocos") + ylab("Contagem")

MLBRPGplot <- ggplot(freqIpTable2, aes(x=freq, y=ip)) + geom_point() + ggtitle("") + xlab("Tamanho dos Blocos") + ylab("IP (decimal)")
