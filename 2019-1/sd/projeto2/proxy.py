# Espresso Pattern
# This shows how to capture data using a pub-sub proxy
# https://github.com/booksbyus/zguide/blob/master/examples/Python/espresso.py

import time

from threading import Thread
import zmq
from zmq.devices import monitored_queue
import binascii
import os

# main thread
# The main task starts the subscriber and publisher, and then sets
# itself up as a listening proxy. The listener runs as a child thread:
def main ():
    # Start child threads
    ctx = zmq.Context.instance()
    subscriber = ctx.socket(zmq.XSUB)
    subscriber.bind("tcp://*:6000")

    publisher = ctx.socket(zmq.XPUB)
    publisher.bind("tcp://*:6001")

    zmq.device(zmq.FORWARDER, subscriber, publisher)

if __name__ == '__main__':
    main()