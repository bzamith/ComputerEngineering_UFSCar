# Trabalho 2 de Redes Neurais Artificiais
# Bruna Zamith Santos e Elaine Cecília Gatto
# 07/2018
# Prof. Dr. Ricardo Cerri

################## Funções gerais ##################################

# Pacote para trabalhar com imagens
library(png)

# Carrega os digitos da base MNIST
carrega.digitos = function(digitos = c(1,3,4,7,9), quantidade = 100, treino=1, taxa.ruido = 0){
  digitos <<- digitos # Padroes a serem armazenados
  taxa.ruido = taxa.ruido # Probabilidade de um pixel ser trocado
  # (probabilidade de ruido)
  # Carrega os padroes
  padroes <<- list()
  orgdim <<- NULL
  for(i in digitos){
    if(treino == 1){
      arquivos = list.files(paste("MNIST/mnist_png/training/",
                                   as.character(i),"/",sep=""))[1:quantidade]
      for(j in 1:quantidade){
        img = readPNG(paste("MNIST/mnist_png/training/",
                             as.character(i),"/",arquivos[j], sep=""))
        orgdim <<- dim(img)
        dim(img) = NULL
        # Armazena os padroes
        padroes[[length(padroes)+1]] <<- as.vector(ifelse(img >= 0.2, 1, 0))
      }
    }
    else{
      arquivos = list.files(paste("MNIST/mnist_png/testing/",
                                   as.character(i),"/",sep=""))[1:quantidade]
      for(j in 1:quantidade){
        img = readPNG(paste("MNIST/mnist_png/testing/",
                             as.character(i),"/",arquivos[j], sep=""))
        orgdim <<- dim(img)
        dim(img) = NULL
        # Armazena os padroes
        padroes[[length(padroes)+1]] <<- as.vector(ifelse(img >= 0.2, 1, 0))
      }
    }
  }
}

# Teste Visual
testa.digitos = function(modelo,taxa.ruido=0,type="Autoencoder"){
  # Carrega digitos de teste
  carrega.digitos(digitos = c(0,1,2,3,4,5,6,7,8,9),1,0,taxa.ruido)
  plotdim = 2*orgdim
  plot(c(1,(plotdim[1]+5)*length(digitos)), c(1,(plotdim[2]+5)*3), type="n", xlab="", ylab="")
  x = 1
  for (i in 1:length(padroes)) {
    padrao = padroes[[i]]
    ruido = (runif(length(padrao), 0, 1) > taxa.ruido ) * 1
    entrada = padrao * ruido
    if(type=="Autoencoder"){
      retorno = denoising.propagacao(modelo$arq,entrada)
      ret = retorno$y.escondida.saida
      ret = as.vector(ifelse(ret >= 0.5, 1, 0))
    } else if (type=="Denoising"){
      retorno = autoencoder.propagacao(modelo$arq,entrada)
      ret = retorno$y.escondida.saida
      ret = as.vector(ifelse(ret >= 0.5, 1, 0))
    } else{
      ret = rbm.reconstrucao(modelo,entrada)
    }
    # Padrao original
    img = padrao;
    dim(img) = orgdim
    image = as.raster((img+1)/2)
    rasterImage(image, x, 1, x + plotdim[1], plotdim[2], interpolate=F)
    # Entrada com ruido
    img = entrada;
    dim(img) = orgdim
    image = as.raster((img+1)/2)
    rasterImage(image, x, 1+(plotdim[2]+5), x + plotdim[1], 1+2*(plotdim[2]+5), interpolate=F)
    # Imagem recuperada
    img = ret;
    dim(img) = orgdim
    image = as.raster((img+1)/2)
    rasterImage(image, x, 1+2*(plotdim[2]+5), x + plotdim[1], 1+2*(plotdim[2]+5)+plotdim[2], interpolate=F)
    x = x + plotdim[1]+5
  }
}

corrompe.padrao = function(padroes,taxa.ruido=0.1){
  corrompidos = padroes
  for(i in 1:length(padroes)){
    padrao = padroes[[i]]
    ruido = (runif(length(padrao), 0, 1) > taxa.ruido ) * 1
    corrompidos[[i]] = padrao*ruido
  }
  return(corrompidos)
}

# Funcao de ativacao
funcao.ativacao = function(v){
  y = 1 / (1 + exp(-v))
  return(y)
}

# Derivada da funcao de ativacao
der.funcao.ativacao = function(y){
  derivada = y * (1 - y)
  return(derivada)
}

############## Funcoes do RBM ###################
sample.bernoulli <- function(p){
  retorno <- 0
  if(runif(min=0,max=1,1) < p){
    retorno <-1
  }
  return(retorno)
}

