[//I CAN HAS LASSO?
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
	
	



	var('c00k135') = 
		array(
				'Authentication'= '/',
				'MakeratorAction'='/',
				'uploadSession'='/',
				'process_login'='/',
			)
		;
	iterate($makeratorActionSessionNames, local('x'));
			$c00k135->insert(#x->first = #x->second);
	/iterate;
	
	
	Iterate: $c00k135, var('x');
			
			cookie_set:
				$x->first=session_ID(-name=$x->first),
				-Domain=(Server_Name),
				-Expires=-10000000,
				-Path=($x->second != '/') ? $makeratorActionSessionIds->find($x->first) | $x->second
				;
			cookie_set:
				$x->first=session_ID(-name=$x->first),
				-Domain=(Server_Name),
				-Expires=-10000000000,
				-Path=($x->second != '/') ? $makeratorActionSessionIds->find($x->first) | $x->second
				;
			cookie_set:
				$x->first=session_ID(-name=$x->first),
				-Domain=(Server_Name),
				-Expires=-100000000000000000,
				-Path=($x->second != '/') ? $makeratorActionSessionIds->find($x->first) | $x->second
				;
			Session_End: -Name=$x->first;
			Session_End: -Name=$x->first;
	/Iterate;
	inline('client_params'= array(
			'AuthSessionID'=session_ID(-name='AuthSessionID')
		,	'MakeratorActionSessionID'=session_id(-name='MakeratorActionSessionID')
		)
	);
			library('/_makerator/_library/sessions.lasso');
			Iterate: $c00k135, var('x');
					cookie_set:
						$x->first=session_ID(-name=$x->first),
						-Domain=(Server_Name),
						-Expires=-10000000,
						-Path=($x->second != '/') ? $makeratorActionSessionIds->find($x->first) | $x->second
						;
					cookie_set:
						$x->first=session_ID(-name=$x->first),
						-Domain=(Server_Name),
						-Expires=-10000000000,
						-Path=($x->second != '/') ? $makeratorActionSessionIds->find($x->first) | $x->second
						;
					cookie_set:
						$x->first=session_ID(-name=$x->first),
						-Domain=(Server_Name),
						-Expires=-100000000000000000,
						-Path=($x->second != '/') ? $makeratorActionSessionIds->find($x->first) | $x->second
						;
					Session_End: -Name=$x->first;
					Session_End: -Name=$x->first;
			/Iterate;
	/inline;


	/protect;
]
