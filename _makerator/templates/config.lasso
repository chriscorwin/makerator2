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
	
	


//	if((string(response_path) >>  + $makerator_pathToAdmin + ) && $AuthenticationStatus == 'Authorized');
//			asset_manager->add('/assets/css/makerator/admin.css');
//			asset_manager->add('/assets/css/makerator/content_siteAdminToolbar.css');
//			asset_manager->add('/assets/css/makerator/blueprintcss/screen.css');
//			asset_manager->add('/assets/css/makerator/nav/horizonal.css');
//			asset_manager->add('/assets/css/makerator/makerator_ui.css');
//	/if;
	
	/protect;
]