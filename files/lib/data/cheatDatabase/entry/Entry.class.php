<?php
// wcf imports
require_once(WCF_DIR.'lib/data/DatabaseObject.class.php');

// cheat database imports
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/EntryRibbon.class.php');
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/message/EntryMessage.class.php');

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
class Entry extends DatabaseObject {
	protected $ribbons = null;
	
	/**
	 * Creates a new Entry object.
	 * 
	 * @param	integer		$entryID
	 * @param	array		$row
	 * @param 	integer 	$messageID
	 */
	public function __construct($entryID, $row = null, $messageID = null) {
		if (($entryID !== null) || ($messageID !== null && $messageID !== 0)) {
			$sql = "SELECT		entry.*,
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
				LEFT JOIN	wcf" . WCF_N . "_cheat_database_entry_message message
				ON 		(entry.messageID = message.messageID)
				WHERE		".(($messageID !== null && $messageID !== 0) ? ("entry.messageID = ".$messageID) : ("entry.entryID = ".$entryID));
			$row = WCF::getDB()->getFirstRow($sql);
			
			if ($row) {
				$row['message'] = new EntryMessage(null, $row);
			}
		}
		
		parent::__construct($row);
	}
	
	public function getUser() {
		return $this->message->getUser();
	}
	
	public function getDescription() {
		return $this->message->getFormattedMessage();
	}
	
	public function getSpritePath() {
		return RELATIVE_WCF_DIR.'images/pokemon/sprites/'.(($this->isShiny == 1) ? 'shiny' : 'normal').'/'.sprintf('%03d', $this->pokedexNumber).(($this->form > 0) ? '.'.sprintf('%d', $this->form) : '').'.png';
	}
	
	public function getIconPath() {
		return RELATIVE_WCF_DIR.'images/pokemon/icons/'.(($this->isShiny == 1) ? 'shiny' : 'normal').'/'.sprintf('%03d.png', $this->pokedexNumber);
	}
	
	public function getBallIconPath() {
		return RELATIVE_WCF_DIR.'images/pokemon/balls/'.$this->ball.'.png';
	}
	
	/**
	 * Returns the list of ribbons.
	 * 
	 * @return	array<EntryRibbon>
	 */
	public function getRibbons() {
		if ($this->ribbons === null) {
			$this->ribbons = array();
			
			$sql = "SELECT		ribbon.*,
						languageRibbonName.languageItemValue AS ribbonName
				FROM		wcf".WCF_N."_cheat_database_ribbon_to_entry ribbon
				LEFT JOIN	wcf".WCF_N."_language_item languageRibbonName
				ON		(languageRibbonName.languageItem = CONCAT('wcf.cheatDatabase.entry.ribbon.', ribbon.ribbonID))
						AND (languageRibbonName.languageID = ".WCF::getUser()->languageID.")
				WHERE		ribbon.entryID = ".$this->entryID."
				ORDER BY	ribbon.ribbonID";
			$result = WCF::getDB()->sendQuery($sql);
			while ($row = WCF::getDB()->fetchArray($result)) {
				$this->ribbons[] = new EntryRibbon(null, null, $row);
			}
		}
		
		return $this->ribbons;
	}
	
	/**
	 * Sets a ribbon.
	 * 
	 * @param	EntryRibbon	$ribbon
	 */
	public function setRibbon(EntryRibbon $ribbon) {
		if ($this->ribbons === null) {
			$this->ribbons = array();
		}
		
		$this->ribbons[] = $ribbon;
	}
	
	/**
	 * Sets the ribbons.
	 * 
	 * @param	array<EntryRibbon>	$ribbons
	 */
	public function setRibbons($ribbons) {
		$this->ribbons = $ribbons;
	}
	
	/**
	 * Get editor object of this entry
	 *
	 * @return EntryEditor
	 */
	public function getEditor() {
		require_once(WCF_DIR.'lib/data/cheatDatabase/entry/EntryEditor.class.php');
		return new EntryEditor(null, $this->data);
	}
}
