import time
import multiprocessing

def eat(num,name):
    for i in range(num):
        print(name+"吃一口...")
        time.sleep(1)

def drink(num,name):
    for i in range(num):
        print(name+"喝一口...")
        time.sleep(1)

if __name__ == '__main__':
    eat_process=multiprocessing.Process(target=eat,args=(3,"giao"))
    drink_process=multiprocessing.Process(target=drink,kwargs={"num":4,"name":"giao"})
    eat_process.start()
    drink_process.start()



