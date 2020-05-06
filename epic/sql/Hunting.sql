-- The statement below sets the collation of the database to utf8
--ALTER DATABASE jromero326 CHARACTER SET utf8 COLLATE utf8_unicode_ci;

-- this is a comment in SQL (yes, the space is needed!)
-- these statements will drop the tables and re-add them
-- this is akin to reformatting and reinstalling Windows (OS X never needs a reinstall...) ;)
-- never ever ever ever ever ever ever ever ever ever ever ever ever ever ever ever ever ever ever ever
-- do this on live data!!!!
DROP TABLE IF EXISTS hunt;
DROP TABLE IF EXISTS billHunt;
DROP TABLE IF EXISTS bill;
DROP TABLE IF EXISTS hunter;

-- the CREATE TABLE function is a function that takes tons of arguments to layout the table's schema
CREATE TABLE hunter (
-- this creates the attribute for the primary key
-- not null means the attribute is required!
hunterId BINARY(16) NOT NULL,
hunterActivationToken CHAR(32),
hunterName CHAR(32) NOT NULL,
hunterEmail VARCHAR(128) NOT NULL,
hunterHash CHAR(97) NOT NULL,

unique(hunterEmail),
primary key(hunterId)
);

-- create the Bill entity
CREATE TABLE bill (

billId BINARY(16) NOT NULL,
billHunterId BINARY(32) NOT NULL,
billDate DATETIME(3) NOT NULL,
  -- this creates the actual foreign key relation
  FOREIGN KEY(billHunterId) REFERENCES hunter(hunterId),
  -- and finally create the primary key
  PRIMARY KEY(billId)
);

CREATE table hunt (

huntId BINARY(16) NOT NULL,
huntSpecies CHAR (16) NOT NULL,
huntSpeciesUnit VARCHAR(16) NOT NULL,
huntDate DATETIME(3) NOT NULL,
huntCost VARCHAR(8) NOT NULL,
huntAttachment VARCHAR(16) NOT NULL,

 PRIMARY KEY(huntId)
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
  FOREIGN KEY(billHuntHuntId) REFERENCES hunt(huntId),
  FOREIGN KEY(billHuntHunterId) REFERENCES hunter(hunterId),
  -- finally, create a composite foreign key with the two foreign keys
  PRIMARY KEY(billHuntHuntId, billHuntHunterId)
);