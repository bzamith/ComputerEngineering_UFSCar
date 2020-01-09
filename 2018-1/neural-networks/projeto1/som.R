# Distancia Euclidiana
som.euc.dist = function(x, y){
  distancia = sqrt(sum((x - y)^2))
}

#Seta parametros pra Som
som.cria.parametros = function(dados){
  parametros=list()
  parametros$levels.original = levels(dados[,ncol(dados)])
  dados[,ncol(dados)]=as.factor(dados[,ncol(dados)])
  num.variaveis = ncol(dados[,-ncol(dados)])
  parametros$dados = dados
  parametros$num.variaveis = num.variaveis
  parametros$n0 = 0.1 # taxa de aprendizado inicial
  parametros$fi0 = 8 # largura inicial da vizinhanca
  parametros$tal1 = 1000/log(parametros$fi0) # constante para a variacao da largura
  parametros$tal2 = 1000 # constante para a variacao da taxa de aprendizado
  parametros$iteracoes = 30 # numero maximo de iteracoes
  parametros$iteracoes.s = 5 # a cada iteracoes.s salvar a estado do mapa
  parametros$dimensao = 8 # dimensao do mapa
  return(parametros)
}

som.constroi.mapa = function(parametros, printar = FALSE){
  mapa = matrix(ncol=parametros$dimensao ,nrow=parametros$dimensao, data=0)
  # Array tri-dimensional para armazenar os pesos
  # [linha,pesos,coluna]
  pesos = array(runif(parametros$dimensao*parametros$num.variaveis*parametros$dimensao,min=-1,max=1),
                dim=c(parametros$dimensao,parametros$num.variaveis,parametros$dimensao))
  fi = parametros$fi0
  n = parametros$n0
  # Inicio da iteracao
  for(it in 1:parametros$iteracoes){
    # Mistura os dados
    parametros$dados= parametros$dados[sample(nrow(parametros$dados)),]
    dados.entrada = parametros$dados[,-ncol(parametros$dados)]
    dados.saida = parametros$dados[,ncol(parametros$dados)]
    # Itera para cada exemplo
    for(i in 1:nrow(dados.entrada)){
      x = dados.entrada[i,]
      # Para cada vetor de pesos dos neuronios
      min_j = 1
      min_k = 1
      min_dist = 99999
      for(j in 1:parametros$dimensao){
        # Pesos dos primeiros dimensao neuronios
        tpesos = t(pesos[j,,])
        colnames(tpesos) = colnames(x)
        matriz = rbind(x,tpesos)
        matriz.distancias = dist(matriz,method = "euclidean")
        # matriz.distancias eh tipo dist. As primeiras "dimensao" posicoes contem
        # as distancias entre x e os neuronios
        distancias = sort(matriz.distancias[1:parametros$dimensao],index.return=TRUE)
        for(k in 1:parametros$dimensao){
          distancia = distancias$x[k]
          # Guarda o neuronio com a menor distancia
          # Nao vamos mapear mais de um exemplo para o mesmo neuronio
          if(distancia < min_dist){
            if(mapa[j,distancias$ix[k]] == 0){
              min_dist = distancia
              min_j = j
              min_k = distancias$ix[k]
              break
            }
          }
        }
      }
      #cat(i," ")
      # Marca o neuronio mais proximo
      mapa[min_j,min_k] = dados.saida[i]
      # Atualizacao dos pesos
      # wj(it+1) = wj(it) + n(it)*hji(x)(it)*[x(it)-wj(it)]
      for(j in 1:parametros$dimensao){
        for(k in 1:parametros$dimensao){
          # Distancia entre neuronio vencedor e neuronio [j,k] no mapa
          #distancia = dist(rbind(c(min_j,min_k),c(j,k)), method = "euclidean")
          #distancia = as.numeric(distancia)
          distancia = som.euc.dist(c(min_j,min_k),c(j,k))
          # Funcao Gaussiana
          vizinhanca = exp(-distancia / (2*fi*fi))
          # Atualiza os pesos
          w = pesos[j,,k]
          w = w + n * vizinhanca * (x - w)
          pesos[j,,k] = unlist(w)
        }
      }
    }
    # Atualiza fi e n
    fi = parametros$fi0 * exp(-it / parametros$tal1)
    n = parametros$n0 * exp(-it / parametros$tal2)
    # Mostra o mapa
    if(printar){
      # Mapa inicial
      if(it == 1){
        cat("\nMapa inicial\n")
        print(mapa)
        cat("\n")
      }
      cat(it," ")
      if((it %% parametros$iteracoes.s) == 0){
        cat("\nIteracao: ",it,"\n")
        print(mapa)
        cat("\n")
      }
    }
    if(it!=parametros$iteracoes){
      # Reinicia o mapa
      mapa = matrix(ncol=parametros$dimensao ,nrow=parametros$dimensao, data=0)
    }
  }
  saida = list()
  saida$mapa = mapa
  saida$pesos = pesos
  saida$levels.original = 
  return(saida)
}


som.predicao = function(algoritmo, parametros, dados){
  mapa.treino = algoritmo$mapa
  mapa.teste = matrix(ncol=parametros$dimensao ,nrow=parametros$dimensao, data=0)
  pesos = algoritmo$pesos
  dados.entrada = dados[,-ncol(dados)]
  dados.saida = as.factor(as.numeric(dados[,ncol(dados)]))
  dados.predito = c()
  # Itera para cada exemplo
  for(i in 1:nrow(dados.entrada)){
      x = dados.entrada[i,]
      # Para cada vetor de pesos dos neuronios
      min_j = 1
      min_k = 1
      min_dist = 99999
      for(j in 1:parametros$dimensao){
        # Pesos dos primeiros dimensao neuronios
        tpesos = t(pesos[j,,])
        colnames(tpesos) = colnames(x)
        matriz = rbind(x,tpesos)
        matriz.distancias = dist(matriz,method = "euclidean")
        # matriz.distancias eh tipo dist. As primeiras "dimensao" posicoes contem
        # as distancias entre x e os neuronios
        distancias = sort(matriz.distancias[1:parametros$dimensao],index.return=TRUE)
        for(k in 1:parametros$dimensao){
          distancia = distancias$x[k]
          # Guarda o neuronio com a menor distancia
          # Nao vamos mapear mais de um exemplo para o mesmo neuronio
          if(distancia < min_dist){
            if(mapa.teste[j,distancias$ix[k]] == 0 && mapa.treino[j,distancias$ix[k]] != 0){
              min_dist = distancia
              min_j = j
              min_k = distancias$ix[k]
              break
            }
          }
        }
      }
      mapa.teste[min_j,min_k] = dados.saida[i]
      # Marca o neuronio mais proximo
      dados.predito = c(dados.predito,mapa.treino[min_j,min_k])
    }
  return(dados.predito)
}

som.confusion.matrix = function(algoritmo, parametros, dados){
  resultado = som.predicao(algoritmo, parametros, dados)
  preditos = c()
  for(i in 1:length(resultado)){
    preditos = c(preditos,parametros$levels.original[resultado[i]])
  }
  retorno = list()
  retorno$matriz.confusao = confusionMatrix(as.factor(preditos),dados[,ncol(dados)])
  retorno$predito = as.factor(preditos)
  return(retorno)
}
