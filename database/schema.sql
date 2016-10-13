create table Users (
	id serial not null,
        name text not null,
        pwrd text not null,
        email text not null,
        primary key (id)
    );

create table Ingredients (
       	id serial not null,
        name text not null,
        calories float not null
                constraint has_caloties check (calories >= 0),
        sugar float not null
                constraint has_sugar check (sugar >= 0),
        protein float not null
                constraint has_protein check (sugar >= 0),
        fat float not null
                constraint has_fat check (sugar >= 0),
        primary key (id)              
);

create table Recipes (
	id serial not null,
        name text not null,
        author smallint
                constraint valid_user references Users(id),
	instruction_file text not null, 
        primary key (id)
);

create table Contains (
	id serial not null,
        recipe smallint not null
                constraint valid_recipe references Recipes (id),
        ingredient smallint  not null
                constraint valid_ingredient references Ingredients (id),
        amount float not null
                constraint sane_amoint check (amount >= 0),
		
        primary key (id),
        unique (recipe, ingredient)
);

create table Ratings (
	id serial not null,
        userid smallint not null
                constraint valid_user references Users(id),
        recipe smallint not null
                constraint valid_recipe references Recipes (id),
        rating smallint not null
                constraint sane_rating check (rating >= 0 and rating <= 10),
        primary key (id),
        unique (userid, recipe)
);
