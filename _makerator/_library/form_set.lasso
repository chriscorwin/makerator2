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
	
	
	var('size' = 1);
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
										class="' + $option_classes->join(' ') + '"
										value="set_' + value_listItem + '" 
										' + ((#a_value == '' && value_listItem == $a_default) ?  + ' selected="selected" ') + '
										' + ((value_listItem == #a_value) || (var($listeratorAction + '_sets') >> pair($a_column=value_listItem)) ?  + ' selected="selected" ') + '
										' + ((value_listItem == #a_value) ? ' selected="selected" ') + '
									>' + value_listItem + '
									</option>
					');
			/value_list;
	/inline;
	
	$size >= 1 ? $input_classes->merge(array('multiple'));
	
	
	local('a_desc' = $a_description != '' ? '<div class="description">' + $a_description + '</div>' | '');
	$content_primary += ('
		<section class="' + $section_classes->join(' ') + '">
			<label
				class="' + $section_classes->join(' ') + '"
				for="' +  $a_column + '"
			>
				' + $field_label + '
			</label>
			<select 
				id="' + $a_column + '" 
				class="' + $input_classes->join(' ') + '"
				name="' + $a_column + '" 
				size="' $size '" 
				' + $size > 1 ? 'multiple="true"' + '
			>
					<option 
						label="(please choose one)" 
						class="' + $option_classes->join(' ') + '"
						value="" 
						>
							(please choose one)
					</option>
					' + #content_valueList + '
			</select>
			' + $errorWarning + #a_desc + '
		</section>
	');
	
	
	
	/protect;
]