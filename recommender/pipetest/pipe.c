#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <fcntl.h>
#include "msg.h"
const static char* ctl_name = "CTRL_PIPE";
const static char* sta_name = "STATUS_PIPE";
const static char* res_name = "RES_PIPE";

int main (int argc,char** argv){
	char stackbufarr[200];
	char* stackbuf = stackbufarr;
	char opcode [5];
	opcode [5] = 0;
	int consumed;
	msg_t m;
	mkfifo (ctl_name, 0666);
	mkfifo (sta_name, 0666);
	mkfifo (res_name, 0666);
/*
	FILE* ctlfd = fopen (ctl_name, "rw");
	FILE* stafd = fopen (sta_name, "rw");
	FILE* resfd = fopen (res_name, "rw");
  */
    printf ("WAITING FOR PIPE CONNECTION\n");
    fflush (stdout);
    int ctlfn = open (ctl_name, O_WRONLY); FILE* ctlfd = fdopen (ctlfn, "w");
    int stafn = open (sta_name, O_RDONLY); FILE* stafd = fdopen (stafn, "r");
    int resfn = open (res_name, O_RDONLY|O_NONBLOCK); FILE* resfd = fdopen (resfn, "r");
     
   
    printf ("pipetest >");
	while (fgets (stackbuf, 200,stdin) ){
		sscanf (stackbuf, "%4s%n ", opcode, &consumed);
  
		
		if (!strcmp (opcode, "updt")){
			long uid,iid;
			float rting;			
			int numread;
			if (numread = 
				sscanf (stackbuf + consumed, "%ld %ld %f",&uid, &iid, &rting)
				!= 3)
			{
				fprintf (stderr, "expecting uid iid rating\n");
			
			} 
                        m = UPDT_RATING(uid,iid,rting); 
		}else if (!strcmp (opcode, "swth")){
			m = SWTCH_MDL;
		}else if (!strcmp (opcode, "exit")){
			m = REC_EXT;
		}else if (!strcmp (opcode, "getr")){
			long uid;
			long num;
			int numread;
			if (numread = 
				sscanf (stackbuf + consumed, "%ld %ld", &uid, &num)
				!= 2)
			{	
				fprintf (stderr, "expecting uid num\n");
				
			}
			m = GET_RECOM (uid, num);
            
		}else{
			fprintf(stderr, "UNKNOWN OPCODE %s\n", stackbuf);
                        continue;
		}	
		recom_t* res = NULL;
        int num_items = 0;
	    if (put_command (ctlfd, stafd, resfd, &m,&res, &num_items)) {
                fprintf (stderr,"command failed\n");
            }
        
        if (res)
            free (res); 

        printf ("pipetest >");
	}	
	return 0;
}
