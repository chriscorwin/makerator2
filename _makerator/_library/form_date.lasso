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
	
	
	local('date_value') = (date($a_value))->format('%Q');
	local('iso_value') = (date($a_value))->format('%Q');
	
	
// 	#date_value = ($date_today != '' ? $date_today | $a_default->format('%QT%T'));
	
	
	$a_value = #date_value;
	
	local('a_desc' = $a_description != '' ? '<div class="description">' + $a_description + '</div>' | '');
	$content_primary += ('
		<div class="' + $rowClass + '">
			<label
				class="' + $labelClass + '"
				for="' +  $a_column + '"
			>
				' + $field_label + '
			</label>
			<input 
				class="' + $inputClass + '"
				type="text" 
				title="' + #iso_value + '"
				name="' + $a_column + '" 
				id="' + $a_column + '" 
				value="'  + #date_value + '"
				remote="/api/validation/date/' + $these + '/' + $listeratorVerb + '/' + $a_column + '/"
			>
			' + $errorWarning + #a_desc + '
		</div>
	');
	
// 				remote="/api/validation/unique/' + $these + '/' + $listeratorVerb + '/' + $a_column + '/"
	
	/protect;
]