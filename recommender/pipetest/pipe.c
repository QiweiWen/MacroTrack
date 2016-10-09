#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
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
	FILE* ctlfd = fopen (ctl_name, "w");
	FILE* stafd = fopen (sta_name, "r");
	FILE* resfd = fopen (res_name, "r");
	
	while (fgets (stackbuf, 200,stdin) ){
		sscanf (stackbuf, "%4s%n ", opcode, &consumed);
		stackbuf += consumed;
		if (!strcmp (stackbuf, "updt")){
			long uid,iid;
			float rting;			
			int numread;
			if (numread = 
				sscanf (stackbuf + consumed, "%ld %ld %f",&uid, &iid, &rting)
				!= 3)
			{
				fprintf (stderr, "expecting uid iid rating");
				exit (1);
			} 
		}else if (!strcmp (stackbuf, "swth")){
			m = SWTCH_MDL;
		}else if (!strcmp (stackbuf, "exit")){
			m = REC_EXT;
		}else if (!strcmp (stackbuf, "getr")){
			long uid;
			long num;
			int numread;
			if (numread = 
				sscanf (stackbuf + consumed, "%ld %ld", &uid, &num)
				!= 2)
			{	
				fprintf (stderr, "expecting uid num");
				exit (1);
			}
			m = GET_RECOM (uid, num);
		}else{
			fprintf(stderr, "UNKNOWN OPCODE %s\n", stackbuf);
		}	
	}	
	return 0;
}
