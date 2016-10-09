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
(FILE* ctl, FILE* sta, FILE* res,msg_t* msg, recom_t** ret)
{
	char stackbuf [20];
	switch (msg->argnum){
		case 0:
		{sprintf (stackbuf, "%d\n", msg->opcode);break;}
		case 2:
		{sprintf (stackbuf, "%d, %ld, %ld\n",msg->opcode, msg->arg1, msg->arg2);break;}
		case 3:
		{sprintf (stackbuf, "%d, %ld, %ld, %f\n",msg->opcode, msg->arg1, msg->arg2,msg->arg3);break;}
		default: break;
	}
	fputs (stackbuf, ctl);
	int status_code;
	if (!fgets (stackbuf, 20, sta)) goto err;
	sscanf (stackbuf, "%d", &status_code);
	if (status_code) goto err;
	//collect result
	recom_t* inarr;
	if (msg->opcode == RECOM_CODE){
		inarr = malloc (sizeof (recom_t) * msg->arg2);
		int i = 0;
		while (fgets (stackbuf,20, res)){
			long iid;
			float rating;
			if (sscanf(stackbuf, "%ld,%f", &iid, &rating) != 2){
				goto free_arr;
			}
			inarr[i++] = (recom_t){.iid = iid, .rating = rating};
		}
		*ret = inarr;
	}
	return 0;	
free_arr:
	free (inarr); 
err:
	return 1;
}

#endif
