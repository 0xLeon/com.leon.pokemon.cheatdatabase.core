<?php
// cheat databse imports
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/EntryList.class.php');
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/EntrySearchResult.class.php');

/**
 * Represents a search result list of cheat database entries.
 * 
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.pokemon.cheatdatabase.core
 * @subpackage	data.cheatDatabase.entry
 * @category 	Cheat Database
 */
class EntrySearchResultList extends EntryList {
	/**
	 * @see	EntryList::$objectClassName
	 */
	public $objectClassName = 'EntrySearchResult';
}