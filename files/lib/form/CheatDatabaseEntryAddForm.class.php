<?php
// wcf imports
require_once(WCF_DIR.'lib/form/MessageForm.class.php');
require_once(WCF_DIR.'lib/page/util/InlineCalendar.class.php');
require_once(WCF_DIR.'lib/page/util/menu/PageMenu.class.php');

// cheat database imports
require_once(WCF_DIR.'lib/data/cheatDatabase/entry/EntryEditor.class.php');

/**
 * Shows the cheat database entry add form.
 *
 * @author	Stefan Hahn
 * @copyright	2012 Stefan Hahn
 * @license	Simplified BSD License License <http://projects.swallow-all-lies.com/licenses/simplified-bsd-license.txt>
 * @package	com.leon.cheatdatabase.core
 * @subpackage	form
 * @category 	Cheat Database
 */
class CheatDatabaseEntryAddForm extends MessageForm {
	public $maxTextLength = 10000; // todo: via group option
	public $showPoll = false;
	public $showAttachments = false;
	public $showSignatureSetting = false;
	
	/**
	 * @see AbstractPage::$action
	 */
	public $action = 'add';
	
	/**
	 * @see AbstractPage::$templateName
	 */
	public $templateName = 'cheatDatabaseEntryAdd';
	
	/**
	 * @see AbstractPage::$neededPermissions
	 */
	public $neededPermissions = 'mod.cheatDatabase.canAddEntry';
	
	/**
	 * Form buttons for preview mode and send mode
	 *
	 * @var boolean
	 */
	public $preview, $send;
	
	/**
	 * Current entry object
	 *
	 * @var EntryEditor
	 */
	public $entry = null;

	/**
	 * current entry id
	 *
	 * @var integer
	 */
	public $entryID = 0;
	
	/**
	 * Name of user
	 *
	 * @var string
	 */
	public $username = '';
	
	/**
	 * Pokedex number
	 * 
	 * @var	integer
	 */
	public $pokedexNumber = 0;
	
	/**
	 * Pokemon nickname
	 * 
	 * @var	string
	 */
	public $nickname = '';
	
	/**
	 * Pokemon gender
	 * 
	 * @var	integer
	 */
	public $gender = 0;
	
	/**
	 * Pokemon original trainer name
	 * 
	 * @var	string
	 */
	public $trainerName = '';
	
	/**
	 * Pokemon original trainer id
	 * 
	 * @var	integer
	 */
	public $trainerID = 0;
	
	/**
	 * Pokemon level
	 * 
	 * @var	integer
	 */
	public $level = 0;
	
	/**
	 * Pokemon catch location
	 * 
	 * @var	string
	 */
	public $catchLocation = '';
	
	/**
	 * Pokemon catch date
	 * 
	 * @var	integer
	 */
	public $catchDate = 0;
	
	/**
	 * Pokemon catch level
	 * 
	 * @var	integer
	 */
	public $catchLevel = 0;
	
	/**
	 * Pokemon nature
	 * 
	 * @var	integer
	 */
	public $nature = 0;
	
	/**
	 * Pokemon characteristic
	 * 
	 * @var	integer
	 */
	public $characteristic = 0;
	
	/**
	 * Pokemon shiny status
	 * 
	 * @var	boolean
	 */
	public $isShiny = false;
	
