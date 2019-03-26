#Importa os algoritmos
source('mlp.R')
source('rbf.R')
source('som.R')

#Lê o dataset iris
dados = iris

#Normaliza os dados
dados[,1:4]=scale(dados[,1:4])

#Randomiza os dados
dados=dados[sample(nrow(dados)),]

#Cria os k-folds com k = 5
num.folds = 10
folds <- createFolds(dados$Species, k = num.folds)
#teste = dados[folds[[num.folds]],]

#Listas de saidas
mlp.acuracia = c()
rbf.acuracia = c()
som.acuracia = c()

mlp.preditos = c()
rbf.preditos = c()
som.preditos = c()

teste.reais = c()

#Arquitetura do mlp => 4 neuronios de entrada, 3 neuronios na camada escondida e 3 neuronios de saida
mlp.arq=mlp.arquitetura(4,3,3,funcao.ativacao,der.funcao.ativacao)

#Classifica já os k folds
for(i in 1:(num.folds/2)){
  treino = dados[folds[[i]],]
  teste = dados[folds[[num.folds+1-i]],]
  mlp.algoritmo = mlp.retropropagacao(mlp.arq,treino,0.3,1e-2)
  mlp.retorno = mlp.confusion.matrix(mlp.algoritmo,teste)
  mlp.acuracia = c(mlp.acuracia, mlp.retorno$matriz.confusao$overall[[1]])
  mlp.preditos = c(mlp.preditos, mlp.retorno$predito)
  cat(paste("Treinou MLP Fold",i,"\n",sep=" "))
  
  rbf.algoritmo = rbf(treino, K = 5)
  rbf.retorno = rbf.confusion.matrix(rbf.algoritmo,teste)
  rbf.acuracia = c(rbf.acuracia, rbf.retorno$matriz.confusao$overall[[1]])
  rbf.preditos = c(rbf.preditos, rbf.retorno$predito)
  cat(paste("Treinou RBF Fold",i,"\n",sep=" "))
  
  som.parametros = som.cria.parametros(treino)
  som.algoritmo = som.constroi.mapa(som.parametros)
  som.retorno = som.confusion.matrix(som.algoritmo,som.parametros,teste)
  som.acuracia = c(som.acuracia, som.retorno$matriz.confusao$overall[[1]])
  som.preditos = c(som.preditos, som.retorno$predito)
  cat(paste("Treinou SOM Fold",i,"\n",sep=" "))
  
  teste.reais = c(teste.reais,teste[,ncol(teste)])
}

#Médias e desvio-padrao das acuracias
mlp.media.acuracia = mean(mlp.acuracia)
mlp.desv.padrao.acuracia = sd(mlp.acuracia)
rbf.media.acuracia = mean(rbf.acuracia)
rbf.desv.padrao.acuracia = sd(rbf.acuracia)
som.media.acuracia = mean(som.acuracia)
som.desv.padrao.acuracia = sd(som.acuracia)

#Matriz de confusao geral
mlp.saida.preditos = c()
rbf.saida.preditos = c()
som.saida.preditos = c()
teste.saida.reais = c()
for(i in 1:length(teste.reais)){
  mlp.saida.preditos = c(mlp.saida.preditos, levels(teste[,ncol(teste)])[mlp.preditos[i]])
  rbf.saida.preditos = c(rbf.saida.preditos, levels(teste[,ncol(teste)])[rbf.preditos[i]])
  som.saida.preditos = c(som.saida.preditos, levels(teste[,ncol(teste)])[som.preditos[i]])
  teste.saida.reais = c(teste.saida.reais, levels(teste[,ncol(teste)])[teste.reais[i]])
}

mlp.conf.matrix = confusionMatrix(as.factor(mlp.saida.preditos),as.factor(teste.saida.reais))
rbf.conf.matrix = confusionMatrix(as.factor(rbf.saida.preditos),as.factor(teste.saida.reais))
som.conf.matrix = confusionMatrix(as.factor(som.saida.preditos),as.factor(teste.saida.reais))

