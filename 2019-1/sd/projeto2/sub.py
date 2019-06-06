import zmq
from random import randint
import time

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
    while count < 5:
        try:
            print("Oie")
            msg = subscriber.recv_multipart()
        except zmq.ZMQError as e:
            if e.errno == zmq.ETERM:
                break           # Interrupted
            else:
                raise
        count += 1

    print ("Subscriber received %d messages" % count)