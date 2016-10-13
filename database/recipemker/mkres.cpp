#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string>
#include <ctype.h>
#include <assert.h>
#include <libpq-fe.h>
#include <string.h>
#include <fstream>
#include <limits>
#include <unistd.h>
#include <sys/wait.h>

#define errprint(...) {fprintf (stderr, __VA_ARGS__);}

int chomp (std::string & twat){ 
    size_t wspace_begin;
    for (wspace_begin = 0; wspace_begin< twat.length(); ++wspace_begin){
        if (!isspace(twat[wspace_begin])){
            break;
        }
    }
    if (wspace_begin == twat.length()) return -1;
    size_t wspace_end;
    for (wspace_end = twat.length() - 1; wspace_end >= 0; --wspace_end){
        if (!isspace  (twat [wspace_end])){
            break;
        }
    }
    
    twat = twat.substr (wspace_begin, wspace_end + 1);    
    return 0;
}

PGconn* dbcon (const char* comminfo){
    PGconn* conn = PQconnectdb (comminfo);  
    return (PQstatus(conn) == CONNECTION_OK)?conn:NULL;
}

PGresult* dbexec (PGconn *conn, std::string cmd){  
    PGresult   *res;
    res = PQexec (conn,cmd.c_str());
    if (PQresultStatus(res) != PGRES_COMMAND_OK && PQresultStatus(res) != PGRES_TUPLES_OK){
            errprint( "command failed: %s\n"
                    "while attempting to execute: %s\n", 
                    PQerrorMessage(conn),cmd.c_str());
            //exit (1);
            return NULL;
    }
    return res;
}

int main (int argc, char** argv){
    if (argc != 2){
        errprint ("look, I came here for an argument!\n");
        exit (1);
    }
    
    PGconn* conn;
    FILE* ofile = fopen (argv[1], "w");
        
    if (!(conn = dbcon("dbname = MacroTrack"))){
        errprint ("error connecting to db");
        exit (1);
    }
	
    std::string recname;
    printf ("enter the name of the recipe\n");
    std::getline (std::cin,recname);
    chomp (recname);
    std::string ingr_query_base
        ("select * from ingredients where name ~ ");
    printf ("enter a fresh recipe ID\n");
    int rid;
    std::cin >> rid;
    PGresult* rs;
    const char* rec_fmt = "insert into recipes (\"id\",\"name\", \"instruction_file\") values (%d, \'%s\', \'%s\');\n";
    const char* cont_fmt = "insert into contains (\"recipe\", \"ingredient\", \"amount\") values (%d,%d,%lf);\n"; 
    std::string ifname = recname + ".instr";
    fprintf (ofile, rec_fmt, rid, recname.c_str(), (recname + ".instr").c_str()); 
   // assert (rs = dbexec (conn, "BEGIN"));
    for (;;){
        printf ("enter ingredient regex\n");
        std::string ingredient_regex;
        std::cin >> ingredient_regex;
        if (chomp (ingredient_regex)  == -1){
            printf ("invalid ingredient regex\n");
            continue;
        }
        //std::cout << ingredient_regex;
        if (ingredient_regex == "nomore"){
            break;
        }

        std::string ingr_query = ingr_query_base + '\'' + ingredient_regex + '\'';
        assert (rs = dbexec (conn, ingr_query));
        if (!PQntuples(rs)){
            printf ("no match for regex %s\n", ingredient_regex.c_str());
            continue;
        }
        printf ("select the correct ingredient\n");
        int i = 0;
        for (i = 0; i < PQntuples(rs); ++i){
           printf ("%d: ",i);
           printf ("%s\n", PQgetvalue(rs, i, 1)); 
        }
        int sel = 0;
        for (;;){
            if (!(std::cin >> sel)){
                std::cin.clear();
                std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
                errprint ("invalid selection, enter a number between %d and %d\n",0,i - 1);
            }else if (sel < 0 || sel >= i){ 
                errprint ("invalid selection, enter a number between %d and %d\n",0,i - 1);
            }else break;
        }
        int igr_id = atoi (PQgetvalue (rs, sel, 0)); 
        //printf ("%d\n", igr_id);
        printf ("enter the amount of the ingredient in grammes\n");
        double grammes;
        std::cin >> grammes;
        grammes /= (double)100;
        fprintf (ofile, cont_fmt, rid, igr_id, grammes); 
   }
    printf ("enter a description on how to make the recipe\n");
    
    int pid = fork();
    if (pid){
        //parent
        int retstat;
        waitpid (pid, &retstat, 0);
    }else{
        //child
        
        char* ifname_cchararr = (char*)malloc(ifname.length() + 1);
        strcpy (ifname_cchararr, ifname.c_str());
        char* const aargv[3] = {"vim", ifname_cchararr, NULL};
       // std::cout << ifname_cchararr<<std::endl;
        execvp ("vim", aargv);
    }

}