# Funcao para construir a arquitetura
rbm.arquitetura <- function(num.visiveis, num.escondidas, n, funcao.ativacao){
  arq <- list()
  # Parametros da rede
  arq$num.visiveis <- num.visiveis
  arq$num.escondidas <- num.escondidas
  arq$funcao.ativacao <- funcao.ativacao
  arq$n <- n

  # Pesos conectando camada visivel e escondida
  num.pesos.visivel.escondida <- num.visiveis*num.escondidas
  arq$visivel.escondida <- matrix(runif(min=-0.5,max=0.5, num.pesos.visivel.escondida),
                                  
                                  nrow=num.escondidas, ncol=num.visiveis)
  
  # Pesos conectando bias e camada escondida
  arq$bias.escondida <- runif(min=-0.5,max=0.5,num.escondidas)
  # Pesos conectando bias e camada visivel
  arq$bias.visivel <- runif(min=-0.5,max=0.5,num.visiveis)
  return(arq)
}

# Funcao para a execucao do algoritmo contrastive divergence
contrastive.divergence <- function(exemplos,arq,K,epocas){
  # Para cada epoca
  for(i in 1:epocas){
    # Para cada exemplo
    for(j in 1:length(exemplos)){
      x <- exemplos[[j]]
      # Para caada k -> Gibbs Sampling
      for(k in 1:K){
        #p(h|x)
        v.h.x <- cbind(arq$visivel.escondida,arq$bias.escondida) %*% c(x,1)
        p.h.x <- as.numeric(arq$funcao.ativacao(v.h.x))
        bernoulli.p.h.x <- unlist(lapply(p.h.x,sample.bernoulli))
        #p(x|h) -> reconstrucao
        v.x.h <- t(c(bernoulli.p.h.x,1)) %*%
          rbind(arq$visivel.escondida,arq$bias.visivel)
        p.x.h <- as.numeric(arq$funcao.ativacao(v.x.h))
        bernoulli.p.x.h <- unlist(lapply(p.x.h,sample.bernoulli))
      }
      # Obtem p(h|~x) -> h(~x)
      v.h.x.reconst <- cbind(arq$visivel.escondida,arq$bias.escondida) %*%
        
        c(bernoulli.p.x.h,1)
      
      p.h.x.reconst <- as.numeric(arq$funcao.ativacao(v.h.x.reconst))
      # Atualizacao de pesos
      # Conexoes entre neuronios visiveis e escondidos
      deltaW <- p.h.x %*% t(x) - p.h.x.reconst %*% t(bernoulli.p.x.h)
      arq$visivel.escondida <- arq$visivel.escondida + arq$n * deltaW
      
      
      # Conexoes entre bias e camada escondida
      arq$bias.escondida <- arq$bias.escondida + arq$n * (p.h.x - p.h.x.reconst)
      # Conexoes entre bias e camada visivel
      arq$bias.visivel <- arq$bias.visivel + arq$n * (x - bernoulli.p.x.h)
    }
  }
  return(arq)
}

rbm.reconstrucao <- function(modelo,padrao){
  #p(h|x)
  v.h.x <- cbind(modelo$visivel.escondida,modelo$bias.escondida) %*% c(padrao,1)
  p.h.x <- as.numeric(modelo$funcao.ativacao(v.h.x))
  bernoulli.p.h.x <- unlist(lapply(p.h.x,sample.bernoulli))
  #p(x|h) -> reconstrucao
  v.x.h <- t(c(bernoulli.p.h.x,1)) %*%
    rbind(modelo$visivel.escondida,modelo$bias.visivel)
  p.x.h <- as.numeric(modelo$funcao.ativacao(v.x.h))
  bernoulli.p.x.h <- unlist(lapply(p.x.h,sample.bernoulli))
  return(bernoulli.p.x.h)
}


############## Funcoes do Autoencoder ###################
# Cria a arquitetura do Autoencoder
autoencoder.arquitetura = function(num.entrada, num.escondida, funcao.ativacao, der.funcao.ativacao){
  arq = list()
  # Parametros da rede
  arq$num.entrada.saida = num.entrada
  arq$num.escondida = num.escondida
  arq$funcao.ativacao = funcao.ativacao
  arq$der.funcao.ativacao = der.funcao.ativacao
  # Pesos conectando entrada e escondida
  num.pesos.entrada.escondida = (num.entrada+1)*num.escondida 
  arq$escondida = matrix(runif(min=-0.5,max=0.5, num.pesos.entrada.escondida),nrow=num.escondida, ncol=num.entrada+1)
  # Pesos conectando escondida e saida
  num.pesos.escondida.saida = (num.escondida+1)*num.entrada
  arq$saida = matrix(runif(min=-0.5,max=0.5, num.pesos.escondida.saida),nrow=num.entrada, ncol=num.escondida+1)
  return(arq)
}

