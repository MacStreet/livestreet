{literal}
<script language="JavaScript" type="text/javascript">
    document.addEvent('domready', function() {
        new Autocompleter.Request.LS.JSON($('stream_users_complete'), aRouter['ajax']+'autocompleter/user/?security_ls_key='+LIVESTREET_SECURITY_KEY, {
            'indicatorClass': 'autocompleter-loading', // class added to the input during request
            'minLength': 1, // We need at least 1 character
            'selectMode': 'pick', // Instant completion
            'multiple': false, // Tag support, by default comma separated
        });
        $('stream_users_complete').addEvent('keydown', function (event) {
            if (event.key == 'enter') {
                lsStream.appendUser()
            }
        });
	});
</script>
{/literal}


<div class="block stream-settings">
	<h2>{$aLang.stream_block_config_title}</h2>
	
	<p class="sp-note">{$aLang.stream_settings_note_filter}</p>

<ul class="stream-settings-filter">
	{foreach from=$aStreamEventTypes key=sType item=aEventType}
		<li>
			<label>
				<input class="streamEventTypeCheckbox input-checkbox"
					type="checkbox"
					id="strn_et_{$sType}"
					{if in_array($sType, $aStreamTypesList)}checked="checked"{/if}
					onClick="if ($(this).get('checked')) { lsStream.switchEventType( '{$sType}') } else { lsStream.switchEventType( '{$sType}')  } " />
				{assign var=langKey value="stream_event_type_`$sType`"}
				{$aLang.$langKey}
			</label>
		</li>
	{/foreach}
</ul>
	
	
	<h3>{$aLang.stream_block_users_title}</h3>
	
	<p class="sp-note">{$aLang.stream_settings_note_follow_user}</p>
	
	<div class="stream-settings-userlist">
		<p><input type="text" id="stream_users_complete" autocomplete="off" />
		<a href="javascript:lsStream.appendUser()">{$aLang.stream_block_config_append}</a></p>
		{if count($aStreamSubscribedUsers)}
                        <ul id="userfeed_block_users_list">
                            {foreach from=$aStreamSubscribedUsers item=oUser}
                                {assign var=iUserId value=$oUser->getId()}
                                {if !isset($aStreamFriends.$iUserId)}
                                    <li><input class="streamUserCheckbox input-checkbox"
                                                type="checkbox"
                                                id="strm_u_{$iUserId}"
                                                checked="checked"
                                                onClick="if ($(this).get('checked')) { lsStream.subscribe({$iUserId}) } else { lsStream.unsubscribe({$iUserId}) } " />
                                        <a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>
                                    </li>
                                {/if}
                            {/foreach}
                        </ul>
                {else}
                    <ul id="stream_block_users_list"></ul>
                    <p id="stream_no_subscribed_users">{$aLang.stream_no_subscribed_users}</p>
                {/if}
	</div>
	
	
	{if count($aStreamFriends)}
		<h3>{$aLang.stream_block_users_friends}</h3>
		
		<p class="sp-note">{$aLang.stream_settings_note_follow_friend}</p>
		
		<ul class="stream-settings-friends">
			{foreach from=$aStreamFriends item=oUser}
				{assign var=iUserId value=$oUser->getId()}
				<li><input class="streamUserCheckbox input-checkbox"
							type="checkbox"
							id="strm_u_{$iUserId}"
							{if isset($aStreamSubscribedUsers.$iUserId)} checked="checked"{/if}
							onClick="if ($(this).get('checked')) { lsStream.subscribe({$iUserId}) } else { lsStream.unsubscribe({$iUserId}) } " />
					<a href="{$oUser->getUserWebPath()}">{$oUser->getLogin()}</a>
				</li>
			{/foreach}
		</ul>
	{/if}
</div>