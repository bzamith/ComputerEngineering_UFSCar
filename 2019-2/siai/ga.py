import random
import collections
import operator

class Cromossomo:
	def __init__(self, kp, ki, kd):
		self.kp = kp
		self.ki = ki
		self.kd = kd
		self.taxa_erro = 0
	def calculaTaxaErro(self):
		self.taxa_erro = 10
		return 10
	def printaCromossomo(self):
		print("Kp = "+str(self.kp)+"\n"
			"Ki = "+str(self.ki)+"\n"
			"Kd = "+str(self.kd)+"\n"
			"Erro = "+str(self.taxa_erro)+"\n")

def calculaRangeKp():
	return 1,9

def calculaRangeKi():
	return 7,20.8

def calculaRangeKd():
	return 10,30.5

def populacaoInicial(qntd):
	populacao = list()	
	pmin, pmax = calculaRangeKp()
	imin, imax = calculaRangeKi()
	dmin, dmax = calculaRangeKd()		
	for i in range(0, qntd):
		populacao.append(Cromossomo(
			random.uniform(pmin,pmax),
			random.uniform(imin,imax),
			random.uniform(dmin,dmax)))
	return populacao

def selecao(populacao, qntd):
	erros = {}	
	for i in range(0, len(populacao)):
		populacao[i].calculaTaxaErro()
	sorted_erros = sorted(populacao, key=operator.attrgetter('taxa_erro'))
	return sorted_erros

if __name__ == "__main__":
	teste = selecao(populacaoInicial(10),10)
	for i in range(0,10):
		teste[i].printaCromossomo()
