import zmq
import time
import os
import sys
from threading import Thread
from blessings import Terminal

COLUMN_BOLSA = 0
COLUMN_EMPRESA = 10
COLUMN_VALOR = 20
COLUMN_DIF = 30

stocks_list = ["NASDAQ","BOVESPA","TOKYOSE","NYSE","EURONEXT","LONDONSE"]
term = Terminal()

def print_header():
    print_term("BOLSA",COLUMN_BOLSA,1)
    print_term("EMPRESA",COLUMN_EMPRESA,1)
    print_term("VALOR",COLUMN_VALOR,1)
    print_term("DIFF",COLUMN_DIF,1)
    print_term("--------------------------------------",0,2)

def print_term(msg,posX,posY):
    os.system('setterm -cursor off')
    if isinstance(msg,float):
        if msg > 0:
            msg='{:+}'.format(round(msg,5))
            with term.location(posX, posY):
                print(msg)
        else:
            msg=format(round(msg,3))
            with term.location(posX, posY):
                print(msg)
    with term.location(posX, posY):
        print(msg)

# The subscriber thread requests messages starting with the corresponding topic
def subscriber_thread(topic, line):
    ctx = zmq.Context.instance()

    subscriber = ctx.socket(zmq.SUB)
    subscriber.connect("tcp://localhost:6001")

    topic = bytes(topic, encoding="ascii")
    subscriber.setsockopt(zmq.SUBSCRIBE, topic)

    values = [0]*100

    while True:
        try:
            msg = subscriber.recv_multipart()
            count = int(msg[0].decode("ascii").split("-")[1])
                
            for i in range(0,count):
                msg = subscriber.recv_multipart()
                parts = msg[0].decode("ascii").split("-")   
                print_term(parts[0],COLUMN_BOLSA,line+1+i)
                print_term(parts[1],COLUMN_EMPRESA,line+1+i)
                print_term(parts[2],COLUMN_VALOR,line+1+i)
                print_term(float(float(parts[2])-values[i]),COLUMN_DIF,line+1+i)
                values[i] = float(parts[2])
        except zmq.ZMQError as e:
            if e.errno == zmq.ETERM:
                break           # Interrupted
            else:
                raise

# Prints the stock list for selection
def print_stocks():
    for i in range(0,len(stocks_list)):
        string = "%i - %s" % (i+1,stocks_list[i])
        print(string)

# Gets the input 
def get_stocks():
    print("Favor inserir o numeros das bolsas que deseja se inscrever, separado por virgulas:")
    print_stocks()
    values = input(">>>> ")
    values = values.strip().split(",")
    output = list()
    for value in values:
        try:
            value = int(value)
        except ValueError:
            print("Entrada não reconhecida: "+value)
            sys.exit()
        if value > 0 and value < len(stocks_list)+1:
            output.append(stocks_list[value-1]) 
    output = list(set(output))
    os.system('cls||clear')
    return output

def main():
    stocks = get_stocks()
    print_header()

    for i in range(0,len(stocks)):
        Thread(target=subscriber_thread, args=[stocks[i],i*4+2]).start()

if __name__ == '__main__':
    main()