import socket
import sys
import errno
import os
import traceback
import time
import pickle

#Linda class represents a connection
class Linda():
    def __init__(self, host, hostname, port, topic):
        self.port = port
        self.host = host
        self.topic = topic #Current topic, used as a key to TuppleSpace, can be changeded by the user
        self.hostname = hostname #Used to print out the message publisher
        self.soc = self.linda_connect()

    #Produces a tuple, writing it into tuplespace (tuple may be duplicated in tuplespace)
    def linda_out(self, message):
        message = "PUB%"+self.topic+'%'+message+'%'+self.hostname
        try:
            self.soc.send(message.encode("utf8"))
        except IOError as e:
            if e.errno == errno.EPIPE:
                self.linda_server_down()      
        self.clear_line()
        self.clear_line()
        print(self.soc.recv(5120).decode("utf8").upper())

    #Non-destructively reads a tuplespace
    def linda_rd(self):
        message = "SUB%"+self.topic
        try:
            self.soc.send(message.encode("utf8"))
        except IOError as e:
            if e.errno == errno.EPIPE:
                self.linda_server_down()
        news = pickle.loads(self.soc.recv(5120))
        if isinstance(news, list):
            for new in news:
                print("- "+new)
        else:
            print("- "+news)

    #Atomically reads and removes—consumes—a tuple from tuplespace
    def linda_in(self):
        message = "POP%"+self.topic
        try:
            self.soc.send(message.encode("utf8"))
        except IOError as e:
            if e.errno == errno.EPIPE:
                self.linda_server_down()
        print(self.soc.recv(5120).decode("utf8"))

    #Connect to the server
    def linda_connect(self):
        soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            soc.connect((self.host, self.port))
            message = "CON%"+self.topic
            soc.sendall(message.encode("utf8"))
            soc.recv(5120).decode("utf8")
            return soc
        except IOError as e:
            if e.errno == errno.EPIPE:
                self.linda_server_down()

    #Return the number of subscribers
    def linda_nb_sub(self):
        message = "CON%"+self.topic
        try:
            self.soc.send(message.encode("utf8"))
        except:
            self.linda_server_down()
        return self.soc.recv(5120).decode("utf8")

    #Closes the current connection
    def linda_close(self):
        message = "QUIT"
        self.soc.sendall(message.encode("utf8"))
        print("Connection closing.".upper())
        time.sleep(.5)
        self.clear_line()
        print("Connection closing..".upper())
        time.sleep(.5)
        self.clear_line()
        print("Connection closing...".upper())
        time.sleep(.5)
        self.clear_line()
        print("Bye!".upper())
        time.sleep(.7)

    #If cant reach the server
    def linda_server_down(self):
        print("Server down. Connection closing.".upper())
        time.sleep(.5)
        self.clear_line()
        print("Server down. Connection closing..".upper())
        time.sleep(.5)
        self.clear_line()
        print("Server down. Connection closing...".upper())
        time.sleep(.5)
        os.system('cls||clear')
        sys.exit()
        
    #Change topic
    def linda_set_topic(self,topic):
        self.topic = topic

    def clear_line(self):
        sys.stdout.write("\033[F") #Back to previous line
        sys.stdout.write("\033[K") #Clear line