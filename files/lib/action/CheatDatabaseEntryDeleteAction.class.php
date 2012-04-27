<?php
// wcf imports
require_once(WCF_DIR.'lib/action/AbstractSecureAction.class.php');

// cheat database imports
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/EntryEditor.class.php');

/**
 * Deletes a cheat database entry.
 * 
 * @author 	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.pokemon.cheatdatabase.core
 * @subpackage	action
 * @category 	Cheat Database
 */
class CheatDatabaseEntryDeleteAction extends AbstractSecureAction {
	/**
	 * entry id
	 *
	 * @var integer
	 */
	public $entryID = 0;
	
	/**
	 * entry editor object
	 *
	 * @var EntryEditor
	 */
	public $entry = null;
	
	/**
	 * @see Action::readParameters()
	 */
	public function readParameters() {
		parent::readParameters();
		
		if (isset($_REQUEST['entryID'])) $this->entryID = intval($_REQUEST['entryID']);
		$this->entry = new EntryEditor($this->entryID);
		if (!MODULE_CHEAT_DATABASE || !$this->entry->entryID) {
			throw new IllegalLinkException();
		}
	}
	
	/**
	 * @see Action::execute()
	 */
	public function execute() {
		parent::execute();
		
		WCF::getUser()->checkPermission('mod.cheatDatabase.canDeleteEntry');
		
		$this->entry->delete();
		
		$this->executed();
		
		HeaderUtil::redirect('index.php?page=CheatDatabaseEntryList&deletedEntryID='.$this->entryID.SID_ARG_2ND_NOT_ENCODED);
		exit;
	}
}
