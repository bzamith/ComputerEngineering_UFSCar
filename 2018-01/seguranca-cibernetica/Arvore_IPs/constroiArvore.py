import csv
from netaddr import *
import ipaddress
import re
from anytree import Node, RenderTree

def numtoip(ip):
    return ipaddress.ip_address(int(re.sub('[^0-9]', '', str(ip)))).__str__()

def getstrcidr(nets):
	for i in range(0,len(nets)-1):
		nets[i] = str(nets[i])
	return(nets)

def diff(l1, l2):
	#return([x for x in l1 if x not in l2])
	#return(list(set(l1) - set(l2)))
	l1 = set(l1)
	l2 = set(l2)
	l3 = l1.difference(l2)
	return(list(l3))


with open('ipsreduced.csv', 'rb') as csvfile:
	leitor = csv.reader(csvfile, delimiter=',')
	leitor.next()
	nets = list()
	for row in leitor:
		nets.append(str(numtoip(row[1])) + "/" + str(row[2]))


nos_nivel1 = list()
root = Node("root")

nivel1 = getstrcidr(cidr_merge(nets))
for i in range(0,len(nivel1)):
	nos_nivel1.append(Node(nivel1[i],parent=root))

resto = diff(nets,nivel1)
nivel2 = getstrcidr(cidr_merge(resto))
nivel2 = diff(nivel2,nivel1)
nos_nivel2 = list()

for i in range(0,len(nivel2)):
	for j in range(0,len(nivel1)):
		if(ipaddress.ip_network(unicode(nivel2[i]),False).subnet_of(ipaddress.ip_network(unicode(nivel1[j]),False))):
			nos_nivel2.append(Node(nivel2[i],parent=nos_nivel1[j]))
			break

resto = diff(nets,nivel1)
resto = diff(resto,nivel2)
nivel3 = getstrcidr(cidr_merge(resto))
nivel3 = diff(nivel3,nivel1)
nivel3 = diff(nivel3,nivel2)
nos_nivel3 = list()

for i in range(0,len(nivel3)):
	for j in range(0,len(nivel2)):
		if(ipaddress.ip_network(unicode(nivel3[i]),False).subnet_of(ipaddress.ip_network(unicode(nivel2[j]),False))):
			nos_nivel3.append(Node(nivel3[i],parent=nos_nivel2[j]))
			break

resto = diff(nets,nivel1)
resto = diff(resto,nivel2)
resto = diff(resto,nivel3)
nivel4 = getstrcidr(cidr_merge(resto))
nivel4 = diff(nivel4,nivel1)
nivel4 = diff(nivel4,nivel2)
nivel4 = diff(nivel4,nivel3)
nos_nivel4 = list()

for i in range(0,len(nivel4)):
	for j in range(0,len(nivel3)):
		if(ipaddress.ip_network(unicode(nivel4[i]),False).subnet_of(ipaddress.ip_network(unicode(nivel3[j]),False))):
			nos_nivel4.append(Node(nivel4[i],parent=nos_nivel3[j]))
			break

resto = diff(nets,nivel1)
resto = diff(resto,nivel2)
resto = diff(resto,nivel3)
resto = diff(resto,nivel4)
nivel5 = getstrcidr(cidr_merge(resto))
nivel5 = diff(nivel5,nivel1)
nivel5 = diff(nivel5,nivel2)
nivel5 = diff(nivel5,nivel3)
nivel5 = diff(nivel5,nivel4)
nos_nivel5 = list()

for i in range(0,len(nivel5)):
	for j in range(0,len(nivel4)):
		if(ipaddress.ip_network(unicode(nivel5[i]),False).subnet_of(ipaddress.ip_network(unicode(nivel4[j]),False))):
			nos_nivel5.append(Node(nivel5[i],parent=nos_nivel4[j]))
			break

# encoding=utf8
import sys
reload(sys)
sys.setdefaultencoding('utf8')
log = open("arvore.txt","w")
for pre, fill, node in RenderTree(root):
	print("%s%s" % (pre, node.name),file=log)

