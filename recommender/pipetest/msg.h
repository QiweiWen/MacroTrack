#ifndef MSG_H
#define MSG_H

typedef struct{
	int opcode;
	long arg1, arg2;
	float arg3;
	int argnum;
}msg_t;

#define GET_RECOM(x,y) ((msg_t) {.opcode = 0, .arg1 = x, .arg2 = y,.argnum = 2})
#define UPDT_RATING(x,y,z) ((msg_t) {.opcode = 1, .arg1 = x, .arg2 = y, .arg3 = z, .argnum = 3})
#define SWTCH_MDL ((msg_t) {.opcode = 2, .argnum = 0})
#define REC_EXT ((msg_t) {.opcode = 3, .argnum = 0})

#define RECOM_CODE 0
#define UPDT_CODE 1
#define SWTH_CODE 2
#define EXT_CODE 3

typedef struct{
	long iid;
	float rating;
}recom_t;

static inline int put_command 
(FILE* ctl, FILE* sta, FILE* res,msg_t* msg, recom_t** ret, int* numitems)
{
	char stackbuf [100] = {0};
 
	switch (msg->argnum){
		case 0:
		{sprintf (stackbuf, "%d\n", msg->opcode);break;}
		case 2:
		{sprintf (stackbuf, "%d,%ld,%ld\n",msg->opcode, msg->arg1, msg->arg2);break;}
		case 3:
		{sprintf (stackbuf, "%d,%ld,%ld,%f\n",msg->opcode, msg->arg1, msg->arg2,msg->arg3);break;}
		default: break;
	}
    

   
    int written =  write (fileno (ctl), stackbuf, strlen (stackbuf));
    if (written < 0){
        printf ("%s\n", strerror (errno));
        exit (-1);
    }
	int status_code;
    fgets (stackbuf, 5, sta); 
	sscanf (stackbuf, "%d", &status_code);
	if (status_code) {
         
        fprintf (stderr, "bad status from recommender %d\n", status_code);
        goto err;
    }
	//collect result
	recom_t* inarr;
	if (msg->opcode == RECOM_CODE){
		inarr = malloc (sizeof (recom_t) * msg->arg2);
		int i = 0;
		while (1){

            char* crap = fgets (stackbuf, 100, res);
            if (!crap) break;
			long iid;
			float rating;
			if (sscanf(stackbuf, "%ld,%f", &iid, &rating) != 2){
				goto free_arr;
			}
			inarr[i++] = (recom_t){.iid = iid, .rating = rating};
            printf ("%ld, %f\n", iid, rating);
		}
		*ret = inarr;
        *numitems = i; 
	}else if (msg->opcode == EXT_CODE){
        exit(0);
    }
	return 0;	
free_arr:
	free (inarr); 
err:
	return 1;
}

#endif
