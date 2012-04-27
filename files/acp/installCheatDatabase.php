<?php
// wcf imports
require_once(WCF_DIR.'lib/data/style/StyleEditor.class.php');

/**
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.pokemon.cheatdatabase.core
 * @category 	Cheat Database
 */
$sql = "SELECT	styleID
	FROM	wcf".WCF_N."_style";
$result = WCF::getDB()->sendQuery($sql);
while ($row = WCF::getDB()->fetchArray($result)) {
	$style = new StyleEditor($row['styleID']);
	$style->writeStyleFile();
}
