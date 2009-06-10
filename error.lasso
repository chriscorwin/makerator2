[//lasso

	// copy error message and code in case they get reset
	var(
		'msg' = error_msg,
		'code' = error_code
	);

	// do everything within a protect block to avoid unwanted recursion	
	protect;
	
	
		// set HTTP status to 500 ISE
		$__http_header__ = string_replaceregexp(
			$__http_header__,
			-find='(^HTTP\\S+)\\s+.*?\r\n',
			-replace='\\1 500 Internal Server Error\r\n'
		);
		
		!var_defined('content_error') ? var('content_error' = string);
		if($content_error->contains('No tag, type or constant was defined under the name'));
				tags_load('/_makerator/_tags/', -refresh=boolean(client_param('refreshtags')));
				redirect_url(response_filepath + '#/tags_reloaded/');
		/if;
		
		
		if($code);
			// log error to error database
			var('desc') = ('[' + client_url + ']' + ' (' + response_filepath + ')' + ' ' + $code + ': ' + $msg);	
			log_critical($desc);
		/if;

		handle_error;
// 			if(error_code == '-9963'); 
// 					auth_prompt; 
// 					//auth_prompt: -noabort, -noresponse; 
// 			/if; 
/* 			inline($authForFileOperations); */
/* 					log('/_logs/errors.txt'); */
/* 							'handle_error: =========================================' + '\r'; */
/* 							response_filepath + '\r'; */
/* 							include_currentPath + '\r'; */
/* 							date + '\r'; */
/* 							'client_params: ' + client_params + '\r'; */
/* 							'params: ' + params + '\r'; */
/* 							'params_up: ' + params_up + '\r'; */
/* 							'error_msg: ' + error_msg + '\r'; */
/* 							'-----------------------------------------' + '\r'; */
/* 					/log; */
/* 			/inline; */
		/handle_error;
		
		handle;
				'
<!DOCTYPE html >
<html>
	<head>
		<meta http-equiv="Content-Language" content="en">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>500 Internal Server Error</title> 
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/global/000_tripoli-combo.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/global/100_blueprint-css-screen-modified.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/global/204_jquery.jgrowl-1.2.0.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/global/205_jgrowl.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/global/205_superfish.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/global/207_superfish-navbar.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/global/700_navbarTopSkin.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/global/800_application.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/modules/buttons/buttons.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/modules/forms/forms.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/modules/listerators/listerators.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/themes/makeratordotcom/jquery-ui-1.7.1.custom-additions.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator_admin/css/themes/makeratordotcom/jquery-ui-1.7.1.custom.css">
	</head>
	
	<body class="error" >
		<div id="container" class="container content">
			<div id="header" class="column span-16 first last">
				<a href="/" id="masthead" title=" #{pageTitle}# " class="loader"><strong>Error</strong></a>
			</div>
			
			
			
			<div id="primary" class="column span-16 first last">
				<div id="primaryContentWrapper"  class="content loader">
					<div class="ui-widget">
						<div class="ui-widget-header ui-corner-top"">
								<h1>500 Internal Server Error</h1>
						</div>
						<div class="ui-widget-content ui-corner-bottom">
							<p>
								An error has occurred. The error has been logged and the system administrator has been notified.
							</p>
							<p>
								You may go back and try again now, or, if the error persists, try again later. We apologize for
								the inconvenience.
							</p>
						</div>
					</div>
					<div id="errorContent" class="content loader ui-layout-content">
						<div class="ui-widget">
							<div class="ui-state-error ui-corner-all">
								<p class=""><strong>Error reported by:</strong> error.lasso</p>
							</div>
						</div>
						<div class="ui-widget">
							<div class="ui-widget-header ui-corner-top">
								<h3>Error Information</h3>
							</div>
							<div class="ui-widget-content ui-corner-bottom">
								<p><strong>Error Code:</strong> ' + error_code + '</p>
								<pre>' + error_msg + '</pre>
							</div>
						</div>
						' + var('content_error') + '
					</div>
					<div id="debugContent" class="content loader ui-layout-content">
						' + var('content_debug') + '
					</div>
				</div>
			</div>
			
			<div id="footer" class="column span-16 first last">
				<div class="content loader ui-widget">
					<div class="ui-state-error ui-corner-all">
						<p><strong>Server Info:</strong> ' + server_name + ' running on ' + lasso_version + '</p>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
			';
		/handle;
	/protect;
]