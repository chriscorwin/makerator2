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
	
	
	local('a_desc' = $a_description != '' ? '<div class="description">' + $a_description + '</div>' | '');
	$content_primary += ('
		<section class="' + $section_classes->join(' ') + '">
			<label
				class="' + $section_classes->join(' ') + '"
				for="' +  $a_column + '"
			>
				' + $field_label + '
			</label>
			<input 
				class="' + $input_classes->join(' ') + '"
				type="text" 
				name="' + $a_column + '" 
				id="' + $a_column + '" 
				value="'  + $a_value + '"
				remote="/api/validation/unique/' + $these + '/' + $listeratorVerb + '/' + $a_column + '/"
			>
			' + $errorWarning + #a_desc + '
		</section>
	');
	
	
// 	/protect;
]