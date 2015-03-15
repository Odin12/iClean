DROP SCHEMA IF EXISTS iClean CASCADE;
CREATE SCHEMA iClean;
SET SEARCH_PATH = iClean;

DROP TABLE IF EXISTS account;
-- Account table: Responsible for initial login, matching username with a_id to receieve 
CREATE TABLE account(
    a_id SERIAL,
    username varchar(20),
    PRIMARY KEY(a_id)
);

-- hashed table: Responsible for encrypted pw, matches a_id field and checks encryption.
DROP TABLE IF EXISTS hashed;
CREATE TABLE hashed(
    a_id int PRIMARY KEY,
    hashed_pw varchar(60),
    FOREIGN KEY(a_id) REFERENCES account(a_id) ON DELETE CASCADE
);

-- building table: Responsible for storing information about who lives where, used to connect roommates through roommate table.
DROP TABLE IF EXISTS building;
CREATE TABLE building(
    b_id SERIAL PRIMARY KEY,
    bname char(30),
    num_occupants int
);

-- building_address: Stores the buildings address, used to help users find their building if a roommate has already created it.
DROP TABLE IF EXISTS building_address;
CREATE TABLE Building_address(
    b_id int PRIMARY KEY REFERENCES building(b_id) ON DELETE CASCADE,
    street varchar(30),
    zipcode int,
    apt_num INT DEFAULT NULL
);

-- State table: For normalizations sake, State will be checked through trigger on insert, checking that the zipcode matches the state.
DROP TABLE IF EXISTS state;
CREATE TABLE state(
    abv varchar(2) PRIMARY KEY,
    zipcode_min int,
    zipcode_max int
);   
    
-- users table: Responisble for storing basic information about the user, as well as connect user to other entities in our design.
DROP TABLE IF EXISTS users;
CREATE TABLE users(
    a_id int REFERENCES account(a_id) ON DELETE CASCADE,
    u_id Serial,
    fname char(20),
    lname char(20),
    PRIMARY KEY(u_id)
);

-- contact information: Responsible for storing the information used to send notifications to users about their apt.
DROP TABLE IF EXISTS contact_information;
CREATE TABLE contact_information(
    u_id int REFERENCES users(u_id),
    email varchar(40),
    phone varchar(12),
    PRIMARY KEY (u_id)
);

-- roommates: Responsible for identifying which user accounts are associated to eachother through matching b_id field, which rep. building id.
DROP TABLE IF EXISTS roommates;
CREATE TABLE roommates(
    b_id int REFERENCES building(b_id),
    u_id int REFERENCES users(u_id)
);

-- CHORES: Responsible for the storage of chores that are done around one's house/apt.
DROP TABLE IF EXISTS chores;
CREATE TABLE chores(
    c_id SERIAL PRIMARY KEY,
    name char(20)
);

-- Chore_record: Responsible for the storage of user's chore completion status.
DROP TABLE IF EXISTS chore_record;
CREATE TABLE chore_record(
    u_id int REFERENCES users(u_id),
    c_id int REFERENCES chores(c_id),
    times_completed int,
    last_completed date,
    PRIMARY KEY(u_id, c_id)
);

                                 
    