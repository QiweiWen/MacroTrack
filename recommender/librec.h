#ifndef LIBREC_H
#define LIBREC_H
#include <string>
#include <unordered_map>
#include <vector>

#define MAX_RATING 5
#define MIN_RATING 4

typedef struct recommender recommender_t;
typedef struct user user_t;
typedef struct item item_t;

typedef struct{
        double weight;
        int is_dirty;
}similarity_t;

struct user{
        //for debugging only
        std::string name;   
        int uid;
        std::unordered_map <user, similarity_t> similarities;
};

struct item{
    std::string name;
    int iid;
};

struct recommender{
    public:
        recommender(void);
        void add_user(std::string name);
        void add_rating (int uid, int iid, int rating);
        void delete_rating (int uid, int iid);
        std::vector <int> get_recommendations (int uid, int num);
    private:
         
};

#endif
