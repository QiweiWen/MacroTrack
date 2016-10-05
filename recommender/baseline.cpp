#include <vector>
#include <stdio.h>
#include "baseline.h"
#include <stdlib.h>

void baseline_predictor::add_user (int uid){
    known_users [uid] = 1; 
}

void baseline_predictor::add_item (int iid){
    known_items [iid] = 1;
}

void baseline_predictor::update_rating (int uid, int iid, int rating){
	this->_update_rating (uid, iid, rating, 0);
}

void baseline_predictor::add_rating (int uid, int iid, int rating){
	this->_update_rating (uid, iid, rating, 1);
}

void baseline_predictor::_update_rating (int uid, int iid, int rating, int is_new){
    
    int update_avg = 0;
    if (known_users.find (uid) != known_users.end())
        if (known_items.find(iid) != known_items.end()){
            dirty_flag = true;
            double new_avg;
            if (is_new){
                new_avg = (average_rating * num_ratings + rating)
                            / (num_ratings + 1);
            }else{
                new_avg = (average_rating * (num_ratings - 1) + rating)/(num_ratings);
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
                int buserrow, bitemrow; 
                int num_new_cols = 0;
				/*
                 * record the position of new model
				 * parameters in solution to vector B
                 */
                if (b_user_row. find (uid) != b_user_row.end()){
                    buserrow = b_user_row [uid];
                }else{
                 	b_user_row [uid] = b_row_count++;                   
                    ++num_new_cols;
                }

                if (b_item_row. find (iid) != b_item_row.end()){
                    bitemrow = b_item_row [iid];
                }else{
                    b_item_row [iid] = b_row_count++;
                    ++num_new_cols;
                }
				/*
                 * record the position of the new rating
				 * in matrix A and vector C
                 */
				c_rating_row [uid][iid] = num_ratings;
                //resize A
                A. set_true_dimensions (A. true_rows() + 1, A. true_cols() + num_new_cols); 
                //populate new row and column with numbers	
                A. add_non_zero (A. true_rows() - 1, buserrow, 1);
                A. add_non_zero (A. true_rows() - 1, bitemrow, 1);
                //add new rating in C
                C. conservativeResize (C. rows() + 1);
                C << rating - old_avg;
                ++num_ratings;
                rating_history [uid][iid] = rating;
            }else{
                //assert (!"NOT IMPLEMENTED");
                int rating_row = c_rating_row [uid][iid];
                C. coeffRef (rating_row, 0) += (rating - rating_history [uid][iid]);
            }
        }
}

void baseline_predictor::delete_rating (int uid, int iid){
    assert (!"unimplemented");
}

void baseline_predictor::update_predictor (void){
    assert (!"unimplemented");
    if (!dirty_flag){
        //TODO:
        //return cached result for B
    }else{ 
        //TODO:
        //solve least square |Ab - C|^2
        dirty_flag = false;
    }
}
