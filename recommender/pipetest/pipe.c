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
#include <limits.h>

#include <assert.h>

#define NUM_USERS 100
#define NUM_ITEMS 1000
#define RATINGS_PER_USER 100
#define RTCHANCE ((double)RATINGS_PER_USER/NUM_ITEMS)
#define SWTHCHANCE (0.01)
#define MIND_CHANGE_CHANCE (0.3)
#define RED     "\033[31m"      /* Red */
#define RESET "\033[0m"
const static char* ctl_name = "CTRL_PIPE";
const static char* sta_name = "STATUS_PIPE";
const static char* res_name = "RES_PIPE";

inline int true_by_chance (double chance){
    int r = 100* ((double)rand()/RAND_MAX);
    int upperbound = chance * 100;
//    printf ("%d, %d\n", r, upperbound); 
    if (r <= upperbound){
        return 1;
    }
    return 0;
} 

inline int rand_range (int lower, int upper){
    if (lower > upper) return -1;
    int r = lower + ((double)rand()/RAND_MAX)*(upper - lower + 1);
    if (r > upper) r = upper;
    return r; 
}



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

    printf ("WAITING FOR PIPE CONNECTION\n");
    fflush (stdout);
    int ctlfn = open (ctl_name, O_WRONLY); FILE* ctlfd = fdopen (ctlfn, "w");
    int stafn = open (sta_name, O_RDONLY); FILE* stafd = fdopen (stafn, "r");
    int resfn = open (res_name, O_RDONLY); FILE* resfd = fdopen (resfn, "r");

    srand(time(NULL)); 
    int t= 0, f = 0;
    for (int i = 0; i < 100000; ++i){
        if (true_by_chance (SWTHCHANCE)){
            ++t;
        }else{
            ++f;
        }
    } 
   
  
    int rating_arr[NUM_USERS][NUM_ITEMS];
    for (int i = 0; i < NUM_USERS; ++i){
        memset (rating_arr [i], 0, sizeof (int)* NUM_ITEMS);
    }
    msg_t mess;
    double rate_prob = (double)RATINGS_PER_USER/(double)NUM_ITEMS;
    for (int i=0; i < NUM_USERS; ++i){
        int rated = 0;
        for (int j = 0; j < NUM_ITEMS &&  rated < RATINGS_PER_USER; ++j){
           int rem_to_rate = RATINGS_PER_USER - rated;
           int rem_tot = NUM_ITEMS - j;
           
           if (true_by_chance (RTCHANCE)||(rem_to_rate >= rem_tot)){  
                ++rated;
                rating_arr[i][j] = rand_range(1,5);
                assert (rating_arr [i] [j] >= 1 && rating_arr [i] [j]<= 5);
           }
        } 
    }

    for (int i = 0; i < NUM_ITEMS; ++i){
        for (int j = 0; j < NUM_USERS; ++j){
            if (rating_arr [j][i] != 0){
                mess = UPDT_RATING(j,i,rating_arr[j][i]);
                print_command (&mess);
                assert(!put_command (ctlfd, stafd, resfd, &mess,NULL,NULL)); 

                if (true_by_chance (SWTHCHANCE)){
                    mess = SWTCH_MDL; 
                    print_command (&mess);
                    assert (!put_command (ctlfd, stafd, resfd, &mess, NULL, NULL));
                }
            }
            if (true_by_chance (MIND_CHANGE_CHANCE)){
                int who = rand_range (0, NUM_USERS);
                int what = rand_range (0, NUM_ITEMS);
                int how = rand_range (1,5);
                mess = UPDT_RATING(who,what, how);
                assert (!put_command (ctlfd, stafd, resfd, &mess, NULL, NULL));
            } 
        }
    }
    int randu = rand_range (0, NUM_USERS);
    mess = GET_RECOM (randu, 10); 
    recom_t* res;
    int ressize = -1;
    printf (RED"GETTING REC'ED:\n"RESET);
    print_command (&mess);
    put_command (ctlfd, stafd, resfd, &mess, &res, &ressize);
    print_recresult (res, ressize);

    return 0;
}
