<?php
// wcf imports
require_once(WCF_DIR.'lib/page/AbstractPage.class.php');
require_once(WCF_DIR.'lib/page/util/menu/PageMenu.class.php');

// cheat database imports
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/Entry.class.php');

/**
 * Shows a cheat database entry.
 *
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.cheatdatabase.core
 * @subpackage	page
 * @category 	Cheat Database
 */
class CheatDatabaseEntryPage extends AbstractPage {
	public $templateName = 'cheatDatabaseEntry';
	public $neededPermissions = 'user.cheatDatabase.canUseCheatDatabase';
	
	/**
	 * entry id
	 * 
	 * @var	integer
	 */
	public $entryID = 0;
	
	/**
	 * entry object
	 * 
	 * @var	Entry
	 */
	public $entry = null;
	
	/**
	 * @see Page::readParameters()
	 */
	public function readParameters() {
		parent::readParameters();
		
		if (isset($_GET['entryID'])) {
			$this->entryID = intval($_GET['entryID']);
		}
		
		$this->entry = new Entry($this->entryID);
		
		if (!$this->entry->entryID) {
			throw new IllegalLinkException();
		}
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
