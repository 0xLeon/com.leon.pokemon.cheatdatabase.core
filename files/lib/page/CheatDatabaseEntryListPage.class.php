<?php
// wcf imports
require_once(WCF_DIR.'lib/page/SortablePage.class.php');
require_once(WCF_DIR.'lib/page/util/menu/PageMenu.class.php');

// cheat database imports
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/EntryList.class.php');

/**
 * Shows a list of all cheat database entries.
 *
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.pokemon.cheatdatabase.core
 * @subpackage	page
 * @category 	Cheat Database
 */
class CheatDatabaseEntryListPage extends SortablePage {
	public $templateName = 'cheatDatabaseEntryList';
	public $neededPermissions = 'user.cheatDatabase.canUseCheatDatabase';
	public $defaultSortField = 'entry.pokedexNumber';
	public $defaultSortOrder = 'ASC';
	public $deletedEntryID = 0;
	
	/**
	 * Entry list object
	 * 
	 * @var	EntryList
	 */
	public $entryList = null;
	
	/**
	 * @see Page::readParameters()
	 */
	public function readParameters() {
		parent::readParameters();
		
		if (isset($_REQUEST['deletedEntryID'])) $this->deletedEntryID = intval($_REQUEST['deletedEntryID']);
		$this->entryList = new EntryList();
	}
	
	/**
	 * @see Page::readData()
	 */
	public function readData() {
		parent::readData();
		
		$this->entryList->sqlOffset = ($this->pageNo - 1) * $this->itemsPerPage;
		$this->entryList->sqlLimit = $this->itemsPerPage;
		$this->entryList->sqlOrderBy = $this->sortField." ".$this->sortOrder;
		$this->entryList->readObjects();
	}
	
	/**
	 * @see SortablePage::validateSortField()
	 */
	public function validateSortField() {
		parent::validateSortField();
		
		switch ($this->sortField) {
			case 'pokemon':
				$this->sortField = 'pokemonName';
				break;
			case 'name':
				$this->sortField = 'message.subject';
				break;
			case 'entryID':
			case 'nickname':
			case 'trainerName':
			case 'trainerID':
			case 'level':
			case 'pokedexNumber':
				$this->sortField = 'entry.'.$this->sortField;
				break;
			default:
				$this->sortField = $this->defaultSortField;
		}
	}
	
	/**
	 * @see MultipleLinkPage::countItems()
	 */
	public function countItems() {
		parent::countItems();
		
		return $this->entryList->countObjects();
	}
	
	/**
	 * @see Page::assignVariables()
	 */
	public function assignVariables() {
		parent::assignVariables();
		
		WCF::getTPL()->assign(array(
			'entries' => $this->entryList->getObjects(),
			'deletedEntryID' => $this->deletedEntryID
		));
	}
	
	/**
	 * @see Page::show()
	 */
	public function show() {
		if (!MODULE_CHEAT_DATABASE) {
			throw new IllegalLinkException();
		}
		
		PageMenu::setActiveMenuItem('wcf.header.menu.cheatDatabase');
		
		parent::show();
	}
}