# Fase de propagacao
autoencoder.propagacao = function(arq, exemplo){
  # Entrada -> Cama Escondida
  v.entrada.escondida = arq$escondida %*% as.numeric(c(exemplo,1))
  y.entrada.escondida = arq$funcao.ativacao(v.entrada.escondida)
  # Camada Escondida -> Camada de Saida
  v.escondida.saida = arq$saida %*% c(y.entrada.escondida,1)
  y.escondida.saida = arq$funcao.ativacao(v.escondida.saida)
  # Resultados
  resultado = list()
  resultado$v.entrada.escondida = v.entrada.escondida
  resultado$y.entrada.escondida = y.entrada.escondida
  resultado$v.escondida.saida = v.escondida.saida
  resultado$y.escondida.saida = y.escondida.saida
  return(resultado)
}

# Fase de aprendizado
autoencoder = function(arq, dados, n, limiar){
  loss = 10
  loss.anterior = 0
  epocas = 0
  # Treina eqto o erro for maior que um limiar
  while((abs(loss-loss.anterior)) > limiar){
    loss.anterior = loss
    loss = 0
    # Treino para todos os exemplos (epoca)
    for(i in 1:length(dados)){
      # Pego um exemplo de entrada
      x = dados[[i]]
      # Pego a saida da rede para o exemplo
      resultado = autoencoder.propagacao(arq,x)
      y = resultado$y.escondida.saida
      # Calculo do erro para o exemplo
      erro = x - y
      loss = loss + -(sum(x*log(y) + (1-x)*log(1-y)))
      # Gradiente local no neuronio de saida
      # erro * derivada da funcao de ativacao
      grad.local.saida = erro * arq$der.funcao.ativacao(y)
      # Gradiente local no neuronio escondido
      # derivada da funcao de ativacao no neuronio escondido * soma dos gradientes
      # locais dos neuronios conectados na proxima camada * pesos conectando a camada
      # escondida com a saida
      pesos.saida = arq$saida[,1:arq$num.escondida]
      grad.local.escondida = as.numeric(arq$der.funcao.ativacao(resultado$y.entrada.escondida)) * (as.vector(grad.local.saida) %*% pesos.saida)
      # Ajuste dos pesos
      # Saida
      arq$saida = arq$saida + n * (grad.local.saida %*% c(resultado$y.entrada.escondida,1))
      # Escondida
      arq$escondida = arq$escondida + n * (t(grad.local.escondida) %*% as.numeric(c(x,1)))
    }
    loss = loss / length(dados)
    #cat("Epoca = ",epocas," / Erro = ",loss," / ",abs(loss-loss.anterior),"\n")
    epocas = epocas+1
  }
  retorno = list()
  retorno$arq = arq
  retorno$epocas = epocas
  return(retorno)
}

############## Funcoes do Denoising Autoencoder ###################
# Cria a arquitetura do Autoencoder
denoising.arquitetura = function(num.entrada, num.escondida, funcao.ativacao, der.funcao.ativacao){
  arq = list()
  # Parametros da rede
  arq$num.entrada.saida = num.entrada
  arq$num.escondida = num.escondida
  arq$funcao.ativacao = funcao.ativacao
  arq$der.funcao.ativacao = der.funcao.ativacao
  # Pesos conectando entrada e escondida
  num.pesos.entrada.escondida = (num.entrada+1)*num.escondida 
  arq$escondida = matrix(runif(min=-0.5,max=0.5, num.pesos.entrada.escondida),nrow=num.escondida, ncol=num.entrada+1)
  # Pesos conectando escondida e saida
  num.pesos.escondida.saida = (num.escondida+1)*num.entrada
  arq$saida = matrix(runif(min=-0.5,max=0.5, num.pesos.escondida.saida),nrow=num.entrada, ncol=num.escondida+1)
  return(arq)
}

# Fase de propagacao
denoising.propagacao = function(arq, exemplo){
  # Entrada -> Cama Escondida
  v.entrada.escondida = arq$escondida %*% as.numeric(c(exemplo,1))
  y.entrada.escondida = arq$funcao.ativacao(v.entrada.escondida)
  # Camada Escondida -> Camada de Saida
  v.escondida.saida = arq$saida %*% c(y.entrada.escondida,1)
  y.escondida.saida = arq$funcao.ativacao(v.escondida.saida)
  # Resultados
  resultado = list()
  resultado$v.entrada.escondida = v.entrada.escondida
  resultado$y.entrada.escondida = y.entrada.escondida
  resultado$v.escondida.saida = v.escondida.saida
  resultado$y.escondida.saida = y.escondida.saida
  return(resultado)
}

