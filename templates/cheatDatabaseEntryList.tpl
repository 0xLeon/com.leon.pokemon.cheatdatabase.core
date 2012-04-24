{include file='documentHeader'}
<head>
	<title>{lang}wcf.cheatDatabase.title{/lang} - {PAGE_TITLE}</title>
	{include file='headInclude' sandbox=false}
	<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/MultiPagesLinks.class.js"></script>
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
		<img src="{icon}cheatDatabaseL.png{/icon}" alt="" />
		<div class="headlineContainer">
			<h2>{lang}wcf.cheatDatabase.title{/lang}</h2>
		</div>
	</div>

	{if $userMessages|isset}{@$userMessages}{/if}
	
	{if $deletedEntryID}
		<p class="success">{lang}wcf.cheatDatabase.entry.delete.success{/lang}</p>	
	{/if}
	
	<div class="contentHeader">
		{pages print=true assign=pagesLinks link="index.php?page=CheatDatabaseEntryList&pageNo=%d&sortField=$sortField&sortOrder=$sortOrder"|concat:SID_ARG_2ND_NOT_ENCODED}
		
		<div class="largeButtons">
			<ul>
				{if $this->user->getPermission('mod.cheatDatabase.canAddEntry')}<li><a href="index.php?form=CheatDatabaseEntryAdd{@SID_ARG_2ND}" title="{lang}wcf.cheatDatabase.entry.add{/lang}"><img src="{icon}cheatDatabaseEntryAddM.png{/icon}" alt="" /> <span>{lang}wcf.cheatDatabase.entry.add{/lang}</span></a></li>{/if}
				{if $additionalLargeButtons|isset}{@$additionalLargeButtons}{/if}
			</ul>
		</div>
	</div>

	{if $entries|count == 0}
		<div class="border content">
			<div class="container-1">
				<p>{lang}wcf.cheatDatabase.entry.count.noEntries{/lang}</p>
			</div>
		</div>
	{else}
		<div class="border titleBarPanel">
			<div class="containerHead"><h3>{lang items=$entries|count}wcf.cheatDatabase.entry.count{/lang}</h3></div>
		</div>
		<div class="border borderMarginRemove">
			<table class="tableList">
				<thead>
					<tr class="tableHead">
						<th class="columnEntryID{if $sortField == 'entry.entryID'} active{/if}"{if $this->user->getPermission('mod.cheatDatabase.canDeleteEntry')} colspan="2"{/if}>
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=entryID&amp;sortOrder={if $sortField == 'entry.entryID' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.entryID{/lang}{if $sortField == 'entry.entryID'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnPokedexNumber{if $sortField == 'entry.pokedexNumber'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=pokedexNumber&amp;sortOrder={if $sortField == 'entry.pokedexNumber' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.pokedexNumber{/lang}{if $sortField == 'entry.pokedexNumber'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnPokemon{if $sortField == 'pokemonName'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=pokemon&amp;sortOrder={if $sortField == 'pokemonName' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.pokemon{/lang}{if $sortField == 'pokemonName'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnName{if $sortField == 'message.subject'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=name&amp;sortOrder={if $sortField == 'message.subject' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.name{/lang}{if $sortField == 'message.subject'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnNickname{if $sortField == 'entry.nickname'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=nickname&amp;sortOrder={if $sortField == 'entry.nickname' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.nickname{/lang}{if $sortField == 'entry.nickname'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnTrainerName{if $sortField == 'entry.trainerName'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=trainerName&amp;sortOrder={if $sortField == 'entry.trainerName' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.trainerName{/lang}{if $sortField == 'entry.trainerName'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnTrainerID{if $sortField == 'entry.trainerID'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=trainerID&amp;sortOrder={if $sortField == 'entry.trainerID' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.trainerID{/lang}{if $sortField == 'entry.trainerID'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
								</a>
							</div>
						</th>
						<th class="columnLevel{if $sortField == 'entry.level'} active{/if}">
							<div>
								<a href="index.php?page=CheatDatabaseEntryList&amp;pageNo={@$pageNo}&amp;sortField=level&amp;sortOrder={if $sortField == 'entry.level' && $sortOrder == 'DESC'}ASC{else}DESC{/if}{@SID_ARG_2ND}">
									{lang}wcf.cheatDatabase.entry.level{/lang}{if $sortField == 'entry.level'} <img src="{icon}sort{@$sortOrder}S.png{/icon}" alt="" />{/if}
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
									<a onclick="return confirm('{lang}wcf.cheatDatabase.entry.delete.sure{/lang}')" href="index.php?action=CheatDatabaseEntryDelete&amp;entryID={@$entry->entryID}&amp;t={@SECURITY_TOKEN}{@SID_ARG_2ND}"><img src="{icon}deleteS.png{/icon}" alt="" title="{lang}wcf.cheatDatabase.entry.delete.sure{/lang}" /></a>
								</td>
							{/if}
							<td class="columnEntryID columnID">
								{$entry->entryID}
							</td>
							<td class="columnPokedexNumber columnID">
								{$entry->pokedexNumber}
							</td>
							<td class="columnPokemon columnIcon">
								<a href="index.php?page=CheatDatabaseEntry&amp;entryID={@$entry->entryID}{@SID_ARG_2ND}"><img src="{@$entry->getIconPath()}" alt="{$entry->pokemonName}" title="{$entry->pokemonName}" /></a>
							</td>
							<td class="columnName columnText">
								<a href="index.php?page=CheatDatabaseEntry&amp;entryID={@$entry->entryID}{@SID_ARG_2ND}">{$entry->subject}</a>
							</td>
							<td class="columnNickname columnText">
								{$entry->nickname}
							</td>
							<td class="columnTrainerName columnText">
								{$entry->trainerName}
							</td>
							<td class="columnTrainerID columnNumbers">
								{'%05d'|sprintf:$entry->trainerID}
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
		{@$pagesLinks}
		
		<div class="largeButtons">
			<ul>
				{if $this->user->getPermission('mod.cheatDatabase.canAddEntry')}<li><a href="index.php?form=CheatDatabaseEntryAdd{@SID_ARG_2ND}" title="{lang}wcf.cheatDatabase.entry.add{/lang}"><img src="{icon}cheatDatabaseEntryAddM.png{/icon}" alt="" /> <span>{lang}wcf.cheatDatabase.entry.add{/lang}</span></a></li>{/if}
				{if $additionalLargeButtons|isset}{@$additionalLargeButtons}{/if}
			</ul>
		</div>
	</div>
</div>

{include file='footer' sandbox=false}
</body>
</html>
