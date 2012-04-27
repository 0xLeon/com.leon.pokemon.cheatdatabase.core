<ul class="breadCrumbs">
	<li><a href="index.php?page=Index{@SID_ARG_2ND}"><img src="{icon}indexS.png{/icon}" alt="" /> <span>{PAGE_TITLE}</span></a> &raquo;</li>
	<li><a href="index.php?page=CheatDatabaseEntryList{@SID_ARG_2ND}"><img src="{icon}cheatDatabaseS.png{/icon}" alt="" /> <span>{lang}wcf.cheatDatabase.title{/lang}</span></a> &raquo;</li>
	{if $entry|isset && $showEntryForm|isset}
		<li><a href="index.php?page=CheatDatabaseEntry&amp;entryID={@$entry->entryID}{@SID_ARG_2ND}"><img src="{icon}cheatDatabaseEntryS.png{/icon}" alt="" /> <span>{$entry->subject}</span></a> &raquo;</li>
	{/if}
</ul>
