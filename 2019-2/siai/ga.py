import random
class Cromossomo:
	def __init__(self, kp, ki, kd):
		self.kp = kp
		self.ki = ki
		self.kd = kd
		self.taxa_erro

def populacaoInicial(qntd):
	populacao = list()	
	pmin, pmax = calculaRangeKp()
	imin, imax = calculaRangeKi()
	dmin, dmax = calculaRangeKd()		
	for i in range(0, qntd):
		populacao.append(Cromossomo(
			random.uniform(pmin,pmax),
			random.uniform(imin,imax).
			ranfom.uniform(dmin,dmax)))
	return populacao

def calculaErro(cromossomo):
	erro = calculaTaxaErro(cromossomo)
	cromossomo.taxa_erro = erro

def selecao(populacao, qtnd):
	erros = list()	
	for i in range(0, len(populacao)):
		calculaErro(populacao[i])
		erros.append(populacao[i].taxa_erro)
	erros.sort()
	return erros[0:qntd]
