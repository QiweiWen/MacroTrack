import os, sys
import re
#from base_model import BaseModel
cpipe_fname='stage/CTRL_PIPE'
spipe_fname='stage/STATUS_PIPE'
rpipe_fname='stage/RES_PIPE'

RECOM_CODE=0
UPDT_CODE=1
SWTH_CODE=2
EXT_CODE=3

class recresult:
    def __init__(self):
        self.iid = 0
        self.val = 0


#class recommender(BaseModel):
 
class recommender():
    control_pipe = None
    status_pipe = None
    result_pipe = None

    def __init__ (self):
   #     super(recommender,self).__init__(self) 
        self.control_pipe = os.open (cpipe_fname, os.O_WRONLY)
        self.status_pipe = os.open (spipe_fname, os.O_RDONLY)
        self.result_pipe = os.open (rpipe_fname, os.O_RDONLY)
       

    def __put_cmd (self, opcode, *args):
        stackbuf=None
        count=0
        arg1=0
        arg2=0
        arg3=0
        if (opcode == RECOM_CODE): 
            for arg in args:
                if (count == 0):
                    arg1 = arg
                elif (count == 1):
                    arg2 = arg
                else:
                    break
                count = count + 1
            stackbuf = '0,%d,%d\n' % (arg1, arg2)
        elif (opcode == UPDT_CODE):
            for arg in args:
                if (count == 0):
                    arg1 = arg
                elif (count == 1):
                    arg2 = arg
                elif (count == 2):
                    arg3 = arg
                else:
                    break
                count = count + 1
            stackbuf = '1,%d,%d,%f\n' % (arg1, arg2, arg3)
        elif (opcode == SWTH_CODE):
            stackbuf = "2\n"
        elif (opcode == EXT_CODE):
            stackbuf = "3\n"
        else:
            return None 
        os.write (self.control_pipe, stackbuf);

    def __get_status (self):
        while (True):
            statusstr = os.read (self.status_pipe, 5)
            try: 
                return int (statusstr)
            except ValueError:
                continue
    def __get_reced (self):
        mylist=[]
        #quick and dirty
        mystr=os.read (self.result_pipe, 10000)
        reslist = mystr.split ("\n")
        for result in reslist:
            if (not result):
                break
            newres = recresult() 
            tokenl = result.split(",")
            newres.iid=int(tokenl[0].strip())
            newres.val=float(tokenl[1].strip()) 
            mylist.append(newres)
            
        return mylist
        
    #returns None if empty
    #returns list if not
    def get_reced (self, uid, num):
        self.__put_cmd (RECOM_CODE, uid, num)
        stat=self.__get_status ()
        if (stat != 0):
            return None
        recl = self.__get_reced()
        return recl
    
    #return 0 if success
    #return 1 if failure
    def update_rating (self, uid, iid, rting):
        self.__put_cmd (UPDT_CODE, uid, iid, rting)
        stat=self.__get_status ()
        return stat

    #return 0 if success
    #return 1 if failure
    def switch_model (self):
        self.__put_cmd (SWTH_CODE)
        stat=self.__get_status()
        return stat


if __name__ == "__main__":
    recky = recommender()
    l = recky.get_reced (28, 10);
    for item in l:
	print "%d,%f" % (item.iid, item.val)



