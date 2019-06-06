import zmq
from random import randint
import time
from threading import Thread

# The subscriber thread requests messages starting with
# A and B, then reads and counts incoming messages.
def subscriber_thread(topic):
    ctx = zmq.Context.instance()

    # Subscribe to "A" and "B"
    subscriber = ctx.socket(zmq.SUB)
    subscriber.connect("tcp://localhost:6001")
    topic = bytes(topic, encoding="ascii")
    subscriber.setsockopt(zmq.SUBSCRIBE, topic)

    count = 0
    while True:
        try:
            msg = subscriber.recv_multipart()
            print(msg)
        except zmq.ZMQError as e:
            if e.errno == zmq.ETERM:
                break           # Interrupted
            else:
                raise
        count += 1

    print ("Subscriber received %d messages" % count)

def main():
    s_thread = Thread(target=subscriber_thread, args=["Nasdaq"])
    s_thread.start()
    #s_thread2 = Thread(target=subscriber_thread, args=["Bovespa"])
    #s_thread2.start()
    #s_thread3 = Thread(target=subscriber_thread, args=["Nasdaq"])
    #s_thread3.start()

if __name__ == '__main__':
    main()