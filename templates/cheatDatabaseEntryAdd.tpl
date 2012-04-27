{include file='documentHeader'}
<head>
	<title>{lang}wcf.cheatDatabase.entry.add{/lang} - {lang}wcf.cheatDatabase.title{/lang} - {PAGE_TITLE}</title>
	{include file='headInclude' sandbox=false}
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
				<div class="containerHead">
					<h3>{lang}wcf.cheatDatabase.entry.preview{/lang}</h3>
				</div>
				<div class="message content cheatDatabaseEntry">
					<div class="messageInner container-1">
						{if $subject}<h3 class="messageSubject" ><span>{$subject}</span></h3>{/if}
						
						<div class="messageContent">
							{include file='cheatDatabaseEntrySidebar'}
							{include file='cheatDatabaseEntryDetails'}
							
							<div class="messageBody">
								{@$preview}
							</div>
						</div>
					</div>
				</div>
			</div>
		{/if}
		
		<form enctype="multipart/form-data" method="post" action="index.php?form=CheatDatabaseEntry{$action|ucfirst}{if $entryID}&amp;entryID={@$entryID}{/if}">
			<div class="border content">
				<div class="container-1">
					
					
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
