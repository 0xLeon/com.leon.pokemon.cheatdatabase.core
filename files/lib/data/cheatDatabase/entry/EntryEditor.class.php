<?php
// cheat database imports
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/Entry.class.php');

/**
 * EntryEditor creates, dedits or deletes cheat database entries.
 *
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.pokemon.cheatdatabase.core
 * @subpackage	data.cheatDatabase.entry
 * @category 	Cheat Database
 */
class EntryEditor extends Entry {
	/**
	 * Creates a new entry
	 * 
	 * @return 	Entry
	 */
	public static function create() {
		$sql = "";
		WCF::getDB()->sendQuery($sql);
		
		return new EntryEditor(WCF::getDB()->getInsertID());
	}
	
	/**
	 * Deletes this entry.
	 * 
	 * @return	boolean
	 */
	public function delete() {
		$sql = "DELETE
			FROM	wcf".WCF_N."_cheat_database_entry
			WHERE	entryID = ".$this->entryID;
		WCF::getDB()->sendQuery($sql);
		
		$sql = "DELETE
			FROM	wcf".WCF_N."_cheat_database_ribbon_to_entry
			WHERE	entryID = ".$this->entryID;
		WCF::getDB()->sendQuery($sql);
		
		$sql = "DELETE
			FROM	wcf".WCF_N."_cheat_database_entry_message
			WHERE	entryID = ".$this->entryID;
		WCF::getDB()->sendQuery($sql);
		
		return true;
	}
}
