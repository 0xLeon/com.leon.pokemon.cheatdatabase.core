<?php
// cheat database imports
require_once(WCF_DIR.'lib/form/CheatDatabaseEntryAddForm.class.php');

/**
 * Shows the cheat database entry edit form.
 *
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.pokemon.cheatdatabase.core
 * @subpackage	form
 * @category 	Cheat Database
 */
class CheatDatabaseEntryEditForm extends CheatDatabaseEntryAddForm {
	/**
	 * @see AbstractPage::$action
	 */
	public $action = 'edit';
	
	/**
	 * @see AbstractPage::$neededPermissions
	 */
	public $neededPermissions = 'mod.cheatDatabase.canEditEntry';
	
	/**
	 * @see Page::readParameters()
	 */
	public function readParameters() {
		if (isset($_REQUEST['entryID']))
			$this->entryID = intval($_REQUEST['entryID']);
		
		$this->entry = new EntryEditor($this->entryID);
		
		if (!$this->entry->entryID) {
			throw new IllegalLinkException();
		}
	}
	
	/**
	 * @see	Page::readData()
	 */
	public function readData() {
		parent::readData();
		
		$this->username = $this->entry->username;
		$this->pokedexNumber = $this->entry->pokedexNumber;
		$this->nickname = $this->entry->nickname;
		$this->gender = $this->entry->gender;
		$this->trainerName = $this->entry->trainerName;
		$this->trainerID = $this->entry->trainerID;
		$this->level = $this->entry->level;
		$this->catchLocation = $this->entry->catchLocation;
		$this->catchDate = $this->entry->catchDate;
		$this->catchLevel = $this->entry->catchLevel;
		$this->nature = $this->entry->nature;
		$this->characteristic = $this->entry->characteristic;
		$this->isShiny = $this->entry->isShiny;
		$this->ball = $this->entry->ball;
		$this->ribbonIDs = $this->entry->getRibbonIDs();
	}
	
	/**
	 * @see Form::save()
	 */
	public function save() {
		MessageForm::save();
		
		//$this->entry->update()
		
		$this->saved();
		
		HeaderUtil::redirect('index.php?page=CheatDatabaseEntry&entryID='.$this->entry->entryID.SID_ARG_2ND_NOT_ENCODED);
		exit;
	}
	
	/**
	 * @see Page::assignVariables()
	 */
	public function assignVariables() {
		parent::assignVariables();
		
		WCF::getTPL()->assign(array(
			'entry' => $this->entry
		));
	}
}
