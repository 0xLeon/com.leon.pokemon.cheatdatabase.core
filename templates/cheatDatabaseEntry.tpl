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
		
		{include file='cheatDatabaseEntryBox'}
		
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
