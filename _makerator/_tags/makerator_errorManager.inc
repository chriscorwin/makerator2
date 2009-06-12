[
	define_tag(
		'errorManager'
	,	-namespace='makerator_'
	,	-priority='replace'
	,	-required='fileThatErrored'
	,	-required='errorCode'
	,	-required='errorMessage'
	,	-optional='actionStatement'
	,	-optional='params1'
	,	-optional='params2'
	);
			handle_error;
					var('desc') = ('Error Manager Error: [' + client_url + ']' + ' (' + response_filepath + ')' + ' ' + error_code + ': ' + error_msg);
					log_critical($desc);
			/handle_error;
			local('errorMap' = map(
				'include_currentPath' = #fileThatErrored
			,	'error_code' = #errorCode
			,	'error_msg' = #errorMessage
			));
			
			
			!var_defined('makerator_errorStack') ? var('makerator_errorStack' = array);
			!var_defined('listeratorAction') ? var('listeratorAction' = '');
			!var_defined('listeratorNoun') ? var('listeratorNoun' = '');
			!var_defined('listeratorVerb') ? var('listeratorVerb' = '');
			!var_defined('json_data') ? var('json_data' = map);
			!var_defined('content_pageTitle') ? var('content_pageTitle' = '');
			!var_defined('content_error') ? var('content_error' = '');
			!var_defined($listeratorAction + '_pathto') ? var(($listeratorAction + '_pathto') = '');
			params->size >= 4 ? #errorMap->insert('action_statement' = params->get(4));
			params->size >= 5 ? #errorMap->insert('params' = params->get(5));
			params->size >= 6 ? #errorMap->insert('params_up' = params->get(6));
			$makerator_errorStack->insert(#errorMap);
			var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
			$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
			$content_pageTitle = 'Error: ' + $content_pageTitle;
			$content_error += ('
				<div class="ui-widget">
					<div class="ui-state-error ui-corner-all">
						<p>
							<span class="ui-icon ui-icon-alert ui-icon-left">
								<strong class="ui-helper-hidden-accessible"></strong>
							</span>
							<strong>Error!</strong> 
							There has been an error: ' + #errorMessage + '
						</p>
					</div>
				</div>
			');
			
			var('desc') = ('Error Manager: [' + client_url + ']' + ' (' + response_filepath + ')' + ' ' + #errorCode + ': ' + #errorMessage);	
			log_critical($desc);
			
	/define_tag;
]
