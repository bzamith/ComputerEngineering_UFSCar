import queue

#Tupple Space
class TuppleSpace():
    def __init__(self, topic):
        self.topic = topic #Topic
        self.message_queue = queue.Queue() #Messages queue
        self.subscribers = list() #List of subscribers, identified by hostnames, unique