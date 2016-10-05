#include <vector>
#include <stdio.h>
#include "baseline.h"
#include <stdlib.h>

baseline_predictor::add_user (int uid){
    known_users [uid] = 1; 
}

baseline_predictor::add_item (int iid){
    known_items [iid] = 1;
}

baseline_predictor::update_rating (int uid, int iid, int rating){
	this->_update_rating (uid, iid, rating, 0);
}

baseline_predictor::new_rating (int uid, int iid, int rating){
	this->_update_rating (uid, iid, rating, 1);
}

baseline_predictor::_update_rating (int uid, int iid, int rating, int is_new){
    
    int update_avg = 0;
    if (known_users.find (uid) != known_users.end())
        if (known_items.find(iid) != known_items.end()){
            double new_avg;
            if (is_new){
                new_avg = (average_avg * num_ratings + rating)
                            / (num_ratings + 1);
            }else{
                new_avg = (average_avg * (num_ratings - 1) + rating)/(num_ratings);
            }
            average_rating = new_avg;

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
                
                Floatvector adj(C.rows());
                for (int i = 0; i < adj. rows(); ++i){
                    adj << (average_rating - old_avg);
                }
                old_avg = average_rating;
                C -= adj;
            }
            if (is_new){
                
                ++num_ratings;
            }else{
                assert (!"NOT IMPLEMENTED");
            }
        }
}
