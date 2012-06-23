<?php
//wcf imports
require_once(WCF_DIR.'lib/data/message/search/AbstractSearchableMessageType.class.php');

//cheat database imports
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/EntrySearchResult.class.php');
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/EntrySearchResultList.class.php');

/**
 * An implementation of SearchableMessageType for searching cheat database entries.
 * 
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.pokemon.cheatdatabase.core
 * @subpackage 	data.cheatDatabase.entry
 * @category 	Cheat Database
 */
class EntrySearch extends AbstractSearchableMessageType {
	/**
	 * Cache of messages
	 * 
	 * @var array<array>
	 */
	protected $messageCache = array();
	
	// form parameters
	protected $pokedexNumber = 0;
	protected $nickname = '';
	protected $gender = 0;
	protected $trainerName = '';
	protected $trainerID = 0;
	protected $level = 0;
	protected $catchLocation = '';
	protected $catchlevel = '';
	protected $nature = 0;
	protected $characteristic = 0;
	protected $isShiny = null;
	protected $ball = 0;
	protected $ribbonIDs = array();
	
	/**
	 * @see SearchableMessageType::cacheMessageData()
	 */
	public function cacheMessageData($messageIDs, $additionalData = null) {
		$entrySearchResultList = new EntrySearchResultList();
		$entrySearchResultList->sqlLimit = 0;
		$entrySearchResultList->sqlConditions = "entry.entryID IN (".$messageIDs.")";
		$entrySearchResultList->readObjects();
		$entrySearchResultObjects = $entrySearchResultList->getObjects();
		
		foreach ($entrySearchResultObjects as $entrySearchResult) {
			$this->messageCache[$entrySearchResult->entryID] = array(
				'type' => 'entry',
				'message' => clone $entrySearchResult
			);
		}
	}
	
	/**
	 * @see SearchableMessageType::getMessageData()
	 */
	public function getMessageData($messageID, $additionalData = null) {
		if (isset($this->messageCache[$messageID])) return $this->messageCache[$messageID];
		
		return null;
	}
	
	/**
	 * @see SearchableMessageType::getConditions()
	 */
	public function getConditions($form = null) {
		// todo: build conditions
	}
	
	/**
	 * @see SearchableMessageType::getJoins()
	 */
	public function getJoins() {
		return ", wcf".WCF_N."_cheat_database_entry cheatDatabase_entry";
	}
	
	/**
	 * @see SearchableMessageType::getTableName()
	 */
	public function getTableName() {
		return "wcf".WCF_N."_cheat_database_entry_message";
	}
	
	/**
	 * @see	SearchableMessageType::getIDFieldName();
	 */
	public function getIDFieldName() {
		return 'entryID';
	}
	
	/**
	 * @see SearchableMessageType::isAccessible()
	 */
	public function isAccessible() {
		return (MODULE_CHEAT_DATABASE && WCF::getUser()->getPermission('user.cheatDatabase.canUseCheatDatabase'));
	}
	
	/**
	 * @see SearchableMessageType::getFormTemplateName()
	 */
	public function getFormTemplateName() {
		return 'searchEntry';
	}
	
	/**
	 * @see SearchableMessageType::getResultTemplateName()
	 */
	public function getResultTemplateName() {
		return 'searchResultEntry';
	}
	
	/**
	 * @see	SearchableMessageType::show()
	 */
	public function show($form = null) {
		if ($form !== null && isset($form->searchData['additionalData']['entry'])) {
			// todo: get existing values
		}
		
		// todo: assign data
		WCF::getTPL()->assign(array());
	}
	
	protected function getSearchData($form = null) {
		// $searchData = array();
		
		// get existing values
		if ($form !== null && isset($form->searchData['additionalData']['entry'])) {
			
		}
	}
}
