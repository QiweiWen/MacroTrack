#ifndef LIBREC_H
#define LIBREC_H
#include <string>
#include <unordered_map>
#include <map>
#include <vector>
#include <list>
#include "baseline.h"

#define MAX_RATING 5
#define MIN_RATING 0

#define UPDATES_PER_RECALC 50
#define UPDATES_PER_RECALC_SIM 10

//collaborative filtering
//user-user correlation

typedef struct recommender recommender_t;

typedef struct{
        int user;
        int item;
        int rating;
}rating_t;

struct recommender{
    public:
        recommender(void):update_count(0),baseline_calculated(0),
                          num_users(0), num_items(0){};
        void add_user(std::string name, int uid);
        void add_item (int iid);
        void add_rating (int uid, int iid, int rating);
        void delete_rating (int uid, int iid);
        void update_rating (int uid, int iid, int rating);
        //insert item IDs into "items" given user and deried number of recommendations
        void get_recommendations (int uid, int num, std::vector<int> items);
    private:

        //given user ID, map to a list of ratings of that user for various items
        //second template argument is an RB tree indexed by item ID
        std::unordered_map <int, 
                            std::map<int,rating_t>> 
                            user_to_ratings;
        
        //given item ID, map to a list of ratings of that item by various users
        //second template argument is an RB tree indexed by user ID
        std::unordered_map <int, 
                            std::map<int,rating_t>> 
                            item_to_ratings;

        //number of updates for individual users
        //update similarity vector when the threshold is reached
        std::unordered_map <int, int> num_updates;
        simcache_t simcache;
        //recalculate the results when enough updates have happened 
        int update_count;
        
        baseline_t baseline;
        int num_users;
        int num_items;
        double average_rating;
};

#endif
