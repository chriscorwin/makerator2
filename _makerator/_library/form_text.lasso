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
	
	
	if(variable_defined($a_column_decrypted));
		local('a_value' = var($a_column_decrypted));
	else;
		local('a_value' = $a_default);
	/if;
	
	
	local('errorWarning' = string);
	var($listeratorAction + '_missing')->find($a_column_decrypted)->size > 0 || var($listeratorAction + '_invalid')->find($a_column_decrypted)->size > 0 ?  $rowClass += ' error ui-state-error ';
	var($listeratorAction + '_required')->find($a_column)->size ? $rowClass += ' required ' | $rowClass += ' optional ';
	
	
	if(var($listeratorAction + '_missing')->find($a_column_decrypted)->size > 0  );
			#errorWarning +=  ('
				<label 
					for="' +  $a_column + '"
					class="ui-helper-reset ui-helper-clearfix ui-clickable ui-widget-content ui-corner-all ui-state-highlight ui-state-missing"
				>
						<p>This field is required.</p>
				</label>
			');
			#a_value = '';
	else(var($listeratorAction + '_invalid')->find($a_column_decrypted)->size > 0);
			iterate(var($listeratorAction + '_validationwarnings'), var('a_pair'));
					if($a_pair->first == $a_column_decrypted);
						#errorWarning += '<label for="' +  $a_column + '" class="ui-helper-reset ui-helper-clearfix ui-clickable ui-widget-content ui-corner-all ui-state-invalid">';
						#errorWarning += $a_pair->second;
						#errorWarning += '</label>';
					/if;
			/iterate;
	/if;
	
	
	local('a_desc' = $a_description != '' ? '<div class="description">' + $a_description + '</div>' | '');
	
	
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
	
	
	local(
		'numberOfRows' = 5
	,	'numberOfCols' = 35
	);
	
	#a_value->size ? #numberOfRows = #a_value->split('\r')->size + #numberOfRows;
	
/* 	$content_primary += (' */
/* 		<fieldset class="' + $rowClass + '"> */
/* 			<label */
/* 				class="ui-helper-reset ui-widget-header ui-clickable ui-corner-left" */
/* 				for="' +  $a_column + '" */
/* 			> */
/* 				' + $field_label + ' */
/* 			</label> */
/* 			' + #hiddenFckEditorStuff + ' */
/* 			' + $myeditor->create + ' */
/* 			' + #errorWarning + #a_desc + ' */
/* 		</fieldset> */
/* 	'); */
	$content_primary += ('
		<div class="' + $rowClass + '">
			<label
				class="' + $labelClass + '"
				for="' +  $a_column + '"
			>
				' + $field_label + '
			</label>
			<textarea 
				class="' + $inputClass + '"
				type="text" 
				name="' + $a_column + '" 
				rows="' + #numberOfRows + '"
				cols="' + #numberOfCols + '"
				id="' + $a_column + '">'  + #a_value + '</textarea>
			' + #errorWarning + #a_desc + '
		</div>
	');

	/protect;
]