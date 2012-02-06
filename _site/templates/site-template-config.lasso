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
	
	
	$user_can_makerator_admin ? $show_content_siteAdmin = true;
	if(!request_isajax);
			asset_manager->add('/assets/css/modules/buttons/buttons.css');
			asset_manager->add('/assets/css/modules/forms/forms.css');
			asset_manager->add('/assets/css/modules/listerators/listerators.css');
			asset_manager->add('/assets/scripts/modules/jquery-validate-1.5.2/jquery.validate.js');
			asset_manager->add('/assets/scripts/modules/jquery-validate-1.5.2/additional-methods.js');
			asset_manager->add('/assets/scripts/modules/jquery.maskedinput.js');
			asset_manager->add('/assets/css/themes/' + $makerator_defaultUiThemeName + '/jquery-ui-1.7.1.custom-additions.css');
			asset_manager->add('/assets/css/themes/' + $makerator_defaultUiThemeName + '/jquery-ui-1.7.1.custom.css');
	/if;
	
	
	// insert individual modules into template
	$templating_templateModules->merge(array(
						'pageTitle'
					,	'navbarTop'
					,	'header'
					,	'primary'
					,	'secondary'
					,	'error'
					,	'debug'
					,	'tertiary'
					,	'siteAdminToolbar'
					,	'footer'
	));
	
	/protect;
]