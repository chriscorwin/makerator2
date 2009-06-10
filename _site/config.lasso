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
	
	
	/*
		The select statement below allows us to run the same code 
		in multiple environtments, such as development, staging, and production.
		
		Based on server_name, we can use different databse and authentication info.
	
	*/
	
	
	// all of the domains in this install share some configuration values
	var('makerator_defaultDomainName'					=	'makerator.chriscorwin.com');
	var('siteDB'										=	'makerator02'
	,	'content_siteTitle'								=	'Makerator Dev Install'
	,	'content_pageTitle'								=	''
	,	'site_webMaster'								=	'chris@chriscorwin.com'
	,	'templating_templateName'						=	'base'
	,	'navbar_config_showHome'						=	false
	,	'navbar_config_multiLevel'						=	true
	,	'default_pageLoadsUseAjax'						=	true
	,	'default_forceAjaxContent'						=	true
	,	'pagesTimeOut'									=	false
	,	'makerator_assetManagerSubdomains_cookieless'	=	array(
															'(/assets/css)(/[^"]+?)'		=	'http://assets.' + server_name + '\\2\\3'
														,	'(/assets/scripts)(/[^"]+?)'		=	'http://assets.' + server_name + '\\2\\3'
														,	'(/assets/images)(/[^"]+?)'		=	'http://assets.' + server_name + '\\2\\3'
														)
	,	'makerator_assetManagerSubdomains_cloud'		=	array(
															'(/assets/css)(/[^"]+?)'		=	'http://cloud.chriscorwin.com' + '\\2\\3'
														,	'(/assets/scripts)(/[^"]+?)'		=	'http://cloud.chriscorwin.com' + '\\2\\3'
														,	'(/assets/images)(/[^"]+?)'		=	'http://cloud.chriscorwin.com' + '\\2\\3'
														)
	,	'makerator_assetManagerSubdomains_plain'		=	array(
															'(/assets/css)(/[^"]+?)'		=	'http://' + server_name + '\\2\\3'
														,	'(/assets/scripts)(/[^"]+?)'		=	'http://' + server_name + '\\2\\3'
														,	'(/assets/images)(/[^"]+?)'		=	'http://' + server_name + '\\2\\3'
														)
	,	'makerator_assetManagerPaths'					=	map('yui'						=	server_webroot + '/assets/yuicompressor.jar'
														,	'scriptbase'						=	'/assets/scripts/global/'
														,	'scriptcache'					=	'/assets/scripts/cached/'
														,	'scriptModules'					=	'/assets/scripts/modules/'
														,	'stylebase'						=	'/assets/css/global/'
														,	'stylecache'					=	'/assets/css/cached/'
														,	'styleModules'					=	'/assets/css/modules/'
														)
	,	'usernameDatabaseQueries'						=	'chriscorwin'
	,	'passwordDatabaseQueries'						=	'm0mm135'
	,	'usernameFileOperations'							=	'chriscorwin'
	,	'passwordFileOperations'							=	'm0mm135'
	,	'usernameUploads'								=	'chriscorwin'
	,	'passwordUploads'								=	'm0mm135'
	,	'makerator_defaultDomainName'					=	'makerator.chriscorwin.com'
	,	'makerator_defaultUiThemeName'					=	'makeratordotcom'
	,	'makerator_authenticationExpiresMinutes'			=	30
	,	'makerator_currentActionExpiresMinutes'			=	120
	);
	
	
	// this is where you can have users redirected to in case of a configuration error
	select(server_name);
	case('makerator.chriscorwin.com');
			$makerator_assetManagerSubdomains			=	$makerator_assetManagerSubdomains_cookieless;
	case('makerator.chriscorwin.maker');
			$makerator_assetManagerSubdomains			=	$makerator_assetManagerSubdomains_plain;
	case('makerator.com');
			var('siteDB'								=	'chriscorwin'
			,	'usernameDatabaseQueries'				=	'chriscorwin'
			,	'passwordDatabaseQueries'				=	'm0mm135'
			,	'usernameFileOperations'					=	'chriscorwin'
			,	'passwordFileOperations'					=	'm0mm135'
			,	'usernameUploads'						=	'chriscorwin'
			,	'passwordUploads'						=	'm0mm135'
			);
			$makerator_assetManagerSubdomains			=	$makerator_assetManagerSubdomains_plain;
	case('www.makerator.chriscorwin.com');
			redirect_url('http://' + $makerator_defaultDomainName +  + response_filepath, -type='301');
	case;
			error_msg									=	'Wrong Server Name';
			error_code									=	403;
			var('makerator_include_currentPathReporting'	=	include_currentPath);
			$__HTML_REPLY__ += include('/_makerator/_installer/error_server_name.html');
			abort;
	/select;
	
	
	var(
		'authForDatabase'								=	array(
																-nothing
															,	-database		=	$sitedb
															,	-table			=	$tablePrefix+'pages'
															,	-username		=	$usernameDatabaseQueries
															,	-password		=	$passwordDatabaseQueries
															,	-maxrecords		=	'all'
															)
	,	'authForFileOperations'							=	array(
																action_params
															,	-nothing
															,	-username		=	$usernameFileOperations
															,	-password		=	$passwordFileOperations
															)
	,	'connection_uploads'								=	array(
																	-nothing
																,	-username		=	$usernameUploads
																,	-password		=	$passwordUploads
																)
	);
	
	//this is for jono's xs_cat tags (which provide nested set capabilities)
	var('gv_sql'									=	$authForDatabase);


	/protect;
]