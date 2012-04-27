{include file='documentHeader'}
<head>
	<title>{$entry->subject} - {lang}wcf.cheatDatabase.title{/lang} - {PAGE_TITLE}</title>
	{include file='headInclude' sandbox=false}
	<script type="text/javascript">
		//<![CDATA[
		var INLINE_IMAGE_MAX_WIDTH = {@INLINE_IMAGE_MAX_WIDTH}; 
		//]]>
	</script>
	<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/ImageResizer.class.js"></script>
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
			<img src="{icon}cheatDatabaseEntryL.png{/icon}" alt="" />
			<div class="headlineContainer">
				<h2><a href="index.php?page=CheatDatabaseEntry&amp;entryID={@$entry->entryID}{@SID_ARG_2ND}">{$entry->subject}</a></h2>
			</div>
		</div>
		
		{if $userMessages|isset}{@$userMessages}{/if}
		
		<div class="contentHeader">
			{if $additionalLargeButtons|isset}
				<div class="largeButtons">
					<ul>
						{if $additionalLargeButtons|isset}{@$additionalLargeButtons}{/if}
					</ul>
				</div>
			{/if}
		</div>
		
		{capture assign='messageFooterClass'}messageFooter{@$this->getStyle()->getVariable('messages.footer.alignment')|ucfirst}{/capture}
		
		<div id="entry{$entry->entryID}" class="message cheatDatabaseEntry">
			<div class="messageInner container-1">
				<a id="entryMessage{@$entry->messageID}"></a>
				
				<div class="messageHeader">
					<div class="containerIcon">
						{if $entry->getUser()->getAvatar()}
							{assign var=x value=$entry->getUser()->getAvatar()->setMaxSize(24, 24)}
							{if $entry->userID}<a href="index.php?page=User&amp;userID={@$entry->userID}{@SID_ARG_2ND}" title="{lang username=$entry->username}wcf.user.viewProfile{/lang}">{/if}{@$entry->getUser()->getAvatar()}{if $entry->userID}</a>{/if}
						{else}
							{if $entry->userID}<a href="index.php?page=User&amp;userID={@$entry->userID}{@SID_ARG_2ND}" title="{lang username=$entry->username}wcf.user.viewProfile{/lang}">{/if}<img src="{@RELATIVE_WCF_DIR}images/avatars/avatar-default.png" alt="" style="width: 24px; height: 24px" />{if $entry->userID}</a>{/if}
						{/if}
					</div>
					
					<div class="containerContent">
						<p class="smallFont light">{@$entry->message->time|time}</p>
						<p class="smallFont light">{lang}wcf.cheatDatabase.entry.by{/lang} {if $entry->userID}<a href="index.php?page=User&amp;userID={@$entry->userID}{@SID_ARG_2ND}">{$entry->username}</a>{else}{$entry->username}{/if}</p>
					</div>
				</div>
				
				<h3 class="messageSubject" id="entrySubject{@$entry->messageID}"><span>{$entry->message->subject}</span></h3>
				
				<div class="messageContent">
					{include file='cheatDatabaseEntrySidebar'}
					{include file='cheatDatabaseEntryDetails'}
					
					{if $entry->message->getFormattedMessage() != ''}		
						<div class="messageBody" id="messageText{@$entry->messageID}">
							{@$entry->message->getFormattedMessage()}
						</div>
					{/if}
				</div>
				
				<div class="{@$messageFooterClass}">
					<div class="smallButtons">
						<ul>
							<li class="extraButton"><a href="#top" title="{lang}wcf.global.scrollUp{/lang}"><img src="{icon}upS.png{/icon}" alt="{lang}wcf.global.scrollUp{/lang}" /> <span class="hidden">{lang}wcf.global.scrollUp{/lang}</span></a></li>
							{if $this->user->getPermission('mod.cheatDatabase.canDeleteEntry')}<li><a onclick="return confirm('{lang}wcf.cheatDatabase.entry.delete.sure{/lang}')" href="index.php?action=CheatDatabaseEntryDelete&amp;entryID={@$entry->entryID}&amp;t={@SECURITY_TOKEN}{@SID_ARG_2ND}"><img src="{icon}deleteS.png{/icon}" alt="" title="{lang}wcf.cheatDatabase.entry.delete.sure{/lang}" /> <span>{lang}wcf.cheatDatabase.entry.delete{/lang}</span></a>{/if}
							{if $this->user->getPermission('mod.cheatDatabase.canEditEntry')}<li><a href="index.php?form=CheatDatabaseEntryEdit&amp;entryID={@$entry->entryID}{@SID_ARG_2ND}" title="{lang}wcf.cheatDatabase.entry.edit{/lang}"><img src="{icon}editS.png{/icon}" alt="" /> <span>{lang}wcf.cheatDatabase.entry.edit{/lang}</span></a></li>{/if}
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="contentFooter">
			{if $additionalLargeButtons|isset}
				<div class="largeButtons">
					<ul>
						{if $additionalLargeButtons|isset}{@$additionalLargeButtons}{/if}
					</ul>
				</div>
			{/if}
		</div>
	</div>
</div>

{include file='footer' sandbox=false}
</body>
</html>
