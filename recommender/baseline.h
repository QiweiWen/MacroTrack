#ifndef BASELINE_H
#define BASELINE_H

#include <Eigen/Sparse>
#include <vector>
#include "zeroint.h"
#include <map>

typedef Eigen::SparseMatrix<double> SpMat; 
typedef Eigen::Triplet<double> T;
typedef Eigen::VectorXf <int> Floatvector;

#define RATING_THRESHOLD 10

typedef struct baseline_predictor{
    public:
        baseline_predictor(int rows, int cols):
                num_users(0), num_items(0), num_ratings (0), pending_updates(0),
                average_rating(0){}
        void add_user (int uid);
        void add_item (int iid);
        void add_rating (int uid, int iid, int rating);         
        void delete_rating (int uid, int iid);
        void update_rating (int uid, int iid, int rating);
        void update_predictor (void);
    private:
        
        SpMat A;
        SpMat At;
        Floatvector C; 
        
        std::map <int, zeroint_t> known_user;
        std::map <int, zeroint_t> known_items;

        int num_users;
        int num_items;
        int num_ratings;
        int pending_updates;  
        double average_rating;
}baseline_t;

#endif
