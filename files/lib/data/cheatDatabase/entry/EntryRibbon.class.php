<?php
// wcf imports
require_once(WCF_DIR.'lib/data/DatabaseObject.class.php');

/**
 * Represents a ribbon of a cheat database entry.
 *
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.pokemon.cheatdatabase.core
 * @subpackage	data.cheatDatabase.entry
 * @category 	Cheat Database
 */
class EntryRibbon extends DatabaseObject {
	/**
	 * Creates a new EntryRibbon object.
	 * 
	 * @param	integer		$entryID
	 * @param	integer		$ribbonID
	 * @param	array		$row
	 */
	public function __construct($entryID, $ribbonID, $row = null) {
		if ($entryID !== null && $ribbonID !== null) {
			$sql = "SELECT		ribbon.*,
						languageRibbonName.languageItemValue AS ribbonName
				FROM		wcf".WCF_N."_cheat_database_ribbon_to_entry ribbon
				LEFT JOIN	wcf".WCF_N."_language_item languageRibbonName
				ON		(languageRibbonName.languageItem = CONCAT('wcf.cheatDatabase.entry.ribbon.', ribbon.ribbonID))
						AND (languageRibbonName.languageID = ".WCF::getUser()->languageID.")
				WHERE		ribbon.entryID = ".$entryID."
						AND ribbon.ribbonID = ".$ribbonID;
			$row = WCF::getDB()->getFirstRow($sql);
		}
		
		parent::__construct($row);
	}
	
	/**
	 * Returns the name of this recipient.
	 *
	 * @return	string
	 */
	public function __toString() {
		return $this->ribbonName;
	}
	
	public function getIconPath() {
		return RELATIVE_WCF_DIR.'images/pokemon/ribbons/'.$this->ribbonID.'.png';
	}
}