	/**
	 * Pokemon ball
	 * 
	 * @var	integer
	 */
	public $ball = 0;
	
	
	/**
	 * @see Form::readFormParameters()
	 */
	public function readFormParameters() {
		parent::readFormParameters();
		
		if (isset($_POST['username'])) $this->username = StringUtil::trim($_POST['username']);
		if (isset($_POST['preview'])) $this->preview = (boolean)intval($_POST['preview']);
		if (isset($_POST['send'])) $this->send = (boolean)intval($_POST['send']);
		if (isset($_POST['pokedexNumber'])) $this->pokedexNumber = intval($_POST['pokedexNumber']);
		if (isset($_POST['nickname'])) $this->nickname = StringUtil::trim($_POST['nickname']);
		if (isset($_POST['gender'])) $this->gender = intval($_POST['gender']);
		if (isset($_POST['trainerName'])) $this->trainerName = StringUtil::trim($_POST['trainerName']);
		if (isset($_POST['trainerID'])) $this->trainerID = intval($_POST['trainerID']);
		if (isset($_POST['level'])) $this->level = intval($_POST['level']);
		if (isset($_POST['catchLocation'])) $this->catchLocation = StringUtil::trim($_POST['catchLocation']);
		if (isset($_POST['catchDate'])) $this->catchDate = intval($_POST['catchDate']);
		if (isset($_POST['catchLevel'])) $this->catchLevel = intval($_POST['catchLevel']);
		if (isset($_POST['nature'])) $this->nature = intval($_POST['nature']);
		if (isset($_POST['characteristic'])) $this->characteristic = intval($_POST['characteristic']);
		if (isset($_POST['isShiny'])) $this->isShiny = (boolean)intval($_POST['isShiny']);
		if (isset($_POST['ball'])) $this->ball = intval($_POST['ball']);
		
		// todo: ribbons
	}
	
	/**
	 * @see Form::submit()
	 */
	public function submit() {
		EventHandler::fireAction($this, 'submit');
		
		$this->readFormParameters();
		
		try {
			if ($this->preview) {
				//WCF::getTPL()->assign('preview', EventEditor::createPreview());
			}
			
			if ($this->send) {
				$this->validate();
				$this->save();
			}
		} catch (UserInputException $e) {
			$this->errorField = $e->getField();
			$this->errorType = $e->getType();
		}
	}
	
	/**
	 * @see Page::readData()
	 */
	public function readData() {
		parent::readData();
		
		if (!count($_POST) && ($this->entryID == 0)) {
			$this->username = WCF::getSession()->username;
		}
	}
	
	/**
	 * @see Form::save()
	 */
	public function save() {
		parent::save();
		
		//$this->entry = EntryEditor::create();
		
		$this->saved();
		
		HeaderUtil::redirect('index.php?page=CheatDatabaseEntry&entryID='.$this->entry->entryID.SID_ARG_2ND_NOT_ENCODED);
		exit;
	}
	
	/**
	 * @see	Page::assignVariables()
	 */
	public function assignVariables() {
		parent::assignVariables();
		InlineCalendar::assignVariables();
		
		WCF::getTPL()->assign(array(
			'showEntryForm' => true,
			'entryID' => $this->entryID,
			'username' => $this->username,
			'pokedexNumber' => $this->pokedexNumber,
			'nickname' => $this->nickname,
			'gender' => $this->gender,
			'trainerName' => $this->trainerName,
			'trainerID' => $this->trainerID,
			'level' => $this->level,
			'catchLocation' => $this->catchLocation,
			'catchDate' => $this->catchDate,
			'catchLevel' => $this->catchLevel,
			'nature' => $this->nature,
			'characteristic' => $this->characteristic,
			'isShiny' => $this->isShiny,
			'ball' => $this->ball
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
		
		$this->messageTable = "wcf".WCF_N."_cheat_database_entry_message";
		
		parent::show();
	}
	
	/**
	 * @see MessageForm::validateText()
	 */
	protected function validateText() {
		try {
			parent::validateText();
		}
		catch (UserInputException $e) {
			if ($e->getType() !== 'empty') throw $e;
		}
	}
	
	/**
	 * Validates the username
	 */
	protected function validateUsername() {
		if (!WCF::getUser()->userID) {
			if (empty($this->username)) {
				throw new UserInputException('username');
			}
			
			if (!UserUtil::isValidUsername($this->username)) {
				throw new UserInputException('username', 'notValid');
			}
			
			if (!UserUtil::isAvailableUsername($this->username)) {
				throw new UserInputException('username', 'notAvailable');
			}
			
			WCF::getSession()->setUsername($this->username);
		} 
		else {
			$this->username = WCF::getUser()->username;
		}
	}
}
