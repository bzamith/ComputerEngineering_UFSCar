#Based on the code from: 
#https://kuntalchandra.wordpress.com/2017/08/23/python-socket-programming-server-client-application-using-threads/

import socket
import sys
import errno
import traceback
import pickle
from threading import Thread, Lock
from linda import Linda
from tupplespace import TuppleSpace

#Get IP and PORT from ip_config file
def get_ip_port():
    with open('ip_config.txt') as file:
        lists = list()
        for count, line in enumerate(file):
            lists.append(line)
        if len(lists) < 2:
            os.system('cls||clear')
            print("Couldn't parse ip_config file")
        else:
            SERVER_IP = lists[0].strip()
            SERVER_PORT = lists[1].strip()
            return str(SERVER_IP), int(SERVER_PORT)

#Dictionary for topics (TuppleSpaces)
topics_map = {}
#Mutex
lock = Lock()

#Server definitions and startup
def start_server():
    host, port = get_ip_port()
    soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    soc.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)  

    try:
        soc.bind((host, port))
    except:
        print("Bind failed.")
        sys.exit()

	#Queue up to 10 requests
    soc.listen(5)

    #Infinite loop, receiving requests
    while True:
        connection, address = soc.accept()
        ip, port = str(address[0]), str(address[1])
        print("Connected with " + ip + ":" + port)
        Thread(target=client_thread, args=(connection, ip, port)).start()
    soc.close()

#Each request is a Thread
def client_thread(connection, ip, port, max_buffer_size = 5120):
    is_active = True
    while is_active:
    	#Receive input from client
        client_input = receive_input(connection, max_buffer_size)
        #Mutex acquired
        with lock: 
            response = process_input(client_input,ip,port)
            #If response is a list (readed messages)
            if isinstance(response, list):
            	#If list is empty
                if len(response) == 0:
                    response = "No messages to display"
                response = pickle.dumps(response)
                try:
                    connection.send(response)
                except IOError as e:
                    if e.errno == errno.EPIPE:
                        print("Connection for " + ip + ":" + port+" was interrupted. Closing")
                        is_active = False
            elif "QUIT" in response:
                connection.close()
                is_active = False
            else:
            	try:
            		connection.send(response.encode("utf8"))
            	except IOError as e:
                    if e.errno == errno.EPIPE:
                        print("Connection for " + ip + ":" + port+" was interrupted. Closing")
                        is_active = False

#Process the input
def receive_input(connection, max_buffer_size):
    client_input = connection.recv(max_buffer_size)
    client_input_size = sys.getsizeof(client_input)
    if client_input_size > max_buffer_size:
        print("The input size is greater than expected {}".format(client_input_size))
    decoded_input = client_input.decode("utf8").rstrip()
    return decoded_input

#Process request
def process_input(input_str, ip, port):
    parts = input_str.split('%')
    len_parts = len(parts)
    unrec = True
    if len_parts == 1:
    	#Quit = linda_close()
        if parts[0] == "QUIT":
            print("Closing connection for " + ip + ":" + port)
            unrec = False
            return "QUIT"
    if len_parts == 2:
    	#Connect = linda_nb_sub()
        if parts[0] == "CON":
            topic = parts[1]
            check_tupplespace(topic)
            print(ip + ":" + port+" is connected to topic "+topic)
            unrec = False
            return str(len(topics_map[topic].subscribers))
        #Pop = linda_in()
        elif parts[0] == "POP":
            topic = parts[1]
            check_tupplespace(topic)
            if len(list(topics_map[topic].message_queue.queue))==0:
                return "No news to delete."
            else: 
                del_news = topics_map[topic].message_queue.get()
            unrec = False
            return "News "+del_news+" deleted."
        #Subscribe = linda_rd()
        elif parts[0] == "SUB":
            topic = parts[1]
            check_tupplespace(topic)
            unrec = False
            return list(topics_map[topic].message_queue.queue)
    if len_parts == 4:
    	#Publish = linda_out()
        if parts[0] == "PUB":
            topic = parts[1]
            check_tupplespace(topic)
            message = parts[2]
            hostname = parts[3]
            check_hostname(topic, hostname)
            topics_map[topic].message_queue.put("["+hostname+"]: "+message)
            return "Message Published"
    #Unknown request
    if unrec == True:
        print("Unknown request from client " + ip + ":" + port)
        return "UNREC"

#Check if TuppleSpace already exists (key = topic) 
def check_tupplespace(topic):
    if not topic in topics_map.keys():
        topics_map[topic] = TuppleSpace(topic)

#Check if Hostname already a subscriber
def check_hostname(topic, hostname):
    if not hostname in topics_map[topic].subscribers:
        topics_map[topic].subscribers.append(hostname)

def main():
    start_server()

if __name__ == "__main__":
    main()
