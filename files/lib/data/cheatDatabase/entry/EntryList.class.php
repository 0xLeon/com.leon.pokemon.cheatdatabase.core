<?php
// wcf imports
require_once(WCF_DIR.'lib/data/DatabaseObjectList.class.php');

// cheat databse imports
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/Entry.class.php');

/**
 * Represents a list of cheat database entries.
 * 
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.pokemon.cheatdatabase.core
 * @subpackage	data.cheatDatabase.entry
 * @category 	Cheat Database
 */
class EntryList extends DatabaseObjectList {
	/**
	 * list of entries
	 * 
	 * @var array<Entry>
	 */
	public $entries = array();
	
	/**
	 * Class name of the result object class
	 * 
	 * @var	string
	 */
	public $objectClassName = 'Entry';
	
	/**
	 * @see DatabaseObjectList::countObjects()
	 */
	public function countObjects() {
		// note: do name and ball filtering by getting IDs
		$sql = "SELECT		COUNT(*) AS count
			FROM		wcf".WCF_N."_cheat_database_entry entry
			LEFT JOIN	wcf".WCF_N."_cheat_database_entry_message message
			ON 		(entry.messageID = message.messageID)
			".$this->sqlJoins."
			".(!empty($this->sqlConditions) ? "WHERE ".$this->sqlConditions : '');
		$row = WCF::getDB()->getFirstRow($sql);
		
		return $row['count'];
	}
	
	/**
	 * @see DatabaseObjectList::readObjects()
	 */
	public function readObjects() {
		$sql = "SELECT		".(!empty($this->sqlSelects) ? $this->sqlSelects.',' : '')."
					entry.*,
					languagePokemonName.languageItemValue AS pokemonName,
					languageBallName.languageItemValue AS ballName,
					message.*
			FROM		wcf".WCF_N."_cheat_database_entry entry
			LEFT JOIN	wcf".WCF_N."_language_item languagePokemonName
			ON		(languagePokemonName.languageItem = CONCAT('wcf.cheatDatabase.entry.pokemon.', entry.pokedexNumber, '.', entry.form))
					AND (languagePokemonName.languageID = ".WCF::getUser()->languageID.")
			LEFT JOIN	wcf".WCF_N."_language_item languageBallName
			ON		(languageBallName.languageItem = CONCAT('wcf.cheatDatabase.entry.ball.', entry.ball))
					AND (languageBallName.languageID = ".WCF::getUser()->languageID.")
			LEFT JOIN	wcf".WCF_N."_cheat_database_entry_message message
			ON 		(entry.messageID = message.messageID)
			".$this->sqlJoins."
			".(!empty($this->sqlConditions) ? "WHERE ".$this->sqlConditions : '')."
			".(!empty($this->sqlOrderBy) ? "ORDER BY ".$this->sqlOrderBy : '');
		$result = WCF::getDB()->sendQuery($sql, $this->sqlLimit, $this->sqlOffset);
		
		while ($row = WCF::getDB()->fetchArray($result)) {
			$this->entries[] = new $this->objectClassName(null, $row);
		}
	}
	
	/**
	 * @see DatabaseObjectList::getObjects()
	 */
	public function getObjects() {
		return $this->entries;
	}
}
