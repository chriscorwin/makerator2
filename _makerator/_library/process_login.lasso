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
	
	
	
	var(
		'submitted_Login_Name' = action_param('this')
	,	'submitted_Password'=action_param('that')
	,	'remember'=action_param('remember')
	);
	
	
	// Does User email exist at all?
	var('statement'='
		SELECT 
			CONCAT(u.First_Name, \' \', u.Last_Name) AS name,
			u.Last_Logged_In,
			u.Number_Of_Logins
		FROM ' + $tablePrefix + 'users AS u JOIN ' + $tablePrefix + 'users_usertypes AS uut ON u.UID = uut.usersUID 
		LEFT JOIN ' + $tablePrefix + 'usertypes AS ut ON uut.usertypesUID = ut.UID
		WHERE
			u.Login_Name = "' + $submitted_Login_Name + '"
	');
	inline($authForDatabase, -SQL=$statement);
			if(found_count != 0);
					/*
						============================================================
						Have email - check password...
						------------------------------------------------------------
					*/
					var('statement'='
						SELECT 
							CONCAT(u.First_Name, \' \', u.Last_Name) AS name,
							u.Last_Logged_In,
							ut.Access_Level, ut.UID AS usertypesUID, ut.Title AS Usertype_Title,
							u.Number_Of_Logins, u.UID AS usersUID, u.First_Name, u.Last_Name, u.login_name
							
						FROM ' + $tablePrefix  + 'users' + ' AS u JOIN ' + $tablePrefix + 'users_usertypes AS uut ON u.UID = uut.usersUID 
						LEFT JOIN ' + $tablePrefix + 'usertypes AS ut ON uut.usertypesUID = ut.UID
						WHERE
							u.Login_Name = "' + $submitted_Login_Name + '" AND
							u.Password = "' + $submitted_Password + '"
						LIMIT 1
					');
					inline($authForDatabase, -SQL=$statement);
						if(found_count == 1);
							/*
								============================================================
								Password matched...
								------------------------------------------------------------
							*/
							var('authenticationStatus'='Authorized');
							rows;
									var(
										'User_UID'						=	column('usersUID')
									,	'User_Login_Name'				=	column('login_name')
									,	'User_Usertype_UID'				=	column('usertypesUID')
									,	'User_Usertype_Title'			=	column('Usertype_Title')
									,	'spoof_User_Usertype_UID'		=	column('usertypesUID')
									,	'spoof_AuthenticationStatus'		=	'Authorized'
									,	'User_First_Name'				=	column('First_Name')
									,	'User_Name_Last'				=	column('Last_Name')
									,	'User_Last_Logged_In'			=	column('Last_Logged_In')
									,	'User_Number_of_Logins_Old'		=	integer(column('Number_of_Logins'))
									,	'User_Access_Level'				=	integer(column('Access_Level'))
									);
							/rows;
							
							
							
							/*
								============================================================
								Authetication information
								------------------------------------------------------------
								Here is the variabes that the authentication system reads.
								
								This is the information that the spoofing system presents to
								the pageprotection routines.
								------------------------------------------------------------
							*/
							var(
								'apparent_AuthenticationStatus'			=	$authenticationStatus
							,	'apparent_User_Access_Level'				=	$User_Access_Level
							,	'User_Usertype_Title'					=	$User_Usertype_Title
							,	'apparent_User_Usertype_UID'				=	$User_Usertype_UID
							);
								
								
								
								
								
							/*
								============================================================
								SuperUser & Admin stuff --->
								------------------------------------------------------------
							*/
							if($User_Access_Level <= 1);
									/*
										============================================================
										"spoofUserTypeUID"
										------------------------------------------------------------
										Sets the `spoofUserTypeUID` variable that tracks the
										UserTypes.uid that is being spoofed.
										------------------------------------------------------------
									*/
									!var_defined('spoof_User_Usertype_UID') ? var('spoof_User_Usertype_UID'=$apparent_User_Usertype_UID);
									/*
										============================================================
										Spoof UserType information
										------------------------------------------------------------
										Grabs and sets the access level for the User
										------------------------------------------------------------
									*/
									inline($authForDatabase
									,	-search
									,	-table		=	$tablePrefix + 'usertypes'
									,	-operator	=	'eq'
									,	'UID'		=	$spoof_User_Usertype_UID
									,	-maxRecords	=	1
									);
											if(found_count == 1);
													rows;
															var(
																'spoof_User_Access_Level'		=	integer(column('Access_Level'))
															,	'spoof_User_Usertype_Title'		=	column('Title')
															);
													/rows;
													/*
														============================================================
														Apparent Authetication information
														------------------------------------------------------------
														Here is the variables that the authentication system reads.
														
														This is the information that the spoofing system presents to
														the page protection routines.
														------------------------------------------------------------
													*/
													var(
														'apparent_User_Usertype_UID'				=	$spoof_User_Usertype_UID
													,	'apparent_User_Access_Level'				=	$spoof_User_Access_Level
													,	'apparent_AuthenticationStatus'			=	$spoof_AuthenticationStatus
													,	'apparent_User_Usertype_Title'			=	$spoof_User_Usertype_Title
													);
											/if;
									/inline;
							/if;
							/*
								------------------------------------------------------------
								End - SuperUser & Admin
								============================================================
							*/
							
							
							
							
							
							// Add 1 to number of logins
							$User_Number_of_Logins_Old += 1;
							
							
							
							
							/*
								============================================================
								Update login information
								------------------------------------------------------------
							*/
							inline($authForDatabase
							,	-update
							,	-table				=	$tablePrefix + 'users'
							,	-keyfield			=	'uid'
							,	-keyvalue			=	$user_uid
							,	'number_of_logins'	=	$user_number_of_logins_old
							,	'last_logged_in'	=	date_format(date, -format='%q %t')
							);/inline;
							
							
							
							
							/*
								============================================================
								Success! -- User is now signed in
								------------------------------------------------------------
							*/
							$process_login_attempts			=	0;
							$process_login_action			=	'signIn';
							$process_login_status			=	'success';
							$process_login_message			=	'Signed In Successfully';
							$process_login_reason			=	'success';
							$process_login_error_msg			=	error_noError;
							$process_login_error_code		=	error_noError(-errorCode);
							$json_data->insert('error_msg'	=	$process_login_error_msg);
							$json_data->insert('error_code'	=	$process_login_error_code);
							
							
						else;
							/*
								============================================================
								Sign in Error - password wrong
								------------------------------------------------------------
							*/
							//	bump Login tries by one
							$process_login_attempts += 1;
							
							
							/*
								============================================================
								Fail! -- User is NOT signed in
								------------------------------------------------------------
							*/
							$process_login_action			=	'signIn';
							$process_login_status			=	'error';
							$process_login_message			=	'The password you supplied does not match our reccords.';
							$process_login_reason			=	'passwordIncorrect';
							$process_login_error_msg			=	error_invalidPassword;
							$process_login_error_code		=	error_invalidPassword(-errorCode);
							$json_data->insert('error_msg'	=	$process_login_error_msg);
							$json_data->insert('error_code'	=	$process_login_error_code);
						/if;
					/inline;
					
					
			else;
					/*
						============================================================
						Fail! -- No account matched
						------------------------------------------------------------
					*/
					$process_login_attempts				+= 1;
					$process_login_action				= 'signIn';
					$process_login_status				= 'error';
					$process_login_message				= 'The username and password you supplied do not match our reccords.';
					$process_login_reason				= 'noAccountFound';
					$process_login_error_msg			=	error_InvalidUserName;
					$process_login_error_code		=	error_InvalidUserName(-errorCode);
					$json_data->insert('error_msg'	=	$process_login_error_msg);
					$json_data->insert('error_code'	=	$process_login_error_code);
			/if;
	/inline;
	
	
	/protect;
]