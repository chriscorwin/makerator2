[
	/*
		Never make chances to this file.
		
		There are two config files you can edit:
			
			
			/_site/config.inc
			
			This is wherere site and domain-specific changes to override
			or compliment Makerator's defaults go.
			
			
			/_site/template/site-template-config.lasso
			
			Application-specifica settings can go in this file.
			
			It loads after all other config files, custom tags, and sessions have initialized.
			
	*/
	
	var(
		'siteDB'										=	'makerator' + server_name->replace('.',string)
	,	'makerator_defaultDomainName'					=	server_name
	,	'content_debug'									=	string
	,	'content_error'									=	string
	,	'content_header'								=	string
	,	'content_primary'								=	string
	,	'content_secondary'								=	string
	,	'content_tertiary'								=	string
	,	'content_footer'								=	string
	,	'content_siteAdmin'								=	string
	,	'content_siteAdminToolbar'						=	string
	,	'content_siteTitle'								=	'A Fresh Makerator Install'
	
	
	,	'default_pageLoadsUseAjax'						=	true
	,	'default_forceAjaxContent'						=	true
	,	'pagesTimeOut'									=	false
	
	,	'errorMessage'									=	string
	,	'json_data'										=	map
	,	'json_scripts'									=	array
	
	
	,	'listeratorValidationDataTypes'					=	array(
				'Alpha'
			,	'AlphaNumeric'
			,	'Date'
			,	'Decimal'
			,	'Email'
			,	'Integer'
			,	'Numeric'
			,	'Phone'
			,	'SSN'
			,	'URL'
			)
	,	'listeratorValidationKeys'						=	array
	,	'listeratorValidationTags'						=	map
	,	'navbar_config_multiLevel'						=	true
	,	'navbar_config_showHome'						=	true
	,	'pageID'											=	integer
	,	'pageName'										=	string
	,	'site_webMaster'								=	'webmaster@' + server_name
	,	'tablePrefix'									=	string
	
	
	,	'templating_templateName'						=	'base'
	,	'templating_templateModules'						=	array
	,	'templating_inlineJavascript'					=	set
	,	'templating_inlineJquery'						=	set
	,	'templating_trailingHtml'						=	string
	
	
	,	'usernameDatabaseQueries'						=	string
	,	'usernameFileOperations'							=	string
	,	'usernameUploads'								=	string
	,	'passwordDatabaseQueries'						=	string
	,	'passwordFileOperations'							=	string
	,	'passwordUploads'								=	string
	
	
	,	'makerator_includes'							=	array
	,	'makerator_currentInclude'						=	string
	,	'makerator_currentIncludeChild'					=	string
	,	'makerator_currentIncludeParent'				=	string
	
	,	'makerator_errorStack'							=	array
	,	'makerator_pathToAdmin'							=	'/makerator_admin/'
	,	'makerator_defaultUiThemeName'					=	'makeratordotcom'
	,	'makerator_adminUiThemeName'					=	'makerator_admin'
	,	'makerator_authenticationExpiresMinutes'			=	21600
	,	'makerator_currentActionExpiresMinutes'			=	120
	
	,	'makerator_saveRenderedVersion'					=	false
	,	'makerator_renderedVersionPathPrefix'			=	''
	,	'makerator_renderedVersionPath'					=	'/_rendered'
	
	,	'makerator_assetManagerSubdomains_cookieless'	=	array(
															'(/assets/css)(/[^"]+?)'		=	'http://assets.' + server_name + '\\2\\3'
														,	'(/assets/scripts)(/[^"]+?)'		=	'http://assets.' + server_name + '\\2\\3'
														,	'(/assets/images)(/[^"]+?)'		=	'http://assets.' + server_name + '\\2\\3'
														)
	,	'makerator_assetManagerSubdomains_cloud'		=	array(
															'(/assets/css)(/[^"]+?)'		=	'http://cloud.' + server_name + '.com' + '\\2\\3'
														,	'(/assets/scripts)(/[^"]+?)'		=	'http://cloud.' + server_name + '.com' + '\\2\\3'
														,	'(/assets/images)(/[^"]+?)'		=	'http://cloud.' + server_name + '.com' + '\\2\\3'
														)
	,	'makerator_assetManagerSubdomains_plain'		=	array(
															'(/assets/css)(/[^"]+?)'		=	'http://' + server_name + '\\2\\3'
														,	'(/assets/scripts)(/[^"]+?)'		=	'http://' + server_name + '\\2\\3'
														,	'(/assets/images)(/[^"]+?)'		=	'http://' + server_name + '\\2\\3'
														)
	,	'makerator_assetManagerSubdomains'			=	array(
															'(/assets/css)(/[^"]+?)'		=	'\\2\\3'
														,	'(/assets/scripts)(/[^"]+?)'		=	'\\2\\3'
														,	'(/assets/images)(/[^"]+?)'		=	'\\2\\3'
														)
	,	'makerator_assetManagerPaths'					=	map('yui'						=	'/assets/yuicompressor.jar'
														,	'scriptbase'						=	'/assets/scripts/global/'
														,	'scriptcache'					=	'/assets/scripts/cached/'
														,	'scriptModules'					=	'/assets/scripts/modules/'
														,	'stylebase'						=	'/assets/css/global/'
														,	'stylecache'					=	'/assets/css/cached/'
														,	'styleModules'					=	'/assets/css/modules/'
														)
	);
	
	iterate($listeratorValidationDataTypes, local('datatype'));
			$listeratorValidationKeys->insert(#datatype);
	/iterate;
	
	var(
		'authForDatabase'								=	array(
				-nothing
			,	-database=$sitedb
			,	-table=$tablePrefix + 'pages'
			,	-username=$usernameDatabaseQueries
			,	-password=$passwordDatabaseQueries
			,	-maxrecords='all'
			)
	,	'authForFileOperations'							=	array(
				action_params
			,	-nothing
			,	-username=$usernameFileOperations
			,	-password=$passwordFileOperations
			)
	,	'connection_uploads'								=	array(
				-username=$usernameUploads
			,	-password=$passwordUploads
			)
	);
	
	//this is for jono's xs_cat tags (which provide nested set capabilities)
	global('gv_error'									=	@$content_error);
	global('gv_sql'										=	$authForDatabase);
]