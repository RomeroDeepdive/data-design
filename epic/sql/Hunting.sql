-- The statement below sets the collation of the database to utf8
--ALTER DATABASE jromero326 CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- this is a comment in SQL (yes, the space is needed!)
-- these statements will drop the tables and re-add them
-- this is akin to reformatting and reinstalling Windows (OS X never needs a reinstall...) ;)
-- never ever ever ever ever ever ever ever ever ever ever ever ever ever ever ever ever ever ever ever
-- do this on live data!!!!
DROP TABLE IF EXISTS Hunt;
DROP TABLE IF EXISTS BillHunt;
DROP TABLE IF EXISTS Bill;
DROP TABLE IF EXISTS Hunter;

-- the CREATE TABLE function is a function that takes tons of arguments to layout the table's schema
CREATE TABLE Hunter (
-- this creates the attribute for the primary key
-- not null means the attribute is required!
HunterId BINARY(16) NOT NULL,
HunterActivationToken CHAR(32),
HunterName CHAR(32) NOT NULL,
HunterEmail VARCHAR(128) NOT NULL,
HunterHash CHAR(97) NOT NULL,

unique(HunterEmail),
primary key(HunterId)
);

-- create the Bill entity
CREATE TABLE Bill (

BillId BINARY(16) NOT NULL,
BillHunterId BINARY(32) NOT NULL,
BillDate DATETIME(3) NOT NULL,
  -- this creates the actual foreign key relation
  FOREIGN KEY(BillHunterId) REFERENCES Hunter(HunterId),
  -- and finally create the primary key
  PRIMARY KEY(BillId)
);

CREATE table Hunt (

HuntId BINARY(16) NOT NULL,
Huntspecies CHAR (16) NOT NULL,
HuntspeciesUnit VARCHAR(16) NOT NULL,
Huntdate DATETIME(3) NOT NULL,
HuntCost VARCHAR(8) NOT NULL,
HuntAttachment VARCHAR(16) NOT NULL,

 PRIMARY KEY(HuntId)
);
-- create the like entity (a weak entity from an m-to-n for profile -->Bill Hunt)
CREATE TABLE billHunt (
  -- these are still foreign keys
billHuntHuntId BINARY(16) NOT NULL,
billHuntHunterId BINARY(16) NOT NULL,
billHuntApproved CHAR(128) NOT NULL,
  -- index the foreign keys
  INDEX(billHuntHuntId),
  INDEX(billHuntHunterId),
  -- create the foreign key relations
  FOREIGN KEY(billHuntHuntId) REFERENCES Hunt(HuntId),
  FOREIGN KEY(billHuntHunterId) REFERENCES Hunter(HunterId),
  -- finally, create a composite foreign key with the two foreign keys
  PRIMARY KEY(billHuntHuntId, billHuntHunterId)
);