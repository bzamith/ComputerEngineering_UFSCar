from copy import deepcopy
import random
import operator

# Variaveis globais, POP_TAM deve ser um numero multiplo de 4
POP_TAM = 12
POP_SEL = POP_TAM/2
MAX_GERACAO = 5

# Classe para Cromossomo do AG 
class Cromossomo:
    def __init__(self, kp, ki, kd):
    	self.kp = kp
    	self.ki = ki
    	self.kd = kd
    	self.taxa_erro = 0
    def getKp(self):
        return self.kp
    def setKp(self,kp):
        self.kp = kp
    def getKi(self):
        return self.ki
    def setKi(self,ki):
        self.ki = ki
    def getKd(self):
        return self.kd
    def setKd(self,kd):
        self.kd = kd
    def getTaxaErro(self):
        return self.taxa_erro
    def calculaTaxaErro(self):
        self.taxa_erro = random.uniform(0,1)
        return self.taxa_erro
    def printaCromossomo(self):
	print("Kp = "+str(self.kp)+"\n"
	    "Ki = "+str(self.ki)+"\n"
	    "Kd = "+str(self.kd)+"\n"
	    "Erro = "+str(self.taxa_erro)+"\n")

# Funcao para simular o range de Kp
def calculaRangeKp():
	return 1,9

# Funcao para simular o range de Ki
def calculaRangeKi():
	return 7,20.8

# Funcao para simular o range de Kd
def calculaRangeKd():
	return 10,30.5

# Cria a populacao inicial baseada nos ranges
def populacaoInicial():
	populacao = list()	
	pmin, pmax = calculaRangeKp()
	imin, imax = calculaRangeKi()
	dmin, dmax = calculaRangeKd()		
	for i in range(0, POP_TAM):
		populacao.append(Cromossomo(
			random.uniform(pmin,pmax),
			random.uniform(imin,imax),
			random.uniform(dmin,dmax)))
	return populacao

# Faz a selecao da populacao
def selecao(populacao):
	erros = {}	
	for i in range(0, len(populacao)):
		populacao[i].calculaTaxaErro()
	sorted_erros = sorted(populacao, key=operator.attrgetter('taxa_erro'))
	return sorted_erros[0:POP_SEL]

# Faz o cruzamento, altera apenas o Kp
def cruzamento(populacao):
    filhos = deepcopy(populacao)
    for i in range(0, len(filhos), 2):
        temp = filhos[i].getKp() 
        filhos[i].setKp(filhos[i+1].getKp())
        filhos[i+1].setKp(temp)
    return filhos

# Funcao principal
if __name__ == "__main__":
    pop_inicial = populacaoInicial()
    geracao = 1
    
    while(geracao <= MAX_GERACAO):
        pop_selecionada = selecao(pop_inicial)
        menor = pop_selecionada[0]
        nova_pop = pop_selecionada+cruzamento(pop_selecionada)
        print("Geracao: "+str(geracao))
        for i in range(0,len(nova_pop)):
		nova_pop[i].printaCromossomo()
	print("-----------------------------------------------------")
    	pop_inicial = deepcopy(nova_pop)
	geracao=geracao+1
	
    menor.printaCromossomo()
