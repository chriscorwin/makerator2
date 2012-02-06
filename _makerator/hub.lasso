[
	/* 
		Makerator
		
		@version: 2.0
		@authors: see /_makerator/_installer/about/authors.txt
		@license: 
	*/
	
	
	if(string(response_filepath)->equals('/reload_tags/') && boolean(client_param('reloadtags')));
			tags_load('/_makerator/_tags/', -refresh=boolean(client_param('reloadtags')));
			redirect_url('/#/tags_reloaded/');
	/if;
	
	
	library_once('/_makerator/config.lasso');
	$makerator_includes->insert('url_handler');
	$makerator_includes->insert(include_currentPath);
	$makerator_currentInclude							=	$makerator_includes->last;
	
	library_once('/_site/config.lasso');
	library_once('/_makerator/_library/sessions.lasso');
	inline($authForFileOperations);
			file_exists('/_site/_library/sessions.lasso') ? library_once('/_site/_library/sessions.lasso');
	/inline;
	
	handle;
			$makerator_currentInclude					=	$makerator_includes->last;
			$makerator_includes->remove;
	/handle;
	
	handle_error;
			// copy error message and code in case they get reset
			var(
				'msg' = error_msg,
				'code' = error_code
			);
		
			// do everything within a protect block to avoid unwanted recursion	
			protect;
					handle_error;
						var('desc') = ('HUB: handle_error\'s handle_error: [' + client_url + ']' + ' (' + response_filepath + ')' + ' ' + error_msg + ': ' + error_code);
						log_critical($desc);
						content_body = $desc;
					/handle_error;
					
					!var_defined('msg') ? var('msg' = string);
					if($msg->contains('No tag, type or constant was defined') && !($msg->contains('null->join')));
							log_critical('ERROR! (hub) "constant" (' + (request_isAjax ? 'AJAX' | 'Regular') + ' : ' + response_filepath + '):');
							var('desc') = ('HUB: handle_Error: [' + client_url + ']' + ' (' + response_filepath + ')' + ' ' + $code + ': ' + $msg);	
							log_critical($desc);
							log_critical('Reloading tags...');
							tags_load('/_makerator/_tags/', -refresh=true);
					/if;
					
					if($code);
							var('desc') = ('HUB: handle_Error: [' + client_url + ']' + ' (' + response_filepath + ')' + ' ' + $code + ': ' + $msg);	
							log_critical($desc);
					/if;
					
					if(!request_isAjax);
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
				<a href="/" id="masthead" title="Makerator: An Error Has Occured" class="loader"><strong>Error</strong></a>
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
								<p><strong>Error Code:</strong> ' + $code + '</p>
								<pre>' + $msg + '</pre>
							</div>
						</div>
					</div>
					<div id="debugContent" class="content loader ui-layout-content">
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
					else;
							makerator_errorManager($makerator_currentInclude, error_code, error_msg);
							!local_defined('json_return') ? local('json_return' = map);
							local('accept_header' = request_params->find('Accept'));
							if($code);
								// log error to error database
								var('desc') = ('Handled! [' + client_url + '] ' + $code + ': ' + $msg);
								log_critical($desc);
							/if;
							!local_defined('json_return') ? local('json_return') = map;
							#json_return->insert('error_msg' = error_msg);
							#json_return->insert('error_code' = error_code);
							#json_return->insert('response_filepath' = response_filepath);
							#json_return->insert('key' = response_filepath->split('/')->get(2));
							#json_return->insert('content_data' = '');
							#json_return->insert('content_pageTitle' = $content_pageTitle + ' - ' + $content_siteTitle);
							#json_return->insert(pair('content_primary' = lp_string_trimHTML(-html=@$content_primary)));
							#json_return->insert(pair('content_error' = lp_string_trimHTML(-html=@$content_error)));
							#json_return->insert(pair('content_debug' = lp_string_trimHTML(-html=@$content_debug)));
							#json_return->insert('scripts' = '');
							#json_return->insert('request_type' = 'AJAX - Error');
							#json_return->insert('accept_header' = request_params->find('Accept'));
							iterate($json_data, local('a_data'));
									if (#a_data->second->type == array);
											local('out' = array);
											iterate(#a_data->second, local('a_member'));
													#out->insert(encode_html(#a_member));
											/iterate;
											#json_return->insert(#a_data->first=#out);
									else;
											#json_return->insert(pair(#a_data->first = #a_data->second));
									/if;
							/iterate;
							#json_return->insert(pair('errorStack' = $makerator_errorStack));
							local('scripts_out') = string;
							iterate($json_scripts, local('a_script'));
									#scripts_out += #a_script + '\n';
							/iterate;
							#json_return->insert(pair('scripts'=#scripts_out));
							
							
							local('token' = string);
							iterate(#json_return, local('i'));
								#token += string(#i);
							/iterate;
							
							local('makerator_responseUID' = encrypt_hmac(
								-token=#token
							,	-password=server_name
							,	-digest='md5'
							,	-cram
							));
							#json_return->insert('makerator_responseUID' = #makerator_responseUID);
							
							
							content_type('application/json');
							content_body = encode_json(#json_return);
							content_body;
					/if;
			/protect;
	/handle_error;
	
	
	
	
	inline($authForFileOperations);
		file_exists('/_site/_library/asset_manager.inc') ? 	library('/_site/_library/asset_manager.inc') | library('/_makerator/_library/asset_manager.inc');
	/inline;
	
	
	var('levels' = response_path->split('/')->removeall('')&);
	if($levels->size);
			($levels->get(1)) != 'Home' ? $levels->insert('Home', 1);
	else;
			$levels = array('Home');
	/if;
	!var_defined('makerator_listerators') ? var('makerator_listerators'	=	set);
	(boolean(client_param('refresh_caches')) || $makerator_listerators->size == 0) ? $makerator_listerators = set;
	inline(
		$authForDatabase,
		-table='listerators',
		-sql='SELECT * FROM ' $tablePrefix+'listerators WHERE Display_Status != "Deleted"',
		-inlinename='listerators'
	);
			rows(-inlinename='listerators');
					if($makerator_listerators !>> (column('Keyword_URL') + '/'));
							(boolean(column('Keyword_URL')) + '/') ? $makerator_listerators->insert(column('Keyword_URL') '/');
					/if;
			/rows;
	/inline;
	
	
	var('content_pageTitle' = ($levels->join(' &#x3E; ')));
	//this is what is output in the <h2> and the <title> tag
	// this is what *would* have been the title before any errors but after we do the string manipulations
	var('content_pageTitle_base' = ($levels->last));
	var('section' = ($levels->second)); // this section var is useful both for the nav hiliting and for assigning a class to the body tag, in case there are section-specific CSS tricks we want to do
	var('body_id' = $content_pageTitle); //similar to seciton, but page-specific -- we save this w/o any of our string manipulations
	$section == '' ? $section = 'Home';
	//manipulate the content_pageTitle to make a human-friendly string
	$content_pageTitle == 'Home' ? $content_pageTitle = 'Home';
	$content_pageTitle->replace('Home &#x3E; ', '');
	$content_pageTitle->replace('~_~', '::::UNDERSCORE::::')
	&replace('~-~', '::::DASH::::')
	&replace('_and_', '&nbsp&amp;&nbsp;')
	&replace('~per-cent~', '%')
	&replace('%3f', '?')
	&replace('--', ': ')
	&replace('~~', ', ')
	&replace('~', '&rsquo;')
	&replace('__', ' / ')
	&replace('_', ' ')
	&replace('::::UNDERSCORE::::', '_')
	&replace('::::DASH::::', '-')
	;
	inline($authForFileOperations);
			//load template-configuration information that is session and/or location-specific
			include('/_makerator/templates/config.lasso');
			if(file_exists('/_site/templates/site-template-config.lasso'));
					//load site-specific template-config files, if they exist
					include('/_site/templates/site-template-config.lasso');
			/if;
	/inline;
	var('levels_count' = $levels->size);
	loop(
		-from=$levels_count,
		-to=1,
		-by=-1
	);
			var('level_' + loop_count = $levels->get(loop_count));
	/loop;
	loop(
		-from=1,
		-to=$levels_count,
		-by=1
	);
			var(
				'loop_count_001'						=	loop_count,
				'pathTo_level_' + loop_count + '_Array'	=	array,
				'pathTo_level_' + loop_count				=	'/'
			);
			loop($loop_count_001);
					var('loop_count_002' = loop_count);
					if(var('level_'+$loop_Count_002) != 'Home');
							var('pathTo_level_'+$loop_count_001+'_Array')->insert(var('level_'+$loop_count_002),$loop_count_002);
							var('pathTo_level_' + $loop_count_001)->append(var('level_' + $Loop_Count_002 + '/'));
					/If;
			/Loop;
	/loop;
	var(
		'thisLevel_Name' = var('level_'+$levels_count),
		'crumbtrail' = string,
		'loop_Count_001' = 0,
		'levels_names' = array
	);
	
	
	if(string(response_path)->contains('/account/'));
			library('/_makerator/_library/account.lasso');
	else(string(response_path)->beginsWith('/api/validation/'));
			library('/_makerator/_library/api_validation.lasso');
			abort;
	else($levels->size > 2 && (response_path)->beginswith($makerator_pathToAdmin) && ((local('fnd') := $makerator_listerators->find($levels->get(3)'/')) != array));
			var('level_to_get' = 3);
			var('listeratorContentType'						=	($makerator_listerators->find($levels->get($level_to_get)'/'))->first->removetrailing('/')&);
			var('listerator_CustomFileExists') = (file_exists(('/_site/listerators/'(($makerator_listerators->find($levels->get($level_to_get)))->first) + '/listerator_admin.lasso')));
			var('listerator_CustomFile') = (('/_site/listerators/'(($makerator_listerators->find($levels->get($level_to_get)))->first) + '/listerator_admin.lasso'));
			var('sql'=string);
			var(
					'these'								=	$listeratorContentType
				,	'this'								=	$listeratorContentType
				,	'listeratorContentType'				=	$listeratorContentType
			);
			$this->removetrailing('s');
			
			protect;
					handle_error;
						error_msg >> 'The position passed to "get" was invalid.' ? var('listeratorVerb' = string);
					/handle_error;
					var('listeratorVerb' = ($levels->get($level_to_get + 2)));
			/protect;
			
			protect;
					handle_error;
						error_msg >> 'The position passed to "get" was invalid.' ? var('listeratorNoun' = string);
					/handle_error;
					var('listeratorNoun' = ($levels->get($level_to_get + 1)));
			/protect;
			
			protect;
					handle_error;
						error_msg >> 'The position passed to "get" was invalid.' ? var('listeratorVerb' = string);
					/handle_error;
					!$listeratorVerb->size ? var('listeratorVerb' = ($levels->get($level_to_get + 1)));
			/protect;
			
			$listeratorNoun == 'create' ? $listeratorVerb = $listeratorNoun;
			$listeratorNoun == 'create' ? $listeratorNoun = string;
			$listeratorVerb == $listeratorNoun ? $listeratorVerb = string;
			var('listeratorAction' = 'listerator-' + $listeratorContentType + ($listeratorNoun->size ? $listeratorNoun) + ($listeratorVerb->size ? $listeratorVerb));
			if($listerator_CustomFileExists);
					library_once($listerator_CustomFile);
			else(file_exists('/_site/listerators/listerator_admin.lasso'));
					library_once('/_site/listerators/listerator_admin.lasso');
			else;
					library_once('/_makerator/listerators/listerator_admin.lasso');
			/if;
			if($show_content_siteAdmin);
					$content_siteAdminToolbar += '<div id="admincontent">';
					$content_siteAdminToolbar += include('/_makerator/_library/admin_links.lasso');
			/if;
			
			$content_primary += $content_siteAdminToolbar;
	else($levels->size > 2 && (response_path)->beginswith($makerator_pathToAdmin) && ((local('fnd') := $makerator_listerators->find($levels->get(3)'/')) != array));
			if(file_exists('/_site/listerators/'(($makerator_listerators->find($levels->get(3)'/'))->first)'listerator_admin.lasso'));
					//app-specific application hub
					$content_primary += include('/_site/listerators/'(($makerator_listerators->find($levels->get(3)'/'))->first)'listerator_admin.lasso');
			else(file_exists('/_site/listerators/listerator_admin.lasso'));
					//site-specific application hub
					$content_primary += include('/_site/listerators/'(($makerator_listerators->find($levels->get(3)'/'))->first)'listerator_admin.lasso');
			else;
					//the default application hub
					$content_primary += include('/_makerator/listerators/listerator_admin.lasso');
			/if;
	else(string(response_path)->beginswith($makerator_pathToAdmin) && $user_can_makerator_admin == true);
			$content_primary += include('/_makerator/_library/admin.lasso');
	else(string(response_path)->beginswith($makerator_pathToAdmin) && $apparent_AuthenticationStatus == 'Unauthorized');
			// this page does not exist
			
			var('content_pageTitle_base' = $content_pageTitle);
			$content_pageTitle = 'Oops! File Not Found (404)';
			
			$content_primary += ('
				<div class="ui-widget">
					<div class="ui-state-error ui-corner-all">
						<p>
							<span class="ui-icon ui-icon-alert ui-icon-left"><strong class="ui-helper-hidden-accessible"></strong></span>
							<strong>Error!</strong> The page you are looking for appears not to exist.
						</p>
					</div>
				</div>
			');



/* 			if(!(response_path)->beginswith($makerator_pathToAdmin)); */
/* 					$content_debug += include('/_makerator/_Library/page_create_form.lasso'); */
/* 			/if; */
/* 		else($levels->size	> 1 && ((local('fnd') := $makerator_listerators->find($levels->get(2)'/')) != array)); */
/* 				var('level_to_get' = 2); */
/* 				var('listeratorContentType' = (((($makerator_listerators->find($levels->get($level_to_get)'/'))->first))->removetrailing('/')&)); */
/* 				var('listerator_CustomFileExists') = (file_exists(('/_site/listerators/'(($makerator_listerators->find($levels->get($level_to_get)))->first) + '/public.lasso'))); */
/* 				var('listerator_CustomFile') = (('/_site/listerators/'(($makerator_listerators->find($levels->get($level_to_get)))->first) + '/public.lasso')); */
/* 				var('sql'=string); */
/* 				$sql += 'SELECT s.template, s.page_url, s.name, s.id, s.content FROM Pages AS s WHERE UCASE(s.page_url) = UCASE("' + $thisLevel_Name + '")'; */
/* 				var('show_page_create'=true); */
/* 				inline($authForDatabase, action_params, -sql=$sql); */
/* 					if(found_count >= 1); */
/* 							rows; */
/* 									var('thisURLpath' =	 (xs_cat->getURLpath(-id=column('id'), -cattable='Pages'))); */
/* 									($thisURLpath == '/') || ($thisURLpath == '/Home') ? $thisURLpath = '/Home'; */
/* 									//$content_primary += $thisURLpath; */
/* 									if(response_path >> $thisURLpath); */
/* 											$show_page_create=false; */
/* 											var('pageID' = column('id')); */
/* 											var('pageName' = column('name')); */
/* 											var('pageurl' = column('page_url')); */
/* 											var('page_content' = column('content')); */
/* 									/if; */
/* 							/rows; */
/* 					/if; */
/* 				/inline; */
/* 				var( */
/* 					'these'=($listeratorContentType), */
/* 					'this'=($listeratorContentType), */
/* 				); */
/* 				$this->removetrailing('s'); */
/* 				var('listeratorAction' = 'Makerator_Action'); */
/* 				var(($listeratorAction + '_pathTo') = '/' + $listeratorContentType + '/'); */
/* 				include_once('/_makerator/_Library/REW_Initialization.lasso'); */
/* 				if($listerator_CustomFileExists); */
/* 						library_once($listerator_CustomFile); */
/* 				else(file_exists('/_site/listerators/public.lasso')); */
/* 						library_once('/_site/listerators/public.lasso'); */
/* 				else; */
/* 						library_once('/_makerator/listerators/public.lasso'); */
/* 				/if; */
/* 				if($show_content_siteAdmin); */
/* 						$content_siteAdminToolbar += '<div id="admincontent">'; */
/* 						$content_siteAdminToolbar += include('/_makerator/_library/admin_links.lasso'); */
/* 						($show_page_create == false) ? $content_siteAdminToolbar += include('/_makerator/_Library/admin_toggle_page_visibility.lasso'); */
/* 				/if; */
/* 		else($levels->size > 2 && ((local('fnd') := $makerator_listerators->find($levels->get(3)'/')) != array)); */
/* 				var('level_to_get' = 3); */
/* 				var('listeratorContentType' = (((($makerator_listerators->find($levels->get($level_to_get)'/'))->first))->removetrailing('/')&)); */
/* 				var('sql'=string); */
/* 				$sql += 'SELECT s.template, s.page_url, s.name, s.id, s.content FROM Pages AS s WHERE UCASE(s.page_url) = UCASE("' + $thisLevel_Name + '")'; */
/* 				var('show_page_create'=true); */
/* 				inline($authForDatabase, action_params, -sql=$sql); */
/* 					if(found_count >= 1); */
/* 							rows; */
/* 									var('thisURLpath' =	 (xs_cat->getURLpath(-id=column('id'), -cattable='Pages'))); */
/* 									($thisURLpath == '/') || ($thisURLpath == '/Home') ? $thisURLpath = '/Home'; */
/* 									$content_primary += $thisURLpath; */
/* 									if(response_path >> $thisURLpath); */
/* 											$show_page_create=false; */
/* 											var('pageID' = column('id')); */
/* 											var('pageName' = column('name')); */
/* 											var('pageurl' = column('page_url')); */
/* 											var('page_content' = column('content')); */
/* 									/if; */
/* 							/rows; */
/* 					/if; */
/* 				/inline; */
/* 				var( */
/* 					'these'=$listeratorContentType, */
/* 					'this'=$listeratorContentType, */
/* 				); */
/* 				$this->removetrailing('s'); */
/* 				Var: 'listeratorAction' = ('Makerator_Action'); */
/* 				var(($listeratorAction + '_pathTo')='/'$listeratorContentType'/'); */
/* 				include('/_makerator/_Library/REW_Initialization.lasso'); */
/* 				if(file_exists('/_site/listerators/'(($makerator_listerators->find($levels->get($level_to_get)'/'))->first)'public.lasso')); */
/* 						//custom plugin hub (try never to use!) */
/* 						$content_primary += include('/_site/listerators/'(($makerator_listerators->find($levels->get($level_to_get)'/'))->first)'public.lasso'); */
/* 				else(file_exists('/_site/listerators/plugin.lasso')); */
/* 						//custom plugin hub (try never to use!) */
/* 						$content_primary += include('/_site/listerators/public.lasso'); */
/* 				else; */
/* 						//the default plugin hub */
/* 						$content_primary += include('/_makerator/listerators/public.lasso'); */
/* 				/if; */
/* 				$content_siteAdminToolbar += '<div id="admincontent">'; */
/* 				$content_siteAdminToolbar += include('/_makerator/_Library/admin_links.lasso'); */
/* 				($show_page_create == false) ? $content_siteAdminToolbar += include('/_makerator/_Library/admin_toggle_page_visibility.lasso'); */
// 	else(file_exists('/_site/pages/'+((((response_filepath)->replace('/','__')&)->removeleading('__')&)->removeTrailing('__')&)+'.lasso'));
// 			
	else;
			
			
			
			//search for page content
			var(
				'sql' = string
			,	'pagesContentFound' = false
			,	'dbContentFound' = false
			,	'show_page_create'=false
			,	'dbPageFound' = false
			);
			
			if(response_path == '/');
					// look for file-based content for '/'
					local('pageContent' = asset_manager->loadpage('home'));
					if(#pageContent != '');
							$content_primary += #pageContent;
							$pagesContentFound = true;
					/if;
					$sql += 'SELECT s.template, s.page_url, s.name, s.id, s.content FROM ' + $tablePrefix + 'pages AS s ORDER BY s.lft LIMIT 1';
			else;
					// look for file-based content
					local('pageContent' = asset_manager->loadpage(response_filepath));
					if(#pageContent != '');
							$content_primary += #pageContent;
							$pagesContentFound = true;
					/if;
					$sql += 'SELECT s.template, s.page_url, s.name, s.id, s.content FROM ' + $tablePrefix + 'pages AS s WHERE UCASE(s.page_url) = UCASE("' + $thisLevel_Name + '")';
			/if;
			inline($authForDatabase, -sql=$sql);
					if(found_count >= 1);
							$dbPageFound = true;
							rows;
									var('thisURLpath' =	 (xs_cat->getURLpath(-id=column('id'), -cattable=$tablePrefix + 'pages')));
									$thisURLpath->beginswith('//') ? $thisURLpath->removeleading('//');
									!$thisURLpath->beginswith('/') ? ($thisURLpath = '/' + $thisURLpath);
									($thisURLpath == '/Home/') || ($thisURLpath == 'Home') || ($thisURLpath == 'Home/') ? $thisURLpath = '/';
									if($thisURLpath == response_path || $thisURLpath == '' && response_path == '/');
											$show_page_create = false;
											var('pageID' = column('id'));
											var('templateID' = column('template'));
											inline(-sql='SELECT name FROM ' + $tablePrefix + 'templates WHERE id='$templateID);
													if(found_count == 1);
															rows;
																	$templating_templateName =  column('name');
															/rows;
													else;
													/if;
											/inline;
											
											var('pageName' = column('name'));
											var('pageurl' = column('page_url'));
											var('page_content' = column('content'));
											$page_content != '' ? $dbContentFound = true;
											$content_pageTitle = string(column('name'));
											$content_primary += @(string(column('content')));
											var('path_to_page' = (xs_cat->getURLpath(-id=$pageID, -cattable=($tablePrefix + 'pages'))));
											if((response_path)->beginswith($makerator_pathToAdmin));
													$content_siteAdminToolbar += '<div id="admincontent">';
											else(string(response_path)->equals('/'));
													if($show_content_siteAdmin);
															$content_siteAdminToolbar += '<div id="admincontent">';
															$content_siteAdminToolbar += include('/_makerator/_Library/admin_links.lasso');
															$content_siteAdminToolbar += include('/_makerator/_Library/edit_this_page.lasso');
													/if;
											else;
													if($show_content_siteAdmin);
															$content_siteAdminToolbar += '<div id="admincontent">';
															$content_siteAdminToolbar += include('/_makerator/_library/edit_this_page.lasso');
															$content_siteAdminToolbar += include('/_makerator/_library/admin_toggle_page_visibility.lasso');
															$content_siteAdminToolbar += include('/_makerator/_library/admin_button_changeurl.lasso');
															// $content_siteAdminToolbar += include('/_makerator/_library/admin_button_renamepage.lasso');
															// $content_siteAdminToolbar += include('/_makerator/_library/admin_button_deletepage.lasso');
															$content_siteAdminToolbar += include('/_makerator/_library/admin_links.lasso');
															// site-specific admin links
															inline($authForFileOperations);
																	if(file_exists('/_site/_library/admin_links.lasso'));
																			include('/_site/_library/admin_links.lasso');
																	/if;
															/inline;
													/if;
											/if;
											$show_page_create == false ? loop_abort;
									else;
											var('path_to_page'=response_path);
											$show_page_create = true;
									/if;
							/rows;
							if(!$pagesContentFound && !$dbContentFound && $dbPageFound);
									$content_primary += ('
										<div class="ui-widget">
											<div class="ui-state-highlight ui-corner-all">
												<p>
													<span class="ui-icon ui-icon-info ui-icon-left"><strong class="ui-helper-hidden-accessible"></strong></span>
													<strong>Attention!</strong> This URL does not currently have any content associated with it.
												</p>
											</div>
										</div>
									');
							/if;
					else;
							handle(!$pagesContentFound && !$dbContentFound);
									// this page does not exist
									var('path_to_page'=response_path);
									var('content_pageTitle_base' = $content_pageTitle);
									$content_pageTitle = 'Oops! File Not Found (404)';
									$content_primary += ('
										<div class="ui-widget">
											<div class="ui-state-error ui-corner-all">
												<p>
													<span class="ui-icon ui-icon-alert ui-icon-left"><strong class="ui-helper-hidden-accessible"></strong></span>
													<strong>Error!</strong> The page you are looking for appears not to exist.
												</p>
											</div>
										</div>
									');
							/handle;
					/if;
			/inline;
	/if;
	
	
	if(request_isajax);
			protect;
					!local_defined('json_return') ? local('json_return' = map);
					local('accept_header' = request_params->find('Accept'));
					handle_error;
							var(
								'msg' = error_msg,
								'code' = error_code
							);
							if($code);
								// log error to error database
								var('desc') = ('Handled! [' + client_url + '] ' + $code + ': ' + $msg);
								log_critical($desc);
							/if;
							!local_defined('json_return') ? local('json_return') = map;
							#json_return->insert('error_msg' = error_msg);
							#json_return->insert('error_code' = error_code);
							#json_return->insert('response_filepath' = response_filepath);
							#json_return->insert('key' = response_filepath->split('/')->get(2));
							#json_return->insert('content_data' = '');
							#json_return->insert('content_pageTitle' = $content_pageTitle + ' - ' + $content_siteTitle);
							#json_return->insert(pair('content_primary' = lp_string_trimHTML(-html=@$content_primary)));
							#json_return->insert(pair('content_error' = lp_string_trimHTML(-html=@$content_error)));
							#json_return->insert(pair('content_debug' = lp_string_trimHTML(-html=@$content_debug)));
							#json_return->insert('scripts' = '');
							#json_return->insert('request_type' = 'AJAX - Error');
							#json_return->insert('accept_header' = request_params->find('Accept'));
							iterate($json_data, local('a_data'));
									if (#a_data->second->type == array);
											local('out' = array);
											iterate(#a_data->second, local('a_member'));
													#out->insert(encode_html(#a_member));
											/iterate;
											#json_return->insert(#a_data->first=#out);
									else;
											#json_return->insert(pair(#a_data->first = #a_data->second));
									/if;
							/iterate;
							#json_return->insert(pair('errorStack' = $makerator_errorStack));
							local('scripts_out') = string;
							iterate($json_scripts, local('a_script'));
									#scripts_out += #a_script + '\n';
							/iterate;
							#json_return->insert(pair('scripts'=#scripts_out));
							
							
							local('token' = string);
							iterate(#json_return, local('i'));
								#token += string(#i);
							/iterate;
							
							local('makerator_responseUID' = encrypt_hmac(
								-token=#token
							,	-password=server_name
							,	-digest='md5'
							,	-cram
							));
							#json_return->insert('makerator_responseUID' = #makerator_responseUID);
							
							
							content_type('application/json');
							content_body = encode_json(#json_return);
							content_body;
					/handle_error;
					
					
					if(#accept_header >> 'json');
							if(client_param('setOption') == true);
									// we only alow a few settings to be changed via ajax, and the are named explicitly
									if(client_param('name') == 'pageLoadsUseAjax');
											$pageLoadsUseAjax = client_param('value');
									/if;
							/if;
							
							#json_return->insert('errorStack' = $makerator_errorStack);
							#json_return->insert('handled_by' = 'Makerator Hub: JSON');
							#json_return->insert('error_msg' = error_msg);
							#json_return->insert('error_code' = error_code);
							#json_return->insert('response_filepath' = response_filepath);
							#json_return->insert('key' = response_filepath->split('/')->get(2));
							#json_return->insert('content_data' = '');
							#json_return->insert('content_pageTitle' = $content_pageTitle + ' - ' + $content_siteTitle);
							#json_return->insert('scripts' = '');
							#json_return->insert('accept_header' = #accept_header);
							
							
							iterate($json_data, local('a_data'));
									if (#a_data->second->type == array);
											local('out' = array);
											iterate(#a_data->second, local('a_member'));
													#out->insert(encode_html(#a_member));
											/iterate;
											#json_return->insert(#a_data->first=#out);
									else;
											#json_return->insert(pair(#a_data->first = #a_data->second));
									/if;
							/iterate;
							
							#json_return->insert(pair('content_primary' = $content_primary));
							#json_return->insert(pair('content_error' = $content_error));
							#json_return->insert(pair('content_debug' = $content_debug));
							
							local('scripts_out') = string;
							iterate($json_scripts, local('a_script'));
									#scripts_out += #a_script + '\n';
							/iterate;
							#json_return->insert(pair('scripts'=#scripts_out));
							
							
							local('token' = string);
							iterate(#json_return, local('i'));
									#token += string(#i);
							/iterate;
							local('makerator_responseUID' = encrypt_hmac(
								-token=#token
							,	-password=server_name
							,	-digest='md5'
							,	-cram
							));
							#json_return->insert('makerator_responseUID' = #makerator_responseUID);
							
							// content_type('application/json');
							// content_type('text/javascript');
							content_body = encode_json(#json_return);
							
					else(#accept_header >> 'html' || #accept_header >> 'xhtml');
							iterate($templating_templateModules, 
								local('module')
							);
									local(
										'slot'							=	'(\<![ \r\n\t]*--)?( *)(\#\{' + #module + '\}\#)( *)(--\>)?'
									,	'modulePath'					=	'' + #module + '.inc'
									,	'contentForSlot'				=	string
									);
									
									var_defined('content_' + #module + '_leading')		?	#contentForSlot += var('content_' + #module + '_leading');
									var_defined('content_' + #module)					?	#contentForSlot += var('content_' + #module);
									file_exists(#modulePath)							?	#contentForSlot += asset_manager->loadmodule(#modulePath);
									var_defined('content_' + #module + '_trailing')		?	#contentForSlot += var('content_' + #module + '_trailing');
									
									content_body += lp_string_trimHTML(-html=@#contentForSlot);
							/iterate;
					/if;
					@content_body;
					abort;
			/protect;
	else(string(client_type) >> 'Flash');
			protect;
					handle_error;
						log_critical('error in flash request: ' + error_msg);
					/handle_error;
					local('json_return') = map;
					#json_return->insert('error_msg' = error_msg);
					#json_return->insert('error_code' = error_code);
					#json_return->insert('response_filepath' = response_filepath);
					#json_return->insert('key' = response_filepath->split('/')->get(2));
					#json_return->insert('content_data' = '');
					#json_return->insert('scripts' = '');
					#json_return->insert('request_type' = 'Non AJAX - Flash requesting');
					if(client_param('content_body_dataType') == 'text' );
							log_critical('Not AJAX Option 1: plain text)');
							local('scripts_out') = string;
							iterate($json_scripts, local('a_script'));
									#scripts_out += #a_script + '\n';
							/iterate;
							#json_return->insert(pair('scripts'=#scripts_out));
							content_body = $content_primary;
							(content_body)->trim;
					/if;
					inline($authForFileOperations);
							log('/assets/logs/stuff.txt');
									(Server_Date: -Extended) ' ' (Server_Time: -Extended) ' ' (Client_IP) ' ' (Client_Type) ' ' (Response_FilePath) ' ' (Error_CurrentError) '\r\r';
									content_body + '\r\r==============\r\r\r\r';
							/log;
					/inline;
					content_body;
			/protect;
	else;
			
			
			$content_pageTitle += ' - ' + $content_siteTitle;
			
			local('testForJavascript' = false);
			
			if($default_pageLoadsUseAjax && $default_forceAjaxContent);
					if($pageLoadsUseAjax && response_filepath == '/');
							// nothing
					else($pageLoadsUseAjax && response_filepath != '/');
							#testForJavascript = true;
							$pageLoadsUseAjax = false;
					else(client_param('j') == 't');
							#testForJavascript = false;
							$pageLoadsUseAjax = true;
					else(client_param('j') == 'u');
							#testForJavascript = true;
					else($pageLoadsUseAjax && response_filepath != '/');
							$pageLoadsUseAjax = false;
							redirect_url('/#' + response_filepath);
					else(action_param('j') == 'f');
							$forceAjaxContent = false;
							$pageLoadsUseAjax = false;
					else(!$pageLoadsUseAjax && response_filepath == '/');
							#testForJavascript = false;
					else(!$pageLoadsUseAjax && response_filepath != '/');
							#testForJavascript = false;
					/if;
			/if;
			inline($authForFileOperations);
					
					#testForJavascript ? var('content_header_trailing' = '
							<div id="javascriptTester" class="ui-widget">
								<div class="ui-state-highlight ui-corner-all">
									<h1>
										<span class="ui-icon ui-icon-info ui-icon-left"><strong class="ui-helper-hidden-accessible"></strong></span>
										<strong>Testing Javascript</strong>
									</h1>
									<p>We are currently testing your browsers ability to handle javascript enabled content.</p>
									<p class=""><strong>$pageLoadsUseAjax:</strong> ' + $pageLoadsUseAjax + '</p>
									<p class=""><strong>$forceAjaxContent:</strong> ' + $forceAjaxContent + '</p>
								</div>
							</div>
					');
					
					if(string(response_filepath)->beginswith($makerator_pathToAdmin) && $user_can_makerator_admin == true);
							var('template' = 'admin');
							$content_siteAdminToolbar += include('/_makerator/_library/admin_links.lasso');
							$user_can_makerator_admin ? $content_siteAdminToolbar += '</div>';
							var('rendered' = asset_manager->load('/_makerator/templates/' $templating_templateName '.lasso'));
					else($apparent_AuthenticationStatus == 'Authorized');
							if(file_exists('/_site/templates/' + $templating_templateName + '.lasso'));
									var('rendered' = asset_manager->load('/_site/templates/' + $templating_templateName + '.lasso'));
							else;
									var('rendered' = asset_manager->load('/_makerator/templates/base.lasso'));
							/if;
					else;
							if(file_exists('/_site/templates/' + $templating_templateName + '.lasso'));
									var('rendered' = asset_manager->load('/_site/templates/' + $templating_templateName + '.lasso'));
							else;
									var('rendered' = asset_manager->load('/_makerator/templates/base.lasso'));
							/if;
					/if;
					
					
					if(file_exists('/_site/templates/' + $templating_templateName + '.lasso'));
							var('rendered' = asset_manager->load('/_site/templates/' + $templating_templateName + '.lasso'));
					else;
							var('rendered' = asset_manager->load('/_makerator/templates/base.lasso'));
					/if;
					iterate($templating_templateModules, 
						local('module')
					);
							local(
								'slot'							=	'(\<![ \r\n\t]*--)?( *)(\#\{' + #module + '\}\#)( *)(--\>)?'
							,	'modulePath'					=	'' + #module + '.inc'
							,	'contentForSlot'				=	string
							);
							
							var_defined('content_' + #module + '_leading')		?	#contentForSlot += var('content_' + #module + '_leading');
							var_defined('content_' + #module)					?	#contentForSlot += var('content_' + #module);
							#contentForSlot += asset_manager->loadmodule(#modulePath);
							var_defined('content_' + #module + '_trailing')		?	#contentForSlot += var('content_' + #module + '_trailing');
							
							
							$rendered = string_replaceRegExp(
									$rendered
								,	-find=#slot
								,	-replace			=	@#contentForSlot
								,	-ignoreCase
							);
					/iterate;
					
					// add the rendered stuff to to the page buffer
					content_body = (@$rendered);
					asset_manager->cache;
					local('x');
					if($templating_inlineJquery->size);
							$templating_trailingHtml += '<script type="text/javascript">';
							$templating_trailingHtml += '
								try {
											console.log(\'init console... done\');
									}
									catch(e) {
											console = {
													log: function() {},
													group: function() {},
													groupEnd: function() {}
											}
									}
									$(function(){
							';
							iterate($templating_inlineJquery, #x);
									$templating_trailingHtml += #x '\r';
							/iterate;
							$templating_trailingHtml += '});\r';
							$templating_trailingHtml += '<\/script>\r';
					/if;
					if($templating_inlineJavascript->size);
							$templating_trailingHtml += '<script type="text/javascript">\r';
							iterate($templating_inlineJavascript, #x);
									$templating_trailingHtml += #x '\r';
							/iterate;
							$templating_trailingHtml += '<\/script>\r';
					/if;
					// display the page
					$templating_trailingHtml->size > 1 ? content_body = string(content_body)->replace('</body>', $templating_trailingHtml + '</body>')&;
					
					
					if($makerator_saveRenderedVersion);
							content_body += '<!-- 
This file was automatically generated by Makerator.
Render date/time: ' + date->format('%QT%T') + '
Render Path: ' + $makerator_renderedVersionPath + response_path + 'index.html
 -->';
							var('out_rendered' = string(content_body));
							!file_exists($makerator_renderedVersionPath + response_path + 'index.html') ? file_Create($makerator_renderedVersionPath + response_path + 'index.html');
							file_Write(($makerator_renderedVersionPath + response_path + 'index.html'), $out_rendered, -fileOverWrite);
					/if;
					content_body;
					
			/inline;
	/if;
]