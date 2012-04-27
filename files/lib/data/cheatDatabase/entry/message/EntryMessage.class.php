<?php
// wcf imports
require_once(WCF_DIR.'lib/data/message/Message.class.php');
require_once(WCF_DIR.'lib/data/message/bbcode/MessageParser.class.php');
require_once(WCF_DIR.'lib/data/message/sidebar/MessageSidebarObject.class.php');
require_once(WCF_DIR.'lib/data/user/UserProfile.class.php');

/**
 * Represents an entry message in the cheat database.
 *
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.pokemon.cheatdatabase.core
 * @subpackage	data.cheatDatabase.entry.message
 * @category 	Cheat Database
 */
class EntryMessage extends Message implements MessageSidebarObject {
	/**
	 * Creates a new entry message object.
	 *
	 * @param 	integer 	$messageID
	 * @param 	array 		$row
	 */
	public function __construct($messageID, $row = null) {
		if ($messageID !== null) {
			$sql = "SELECT		message.*
				FROM 		wcf".WCF_N."_cheat_database_entry_message message
				WHERE 		message.messageID = ".$messageID;
			$row = WCF::getDB()->getFirstRow($sql);
		}
		parent::__construct($row);
		$this->messageID = $row['messageID'];
	}
	
	/**
	 * @see DatabaseObject::handleData()
	 */
	protected function handleData($data) {
		parent::handleData($data);
		$this->user = new UserProfile($this->userID);
	}
	
	/**
	 * Returns the text of this message.
	 *
	 * @return 	string
	 */
	public function getFormattedMessage() {
		// parse message
		$parser = MessageParser::getInstance();
		$parser->setOutputType('text/html');
		return $parser->parse($this->message, $this->enableSmilies, $this->enableHtml, $this->enableBBCodes, !$this->messagePreview);
	}
	
	/**
	 * Returns the user object of this message.
	 *
	 * @return 	UserProfile
	 */
	public function getUser() {
		return $this->user;
	}
	
	/**
	 * Get editor object of this message
	 *
	 * @return	EntryMessageEditor
	 */
	public function getEditor() {
		require_once (WCF_DIR.'lib/data/cheatDatabase/entry/message/EntryMessageEditor.class.php');
		return new EntryMessageEditor(null, $this->data);
	}
	
	/**
	 * @see MessageSidebarObject::getMessageID()
	 */
	public function getMessageID() {
		return $this->messageID;
	}
	
	/**
	 * @see MessageSidebarObject::getMessageType()
	 */
	public function getMessageType() {
		return 'entryMessage';
	}
}
