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
	
	

	var('sessionName' = $listeratorAction);
	var(
		($listeratorAction + '_sessionExpires')				=	420
/* 	,	($listeratorAction + '_required')					=	array */
/* 	,	($listeratorAction + '_validation')					=	array */
/* 	,	($listeratorAction + '_validationWarnings')			=	array */
/* 	,	($listeratorAction + '_optional')					=	array */
	,	'maxresults'										=	75
	,	'maxpages'											=	75
	);
/* 	var( */
/* 		'listeratorAction_errorPage_pathTo'		 = (var: ($listeratorAction + '_pathTo')) + 'error/', */
/* 		'listeratorAction_reviewPage_pathTo'	 = (var: ($listeratorAction + '_pathTo')) + 'view/', */
/* 		'listeratorAction_editPage_pathTo'		 = (var: ($listeratorAction + '_pathTo')) + 'edit/', */
/* 		'listeratorAction_detailPage_pathTo'	 = (var: ($listeratorAction + '_pathTo')) + 'detail/', */
/* 		'listeratorAction_processPage_pathTo'	 = (var: ($listeratorAction + '_pathTo')) + 'processing/', */
/* 		'listeratorAction_resetPage_pathTo'		 = (var: ($listeratorAction + '_pathTo')) + 'reset/', */
/* 		'listeratorAction_successPage_pathTo'	 = (var: ($listeratorAction + '_pathTo')) + 'success/', */
/* 		 */
/* 		'REW_base'		 = (var: ($listeratorAction + '_pathTo')), */
/* 		'REW_create'		= (var: ($listeratorAction + '_pathTo')) 'create/', */
/* 		'REW_detail'	 = (var: ($listeratorAction + '_pathTo')) 'detail/', */
/* 		'REW_delete'	 = (var: ($listeratorAction + '_pathTo')) 'delete/', */
/* 		'REW_edit'		 = (var: ($listeratorAction + '_pathTo')) 'edit/', */
/* 		'REW_add'		 = (var: ($listeratorAction + '_pathTo')) 'add/', */
/* 		'REW_review'	 = (var: ($listeratorAction + '_pathTo')) 'view/', */
/* 		'REW_reset'		 = (var: ($listeratorAction + '_pathTo')) 'reset/', */
/* 		 */
/* 		'listeratorAction'		= (var: ($listeratorAction + '_pathTo')) '', */
/* 		 */
/* 	); */
/* 	if(var($listeratorAction + '_pathto'->endsWith('edit/edit/'); */
/* 			// this is to over-ride the "edit" path, when we are INSIDE the edit section already */
/* 			$listeratorAction_editPage_pathTo->removeTrailing('/edit/'); */
/* 			$listeratorAction_editPage_pathTo += '/'; */
/* 	/if; */
/* 	if: $REW_delete->endsWith('edit/delete/'); */
/* 			// this is to over-ride the "edit" path, when we are INSIDE the edit section already */
/* 			$REW_delete->removeTrailing('/edit/delete/'); */
/* 			$REW_delete += '/delete/'; */
/* 	/if; */
/* 	if: $listeratorAction_editPage_pathTo->endsWith('new/edit/'); */
/* 			// this is to over-ride the "edit" path, when we are INSIDE the new section	 */
/* 			$listeratorAction_editPage_pathTo->removeTrailing('new/edit/'); */
/* 			$listeratorAction_editPage_pathTo += 'edit/'; */
/* 	/if; */



	session_start(
		-usecookie
	,	-name											=	$sessionName
	,	-expires											=	var($listeratorAction + '_sessionexpires')
	,	-path											=	'/'
	);
	
	$makeratorActionSessionNames->insert(pair($sessionName=var($listeratorAction + '_pathto')));
	$makeratorActionSessionIds->insert(pair($sessionName = session_ID(-name=$sessionName)));
	
	
	
	
	session_addVariable(-name = $sessionName,		'formFields');
	session_addVariable(-name = $sessionName,		'keyword');
	
	session_addVariable(-name = $sessionName,		$listeratorAction + '_action');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_checkboxes');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_customError');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_empty');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_error_code');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_error_msg');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_error');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_exitTo');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_formFields');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_invalid');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_message');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_missing');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_okay');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_optional');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_reason');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_required');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_savedSearchParams');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_savedSortField');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_savedSortOrder');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_savedStatement');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_savedStatementModifiers');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_sets');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_sortOn');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_status');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_table');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_titleFieldName');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_UIDfieldName');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_validation');
	session_addVariable(-name = $sessionName,		$listeratorAction + '_validationWarnings');
	
	
	
	!var_defined('formFields')											?	var('formFields'										=	array);
	!var_defined('keyword')												?	var('keyword'											=	string);
	!var_defined('showListeratorDetails')								?	var('showListeratorDetails'								=	false);
	
	!var_defined($listeratorAction + '_action')							?	var($listeratorAction + '_action'						=	string);
	!var_defined($listeratorAction + '_checkboxes')						?	var($listeratorAction + '_checkboxes'					=	array);
	!var_defined($listeratorAction + '_customError')					?	var($listeratorAction + '_customError'					=	string);
	!var_defined($listeratorAction + '_empty')							?	var($listeratorAction + '_empty'						=	map);
	!var_defined($listeratorAction + '_error_code')						?	var($listeratorAction + '_error_code'					=	0);
	!var_defined($listeratorAction + '_error_msg')						?	var($listeratorAction + '_error_msg'					=	string);
	!var_defined($listeratorAction + '_error')							?	var($listeratorAction + '_error'						=	string);
	!var_defined($listeratorAction + '_formFields')						?	var($listeratorAction + '_formFields'					=	array);
	!var_defined($listeratorAction + '_invalid')						?	var($listeratorAction + '_invalid'						=	map);
	!var_defined($listeratorAction + '_message')						?	var($listeratorAction + '_message'						=	string);
	!var_defined($listeratorAction + '_missing')						?	var($listeratorAction + '_missing'						=	map);
	!var_defined($listeratorAction + '_okay')							?	var($listeratorAction + '_okay'							=	map);
	!var_defined($listeratorAction + '_optional')						?	var($listeratorAction + '_optional'						=	array);
	!var_defined($listeratorAction + '_reason')							?	var($listeratorAction + '_reason'						=	string);
	!var_defined($listeratorAction + '_required')						?	var($listeratorAction + '_required'						=	array);
	!var_defined($listeratorAction + '_savedSearchParams')				?	var($listeratorAction + '_savedSearchParams'			=	array);
	!var_defined($listeratorAction + '_savedSortField')					?	var($listeratorAction + '_savedSortField'				=	'UID');
	!var_defined($listeratorAction + '_savedSortOrder')					?	var($listeratorAction + '_savedSortOrder'				=	'ASC');
	!var_defined($listeratorAction + '_savedStatement')					?	var($listeratorAction + '_savedStatement'				=	string);
	!var_defined($listeratorAction + '_savedStatementModifiers')		?	var($listeratorAction + '_savedStatementModifiers'		=	string);
	!var_defined($listeratorAction + '_sets')							?	var($listeratorAction + '_sets'							=	array);
	!var_defined($listeratorAction + '_sortOn')							?	var($listeratorAction + '_sortOn'						=	array);
	!var_defined($listeratorAction + '_status')							?	var($listeratorAction + '_status'						=	string);
	!var_defined($listeratorAction + '_table')							?	var($listeratorAction + '_table'						=	'users');
	!var_defined($listeratorAction + '_titleFieldName')					?	var($listeratorAction + '_titleFieldName'				=	'Title');
	!var_defined($listeratorAction + '_UIDfieldName')					?	var($listeratorAction + '_UIDfieldName'					=	'UID');
	!var_defined($listeratorAction + '_validation')						?	var($listeratorAction + '_validation'					=	array);
	!var_defined($listeratorAction + '_validationWarnings')				?	var($listeratorAction + '_validationWarnings'			=	array);
	
	
/* 	session_addVariable(-name = $sessionName, var($listeratorAction + '_UIDfieldName')); */
/* 	session_addVariable(-name = $sessionName, var($listeratorAction + '_titleFieldName')); */
	
	/protect;
]