#ifndef SIMCACHE_H
#define SIMCACHE_H
//a class for caching similarities between users
#include <vector>


typedef struct simcache{
        public:
            simcache(void){}
            double get_similarity (int u1, int u2){
                int i1 = u1 <= u2? u1: u2;
                int i2 = u1 <= u2? u2: u1;
                return similarity_cache [i1][i2];
            }
            void put_similarity (int u1, int u2, double similarity){ 
                int i1 = u1 <= u2? u1: u2;
                int i2 = u1 <= u2? u2: u1;
                similarity_cache [i1][i2] = similarity;
            }
        private:
            std::vector<std::vector<double>> similarity_cache;
}simcache_t;

#endif
