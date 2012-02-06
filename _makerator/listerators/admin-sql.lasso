[
	$makerator_includes->insert(include_currentPath);
	$makerator_currentInclude							=	$makerator_includes->last;
	handle;
			$makerator_includes->remove;
			$makerator_currentInclude					=	$makerator_includes->last;
	/handle;
	
	
	protect;
	
	handle_error;
			makerator_errorManager(
				$makerator_currentInclude
			,	error_code
			,	error_msg
			,	action_statement
			);
	/handle_error;
	
	
	var('default_status' = get_column_default((var($listeratorAction + '_table')), 'Display_Status')); // we assume that the first option is what you want

	/*	var('option' = get_set_options((var($listeratorAction + '_table')), 'Display_Status')->first); // we assume that the first option is what you want*/


	if($user_access_level == 0); // admins have this access level you can add your own in the usertypes table
			//$baseStatement += ' AND ' var($listeratorAction + '_table')'.Display_Status = "'$default_status'" ';
	else;
			$baseStatement += ' AND ' + var($listeratorAction + '_table') + '.Display_Status = "' + $default_status + '" 
			
			';
	/if;
	
	/protect;
]