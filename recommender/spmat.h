#ifndef SPMAT_H
#define SPMAT_H
/*
 *
 * A nicer interface 
 * for the purpose of this project
 *
 */
#include <vector>
#include <Eigen/Sparse>
//vector typedefs
#include <Eigen/Dense>

typedef Eigen::SparseMatrix<double> SpMat; 
typedef Eigen::Triplet<double> trip_t;

typedef struct sparse_wrapper{
    public:
        sparse_wrapper (void): _row_cap (0), _col_cap (0)
                               ,_true_rows(0), _true_cols (0) {}
        
        void add_non_zero (int row, int col, double val);
        void set_true_dimensions (int row, int col);
        void get_true_matrix (SpMat& res) const;
        int true_rows(void){return _true_rows;}
        int true_cols(void) {return _true_cols;}
    private:
        SpMat _matrix;
        int _true_rows;
        int _true_cols;
        int _row_cap;
        int _col_cap;
}spwrapper_t;

#endif
