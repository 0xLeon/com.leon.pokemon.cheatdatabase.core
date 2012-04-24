<?php
// wcf imports
require_once(WCF_DIR.'lib/data/message/Message.class.php');

/**
 * Represents a cheat database entry.
 *
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.cheatdatabase.core
 * @subpackage	data.cheatDatabase.entry
 * @category 	Cheat Database
 */
class Entry extends Message {
	/**
	 * Creates a new Entry object.
	 * 
	 * @param	integer		$entryID
	 * @param	array		$row
	 */
	public function __construct($entryID, $row = null) {
		if ($entryID !== null) {
			$sql = "SELECT		entry.*,
						language.languageItemValue AS name
				FROM		wcf".WCF_N."_cheat_database_entry entry
				LEFT JOIN	wcf".WCF_N."_language_item language
				ON		(language.languageItem = CONCAT('wcf.cheatDatabase.entry.pokemon.', entry.pokedexNumber))
						AND (language.languageID = ".WCF::getUser()->languageID.")
				WHERE		entry.entryID = ".$entryID;
			$row = WCF::getDB()->getFirstRow($sql);
		}
		$this->messageID = $row['entryID'];
		parent::__construct($row);
	}
	
	public function getSpritePath() {
		return RELATIVE_WCF_DIR.'images/pokemon/sprites/'.(($this->isShiny == 1) ? 'shiny' : 'normal').'/'.sprintf('%03d.png', $this->pokedexNumber);
	}
	
	public function getIconPath() {
		return RELATIVE_WCF_DIR.'images/pokemon/icons/'.(($this->isShiny == 1) ? 'shiny' : 'normal').'/'.sprintf('%03d.png', $this->pokedexNumber);
	}
}
