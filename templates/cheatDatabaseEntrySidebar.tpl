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
