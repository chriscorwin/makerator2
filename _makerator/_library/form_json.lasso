[
	protect;
	
	$makerator_includes->insert(include_currentPath);
	$makerator_currentInclude							=	$makerator_includes->last;
	
	handle_error;
			makerator_errorManager(
				$makerator_currentInclude
			,	error_code
			,	error_msg
			);
	/handle_error;
	
	handle;
			$makerator_includes->remove;
			$makerator_currentInclude					=	$makerator_includes->last;
	/handle;
	
	
	
	
	
	var('decoded_value' = decode_json($a_value));
	var('size' = 1);
	$decoded_value->isA('array') || $decoded_value->isA('map') ? $size = $decoded_value->size;
	
	
	local('content_input' = string(''));
	
	
	if($size >= 2);
			iterate($decoded_value, local('loop_value'));
					#content_input += ('
						<input 
							class="' + $inputClass + '"
							type="text" 
							name="' + $a_column + '" 
							id="' + $a_column + '-' + loop_count + '" 
							rel="' + $a_column + '"
							value="'  + #loop_value + '"
						>
					');
			/iterate;
	/if;
	
	
	
	local('a_desc' = $a_description != '' ? '<div class="description">' + $a_description + '</div>' | '');
	$content_primary += ('
		<div class="' + $rowClass + '">
			<label
				class="ui-helper-reset ui-widget-header ui-clickable ui-corner-left"
				for="' +  $a_column + '"
			>
				' + $field_label + '
			</label>
			' + #content_input + '
			' + $errorWarning + #a_desc + '
		</div>
	');
	
	
// 				 (' + $fieldType + ')
// 				 (' + var($a_column_decrypted) + ')
	/protect;
]