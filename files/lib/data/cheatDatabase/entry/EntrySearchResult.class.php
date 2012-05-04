<?php
// wcf imports
require_once(WCF_DIR.'lib/data/message/util/SearchResultTextParser.class.php');

// cheat database imports
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/Entry.class.php');
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/message/EntryMessage.class.php');

/**
 * This class extends the entry by function for a search result output.
 *
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.pokemon.cheatdatabase.core
 * @subpackage	data.cheatDatabase.entry
 * @category 	Cheat Database
 */
class EntrySearchResult extends Entry {
	/**
	 * @see DatabaseObject::handleData()
	 */
	protected function handleData($data) {
		$data['messagePreview'] = true;
		parent::handleData($data);
	}
	
	/**
	 * @see EntryMessage::getFormattedMessage()
	 */
	public function getFormattedMessage() {
		return SearchResultTextParser::parse($this->message->getFormattedMessage());
	}
}
