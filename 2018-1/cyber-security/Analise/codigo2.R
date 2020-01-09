path = "~/Documents/Grad_e_IC/7o_Semestre/Seguranca/BGP/Tabelas/"

arquivos = list.files(path, "IPv4")
d = freqIpTable[!(freqIpTable$freq==1),]
d = d[!(d$freq==2),]
d = d[!(d$freq==3),]
#d = d[!(d$freq==4),]
#d = d[!(d$freq==5),]

cidades = c()
for(j in 1:length(arquivos)){
  deal_string = unlist(gregexpr("\\.",arquivos[j]))
  cidades = c(cidades,substr(arquivos[j],deal_string[1]+1,deal_string[2]-1))
}

estudo = data.frame(matrix(rep(0,nrow(d)*length(arquivos)), nrow(d), length(arquivos), dimnames=list(d[,2], cidades)),
                    stringsAsFactors=F)

for(i in 1:length(arquivos)){
  info = readLines(paste(path,arquivos[i],sep=""))
  cat(i,"/",length(arquivos),"\n")
  for(j in 1:nrow(d)){
    if(length(grep(d[j,2], info, value = TRUE))>0){
      estudo[j,i]=1
    }
  }
}

write.csv(estudo,"estudoCidades.csv")

soma = c()
for(i in 1:ncol(estudo)){
  soma = c(soma,sum(estudo[,i]))
}


regioes=c("Nordeste","Norte","Sudeste","Nordeste","Centro-Oeste","Nordeste","Sul","Centro-Oeste","Centro-Oeste","Sul","Nordeste","Sul","Sul","Norte","Sul","Sudeste","Nordeste","Nordeste","Sul","Sul","Sudeste","Sul","Sul","Nordeste","Sudeste","Sudeste","Sudeste","Nordeste","Sudeste")
dados = data.frame(freq=soma,cidade=colnames(estudo),regioes=regioes)

write.csv(dados,"dadosCidades.csv")
ggplot(dados, aes(x=cidade, y=freq,fill=dados$regioes)) + stat_summary(fun.y="mean", geom="bar")