# Fase de aprendizado
denoising = function(arq, dados, corrompidos, n, limiar){
  loss = 10
  loss.anterior = 0
  epocas = 0
  # Treina eqto o erro for maior que um limiar
  while((abs(loss-loss.anterior)) > limiar){
    loss.anterior = loss
    loss = 0
    # Treino para todos os exemplos (epoca)
    for(i in 1:length(dados)){
      # Pego um exemplo de entrada
      x = corrompidos[[i]]
      x.real = dados[[i]]
      # Pego a saida da rede para o exemplo
      resultado = autoencoder.propagacao(arq,x)
      y = resultado$y.escondida.saida
      # Calculo do erro para o exemplo
      erro = x.real - y  #UNICA MODIFICACAO?
      loss = loss + -(sum(x*log(y) + (1-x)*log(1-y)))
      # Gradiente local no neuronio de saida
      # erro * derivada da funcao de ativacao
      grad.local.saida = erro * arq$der.funcao.ativacao(y)
      # Gradiente local no neuronio escondido
      # derivada da funcao de ativacao no neuronio escondido * soma dos gradientes
      # locais dos neuronios conectados na proxima camada * pesos conectando a camada
      # escondida com a saida
      pesos.saida = arq$saida[,1:arq$num.escondida]
      grad.local.escondida = as.numeric(arq$der.funcao.ativacao(resultado$y.entrada.escondida)) * (as.vector(grad.local.saida) %*% pesos.saida)
      # Ajuste dos pesos
      # Saida
      arq$saida = arq$saida + n * (grad.local.saida %*% c(resultado$y.entrada.escondida,1))
      # Escondida
      arq$escondida = arq$escondida + n * (t(grad.local.escondida) %*% as.numeric(c(x,1)))
    }
    loss = loss / length(dados)
    #cat("Epoca = ",epocas," / Erro = ",loss," / ",abs(loss-loss.anterior),"\n")
    epocas = epocas+1
  }
  retorno = list()
  retorno$arq = arq
  retorno$epocas = epocas
  return(retorno)
}

############# Roda Tudo ####################
roda.tudo = function(soma,taxa,qntd.imagens){
  carrega.digitos(digitos = c(0,1,2,3,4,5,6,7,8,9),qntd.imagens,1,0)
  corrompidos = corrompe.padrao(padroes, taxa)
  arq.rbm = rbm.arquitetura(length(padroes[[1]]), length(padroes[[1]])-1, 0.2, funcao.ativacao)
  arq.autoencoder = autoencoder.arquitetura(length(padroes[[1]]),length(padroes[[1]])+soma,funcao.ativacao,der.funcao.ativacao)
  arq.denoising = denoising.arquitetura(length(padroes[[1]]),length(padroes[[1]])+soma,funcao.ativacao,der.funcao.ativacao)
  modelo.rbm = contrastive.divergence(padroes,arq.rbm,1,100)
  cat("Rodou: RBM (1/3)\n")
  modelo.autoencoder = autoencoder(arq.autoencoder,padroes,0.2,0.1)
  cat("Rodou: Autoencoder (2/3)\n")
  modelo.denoising = denoising(arq.denoising,padroes,corrompidos,0.2,0.1)
  cat("Rodou: Denoising Autoencoder (3/3)\n\n")
  testa.digitos(modelo.rbm,taxa,"RBM")
  testa.digitos(modelo.autoencoder,taxa,"Autoencoder")
  testa.digitos(modelo.denoising,taxa,"Denoising")
}

############## Comparação ###################

cat("Run1: 30 a mais, taxa.ruido = 0.3, imagens = 50\n")
roda.tudo(30,0.3,50)

cat("Run2: 60 a mais, taxa.ruido = 0.3, imagens = 50\n")
roda.tudo(60,0.3,50)

cat("Run3: 90 a mais, taxa.ruido = 0.3, imagens = 50\n")
roda.tudo(90,0.3,50)

cat("Run4: 60 a mais, taxa.ruido = 0.2, imagens = 50\n")
roda.tudo(60,0.2,50)

#cat("Run5: 60 a mais, taxa.ruido = 0.3, imagens = 50\n")
#roda.tudo(60,0.3,50)

cat("Run6: 60 a mais, taxa.ruido = 0.5, imagens = 50\n")
roda.tudo(60,0.5,50)

cat("Run7: 60 a mais, taxa.ruido = 0.3, imagens = 10\n")
roda.tudo(60,0.3,10)

#cat("Run8: 60 a mais, taxa.ruido = 0.3, imagens = 50\n")
#roda.tudo(60,0.3,50)

cat("Run9: 60 a mais, taxa.ruido = 0.3, imagens = 100\n")
roda.tudo(60,0.3,100)