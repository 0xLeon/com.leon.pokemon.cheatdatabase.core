{include file='documentHeader'}
<head>
	<title>{lang}wcf.cheatDatabase.entry.{$action}{/lang} - {lang}wcf.cheatDatabase.title{/lang} - {PAGE_TITLE}</title>
	{include file='headInclude' sandbox=false}
	
	<script src="{@RELATIVE_WCF_DIR}js/Calendar.class.js" type="text/javascript"></script>
	<script type="text/javascript">
		//<![CDATA[
		var calendar = new Calendar('{$monthList}', '{$weekdayList}', {@$startOfWeek});
		//]]>
	</script>
	<script type="text/javascript">
		//<![CDATA[
		var INLINE_IMAGE_MAX_WIDTH = {@INLINE_IMAGE_MAX_WIDTH}; 
		//]]>
	</script>
	<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/ImageResizer.class.js"></script>
	<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/TabbedPane.class.js"></script>
	<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/ToggleButtonList.class.js"></script>
	{if $canUseBBCodes}{include file="wysiwyg"}{/if}
</head>
<body{if $templateName|isset} id="tpl{$templateName|ucfirst}"{/if}>
{* --- quick search controls --- *}
{assign var='searchFieldTitle' value='{lang}wcf.cheatDatabase.entry.search.query{/lang}'}
{capture assign=searchHiddenFields}
	<input type="hidden" name="types[]" value="entry" />
{/capture}
{* --- end --- *}
{include file='header' sandbox=false}

<div id="main">
	<div class="cheatDatabase">
		{include file='cheatDatabaseBreadCrumbs'}
		
		<div class="mainHeadline">
			<img src="{icon}cheatDatabaseEntry{$action|ucfirst}L.png{/icon}" alt="" />
			<div class="headlineContainer">
				<h2>{lang}wcf.cheatDatabase.entry.{$action}{/lang}</h2>
			</div>
		</div>
		
		{if $userMessages|isset}{@$userMessages}{/if}
		
		{if $errorField}
			<p class="error">{lang}wcf.global.form.error{/lang}</p>
		{/if}
		
		{if $preview|isset}
			<div class="border messagePreview">
				{include file='cheatDatabaseEntryBox'}
			</div>
		{/if}
		
		<form enctype="multipart/form-data" method="post" action="index.php?form=CheatDatabaseEntry{$action|ucfirst}{if $entryID}&amp;entryID={@$entryID}{/if}">
			<div class="border content">
				<div class="container-1">
					<fieldset>
						<legend>{lang}wcf.cheatDatabase.entry.form.settings{/lang}</legend>
						
						{if !$this->user->userID}
							<div class="formElement{if $errorField == 'username'} formError{/if}">
								<div class="formFieldLabel">
									<label for="username">{lang}wcf.user.username{/lang}</label>
								</div>
								<div class="formField">
									<input type="text" class="inputText" name="username" id="username" value="{$username}" tabindex="13" />
									{if $errorField == 'username'}
										<p class="innerError">
											{if $errorType == 'empty'}{lang}wcf.global.error.empty{/lang}{/if}
											{if $errorType == 'notValid'}{lang}wcf.user.error.username.notValid{/lang}{/if}
											{if $errorType == 'notAvailable'}{lang}wcf.user.error.username.notUnique{/lang}{/if}
										</p>
									{/if}
								</div>
							</div>
						{/if}
						
						<div class="formElement{if $errorField == 'subject'} formError{/if}">
							<label class="formFieldLabel" for="subject">{lang}wcf.cheatDatabase.entry.form.name{/lang}</label>
							<div class="formField">
								<input type="text" id="subject" name="subject" class="inputText" value="{$subject}" />
								{if $errorField == 'subject'}
									<p class="innerError">
										{if $errorType == 'empty'}{lang}wcf.global.error.empty{/lang}{/if}
										{if $errorType == 'notValid'}{lang}wcf.cheatDatabase.entry.form.error.name.notValid{/lang}{/if}
									</p>
								{/if}
							</div>
						</div>
					</fieldset>
					
					<fieldset>
						<legend>{lang}wcf.cheatDatabase.entry.form.other{/lang}</legend>
						
						<div class="formElement{if $errorField == 'ribbons'} formError{/if}">
							<div class="formFieldLabel">{lang}wcf.cheatDatabase.entry.form.ribbons{/lang}</div>
							<div class="formField">
								<div id="ribbonIDsToggleButtonList" class="toggleButtonList">
									<ul>
										{foreach from=$ribbons key=key item=ribbon}
											<li class="toggleButtonListListElement"><label title="{$ribbon->ribbonName}" class="toggleButtonListLabel"><input type="checkbox" class="toggleButtonListCheckbox" name="ribbonIDs[]" value="{$ribbon->ribbonID}"{if $ribbon->ribbonID|in_array:$ribbonIDs} checked="checked"{/if} /> <img src="{$ribbon->getIconPath()}" alt="" /></label></li>
										{/foreach}
									</ul>
								</div>
							</div>
						</div>
						
						<script type="text/javascript">
							//<![CDATA[
							onloadEvents.push(function() {
								new ToggleButtonList('ribbonIDsToggleButtonList');
							});
							//]]>
						</script>
					</fieldset>
					
					<fieldset>
						<legend>{lang}wcf.cheatDatabase.entry.form.description{/lang}</legend>
						
						<div id="descriptionSettings">
						
						<div class="editorFrame formElement{if $errorField == 'text'} formError{/if}" id="textDiv">
							<div class="formFieldLabel">
								<label for="text">{lang}wcf.cheatDatabase.entry.form.description{/lang}</label>
							</div>
							<div class="formField">				
								<textarea name="text" id="text" rows="15" cols="40" tabindex="15">{$text}</textarea>
								{if $errorField == 'text'}
									<p class="innerError">
										{if $errorType == 'empty'}{lang}wcf.global.error.empty{/lang}{/if}
										{if $errorType == 'tooLong'}{lang}wcf.message.error.tooLong{/lang}{/if}
										{if $errorType == 'censoredWordsFound'}{lang}wcf.message.error.censoredWordsFound{/lang}{/if}
									</p>
								{/if}
							</div>
							
						</div>
						
						{include file='messageFormTabs'}
					</fieldset>
					
					{if $additionalFields|isset}{@$additionalFields}{/if}
				</div>
			</div>
			
			<div class="formSubmit">
				<input type="submit" name="send" accesskey="s" value="{lang}wcf.global.button.submit{/lang}" />
				<input type="submit" name="preview" accesskey="p" value="{lang}wcf.global.button.preview{/lang}" />
				<input type="reset" name="reset" accesskey="r" value="{lang}wcf.global.button.reset{/lang}" />
				{@SID_INPUT_TAG}
			</div>
		</form>
	</div>
</div>

{include file='footer' sandbox=false}
</body>
</html>
