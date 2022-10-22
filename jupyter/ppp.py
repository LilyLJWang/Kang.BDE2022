li='2004,1,8,4,1141,1145,1237,1244,UA,395,N326UA,116,119,99,-7,-4,DFW,DEN,641,3,14,0,,0,0,0,0,0,0'
li=li.strip().split(",")
def judgekk(ele):
    if ele=='' or ele=='NA' :
        return False
    else:
        return True
print(judgekk(li[1]))
print("11,"*(4-1))
print(''.isdigit())