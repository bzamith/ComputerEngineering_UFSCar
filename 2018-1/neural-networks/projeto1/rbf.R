# Funcao RBF com o LSM com pseudo-inversa
# Retorna um modelo RBF dado:
# * observacoes x1...xN do dataset
# * valor de saida de cada observacao
# * numero de centros
# * valor gama para a funcao Gaussiana
# Precisa so pacote corpcor para a pseudo inversa
require(corpcor)


#Essa funcao retorna as classes originais do problema, comparando com os inteiros que foram criados, já para a predição
rbf.recebe.predicao = function(pred,adaptado,original){
  saida=c()
  for(i in 1:length(pred)){
    dist=c()
    for(j in 1:length(adaptado)){
      dist = c(dist,abs(pred[i]-adaptado[j]))
    }
    saida=c(saida,original[adaptado[which.min(dist)]])
  }
  return(saida)
}

rbf = function(dados, K=10, gama=1.0) {
  N = dim(dados)[1] # numero de observacoes
  ncols = dim(dados[,-ncol(dados)])[2] # numero de variaveis
  repeat {
    km = kmeans(dados[,-ncol(dados)], K) # agrupa os dados em K grupos
    if (min(km$size)>0) # nao pode haver grupos vazios
      break
  }
  mus = km$centers # centros dos grupos (medias)
  # Calcula as saidas das Gaussianas
  Phi = matrix(rep(NA,(K+1)*N), ncol=K+1) # Vai armazenar todas as saidas mais o bias
  for (lin in 1:N) {
    Phi[lin,1] = 1 # coluna do bias
    for (col in 1:K) {
      Phi[lin,col+1] = exp( (-1/(2*gama*gama)) *
                               sum((dados[,-ncol(dados)][lin,]-mus[col,])*(dados[,-ncol(dados)][lin,]-mus[col,])) )
      #Phi[lin,col+1] = exp( -gama * sum((X[lin,]-mus[col,])*(X[lin,]-mus[col,])))
      #Phi[lin,col+1] = exp( -gama * norm(as.matrix(X[lin,]-mus[col,]),"F")^2 )
    }
  }
  # Calcula os pesos com a pseudo inversa -> w = inversa(t(Phi) * Phi) * t(Phi) * Y
  # Encontra os pesos fazendo a inversa
  # %*% é para multiplicacao de matrizes
  Y = as.numeric(dados[,ncol(dados)])
  w = pseudoinverse(t(Phi) %*% Phi) %*% t(Phi) %*% Y
  return(list(pesos=w, centros=mus, gama=gama, levels.original = levels(dados[,ncol(dados)]), levels.adaptado = levels(as.factor(Y)))) # retorna o modelo RBF
}

# Implementacao da funcao para predicao
rbf.predict = function(modelo, dados, classification=FALSE) {
  gama = modelo$gama
  centros = modelo$centros
  w = modelo$pesos
  N = dim(dados[,-ncol(dados)])[1] # numero de observacoes
  pred = rep(w[1],N) # inicia com o peso do bias ja que a entrada associada eh 1
  for (j in 1:N) {
    # Predicao para o ponto xj
    for (k in 1:length(centros[,1])) {
      # o peso para o centro[k] é dado por w[k+1] porque w[1] eh o bias
      pred[j] = pred[j] + w[k+1] * exp( (-1/(2*gama*gama)) *
                                           sum((dados[,-ncol(dados)][j,]-centros[k,])*(dados[,-ncol(dados)][j,]-centros[k,])) )
      #pred[j]=pred[j]+w[k+1]*exp(-gama*sum((X[j,]-centros[k,])*(X[j,]-centros[k,])))
      #pred[j]=pred[j]+w[k+1]*exp(-gama*norm(as.matrix(X[j,]-centros[k,]),"F")^2)
    }
  }
  # Se for classificacao, aplica a funcao sinal em cada pred
  if (classification) {
      pred = rbf.recebe.predicao(pred,as.numeric(modelo$levels.adaptado),modelo$levels.original)
  }
  return(pred)
}

#Cria a matriz de confusao para a mlp gerada
rbf.confusion.matrix = function(modelo,dados){
  resultado = rbf.predict(modelo,dados,classification=TRUE)
  retorno = list()
  retorno$matriz.confusao = confusionMatrix(as.factor(resultado),dados[,ncol(dados)])
  retorno$predito = as.factor(resultado)
  return(retorno)
}

