import zmq
from random import randint
import time

# publisher thread
# The publisher sends random messages starting with A-J:
def publisher_thread():
    ctx = zmq.Context.instance()

    publisher = ctx.socket(zmq.PUB)
    publisher.bind("tcp://*:6000")

    while True:
        #string = "%s-%05d" % (uppercase[randint(0,10)], randint(0,100000))
        string = "B-%05d" % randint(0,100000)
        try:
            print("Cai aqui")
            publisher.send(string.encode('utf-8'))
        except zmq.ZMQError as e:
            if e.errno == zmq.ETERM:
                break           # Interrupted
            else:
                raise
        time.sleep(0.1)         # Wait for 1/10th second