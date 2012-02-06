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
	
	

	
	
	
	
	// authentication is the short-term, User-session
//	Session_Start: 
//		-Name='Authentication', 
//		-UseCookie,
//		-Expires=$makerator_authenticationExpiresMinutes,
//		-Path='/',
//		;



	boolean(client_param('authSessionID')->size) ? var('authSessionID') = client_param('authSessionID') | var('authSessionID') = 'ERROR';
	$authSessionID == 'ERROR' ? session_start(-path='/', -name='Authentication',-usecookie, -expires=$makerator_authenticationExpiresMinutes) | session_start(-path='/', -name='Authentication', -expires=$makerator_authenticationExpiresMinutes, -id=$authSessionID);
	$authSessionID =  session_ID(-name='Authentication');

	boolean(client_param('MakeratorActionSessionID')->size) ? var('MakeratorActionSessionID') = client_param('MakeratorActionSessionID') | var('MakeratorActionSessionID') = 'ERROR';
	$MakeratorActionSessionID == 'ERROR' ? session_start(-path='/', -name='MakeratorAction',-usecookie, -expires=$makerator_currentActionExpiresMinutes) | session_start(-path='/', -name='MakeratorAction', -expires=$makerator_currentActionExpiresMinutes, -id=$MakeratorActionSessionID);
	$MakeratorActionSessionID =	 session_ID(-name='MakeratorAction');
		
		
	
	//	Add variables to sessions
	//	
	//	This adds the variables that most Users will be
	//	authenticated and tracked by.
	
	session_addVariable(-name='Authentication', 'User_UID');
	session_addVariable(-name='Authentication', 'User_Usertype_Title');
	session_addVariable(-name='Authentication', 'User_Login_Name');
	session_addVariable(-name='Authentication', 'User_Access_Level');
	session_addVariable(-name='Authentication', 'AuthenticationStatus');
	session_addVariable(-name='Authentication', 'apparent_User_Usertype_UID');
	session_addVariable(-name='Authentication', 'apparent_User_Access_Level');
	session_addVariable(-name='Authentication', 'apparent_AuthenticationStatus');
	session_addVariable(-name='Authentication', 'dodebug');
	session_addVariable(-name='Authentication', 'debugmode');
	session_addVariable(-name='Authentication', 'listerators');


	session_addVariable(-name='MakeratorAction', 'Current_UID_Value');
	session_addVariable(-name='MakeratorAction', 'Current_UID_Name');
	session_addVariable(-name='MakeratorAction', 'Current_UID_Table');
	session_addVariable(-name='MakeratorAction', 'makeratorActionSessionNames');
	session_addVariable(-name='MakeratorAction', 'makeratorCacheNavbars');
	
	session_addVariable(-name='MakeratorAction', 'pageLoadsUseAjax');
	session_addVariable(-name='MakeratorAction', 'forceAjaxContent');
	
	
	!var_defined('Current_UID_Value') ? var('Current_UID_Value'='null');
	!var_defined('Current_UID_Name') ? var('Current_UID_Name'='null');
	!var_defined('Current_UID_Table') ? var('Current_UID_Table'='null');
	!var_defined('User_Login_Name') ? var('User_Login_Name'=string);
	!var_defined('makeratorActionSessionNames') ? var('makeratorActionSessionNames'=array);
	!var_defined('makeratorActionSessionIds') ? var('makeratorActionSessionIds'=map);
	!var_defined('makeratorCacheNavbars') ? var('makeratorCacheNavbars'=map);
	
	!var_defined('pageLoadsUseAjax') ? var('pageLoadsUseAjax'=$default_pageLoadsUseAjax);
	!var_defined('forceAjaxContent') ? var('forceAjaxContent'=$default_forceAjaxContent);
	
	
	//	Authentication defaults
	//	
	//	Sets the default User type to `visitor`.
	//	
	//	This way, if we do not know what they are, they do not get
	//	to stuff they ought not.
	(!var_Defined('thisSearch')) ? var('thisSearch' = array);
	(!var_Defined('thisStatement')) ? var('thisStatement' = string);
	(!var_Defined('User_UID')) ? var('User_UID' = 'unknown');
	(!var_Defined('user_can_makerator_admin')) ? var('user_can_makerator_admin' = false);
	(!var_Defined('authenticationStatus')) ? var('authenticationStatus' = 'Unauthorized');
	(!var_Defined('expandedRecords')) ? var('expandedRecords' = map('uh'='oh'));
	
	/*
	If: $authenticationStatus == 'Unauthorized';
				$content_primary += $authenticationStatus;
				fail(-1, 'Unauth Error');
	else;
				$content_primary += $authenticationStatus;
				fail(-1, 'Auth Error');
	/if;
	*/
	
	If: $authenticationStatus == 'Unauthorized';
			// User is NOT logged in
			//User_Usertype_Title_UID

			//Sets the `User_Usertype_Title_UID` variable that tracks the Userºs real 
			//information
			If: (Var_Defined: 'User_Usertype_UID') == false;
					Var: 'User_Usertype_UID' = 'visitor';
			/If;
			
			//	User_Usertype_Title information
			//	
			//	Grabs and sets the access level for the User
			(!var_Defined('show_content_siteAdmin')) ? var('show_content_siteAdmin' = false);
			
			var: 'statement'  = 'SELECT * FROM ' $siteDB '.usertypes AS ut WHERE ut.UID = "' $User_Usertype_UID '" LIMIT 1';
			Inline: 
				$authForDatabase,
				-SQL=$statement,
				;
					fail_if(error_code != 0, error_code, error_msg);

					If: (Found_Count) == 1;
							rows;
									Var: 'User_Access_Level'	=  integer(column('Access_Level'));
									Var: 'User_Usertype_Title'			=  column('Title');
							/rows;
					Else;
					
							$__HTML_REPLY__ += (error_msg);
							abort;
							// need a better warning system built here
					
							If: error_code != 0;
									Error_Msg;
							/If;
							Error_SetErrorMessage: 'Error - User
							There has been an error in the authentication system of this website.';
							Error_SetErrorCode: 22001;
							If: error_code != 0;
									@Error_Msg;
									Abort;
							/If;
							Var: 'User_Access_Level'	=  100;
							Var: 'User_Usertype_Title'		=  'Visitor';
					/If;
			/Inline;

			
			
			
			
			//	Authetication information
			//	
			//	Here is the variabes that the authentication system reads.
			//	
			//	This is the information that the spoofing system presents to
			//	the pageprotection routines.
			
			Var: 'apparent_AuthenticationStatus' =	$authenticationStatus;
			Var: 'apparent_User_Access_Level'	   =  $User_Access_Level;
			Var: 'apparent_User_Usertype_Title'	   =  $User_Usertype_Title;
			Var: 'apparent_User_Usertype_UID'		   =  $User_Usertype_UID;
	Else;
			// nothing, for now...
	/If;
	
	
	
	
	
		//SuperUser and Admin stuff 
	
	If: $User_Access_Level <= 10;
			session_addVariable(-name='Authentication', 'show_content_siteAdmin');
			session_addVariable(-name='Authentication', 'user_can_makerator_admin');
			session_addVariable(-name='Authentication', 'spoof_User_Usertype_UID');
			session_addVariable(-name='Authentication', 'spoof_User_Access_Level');
			session_addVariable(-name='Authentication', 'spoof_AuthenticationStatus');
			session_addVariable(-name='Authentication', 'spoof_User_Usertype_Title');
			!var_defined('spoof_User_Usertype_UID') ? var('spoof_User_Usertype_UID'=$apparent_User_Usertype_UID);
			!var_defined('spoof_User_Access_Level') ? var('spoof_User_Access_Level'=$apparent_User_Access_Level);
			!var_defined('spoof_AuthenticationStatus') ? var('spoof_AuthenticationStatus'=$apparent_AuthenticationStatus);
			!var_defined('spoof_User_Usertype_Title') ? var('spoof_User_Usertype_Title'=$User_Usertype_Title);	
			!var_defined('show_content_siteAdmin') ? var('show_content_siteAdmin'=false);
			Var: 'apparent_User_Usertype_UID'		=  $spoof_User_Usertype_UID;
			Var: 'apparent_User_Access_Level'		=  $spoof_User_Access_Level;
			Var: 'apparent_AuthenticationStatus'	=  $spoof_AuthenticationStatus;
			Var: 'apparent_User_Usertype_Title'		=  $spoof_User_Usertype_Title;
			Var: 'user_can_makerator_admin'		=  true;
	/If;
	If: !(var_defined:'pagesTimeOut') || $pagesTimeOut == true;
			If: $apparent_AuthenticationStatus == 'Authorized';
					Var:
						'redirectPage'				=  true,
						'refreshLandingPage'		=  '/Account/TimeOut/',
						'refreshLandingParameters'	=  '?go=' (response_path),
						;
			Else;
					Var: 'redirectPage'			   =  false;
			/If;
	/If;


	/protect;
]