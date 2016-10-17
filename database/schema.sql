
create table Userattr (
        id serial not null,
        sex char
                constraint sane_sex check (sex = 'M' or sex = 'F'),
        height smallint
                constraint sane_height check (height >= 0 and height <= 300),
        weight smallint
                constraint sane_weight check (weight >= 0 and weight <= 800),
        age smallint
                constraint sane_age check (age >= 0 and age <= 200),
        exercise smallint
                constraint sane_exercise check (exercise >= 1 and exercise <= 4),
        primary key (id) 
);

create table Users (
	id serial not null,
        name text not null,
        pwrd text not null,
        email text not null,
        attrid integer
            constraint user_valid_attr references Userattr (id),  
        primary key (id)
    );

create table Ingredients (
       	id serial not null,
        name text not null,
        calories float not null
                constraint has_calories check (calories >= 0),
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

--recipe contains ingredient relation
create table Contains (
	id serial not null,
        recipe smallint not null
                constraint valid_recipe references Recipes (id),
        ingredient smallint  not null
                constraint valid_ingredient references Ingredients (id),
        amount float not null
                constraint sane_amount check (amount >= 0),
		
        primary key (id)
 --       unique (recipe, ingredient)
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

create table mealplan (
        userid integer
            constraint mealplan_valid_user references Users(id),
        recipeid integer
            constraint mealplan_valid_recipe references Recipes (id),
        --breakfast, lunch, supper
        mealcode smallint
            constraint mealplan_valid_meal check (mealcode >= 1 and mealcode <= 3),
        dateadded date not null
);
