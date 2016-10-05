#include <stdio.h>
#include <stdlib.h>
#include "spmat.h"
#include <assert.h>

#define EST_NON_ZERO(x) (x/10)

void sparse_wrapper::set_true_dimensions (int rows, int cols){

    /*
     * exponentially expand the matrix to avoid
     * frequent calls to resize and reserve
     *
     * we know the true size of the matrix,
     * the number of rows being the number of model parameters
     * the number of columns being the number of ratings
     *
     * so we can extract the proper matrix when we need to do so
     * with SparseMatrix::block
     *
     */
    
    int do_reserve = 0;
    for (;;){
        if (_col_cap > cols) break;
        _col_cap += 1;
        _col_cap *= 2;
        if (!do_reserve) do_reserve = 1;
    }

    for (;;){
        if (_row_cap > rows) break;
        _row_cap += 1;
        _row_cap *= 2;
        if (!do_reserve) do_reserve = 1;
    }

    if (do_reserve){
        _matrix. conservativeResize (_row_cap, _col_cap);
        _matrix. reserve (Eigen::VectorXi::Constant(_matrix.cols(),
                                             EST_NON_ZERO (_matrix.rows())));
    }
    _true_rows = rows;
    _true_cols = cols;

}

void sparse_wrapper::add_non_zero (int row, int col, double val){
    assert (row < _true_rows && col < _true_cols);
    _matrix.coeffRef (row, col) = val;
}

void sparse_wrapper::get_true_matrix (SpMat& res) const{
   res =  _matrix.block (0,0, _true_rows, _true_cols); 
}
