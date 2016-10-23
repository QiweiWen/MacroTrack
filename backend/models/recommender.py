import os, sys
import re

from recipe import Recipe

# Bad practice: if this were prod we would make $MACROTRACK_HOME_DIR and grab it using os
cpipe_fname='/Users/fraserhemp/Documents/ethics-project/git-repo/MacroTrack/recommender/recommender_final/pipes/CTRL_PIPE'
spipe_fname='/Users/fraserhemp/Documents/ethics-project/git-repo/MacroTrack/recommender/recommender_final/pipes/STATUS_PIPE'
rpipe_fname='/Users/fraserhemp/Documents/ethics-project/git-repo/MacroTrack/recommender/recommender_final/pipes/RES_PIPE'

RECOM_CODE=0
UPDT_CODE=1
SWTH_CODE=2
EXT_CODE=3


class Recommender():
  """Recommender"""

  class RecommenderResult:

    def __init__(self):
      self.recipe_id = 0
      self.val = 0

  control_pipe = None
  status_pipe = None
  result_pipe = None

  def __init__ (self):
   #   super(recommender,self).__init__(self) 
    self.control_pipe = os.open (cpipe_fname, os.O_WRONLY)
    self.status_pipe = os.open (spipe_fname, os.O_RDONLY)
    self.result_pipe = os.open (rpipe_fname, os.O_RDONLY)

  def __exit__(self, exc_type, exc_value, traceback):
    os.close (cpipe_fname)
    os.close (spipe_fname)
    os.close (rpipe_fname)

  def get_recipes_for_user(self, userid):
    result = self.get_recommendations(userid, 10)
    if not result:
      return []
    print result
    recipes = [res.recipe_id for res in result]
    return Recipe().list_from_ids(recipes)
     

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
      stackbuf = '1,%d,%d,%f\n' % (int(arg1), int(arg2), float(arg3))
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
  def __get_recommmendations (self):
    mylist=[]
    #quick and dirty
    mystr=os.read (self.result_pipe, 10000)
    reslist = mystr.split ("\n")
    for result in reslist:
      if (not result):
        break
      newres = Recommender.RecommenderResult() 
      tokenl = result.split(",")
      newres.recipe_id=int(tokenl[0].strip())
      newres.val=float(tokenl[1].strip()) 
      mylist.append(newres)
      
    return mylist
    
  #returns None if empty
  #returns list if not
  def get_recommendations(self, uid, num):
    self.__put_cmd (RECOM_CODE, uid, num)
    stat=self.__get_status ()
    if (stat != 0):
      return None
    recl = self.__get_recommmendations()
    return recl
  
  #return 0 if success
  #return 1 if failure
  # Args: Userid, recipeid, rating
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
  recky = Recommender()
  l = recky.get_recommendations (11, 10);
  for item in l:
    print "%d,%f" % (item.iid, item.val)



