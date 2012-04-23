{include file='documentHeader'}
<head>
	<title>{lang}wcf.cheatDatabase.title{/lang} - {PAGE_TITLE}
	{include file='headInclude' sandbox=false}
	<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/MultiPagesLinks.class.js"></script>
</head>
<body{if $templateName|isset} id="tpl{$templateName|ucfirst}"{/if}>
{* --- quick search controls --- *}
{assign var='searchFieldTitle' value='{lang}wcf.cheatDatabase.entry.search.query{/lang}'}
{capture assign=searchHiddenFields}
	<input type="hidden" name="types[]" value="event" />
{/capture}
{* --- end --- *}
{include file='header' sandbox=false}

<div id="main">
	
	{include file='cheatDatabaseBreadCrumbs'}
	
	<div class="mainHeadline">
		<img src="{icon}cheatDatabaseL.png{/icon}" alt="" />
		<div class="headlineContainer">
			<h2>{lang}wcf.cheatDatabase.title{/lang}</h2>
		</div>
	</div>

	{if $userMessages|isset}{@$userMessages}{/if}
	
	{if $deletedEntryID}
		<p class="success">{lang}wcf.cheatDatabase.entry.delete.success{/lang}</p>	
	{/if}

	{if $entries|count == 0}
		<div class="border content">
			<div class="container-1">
				<p>{lang}wcf.cheatDatabase.entry.count.noEntries{/lang}</p>
			</div>
		</div>
	{else}
		<div class="border titleBarPanel">
			<div class="containerHead"><h3>{lang}wcf.cheatDatabase.entry.count{/lang}</h3></div>
		</div>
		<div class="border borderMarginRemove">
			<table class="tableList">
				<thead>
					<tr class="tableHead">
						<th class="columnNumber{if $sortField == 'number'} active{/if}"{if $this->user->getPermission('mod.cheatDatabase.canDeleteEntry')} colspan="2"{/if}>
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=number&amp;sortOrder={if $sortField == 'bumber' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.number{/lang}{if $sortField == 'topic'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnPokemon{if $sortField == 'pokemon'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=pokemon&amp;sortOrder={if $sortField == 'pokemon' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.pokemon{/lang}{if $sortField == 'topic'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnNickname{if $sortField == 'nickname'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=nickname&amp;sortOrder={if $sortField == 'nickname' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.nickname{/lang}{if $sortField == 'topic'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnTrainerName{if $sortField == 'trainerName'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=trainerName&amp;sortOrder={if $sortField == 'trainerName' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.trainerName{/lang}{if $sortField == 'topic'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnTrainerID{if $sortField == 'trainerID'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=trainerID&amp;sortOrder={if $sortField == 'trainerID' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.trainerID{/lang}{if $sortField == 'topic'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnLevel{if $sortField == 'level'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=level&amp;sortOrder={if $sortField == 'level' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.level{/lang}{if $sortField == 'topic'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						
						{if $additionalColumns|isset}{@$additionalColumns}{/if}
					</tr>
				</thead>
				<tbody>
					{cycle values='container-1,container-2' name='className' print=false advance=false}
					{foreach from=$entries item=$entry}
						<tr class="{cycle name='className'}" id="entryRow{@$entry->entryID}">
							{if $this->user->getPermission('mod.cheatDatabase.canDeleteEntry')}
								<td class="columnIcon">
									<a onclick="return confirm('{lang}wcf.cheatDatabase.entry.delete.sure{/lang}')" href="index.php?action=EntryDelete&amp;entryID={@$entry->entryID}&amp;t={@SECURITY_TOKEN}{@SID_ARG_2ND}"><img src="{icon}deleteS.png{/icon}" alt="" title="{lang}wcf.cheatDatabase.entry.delete.sure{/lang}" /></a>
								</td>
							{/if}
							<td class="columnNumber columnNumbers">
								{$entry->pokedexNumber}
							</td>
							<td class="columnPokemon columnIcon">
								<img src="{@$entry->getSpritePath()}" alt="" /><br />
								<span>{$entry->name}</span>
							</td>
							<td class="columnNickname columnText">
								{$entry->nickname}
							</td>
							<td class="columnTrainerName columnText">
								{$entry->trainerName}
							</td>
							<td class="columnTrainerID columnNumbers">
								{$entry->trainerID}
							</td>
							<td class="columnLevel columnNumbers">
								{$entry->level}
							</td>
							
							{if $entry->additionalColumns|isset}{@$entry->additionalColumns}{/if}
						</tr>
					{/foreach}
				</tbody>
			</table>
		</div>
	{/if}
	
	<div class="contentFooter">
		{pages print=true link="index.php?page=CheatDatabaseEntryList&pageNo=%d&sortField=$sortField&sortOrder=$sortOrder|concat:SID_ARG_2ND_NOT_ENCODED}
		
		<div class="largeButtons">
			<ul>
				<li><a href="index.php?form=CheatDatabaseEntryAdd{@SID_ARG_2ND}" title="{lang}wcf.cheatDatabase.entry.add{/lang}"><img src="{icon}cheatDatabaseEntryAddM.png{/icon}" alt="" /> <span>{lang}wcf.cheatDatabase.entry.add{/lang}</span></a></li>
				{if $additionalLargeButtons|isset}{@$additionalLargeButtons}{/if}
			</ul>
		</div>
	</div>
</div>

{include file='footer' sandbox=false}
</body>
</html>
