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

	if(variable_defined($a_column));
		local('a_value' = var($a_column));
	else;
		local('a_value' = $a_default);
	/if;
	
	var: 'size' = 1;
	local('content_valueList' = string);
	inline(
		$authForDatabase
	,	-show
	,	-table=$a_table
	,	-inlineName = 'valueList'
	);
			value_list($a_column_decrypted);
					$size += 1;
					
					#content_valueList += ('
									<option 
										value="set_' + value_listItem + '" 
										' + ((#a_value == '' && value_listItem == $a_default) ?  + ' selected="selected" ') + '
										' + ((value_listItem == #a_value) || (var($listeratorAction + '_sets') >> pair($a_column=value_listItem)) ?  + ' selected="selected" ') + '
										' + ((value_listItem == #a_value) ? ' selected="selected" ') + '
									>' + value_listItem + '
									</option>
					');
			/value_list;
	/inline;
	
	
	
	local('fieldsetClass' = ' varchar ui-helper-reset ui-corner-all ');
	local('errorWarning' = string);
	var($listeratorAction + '_missing')->find($a_column_decrypted)->size > 0 || var($listeratorAction + '_invalid')->find($a_column_decrypted)->size > 0 ?  #fieldsetClass += ' error ui-state-error ';
	var($listeratorAction + '_required')->find($a_column)->size ? #fieldsetClass += ' required ' | #fieldsetClass += ' optional ';
	
	
	if(var($listeratorAction + '_missing')->find($a_column_decrypted)->size > 0  );
			#errorWarning +=  ('
				<label 
					for="' +  $a_column + '"
					class="ui-helper-reset ui-helper-clearfix ui-clickable ui-widget-content ui-corner-all ui-state-highlight ui-state-missing"
				>
						<p>This field is required.</p>
				</label>
			');
			#a_value = #a_default;
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
		<fieldset class="' + #fieldsetClass + '">
			<label
				class="ui-helper-reset ui-widget-header ui-clickable ui-corner-left"
				for="' +  $a_column + '"
			>
				' + $field_label + '
				 (' + $fieldType + ')
				 (' + var($a_column_decrypted) + ')
			</label>
			<select 
				id="' + $a_column + '" 
				class="ui-helper-reset ui-clickable ui-widget-content ui-corner-right"
				name="' + $a_column + '" 
				size="' $size '" 
			>
					<option 
						label="(please choose one)" 
						value="" 
						>
							(please choose one)
					</option>
					' + #content_valueList + '
			</select>
			' + #errorWarning + #a_desc + '
		</fieldset>
	');
	
	/protect;
]