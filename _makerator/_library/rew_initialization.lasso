[

	var(
		($listeratorAction + '_SessionExpires') = 420,
		($listeratorAction + '_SessionName') = '_' + $listeratorAction,
		($listeratorAction + '_Required') = (Array),
		($listeratorAction + '_Validation') = (Array),
		($listeratorAction + '_ValidationWarnings') = (Array),
		($listeratorAction + '_Optional') = (Array),
		);
	var(
/* 		'listeratorAction_ErrorPage_pathTo'      = (Var: ($listeratorAction + '_pathTo')) + 'Error/', */
/* 		'listeratorAction_ReviewPage_pathTo'     = (Var: ($listeratorAction + '_pathTo')) + 'View/', */
/* 		'listeratorAction_EditPage_pathTo'       = (Var: ($listeratorAction + '_pathTo')) + 'Edit/', */
/* 		'listeratorAction_DetailPage_pathTo'     = (Var: ($listeratorAction + '_pathTo')) + 'Detail/', */
/* 		'listeratorAction_ProcessPage_pathTo'    = (Var: ($listeratorAction + '_pathTo')) + 'Processing/', */
/* 		'listeratorAction_ResetPage_pathTo'      = (Var: ($listeratorAction + '_pathTo')) + 'Reset/', */
/* 		'listeratorAction_SuccessPage_pathTo'    = (Var: ($listeratorAction + '_pathTo')) + 'Success/', */
/* 		 */
		'REW_Base'       = (Var: ($listeratorAction + '_pathTo')),
/* 		'REW_Create'        = (Var: ($listeratorAction + '_pathTo')) 'Create/', */
/* 		'REW_Detail'     = (Var: ($listeratorAction + '_pathTo')) 'Detail/', */
/* 		'REW_Delete'     = (Var: ($listeratorAction + '_pathTo')) 'Delete/', */
/* 		'REW_Edit'       = (Var: ($listeratorAction + '_pathTo')) 'Edit/', */
/* 		'REW_Add'        = (Var: ($listeratorAction + '_pathTo')) 'Add/', */
/* 		'REW_Review'     = (Var: ($listeratorAction + '_pathTo')) 'View/', */
/* 		'REW_Reset'      = (Var: ($listeratorAction + '_pathTo')) 'Reset/', */
		
		'listeratorAction'      = (Var: ($listeratorAction + '_pathTo')) '',
		
		'maxresults'=6,
		'maxpages'=6,
		);
/* 	if: $listeratorAction_EditPage_pathTo->EndsWith('Edit/Edit/'); */
/* 			// this is to over-ride the "edit" path, when we are INSIDE the edit section already */
/* 			$listeratorAction_EditPage_pathTo->RemoveTrailing('/Edit/'); */
/* 			$listeratorAction_EditPage_pathTo += '/'; */
/* 	/if; */
/* 	if: $REW_Delete->EndsWith('Edit/Delete/'); */
/* 			// this is to over-ride the "edit" path, when we are INSIDE the edit section already */
/* 			$REW_Delete->RemoveTrailing('/Edit/Delete/'); */
/* 			$REW_Delete += '/Delete/'; */
/* 	/if; */
/* 	if: $listeratorAction_EditPage_pathTo->EndsWith('New/Edit/'); */
/* 			// this is to over-ride the "edit" path, when we are INSIDE the new section  */
/* 			$listeratorAction_EditPage_pathTo->RemoveTrailing('New/Edit/'); */
/* 			$listeratorAction_EditPage_pathTo += 'Edit/'; */
/* 	/if; */
	Session_Start:
		-Name=(Var: ($listeratorAction + '_SessionName')),
		-Expires=(Var: ($listeratorAction + '_SessionExpires')),
		-UseCookie,
		-Path=(Var: ($listeratorAction + '_pathTo'))
		;
	// this second session_start is to overcome an apparent bug in webstar
/*	Session_Start:*/
/*		-Name=(Var: ($listeratorAction + '_SessionName')),*/
/*		-Expires=(Var: ($listeratorAction + '_SessionExpires')),*/
/*		-UseCookie,*/
/*		-Path=(Var: ($listeratorAction + '_pathTo'))*/
/*		;*/
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Okay');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Missing');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Required');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Optional');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Empty');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_CustomError');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Invalid');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Error');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Table');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Title_Field_Name');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_SortOn');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Validation');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_ValidationWarnings');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_UIDfieldName');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Checkboxes');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_savedSearchParams');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_savedStatement');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_savedStatementModifiers');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_savedSortField');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_savedSortOrder');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ('formFields');
	
	
	!var_defined(($listeratorAction + '_Okay')) ? var(($listeratorAction + '_Okay')=(Map));
	!var_defined(($listeratorAction + '_Missing')) ? var(($listeratorAction + '_Missing')=(Map));
	!var_defined(($listeratorAction + '_Required')) ? var(($listeratorAction + '_Required')=(Array));
	!var_defined(($listeratorAction + '_Optional')) ? var(($listeratorAction + '_Optional')=(Array));
	!var_defined(($listeratorAction + '_Empty')) ? var(($listeratorAction + '_Empty')=(Map));
	!var_defined(($listeratorAction + '_Invalid')) ? var(($listeratorAction + '_Invalid')=(Map));
	!var_defined(($listeratorAction + '_Error')) ? var(($listeratorAction + '_Error')=(String));
	!var_defined(($listeratorAction + '_CustomError')) ? var(($listeratorAction + '_CustomError')=(String));

	!var_defined(($listeratorAction + '_Table')) ? var(($listeratorAction + '_Table')=('users'));
	!var_defined(($listeratorAction + '_Title_Field_Name')) ? var(($listeratorAction + '_Title_Field_Name')=('Title'));
	!var_defined(($listeratorAction + '_UIDfieldName')) ? var(($listeratorAction + '_UIDfieldName')=('UID'));
	!var_defined(($listeratorAction + '_SortOn')) ? var(($listeratorAction + '_SortOn')=(Array));
	!var_defined(($listeratorAction + '_Checkboxes')) ? var(($listeratorAction + '_Checkboxes')=(Array));
	!var_defined(($listeratorAction + '_Validation')) ? var(($listeratorAction + '_Validation')=(Array));
	!var_defined(($listeratorAction + '_ValidationWarnings')) ? var(($listeratorAction + '_ValidationWarnings')=(Array));

	!var_defined(($listeratorAction + '_savedSearchParams')) ? var(($listeratorAction + '_savedSearchParams')=(Array));
	!var_defined(($listeratorAction + '_savedStatement')) ? var(($listeratorAction + '_savedStatement')=(String));
	!var_defined(($listeratorAction + '_savedStatementModifiers')) ? var(($listeratorAction + '_savedStatementModifiers')=(String));
	!var_defined(($listeratorAction + '_savedSortField')) ? var(($listeratorAction + '_savedSortField')=('UID'));
	!var_defined(($listeratorAction + '_savedSortOrder')) ? var(($listeratorAction + '_savedSortOrder')=('ASC'));
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ((var($listeratorAction + '_UIDfieldName')));


	!var_defined(('formFields')) ? var(('formFields')=(array));
	
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), 'keyword';
	!var_defined('keyword') ? var('keyword'=(''));
	
]