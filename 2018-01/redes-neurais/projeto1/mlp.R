require(caret) #Necessario para a confusionMatrix
require(e1071) #Necessario para a confusionMatrix

#Funcao de ativacao
mlp.funcao.ativacao = function(v){
  y = 1/(1+exp(-v))
  return(y)
}

#Derivada da funcao de ativacao
mlp.der.funcao.ativacao = function(y){
  derivada=y*(1-y)
  return(derivada)
}

#Arquitetura da Rede - Matrizes com pesos
mlp.arquitetura = function(num.entrada,num.escondida,num.saida,funcao.ativacao,der.funcao.ativacao){
  arq = list() #Propriedades da rede
  arq$num.entrada = num.entrada
  arq$num.escondida = num.escondida
  arq$num.saida = num.saida
  arq$funcao.ativacao = mlp.funcao.ativacao
  arq$der.funcao.ativacao = mlp.der.funcao.ativacao
  
  #Pesos conectando a camada de entrada com a escondida
  num.pesos.entrada.escondida = (num.entrada+1)*num.escondida
  arq$escondida = matrix(runif(min=-0.5,max=0.5,num.pesos.entrada.escondida),nrow=num.escondida,ncol=num.entrada+1)
  
  #Pesos conectando a camada escondida com a saida
  num.pesos.escondida.saida = (num.escondida+1)*num.saida
  arq$saida = matrix(runif(min=-0.5,max=0.5,num.pesos.escondida.saida),nrow=num.saida,ncol=num.escondida+1)
  
  return(arq)
}

#Propagacao
mlp.propagacao = function(arq,exemplo){
  #Entrada -> Escondida
  v.entrada.escondida = arq$escondida %*% as.numeric(c(exemplo,1))
  y.entrada.escondida = arq$funcao.ativacao(v.entrada.escondida)
  
  #Escondida -> Saida
  v.escondida.saida = arq$saida %*% c(y.entrada.escondida,1)
  y.escondida.saida = arq$funcao.ativacao(v.escondida.saida)
  
  #Resultados
  resultados = list()
  resultados$v.entrada.escondida = v.entrada.escondida
  resultados$y.entrada.escondida = y.entrada.escondida
  resultados$v.escondida.saida = v.escondida.saida
  resultados$y.escondida.saida = y.escondida.saida
  
  return(resultados)
}

#Fase de retropropagacao
mlp.retropropagacao = function(arq,dados,n,limiar){
  erroQuadratico = 2*limiar
  epocas = 0
  
  #Treina enquanto erroQuadratico > limiar
  while(erroQuadratico > limiar){
    erroQuadratico = rep(0,arq$num.saida)
    
    #Treino para todos os exemplos
    for(i in 1:nrow(dados)){
      #Pego um exemplo de entrada
      x.entrada = dados[i,1:arq$num.entrada]
      x.saida = dados[i,ncol(dados)]
      
      #Saida da rede para o exemplo
      resultado = mlp.propagacao(arq,x.entrada)
      y = resultado$y.escondida.saida
      
      #Erro caso tenha mais de uma saida
      if(arq$num.saida > 1){
        x.compara = rep(0,arq$num.saida)
        for(j in 1:length(levels(dados[,ncol(dados)]))){
          if(x.saida == levels(dados[,ncol(dados)])[j]){
            x.compara[j]=1
            break
          }
        }
        
        erro = mapply('-',as.numeric(x.compara),as.numeric(y))
        erroQuadratico = mapply('+',as.numeric(erroQuadratico),as.numeric(erro*erro))
      }
      #Caso contrario
      else{
        erro = x.saida - y
        erroQuadratico = erroQuadratico + erro*erro
      }
      
      #Gradiente local do neuronio de saida
      #Erro * derivada da funcao de ativacao
      grad.local.saida = erro * arq$der.funcao.ativacao(y)
      
      #Gradiente local dos neuronios escondidos
      #Derivada da funcao de ativacao * (somatorio dos gradientes locais * pesos)
      pesos.saida = arq$saida[,1:arq$num.escondida]
      grad.local.escondida = as.numeric(as.numeric(grad.local.saida) %*% pesos.saida) * arq$der.funcao.ativacao(resultado$y.entrada.escondida) 
      
      
      #Ajuste dos pesos
      #Saida
      arq$saida = arq$saida + n * (grad.local.saida %*% as.numeric(c(resultado$y.entrada.escondida,1)))
      #Escondida
      arq$escondida = arq$escondida + n * (grad.local.escondida %*% as.numeric(c(x.entrada,1)))
    }
    
    erroQuadratico = mean(erroQuadratico)/nrow(dados) 
    #cat("Erro Quadratico Medio = ",erroQuadratico,"\n")
    epocas = epocas+1
  }
  retorno = list()
  retorno$arq = arq
  retorno$epocas = epocas
  
  return(retorno)
}

#Cria a matriz de confusao para a mlp gerada
mlp.confusion.matrix = function(algoritmo,dados){
  predictedClasses=rep("0",nrow(dados))
  for(i in 1:nrow(dados)){
    resultado = mlp.propagacao(algoritmo$arq,dados[i,1:algoritmo$arq$num.entrada])
    class = which.max(resultado$y.escondida.saida)
    levels = levels(dados[,ncol(dados)])
    predictedClasses[i]=levels[class]
  }
  retorno = list()
  retorno$matriz.confusao = confusionMatrix(as.factor(predictedClasses),dados[,ncol(dados)])
  retorno$predito = as.factor(predictedClasses)
  return(retorno)
}
