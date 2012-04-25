<div class="entryDetails"{if !$preview|isset && $entry|isset && $entry->message->getFormattedMessage() == ''} style="border-bottom: 0;"{/if}>
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
	
	{if $entry->catchDate != 0}
		<div class="formElement">
			<p class="formFieldLabel">{lang}wcf.cheatDatabase.entry.catchDate{/lang}</p>
			<p class="formField">{$entry->catchDate|time}</p>
		</div>
	{/if}
</div>
