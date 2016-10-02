#ifndef BASELINE_H
#define BASELINE_H

#include <boost/numeric/ublas/matrix_sparse.hpp>
#include <boost/numeric/ublas/io.hpp>
#include <vector>

typedef struct baseline_predictor{
    public:
        baseline_predictor(int rows, int cols):AtA(rows, cols){}
        void add_user (int uid);
        void add_item (int iid);
        void add_rating (int uid, int iid, int rating);         
        void delete_rating (int uid, int iid);
        void update_rating (int uid, int iid, int rating);
        void update_predictor (void);
    private:
        boost::numeric::ublas::mapped_matrix <int> AtA;
        std::vector <double> C;

        int num_users;
        int num_items;
        double average_rating;
}baseline_t;

#endif
