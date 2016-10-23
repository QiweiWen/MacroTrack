import re
lines = [line.rstrip('\n') for line in open('dummyusers')]
ofile = open ("twat", "w")
for l in lines:
    resobj = re.search (r"([0-9]+),([0-9]+),(.*)$", l);
    uid = int(resobj.group(1))
    iid = int(resobj.group(2))
    rating = float(resobj.group(3))
    uid += 8
    iid -= 9
    print "insert into ratings(\"userid\",\"recipe\",\"rating\") values (%d, %d, %f);" % (uid,iid,rating)

