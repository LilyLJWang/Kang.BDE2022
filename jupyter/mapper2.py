#!/usr/bin/env python3

from curses import flash
from enum import Flag
import sys

def judgekk(ele):
    if ele.isdigit():
        return True
    else:
        return False

for line in sys.stdin:
    line = line.strip().split(",")
    
    month=line[1]
    real_arr=line[6]
    shedu_arr=line[7]
    CarrierDelay=line[24]
    origin=line[16]

    if judgekk(month) and judgekk(real_arr) and judgekk(shedu_arr):

        if(int(line[6])-int(line[7]))>0:#延迟
            delay=1
        else:
            delay=0
        print("origin:%s,CarrierDelay:%s,Delay:%d,"%(line[16],line[24],delay),end="")
   
        #月份打印
        print("month:%s,month_dummy:"%line[1],end="")#把原始月份打印出来
        print("0,"*(int(line[1])-1),end="")#打印0,0,1,0,0,0格式的月份
        print("1",end="")
        print(",0"*(12-int(line[1])))

#Origin,CarrierDelay,是否延误，3月
#Origin,CarrierDelay,1,3,0,0,1,0,0,0,0,0,0,0,0,0
#Origin,0,0,10,0,0,0,0,0,0,0,0,0,1,0,0	
