import socket
import os
import sys
from linda import Linda

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

#Options menu for client
def start(client):
    os.system('cls||clear')
    print("-"*79)
    print("Connected to Space: "+client.topic)
    #Sets a connection
    print("Number of Subscribers: "+str(client.linda_nb_sub()))
    input_select = input("Select:\n\t1\tRead last news\n\t2\tSend News\n\t3\tChange topic\n\t4\tRemove older news\n\t5\tQuit\n>>\t") 
    #Invalid input
    if(input_select!='1' and input_select!='2' and input_select !='3' and input_select !='4' and input_select != '5'):
        print("Invalid option, try again!")
        input("Press any button to continue...")
        start(client)
        return 0
    input_select = int(input_select)
    #Linda rd, read from TuppleSpace
    if input_select == 1:
        print("News: ")
        client.linda_rd()
        input("Press any button to continue...")
        start(client)
        return 0
    #Linda out,send a message
    if input_select == 2:
        news = input("Please type the news you want to send\n>>\t")
        client.linda_out(news)
        input("Press any button to continue...")
        start(client)
    #Change topic
    if input_select == 3:
        topic = input("To which topic you want to subscribe?\n>>\t")
        client.linda_set_topic(topic)
        input("Press any button to continue...")
        start(client)
        return 0
    #Linda in, delete first message (Queue)
    if input_select == 4:
        client.linda_in()
        input("Press any button to continue...")
        start(client)
        return 0
    #Close connection
    if input_select == 5:
        client.linda_close()
        os.system('cls||clear')
        sys.exit()
        return 0

def main():
    os.system('cls||clear')
    print("-"*79)
    #Gets hostname
    hostname = input("What's your hostname?\n>>\t")
    topic = input("To which topic you want to subscribe?\n>>\t")
    #Creates a Linda object for current client
    SERVER_IP, SERVER_PORT = get_ip_port()
    print(SERVER_IP)
    client = Linda(host = SERVER_IP, port = SERVER_PORT, topic = topic, hostname = hostname)
    start(client)

if __name__ == "__main__":
    main()
