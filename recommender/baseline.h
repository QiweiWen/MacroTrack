#ifndef BASELINE_H
#define BASELINE_H

#include <Eigen/Sparse>
#include <vector>
#include "zeroint.h"
#include <map>
#include "spmat.h" 

typedef Eigen::SparseMatrix<double> SpMat; 
typedef Eigen::Triplet<double> T;
typedef Eigen::VectorXf Floatvector;

#define RATING_THRESHOLD 10

typedef struct baseline_predictor{
    public:
        baseline_predictor(int rows, int cols):
                num_users(0), num_items(0), num_ratings (0), pending_updates(0),
                average_rating(0), b_row_count(0), old_avg(0), dirty_flag(0){}
        void add_user (int uid);
        void add_item (int iid);
        void add_rating (int uid, int iid, int rating);         
        void delete_rating (int uid, int iid);
        void update_rating (int uid, int iid, int rating);
        Floatvector& update_predictor (void);
    private:
		void _update_rating (int uid, int iid, int rating, int is_new); 	

        spwrapper_t A; 
        Floatvector C; 
		
				
        std::map <int, zeroint_t> known_users;
        std::map <int, zeroint_t> known_items;
       
        std::map <int, int> b_user_row;
        std::map <int, int> b_item_row; 
 		std::map <int, std::map<int, int> > c_rating_row;   
        std::map <int, std::map <int, int> > rating_history;
        //the number of model parameters
        int b_row_count;
        int num_users;
        int num_items;
        //the row count for A and C
        int num_ratings;
        int pending_updates;  
        //up to date running average
        double average_rating;
        //last average used for vector C
        double old_avg;
        bool dirty_flag;
}baseline_t;

#endif
