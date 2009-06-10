[
define_atbegin: {

	local('requesttype') = (request_isajax ? 'AJAX' | 'Not Ajax');

	var('the_file_exists'=true);
	if(string(response_filepath) ==  '/');
		
		//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') --path is "/" -- including hub from line 11');
		//redirect_url('/Home/');
		$__HTML_REPLY__ = @include('/_makerator/hub.lasso');
		abort;
	else(
		string(response_filepath)->endswith('.lassoapp')
		|| (string(response_filepath)->endswith('.xml'))
		|| (string(response_filepath)->endswith('.html'))
		|| (string(response_filepath)->endswith('.las'))
		);
			// don't do nuffin
	else(string(response_filepath) -> endswith('.lasso'));
			//see if file exists
			protect;
					null(include_raw(response_filepath));
					handle_error;
							$the_file_exists = false;
					/handle_error;
			/protect;
		
			if($the_file_exists);
					//do nothing
					//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') -- request is for a file that exists -- including hub from line 31');
			else;
			
					//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') -- request ends with lasso -- including hub from line 34');
					$__HTML_REPLY__ = include: '/_makerator/hub.lasso';
					abort;
					
			/if;
	else;
			// run site
			string(response_filepath)->endswith('.inc') ? abort;
			
			local(
				'go' = true,
				'rf' = @response_filepath
			);
			
			(
				#rf->endswith('.lasso')
				|| #rf->endswith('.lassoapp')
				|| #rf->endswith('.LassoApp')
				|| #rf->endswith('.html')
				|| #rf->beginswith('/_makerator')
				|| #rf->beginswith('/assets')
				|| #rf->beginswith('/_Site')
				|| !(#rf->endswith('/'))
			) ? #go = false;
			//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') -- What is #go right now? ' #go);
			
			if(#go);
					//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') -- we are GO (' #go ') -- including hub from line 60');
					$__HTML_REPLY__ = @include('/_makerator/hub.lasso');
					abort;
					
					
			// workaround for behavior change in Apache 2.x.
			// updated for Apache 2.2.6 on Mac and Win
			else(#rf->endswith('/'));
					local('exts') = (: 'html', 'lasso');
					local('path') = string(#rf) + 'index.';
					
					iterate(#exts, local('i'));
						local('p') = #path + #i;
						local('continue') = true;
						//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') -- going to try extention: ' #i ' to (' #p ') from line 74');
						protect;
							null(include_raw(#p));
							
							handle_error;
								//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') -- error on: ' #i ' to (' #p ') from line 80:' error_msg '. Continue is set to FALSE.');
								#continue = false;
							/handle_error;
						/protect;
						//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') -- continue to (' #p ') is FALSE from line 84');
						
						!#continue ? loop_continue;
						//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') -- continue is TRUE, redirecting to (' #p ') from line 87');
						redirect_url(#p);
					/iterate;
					
					// if we got this far
					//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') -- So, the file does not exist and ends in a slash, let us have the hub handle it.');
					//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') -- including hub from line 93');
					$__HTML_REPLY__ = @include('/_makerator/hub.lasso');
					abort;
			else;
					local('path') = string(#rf) + '/';
					//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') -- redirecting to (' #path ') from line 98, added a "/" to it');
					redirect_url(#path);
			/if;
			
			
			//log_critical('URL_Handler (' + #requesttype + ' : ' + response_filepath + ') THE THING THAT SHOULD NEVER HAPPEN HAS HAPPENED! INCLUDING HUB FROM LINE 103!');
			$__HTML_REPLY__ = @include('/_makerator/hub.lasso');
			abort;
			
			//$__HTML_REPLY__ = response_filepath;

	/if;
}
]