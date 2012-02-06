[


	var('default_status' = get_column_default((var($listeratorAction + '_Table')), 'Display_Status')); // we assume that the first option is what you want




	/*	var('option' = get_set_options((var($listeratorAction + '_Table')), 'Display_Status')->first); // we assume that the first option is what you want*/


	if($user_Access_Level == 0); // admins have this access level you can add your own in the usertypes table
			$baseStatement += ' AND ' var($listeratorAction + '_Table')'.Display_Status = "'$default_status'" 
			
			';
	else;
			$baseStatement += ' AND ' var($listeratorAction + '_Table')'.Display_Status = "' $default_status '" 
			
			';
	/if;

]