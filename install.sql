DROP TABLE IF EXISTS wcf1_cheat_database_entry;
CREATE TABLE wcf1_cheat_database_entry (
	entryID		INT(10) UNSIGNED	NOT NULL AUTO_INCREMENT,
	messageID	INT(10) UNSIGNED	NOT NULL DEFAULT 0,
	pokedexNumber	INT(5) UNSIGNED		NOT NULL,
	form		TINYINT(3) UNSIGNED	NOT NULL DEFAULT 0,
	nickname	VARCHAR(255)		NOT NULL DEFAULT '',
	gender		TINYINT(1) UNSIGNED	NOT NULL DEFAULT 0,
	trainerName	VARCHAR(255)		NOT NULL DEFAULT '',
	trainerID	INT(5) UNSIGNED		NOT NULL DEFAULT 0,
	level		TINYINT(3) UNSIGNED	NOT NULL DEFAULT 0,
	catchLocation	VARCHAR(255)		NOT NULL DEFAULT '',
	catchDate	INT(10)			NOT NULL DEFAULT 0,
	catchLevel	TINYINT(3) UNSIGNED	NOT NULL DEFAULT 0,
	nature		TINYINT(3) UNSIGNED	NOT NULL DEFAULT 0,
	characteristic	TINYINT(3) UNSIGNED	NOT NULL DEFAULT 0,
	isShiny		TINYINT(1)		NOT NULL DEFAULT 0,
	ball		TINYINT(3) UNSIGNED	NOT NULL DEFAULT 0,
	PRIMARY KEY (entryID),
	FULLTEXT KEY (nickname, trainerName)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS wcf1_cheat_database_ribbon_to_entry;
CREATE TABLE wcf1_cheat_database_ribbon_to_entry (
	entryID		INT(10) UNSIGNED	NOT NULL DEFAULT 0,
	ribbonID	TINYINT(3) UNSIGNED	NOT NULL DEFAULT 0,
	PRIMARY KEY (entryID, ribbonID)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS wcf1_cheat_database_entry_message;
CREATE TABLE wcf1_cheat_database_entry_message (
	messageID 	INT(10) UNSIGNED	NOT NULL AUTO_INCREMENT,
	entryID		INT(10) UNSIGNED	NOT NULL DEFAULT 0,
	userID 		INT(10) UNSIGNED	NOT NULL DEFAULT 0,
	username 	VARCHAR(255) 		NOT NULL DEFAULT '',
	subject 	VARCHAR(255) 		NOT NULL DEFAULT '',
	message 	MEDIUMTEXT,
	time 		INT(10)  		NOT NULL DEFAULT 0,
	ipAddress 	VARCHAR(15) 		NOT NULL DEFAULT '',
	enableSmilies	TINYINT(1)  		NOT NULL DEFAULT 1,
	enableHtml 	TINYINT(1)  		NOT NULL DEFAULT 0,
	enableBBCodes	TINYINT(1)  		NOT NULL DEFAULT 1,
	PRIMARY KEY (messageID),
	FULLTEXT KEY (subject, message)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
