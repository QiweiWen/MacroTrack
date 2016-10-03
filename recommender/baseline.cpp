#include <vector>
#include <stdio.h>
#include "baseline.h"
#include <stdlib.h>

baseline_predictor::add_user (int uid){
        ++this->num_users;
        known_users [uid] = 1;
        //1. add zero column to A
        //2. record row number for user in b
        b_user_row [uid] = b_row_count++;
        int rows = A.rows();
        A.conservativeResize (m.rows(), m.cols() + 1);
		At.conservativeResize (At.rows() + 1, At.cols());
        if ( rows != 0){
                Floatvector newcol(rows);
                for (int i = 0; i < rows; ++i){
                        newcol << 0;
                }
                A.col (A.cols() - 1) = newcol;
				At.row (A.rows() - 1) = newcol;
        }
}

baseline_predictor::add_item (int iid){
        ++this->num_items;
        known_items [iid] = 1; 
        //1. add zero columns to A
        //2. record row number for item in b
        b_item_row [uid] = b_row_count++;

        int rows = A.rows();
        A.conservativeResize (A.rows(), A.cols() + 1);
		At.conservativeResize (At.rows() + 1, At.cols());
        if ( rows != 0){
                Floatvector newcol(rows);
                for (int i = 0; i < rows; ++i){
                        newcol << 0;
                }
                A.col (A.cols() - 1) = newcol;
				At.row (A.rows() - 1) = newcol;
        }
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
                                avg += rating;
                                avg /= (double)(this->num_ratings);
                                //update vector C
                                floatvector adjustment(num_ratings - 1);
                                for (int i = 0; i < num_ratings; ++i){
                                        adjustment << avg - oldavg;
                                }
                                C -= adjustment; 
                        }
						if (is_new){
							++num_ratings;
							if (num_ratings > C.rows()){
								C.conservativeResize (C.rows() * 2);
							}	
							//add the new rating data to the vector C
							C << (double)rating - average_rating;
							//TODO:
							//look up row number of item and user
							//add row in A
							int userrow = b_user_row [uid];
							int itemrow = b_user_row [iid];
							
							//make a vector that is everywhere zero except 
							//at places corresponding to the parameters
							Floatvector newrow(A.cols());
							for (int i = 0; i < A.cols(); ++i){
									if (i == userrow || i == itemrow){
											newrow << 1;
									}else{
											newrow << 0;
									}
							}
							A.conservativeResize (A.rows() + 1, A.cols());
							A. row (A.rows() - 1) = newrow;
							At.conservativeResize (At.rows(), At.cols() + 1);
							At.col (At.cols() - 1) = newrow;
							c_rating_row [uid][iid] = A.rows() - 1;
						}else{
							int c_row = c_rating_row [uid][iid];
								
						}
        }
}
