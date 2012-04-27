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

INSERT INTO wcf1_cheat_database_entry (entryID, messageID, pokedexNumber, form, nickname, gender, trainerName, trainerID, level, catchLocation, catchDate, catchLevel, nature, characteristic, isShiny, ball) VALUES
(1, 1, 6, 0, 'Dragon', 1, 'Leon', 56789, 100, 'Dort', 111111111, 10, 5, 6, 1, 23),
(2, 2, 1, 0, 'Bisersam', 2, 'Robert Robert Agular', 1, 1, 'Hier', 111111111, 1, 1, 1, 0, 1),
(3, 3, 124, 0, 'Kyons Mutter', 0, 'Leon', 56789, 100, 'Kyons Zuhause.', 111111111, 1, 1, 1, 0, 12),
(4, 4, 251, 0, '', 0, 'Cheater', 0, 100, 'Schicksalhafte Begegnung', 255114841, 10, 5, 9, 1, 4),
(5, 5, 351, 1, '', 1, 'Leon', 56789, 50, 'Klimainstitut', 2551148416, 50, 1, 1, 0, 1),
(6, 6, 386, 2, '', 0, 'Leon', 56789, 86, 'Schicksalhafte Begegnung', 2551148416, 1, 10, 10, 1, 10);

INSERT INTO wcf1_cheat_database_ribbon_to_entry (entryID, ribbonID) VALUES
(1, 68),
(1, 78),
(1, 45),
(3, 53);

INSERT INTO wcf1_cheat_database_entry_message (messageID, entryID, userID, username, subject, message, time, ipAddress, enableSmilies, enableHtml, enableBBCodes) VALUES
(1, 1, 1, 'Leon', 'Pokesav Shiny Glurak', 'Voll Cheat, digga.', 222222222, '127.0.0.1', 1, 0, 1),
(2, 2, 1, 'Leon', 'Versager Bisasam', 'Krass Cheat.', 222222222, '127.0.0.1', 1, 0, 1),
(3, 3, 1, 'Leon', 'Kyons fette Mutter', 'Zu fett.', 222222222, '127.0.0.1', 1, 0, 1),
(4, 4, 1, 'Leon', 'Shiny Colosseum Celebi', '[b]Cheat[/b]', 255914841, '127.0.0.1', 0, 0, 1),
(5, 5, 1, 'Leon', 'Cheat Formeo', '', 2951148416, '127.0.0.1', 1, 0, 1),
(6, 6, 1, 'Leon', 'Cheat Shiny Deoxys', '', 2951148416, '127.0.0.1', 1, 0, 1);
