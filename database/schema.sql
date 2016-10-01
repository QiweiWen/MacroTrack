create table Users (
        id varchar (50) not null,
        name varchar (50) not null,
        pwrd varchar (20) not null,
        email varchar (50) not null,
        primary key (id)
    );

create table Ingredients (
        id varchar (50) not null,
        name varchar (500) not null,
        calories float
                constraint has_caloties check (calories >= 0),
        sugar float
                constraint has_sugar check (sugar >= 0),
        protein float
                constraint has_protein check (sugar >= 0),
        fat float
                constraint has_fat check (sugar >= 0),
        primary key (id)              
);

create table Recipes (
        id varchar (50) not null,
        name varchar (20) not null,
        author varchar (50)
                constraint valid_user references Users(id),
	instruction_file varchar (100) not null, 
        primary key (id)
);

create table Contains (
        id varchar (50) not null,
        recipe varchar (50)
                constraint valid_recipe references Recipes (id),
        ingredient varchar (50) 
                constraint valid_ingredient references Ingredients (id),
        amount float
                constraint sane_amoint check (amount >= 0),
		unit varchar (50) not null,
        primary key (id),
        unique (recipe, ingredient)
);

create table Ratings (
        id varchar (50) not null,
        userid varchar (50)
                constraint valid_user references Users(id),
        recipe varchar (50)
                constraint valid_recipe references Recipes (id),
        rating smallint
                constraint sane_rating check (rating >= 0 and rating <= 10),
        primary key (id),
        unique (userid, recipe)
);
