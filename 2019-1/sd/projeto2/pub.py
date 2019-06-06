import zmq
import random
import time
from threading import Thread

# publisher thread
# The publisher sends random messages starting with A-J:
def publisher_thread(stock):
    ctx = zmq.Context.instance()

    publisher = ctx.socket(zmq.PUB)
    publisher.connect("tcp://localhost:6000")

    print(stock)

    stock_value = random.random() 

    while True:
        while time.localtime().tm_sec%5==0:
            stock_value = random.random()
        string = "%s-%f" % (stock,stock_value)
        try:
            publisher.send(string.encode('utf-8'))
        except zmq.ZMQError as e:
            if e.errno == zmq.ETERM:
                break           # Interrupted
            else:
                raise
        time.sleep(0.1)         # Wait for 1/10th second

def main():
    nasdaq = Thread(target=publisher_thread, args=["Nasdaq"])
    nasdaq.start()
    bovespa = Thread(target=publisher_thread, args=["Bovespa"])
    bovespa.start()

if __name__ == '__main__':
    main()