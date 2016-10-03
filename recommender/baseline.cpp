#include <vector>
#include <stdio.h>
#include "baseline.h"
#include <stdlib.h>

baseline_predictor::add_user (int uid){
        ++this->num_users;
        known_users [uid] = 1;
        //TODO:
        //1. add zero column to A
        //2. record row number for user in b
}

baseline_predictor::add_item (int iid){
        ++this->num_items;
        known_items [iid] = 1;
        //TODO:
        //1. add zero columns to A
        //2. record row number for item in b
}

baseline_predictor::add_rating (int uid, int iid, int ratings){
        
        int update_avg = 0;

        if (known_users.find (uid) != known_users.end())
                if (known_items.find(iid) != known_items.end()){
                        
                        if (this->num_ratings < RATING_THRESHOLD){
                                //update avg rating in vector C
                                update_avg = 1;
                        }else if (this->pending_updates == RATING_THRESHOLD){
                                update_avg = 1;
                                this->pending_updates = 0;
                        }else{
                                ++this->pending_updates;
                        }

                        if (update_avg){
                                //calculate new average rating
                                double oldavg = this->average_rating;
                                double& avg = this->average_rating;
                                avg *= this->num_ratings;
                                avg += ratings;
                                avg /= (double)(++this->num_ratings);
                                //update vector C
                                floatvector adjustment(num_ratings);
                                for (int i = 0; i < num_ratings; ++i){
                                        adjustment << avg - oldavg;
                                }
                                C -= adjustment; 
                        }
                        //add the new rating data to the vector C
                        C << (double)rating - average_rating;
                        //TODO:
                        //look up row number of item and user
                        //add row in A 
                }
}
