{include file='documentHeader'}
<head>
	<title>{$entry->subject} - {lang}wcf.cheatDatabase.title{/lang} - {PAGE_TITLE}</title>
	{include file='headInclude' sandbox=false}
	{include file='imageViewer'}
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
	
	{include file='cheatDatabaseBreadCrumbs'}
	
	<div class="mainHeadline">
		<img src="{icon}cheatDatabaseEntryL.png{/icon}" alt="" />
		<div class="headlineContainer">
			<h2>{$entry->subject}</h2>
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
	
	{capture assign='messageClass'}messageFramedLeft{if $this->getStyle()->getVariable('messages.sidebar.divider.use')} dividers{/if}{/capture}
	{capture assign='messageFooterClass'}messageFooter{@$this->getStyle()->getVariable('messages.footer.alignment')|ucfirst}{/capture}
	
	<div id="entry{$entry->entryID}" class="message">
		<div class="{@$messageClass}">
			<a id="entryMessage{@$entry->messageID}"></a>
			<div class="messageContent">
				<div class="messageContentInner color-1">
					<div class="messageHeader">
						<div class="containerIcon">
							<img src="{icon}cheatDatabaseEntryM.png{/icon}" alt=""/>
						</div>
						
						<div class="containerContent">
							<p class="smallFont light">{@$entry->message->time|time}</p>
						</div>
					</div>
					
					<h3 id="entrySubject{@$entry->messageID}"><span>{$entry->message->subject}</span></h3>
					
					{include file='cheatDatabaseEntryDetails'}
					
					{if $entry->message->getFormattedMessage() != ''}		
						<div class="messageBody" id="messageText{@$entry->messageID}">
							{@$entry->message->getFormattedMessage()}
						</div>
					{/if}
					
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

{include file='footer' sandbox=false}
</body>
</html>
