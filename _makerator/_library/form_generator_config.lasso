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
			);
	/handle_error;
	
	var(
		'makerator_admin_formClasses'					=	map
		
	,	'makerator_admin_formTypesClassNames_shared'		=	array('ui-helper-reset', 'ui-helper-clearfix', 'ui-widget', 'ui-form')
	,	'makerator_admin_formTypesClassPrefixen'			=	array('ui-form')
	
	,	'makerator_admin_formElementClassNames_shared'	=	array('ui-form-element')
	,	'makerator_admin_formElementClassPrefixen'		=	array('ui-form-element')


	,	'makerator_admin_formElements_interactive'		=	map(
				'label'			=	array('ui-clickable', 'ui-state-default')
			,	'input'			=	array('ui-clickable', 'ui-state-default')
			,	'button'		=	array('ui-clickable', 'ui-state-default')
			,	'select'		=	array('ui-clickable', 'ui-state-default')
			,	'textarea'		=	array('ui-clickable', 'ui-state-default')
			)
	,	'makerator_admin_formElements_nonInteractive'		=	map(
				'input-hidden'			=	array
			)
	,	'makerator_admin_inputAttributes'				=	array(
				'accept'
			,	'alt'
			,	'autocomplete'
			,	'autofocus'
			,	'checked'
			,	'disabled'
			,	'form'
			,	'formaction'
			,	'formenctype'
			,	'formmethod'
			,	'formnovalidate'
			,	'formtarget'
			,	'height'
			,	'list'
			,	'max'
			,	'maxlength'
			,	'min'
			,	'multiple'
			,	'name'
			,	'pattern'
			,	'placeholder'
			,	'readonly'
			,	'required'
			,	'size'
			,	'src'
			,	'step'
			,	'type'
			,	'value'
			,	'width'
			)
	,	'makerator_admin_formElements_submittable'		=	array(
				'input'
			,	'button'
			,	'select'
			,	'textarea'
			)
	,	'makerator_admin_formElements_stylesReset'	=		map(
				'label'			=	array('ui-helper-reset')
			,	'input'			=	array('ui-helper-reset')
			,	'button'		=	array('ui-helper-reset')
			)
	,	'makerator_admin_formElements_stylesClearfix'	=	map(
				'fieldset'		=	array('ui-helper-clearfix')
			,	'legend'		=	array('ui-helper-clearfix')
			,	'section'		=	array('ui-helper-clearfix')
			)
	,	'makerator_admin_formTypes'						=	array(
				'simple'			=	array
			,	'listerator'	=	array
			,	'signIn'		=	array
			,	'tiny'			=	array
			,	'upload'			=	array
			,	'stacked'		=	array
			,	'grouped'		=	array
			)
	,	'makerator_admin_formElements'					=	map(
				'fieldset'		=	array
			,	'legend'		=	array
			,	'section'		=	array
			,	'label'			=	array
			,	'input'			=	array('hidden', 'text', 'search', 'tel', 'url', 'email', 'password', 'datetime', 'date', 'month', 'week', 'time', 'datetime-local', 'number', 'range', 'color', 'checkbox', 'radio', 'file', 'submit', 'image', 'reset', 'button')
			,	'select'		=	array
			,	'optgroup'		=	array
			,	'option'			=	array
			,	'textarea'		=	array
			,	'button'		=	array('submit', 'reset', 'button')
			,	'output'			=	array
			)
	);
	
	iterate($makerator_admin_formElements, local('formElement__subtypes'));
			local('classNames' = array);
			local('formElement' = #formElement__subtypes->first);
			local('subTypes' = #formElement__subtypes->second);
			
			iterate($makerator_admin_formElementClassNames_shared, local('className'));
					#classNames->insert(#className);
			/iterate;
			
			iterate($makerator_admin_formElementClassPrefixen, local('classPrefix'));
					#classNames->insert(#classPrefix + '-' + #formElement);
					
					$makerator_admin_formClasses->insert(#formElement = #classNames);
					
					iterate(#subTypes, local('elementSubType'));
							#classNames->insert(#elementSubType);
							#classNames->insert(#classPrefix + '-' + #elementSubType);
							#classNames->insert(#classPrefix + '-' + #formElement + '-' + #elementSubType);
							
							iterate($makerator_admin_formElements_interactive, local('tempElement__tempClassNames'));
									local('tempElement' = #tempElement__tempClassNames->first);
									local('tempClassNames' = #tempElement__tempClassNames->second);
									$makerator_admin_formElements_nonInteractive->find(#tempElement  + '-' + #elementSubType)->size ? loop_continue;
									iterate(#tempClassNames, local('tempClassName'));
											#classNames->insert(#tempClassName);
									/iterate;
							/iterate;
							
							iterate($makerator_admin_formElements_stylesReset, local('tempElement__tempClassNames'));
									local('tempElement' = #tempElement__tempClassNames->first);
									local('tempClassNames' = #tempElement__tempClassNames->second);
									iterate(#tempClassNames, local('tempClassName'));
											#classNames->insert(#tempClassName);
									/iterate;
							/iterate;
							
							iterate($makerator_admin_formElements_stylesClearfix, local('tempElement__tempClassNames'));
									local('tempElement' = #tempElement__tempClassNames->first);
									local('tempClassNames' = #tempElement__tempClassNames->second);
									iterate(#tempClassNames, local('tempClassName'));
											#classNames->insert(#tempClassName);
									/iterate;
							/iterate;
							
							$makerator_admin_formClasses->insert((#formElement + '-' + #elementSubType) = #classNames);
					/iterate;
					
			/iterate;
	/iterate;
	
	iterate($makerator_admin_formTypes, local('formType__attributes'));
			local('classNames' = array);
			local('formType' = #formType__attributes->first);
			local('formAttributes' = #formType__attributes->second);
			
			iterate($makerator_admin_formTypesClassNames_shared, local('className'));
					#classNames->insert(#className);
			/iterate;
			
			iterate($makerator_admin_formTypesClassPrefixen, local('classPrefix'));
					#classNames->insert(#classPrefix + '-' + #formType);
					iterate(#formAttributes, local('attribute'));
							#classNames->insert(#classPrefix + '-' + #attribute);
							#classNames->insert(#classPrefix + '-' + #formType  + '-' + #attribute);
					/iterate;
			/iterate;
			$makerator_admin_formClasses->insert(#formType = #classNames);
	/iterate;
	
	
	$content_debug += makerator_content_debug(-title='makerator_admin_formClasses', -body=$makerator_admin_formClasses, -code);
	
	/protect;
]