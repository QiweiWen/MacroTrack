create table Users (
        id TEXT not null,
        name TEXT not null,
        pwrd TEXT not null,
        email TEXT not null,
        primary key (id)
    );

create table Ingredients (
        id TEXT not null,
        name TEXT not null,
        sugar float
                constraint has_sugar check (sugar >= 0),
        protein float
                constraint has_protein check (sugar >= 0),
        fat float
                constraint has_fat check (sugar >= 0),
        primary key (id)              
);

create table Recipes (
        id TEXT not null,
        name TEXT not null,
        author TEXT
                constraint valid_user references Users(id),
        primary key (id)
);

create table Contains (
        id TEXT not null,
        recipe TEXT
                constraint valid_recipe references Recipes (id),
        ingredient TEXT 
                constraint valid_ingredient references Ingredients (id),
        amount float
                constraint sane_amoint check (amount >= 0),
        primary key (id),
        unique (recipe, ingredient)
);

create table Ratings (
        id TEXT not null,
        userid TEXT
                constraint valid_user references Users(id),
        recipe TEXT
                constraint valid_recipe references Recipes (id),
        rating smallint
                constraint sane_rating check (rating >= 0 and rating <= 10),
        primary key (id),
        unique (userid, recipe)
);