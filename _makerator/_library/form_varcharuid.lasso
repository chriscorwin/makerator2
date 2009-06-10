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
	
	
	local('rowClass' = ' varchar ui-helper-reset ui-corner-all ');
	local('errorWarning' = string);
	var($listeratorAction + '_missing')->find($a_column_decrypted)->size > 0 || var($listeratorAction + '_invalid')->find($a_column_decrypted)->size > 0 ?  #rowClass += ' error ui-state-error ';
	var($listeratorAction + '_required')->find($a_column)->size ? #rowClass += ' required ' | #rowClass += ' optional ';
	
	
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
	$content_primary += ('
		<div class="form-field ' + #rowClass + '">
			<label
				class="ui-helper-reset ui-widget-header ui-clickable ui-corner-left"
				for="' +  $a_column + '"
			>
				' + $field_label + '
			</label>
			<input 
				class="ui-helper-reset ui-clickable ui-widget-content ui-corner-right"
				type="text" 
				name="' + $a_column + '" 
				id="' + $a_column + '" 
				value="'  + #a_value + '"
			>
			' + #errorWarning + #a_desc + '
		</div>
	');

	/protect;
]