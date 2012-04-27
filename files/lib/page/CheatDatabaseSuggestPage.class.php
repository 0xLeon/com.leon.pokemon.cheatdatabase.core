<?php
// wcf imports
require_once(WCF_DIR.'lib/page/AbstractPage.class.php');

/**
 * Outputs an XML document with a list of suggestions of given type.
 *
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.cheatdatabase.core
 * @subpackage	page
 * @category 	Cheat Database
 */
class CheatDatabaseSuggestPage extends AbstractPage {
	public $neededPermissions = 'user.cheatDatabase.canUseCheatDatabase';
	public $query = '';
	public $type = 'pokemon';
	public $languageID = 0;
	
	/**
	 * @see Page::readParameters()
	 */
	public function readParameters() {
		parent::readParameters();
		
		if (isset($_REQUEST['query'])) $this->query = StringUtil::trim($_REQUEST['query']);
		if (isset($_REQUEST['type'])) $this->type = StringUtil::trim($_REQUEST['type']);
		
		if (CHARSET != 'UTF-8') {
			$this->query = StringUtil::convertEncoding('UTF-8', CHARSET, $this->query);
			$this->type = StringUtil::convertEncoding('UTF-8', CHARSET, $this->type);
		}
	}
	
	/**
	 * @see Page::readData()
	 */
	public function readData() {
		if (count(Language::getAvailableContentLanguages(PACKAGE_ID)) > 0) {
			$this->languageID = WCF::getLanguage()->getLanguageID();
		}
	}
	
	/**
	 * @see Page::show()
	 */
	public function show() {
		
		if (!MODULE_CHEAT_DATABASE) {
			exit;
		}
		
		try {
			parent::show();
		}
		catch (Exception $e) {
			exit;
		}
		
		header('Content-type: text/xml');
		echo "<?xml version=\"1.0\" encoding=\"".CHARSET."\"?>\n<suggestions>\n";
		
		if (!empty($this->query)) {
			$sql = "SELECT		DISTINCT languageItem, languageItemValue
				FROM		wcf".WCF_N."_language_item
				WHERE		".($this->languageID ? "languageID = ".$this->languageID." AND" : '')."
						languageItem LIKE 'wcf.cheatDatabase.entry.".escapeString($this->type)."%' AND
						languageItemValue LIKE '".escapeString($this->query)."%'
				ORDER BY	languageItemValue";
			$result = WCF::getDB()->sendQuery($sql, 10);
			while ($row = WCF::getDB()->fetchArray($result)) {
				echo "\t<suggestion>\n\t\t<languageItem><![CDATA[".StringUtil::escapeCDATA($row['languageItem'])."]]></languageItem>\n\t\t<value><![CDATA[".StringUtil::escapeCDATA($row['languageItemValue'])."]]></value>\n\t</suggestion>\n";
			}
		}
		
		echo '</suggestions>';
		exit;
	}
}
