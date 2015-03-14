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
    apt_num INT DEFAULT NULL,
    num_occupants int,
    zipcode int
);
    
    
    
    
/* users table: Responisble for storing basic information about the user, as well as connect user to other entities in our design.
DROP TABLE IF EXISTS users;
CREATE TABLE users(
    a_id int REFERENCES account(a_id),
    u_id int,
    b_id int REFERENCES building(b_id),
    fname char(20),
    lname char(20),
);
    */