[
// 	$makerator_includes->insert(include_currentPath);
// 	$makerator_currentInclude							=	$makerator_includes->last;
// 	handle;
// 			$makerator_includes->remove;
// 			$makerator_currentInclude					=	$makerator_includes->last;
// 	/handle;
// 	
// 	
// 	protect;
// 	
// 	handle_error;
// 			makerator_errorManager(
// 				$makerator_currentInclude
// 			,	error_code
// 			,	error_msg
// 			,	action_statement
// 			);
// 	/handle_error;
	
	
	local(
		'numberOfRows' = 5
	,	'numberOfCols' = 35
	);
	
	$a_value->size ? #numberOfRows = $a_value->split('\r')->size + #numberOfRows;
	
	local('a_desc' = $a_description != '' ? '<div class="description">' + $a_description + '</div>' | '');
	$content_primary += ('
		<section class="' + $section_classes->join(' ') + '">
			<label
				class="' + $section_classes->join(' ') + '"
				for="' +  $a_column + '"
			>
				' + $field_label + '
			</label>
			<textarea 
				class="' + $input_classes->join(' ') + '"
				name="' + $a_column + '" 
				rows="' + #numberOfRows + '"
				cols="' + #numberOfCols + '"
				id="' + $a_column + '">'  + #a_value + '</textarea>
			' + $errorWarning + #a_desc + '
		</section>
	');
	
	
/* 	local('hiddenFckEditorStuff' = include('/_makerator/fckeditor/fckeditor.lasso')); */
/* 	var('basepath'='/_makerator/fckeditor/'); */
/* 	var('myeditor') =  */
/* 		fck_editor( */
/* 			-instancename=$a_column, */
/* 			-basepath=$basepath, */
/* 			-initialvalue=string((Variable_Defined: $a_column_decrypted) ? (Var: $a_column_decrypted)) */
/* 			); */
/* 	if(action_param('Toolbar')); */
/* 		$myeditor->toolbarset = action_param('None'); */
/* 	/if; */

// 	/protect;
]