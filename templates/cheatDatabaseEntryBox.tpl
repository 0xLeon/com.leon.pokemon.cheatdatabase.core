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
				<p class="smallFont light">{lang userID=$entry->userID username=$entry->username}wcf.cheatDatabase.entry.by{/lang}</p>
			</div>
		</div>
		
		<h3 class="messageSubject" id="entrySubject{@$entry->messageID}"><span>{$entry->message->subject}</span></h3>
		
		<div class="messageContent">
			<div class="cheatDatabaseEntrySidebar">
				<p class="skipSidebar hidden"><a href="#skipPoint{@$entry->messageID}" title="{lang}wcf.message.pokemonSidebar.skip{/lang}">{lang}wcf.message.pokemonSidebar.skip{/lang}</a></p>
				<div class="pokemon">
					<p class="pokemonName">#{'%03d'|sprintf:$entry->pokedexNumber}: <strong>{$entry->pokemonName}</strong></p>
					<p class="nickname">{$entry->nickname}</p>
					
					{if $additionalPokemonSidebarInformation[$entry->messageID]|isset}{@$additionalPokemonSidebarInformation[$entry->messageID]}{/if}
				</div>
				
				<div class="entrySprite">
					<img src="{$entry->getSpritePath()}" alt="" style="width: 96px; height: 96px;" />
				</div>
				
				<div class="entrySymbols">
					<ul>
						<li><img src="{$entry->getBallIconPath()}" alt="{$entry->ballName}" title="{$entry->ballName}" /></li>
						{if $entry->gender > 0}<li><img src="{if $entry->gender == 1}{icon}genderMaleS.png{/icon}{else}{icon}genderFemaleS.png{/icon}{/if}" alt="" title="" /></li>{/if}
					</ul>
				</div>
				
				<div class="entryCredits">
					{if $entry->level != 0}<p><a href="">{lang}wcf.cheatDatabase.entry.level{/lang}: {$entry->level}</a></p>{/if}
					{if $entry->trainerName != ''}<p><a href="">{lang}wcf.cheatDatabase.entry.trainerName{/lang}: {$entry->trainerName}</a></p>{/if}
					{if $entry->trainerID !== ''}<p><a href="">{lang}wcf.cheatDatabase.entry.trainerID{/lang}: {'%05d'|sprintf:$entry->trainerID}</a></p>{/if}
				</div>
				
				<div class="entryRibbons">
					<ul>
						{foreach from=$entry->getRibbons() item=$ribbon}
							<li><img src="{$ribbon->getIconPath()}" alt="{$ribbon->ribbonName}" title="{$ribbon->ribbonName}" /></li>
						{/foreach}
					</ul>
				</div>
			</div>
			
			<div class="entryDetails">
				{if $entry->nature != 0}
					<div class="formElement">
						<p class="formFieldLabel">{lang}wcf.cheatDatabase.entry.nature.title{/lang}</p>
						<p class="formField">{lang}wcf.cheatDatabase.entry.nature.{@$entry->nature}{/lang}</p>
					</div>
				{/if}
				
				{if $entry->characteristic != 0}
					<div class="formElement">
						<p class="formFieldLabel">{lang}wcf.cheatDatabase.entry.characteristic.title{/lang}</p>
						<p class="formField">{lang}wcf.cheatDatabase.entry.characteristic.{@$entry->characteristic}{/lang}</p>
					</div>
				{/if}
				
				{if $entry->catchLocation != ''}
					<div class="formElement">
						<p class="formFieldLabel">{lang}wcf.cheatDatabase.entry.catchLocation{/lang}</p>
						<p class="formField">{$entry->catchLocation}</p>
					</div>
				{/if}
				
				{if $entry->catchDate != 0}
					<div class="formElement">
						<p class="formFieldLabel">{lang}wcf.cheatDatabase.entry.catchDate{/lang}</p>
						<p class="formField">{$entry->catchDate|date}</p>
					</div>
				{/if}
				
				{if $entry->catchLevel != 0}
					<div class="formElement">
						<p class="formFieldLabel">{lang}wcf.cheatDatabase.entry.catchLevel{/lang}</p>
						<p class="formField">{$entry->catchLevel}</p>
					</div>
				{/if}
			</div>
			
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