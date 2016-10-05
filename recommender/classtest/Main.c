#include <Eigen/Sparse>
#include <stdio.h>
#include <iostream>

typedef Eigen::SparseMatrix<double> SpMat; 
typedef Eigen::Triplet<double> T;
typedef Eigen::VectorXf Floatvector;


int main (int argc, char** argv){
    SpMat cunt;
    cunt.conservativeResize (5, 5);
    for (int i = 0;i < 5; ++i){
        for (int j = 0; j < 5; ++j){
            cunt.coeffRef (i,j) = 0;
        }
    }
    cunt.coeffRef (2,3) = 5;
   
    //add column
    cunt.conservativeResize (cunt.rows(), cunt.cols() + 1);
    

    //add row
    cunt.conservativeResize (cunt. rows () + 1, cunt. cols());
    std::vector<int>  twat(6);
    for (int i = 0; i < 6; ++i){
        twat[i] = 3;
    }
    cunt.reserve (twat);
    
    SpMat wank = cunt. block (0,0,2,3);
    printf ("CUNT\n");
    std::cout << cunt << "\n";
    printf ("TWAT\n");

    std::cout << wank << "\n";
    return 0;
}
