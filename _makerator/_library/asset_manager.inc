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
	
	
	
	asset_manager->options(
		-usecache										=	false
	,	-minify											=	false
	,	-compress										=	false
	,	-refresh										=	false
	,	-paths											=	$makerator_assetManagerPaths
	,	-subdomains										=	$makerator_assetManagerSubdomains
	);
	
	
	
	/protect;
]