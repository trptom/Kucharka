--------------------------------------------------------------------------------
-- TABLES
--------------------------------------------------------------------------------

CREATE TABLE User (
    id int not null primary key,
    login varchar(20) not null,
    password text not null,
    firstName text null default null
    secondName text null default null
    registration datetime not null,
    lastLogin datetime null default null,
    UNIQUE KEY (login)
);

CREATE TABLE Recipe (
    id int not null primary key,
    title text not null,
    description text not null,
    story text null
);

CREATE TABLE Ingredience (
    id int not null primary key,
    title text not null,
    description text not null,
    story text null,
    units text not null,
    inserted datetime not null,
    lastUpdate timestamp on update CURRENT_TIMESTAMP,
);

CREATE TABLE Ranking (
    userId int not null,
    eventType int not null,
    eventId int not null,
    rank int not null,
    inserted datetime not null,
    lastUpdate timestamp on update CURRENT_TIMESTAMP,
    PRIMARY KEY (userId, eventType, eventId),
    FOREIGN KEY (userId) REFERENCES User(id)
);

CREATE TABLE Comment (
    userId int not null,
    eventType int not null,
    eventId int not null,
    title text not null,
    content text not null,
    inserted datetime not null,
    lastUpdate timestamp on update CURRENT_TIMESTAMP,
    PRIMARY KEY (userId, eventType, eventId, inserted),
    FOREIGN KEY (userId) REFERENCES User(id)
);

CREATE TABLE Favourite (
    userId int not null,
    eventType int not null,
    eventId int not null,
    inserted datetime not null,
    PRIMARY KEY (userId, eventType, eventId),
    FOREIGN KEY (userId) REFERENCES User(id)
);

--------------------------------------------------------------------------------
-- CONNECTORS
--------------------------------------------------------------------------------

CREATE TABLE RecipeIngredience (
    recipeId int not null,
    ingredienceId int not null,
    quantity int not null,
    FOREIGN KEY (recipeId) REFERENCES Recipe(id),
    FOREIGN KEY (ingredienceId) REFERENCES Ingredience(id),
);