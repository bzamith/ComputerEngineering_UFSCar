import zmq
import random
import time
from threading import Thread

#Dict for companies on stock market
NASDAQ_list = {"AAPL": 0,"FB": 0, "MSFT": 0}
BOVESPA_list = {"ABEV": 0, "BBAS": 0, "PETR": 0}
TOKYOSE_list = {"TYO": 0, "NIP": 0, "KEY": 0}
NYSE_list = {"BABA":0, "BRK":0, "JNJ": 0}
EURONEXT_list = {"LVMH": 0, "OR": 0, "SAN": 0}
LONDONSE_list = {"RDSA": 0, "ULVR": 0, "BHP": 0}

#Dict for lists for each stock market name
stocks_list = {"NASDAQ": NASDAQ_list, "BOVESPA": BOVESPA_list, "TOKYOSE": TOKYOSE_list, "NYSE": NYSE_list, "EURONEXT": EURONEXT_list, "LONDONSE": LONDONSE_list}

#Get list given a stock market name
def get_list(name):
    return stocks_list[name]

class Stock_Market:
    def __init__ (self, name, switch_time):
        self.name = name
        self.switch_time = switch_time
        self.list = get_list(self.name)
        self.count = len(self.list)
        self.companies = list(self.list)

# Publisher thread
# Generates random numbers for each company given a stock market
def publisher_thread(stock_market):
    ctx = zmq.Context.instance()
    publisher = ctx.socket(zmq.PUB)
    publisher.connect("tcp://localhost:6000")
    
    while True:
        string = "%s-%i" % (stock_market.name, stock_market.count)
        publisher.send_string(string)
        for i in range(0,stock_market.count):
            company = stock_market.companies[i]
            stock_market.list[company] = random.random()
            string = "%s-%s-%f" % (stock_market.name, company, stock_market.list[company])
            print(string)
            try:
                publisher.send_string(string)
            except zmq.ZMQError as e:
                if e.errno == zmq.ETERM:
                    break           # Interrupted
                else:
                    raise
        time.sleep(stock_market.switch_time)   

# Creates publisher thread for each stock market
def main():
    nasdaq = Stock_Market("NASDAQ", 0.1)
    bovespa = Stock_Market("BOVESPA", 0.2)
    tokyose = Stock_Market("TOKYOSE",0.15)
    nyse = Stock_Market("NYSE",0.15)
    euronext = Stock_Market("EURONEXT", 0.15)
    londonse = Stock_Market("LONDONSE",0.3)

    stocks = [nasdaq,bovespa,tokyose,nyse,euronext,londonse]

    for i in range(0,len(stocks)):
        Thread(target=publisher_thread, args=[stocks[i]]).start()
    
if __name__ == '__main__':
    main()