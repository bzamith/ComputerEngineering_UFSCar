library(binaryLogic)
library(iptools)
library(plyr)

subnet = function(ip,mask){
  octetos = strsplit(ip,"\\.")
  ip_binario=c()
  for(i in 1:4){
    binarios = as.binary(octetos[[1]][i],n=0)
    binarios = c(rep(0,8-length(binarios)),binarios)
    ip_binario = c(ip_binario,binarios)
  }
  ip_binario = c(ip_binario[1:mask],rep(0,32-mask))
  saida=""
  for(i in 1:4){
    atual = ip_binario[(8*(i-1)+1):(8*i)]
    saida=paste(saida,Reduce(function(x,y) x*2+y, atual),sep="")
    if(i!=4){
      saida = paste(saida,".",sep="")
    }
  }
  return(saida)
}

ipTable = read.csv("iptable.csv")
ipTable = ipTable[,-1]

ips_string = rep('0',nrow(ipTable))
for(i in 1:nrow(ipTable)){
  ips_string[i] = numeric_to_ip(ipTable[i,1])
}

ipTable = cbind(ipTable,ips_string)

columnReduced = rep("",nrow(ipTable))
for(i in 1:nrow(ipTable)){
  columnReduced[i] = subnet(toString(ipTable[i,3]),ipTable[i,2])
}

