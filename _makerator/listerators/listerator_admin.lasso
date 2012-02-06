[
	
	
// 	$makerator_includes->insert(include_currentPath);
// 	$makerator_currentInclude							=	$makerator_includes->last;
// 	handle;
// 			$makerator_includes->remove;
// 			$makerator_currentInclude					=	$makerator_includes->last;
// 	/handle;
// 	
// 	
// 	
// 	handle_error;
// 			makerator_errorManager(
// 				$makerator_currentInclude
// 			,	error_code
// 			,	error_msg
// 			,	action_statement
// 			);
// 	/handle_error;
	
	
	
// 	$content_primary += '<pre>' + (date->split('/')&->join('-')&->split(' ')&->join('_')&&->split(':')&->join('--')& ) + '</pre>';
	
	$content_siteAdminToolbar += '<ul id="adminToolbar" class="ui-helper-reset ui-helper-clearfix sf-menu sf-navbar ui-widget ui-widget-header ui-corner-all listerator-toolbar ui-widget-toolbar">';
	// Look for this Listerator in the Listorators table, and get heuristic settings from there
	// if there are none, no problem! the defaults will work
	var('getListeratorSettings'='SELECT * FROM ' + $tablePrefix + 'listerators WHERE Keyword_URL = "' + $listeratorContentType + '"');
	inline(
		$authForDatabase
	,	-sql=$getListeratorSettings
	);
			if(found_count == 1);
				// we have configured heuristics
				rows;
						var(
							'these'											=	column('Pluralized')
						,	'this'											=	column('Singular')
						,	$listeratorAction + '_table'					=	column('Table_Name')
						,	$listeratorAction + '_titleFieldName'			=	column('Title_Field_Name')
						);
						
				/rows;
			else;
					var('these'=$listeratorContentType, 'this'=$listeratorContentType);
					if($listeratorContentType->endswith('y'));
							$these->removetrailing('y');
							$these += 'ies';
							var($listeratorAction + '_table') = $these;
							var($listeratorAction + '_titleFieldName') = 'Title';
					else($listeratorContentType->endswith('ies'));
							$this->removetrailing('ies');
							$this += 'y';
							var($listeratorAction + '_table') = $listeratorContentType;
							var($listeratorAction + '_titleFieldName') = 'Title';
					else;
							$this->removetrailing('s');
							var($listeratorAction + '_table') = $listeratorContentType;
							var($listeratorAction + '_titleFieldName') = 'Title';
					/if;
			/if;
			var('listeratorNounForSqlQuery' = $listeratorNoun->replace('?', '%3f')&);
	/inline;
	
	
	var(
		'showEditForm' = false
	,	'showCreateForm' = false
	);
	
	handle($showListeratorDetails);
			//might be a specific '$listeratorContentType' item
			var('sql'=string);
			var('thisKeyword_URL'='none');
			$sql = 'SELECT * FROM ' $tablePrefix + var($listeratorAction + '_table') + ' WHERE ' $tablePrefix + var($listeratorAction + '_table') '.Keyword_URL = "' + encode_SQL(($listeratorNounForSqlQuery)) + '"';
			inline($authForDatabase
			,	action_params
			,	-sql=$sql
			,	-inlinename='show' + $this
			);
$content_debug += ('
	<div class="ui-widget">
		<div class="ui-state-debug ui-corner-all">
			<h5>' + include_currentPath + '</h5>
			<p><strong>$content_pageTitle:</strong> <pre>' + $content_pageTitle + '</pre></p>
			<p><strong>$listeratorContentType:</strong> <pre>' + $listeratorContentType + '</pre></p>
			<p><strong>$listeratorNoun:</strong> <pre>' + $listeratorNoun + '</pre></p>
			<p><strong>$listeratorVerb:</strong> <pre>' + $listeratorVerb + '</pre></p>
			<p><strong>action_statment:</strong><br><pre>' + action_statement + '</pre></p>
		</div>
	</div>
');
					if(found_count == 0);
							$sql = 'SELECT * FROM ' var($listeratorAction + '_table') ' WHERE ' var($listeratorAction + '_table') '.UID = "' + encode_SQL($listeratorNoun) + '"';
							inline(
								$authForDatabase
							,	-sql=$sql
							,	-inlinename='show' + $this
							);
									handle_error;
											makerator_errorManager(
												$makerator_currentInclude
											,	error_code
											,	error_msg
											,	action_statement
											);
									/handle_error;
									rows;
											$listeratorNoun = column('Keyword_URL');
											$showListeratorDetails = true;
									/rows;
							/inline;
					else(error_code != 0);
							handle_error;
									makerator_errorManager(
										$makerator_currentInclude
									,	error_code
									,	error_msg
									,	action_statement
									);
							/handle_error;
					else;
							rows;
								$content_pageTitle->replace($this, column(get_listeratorTitleFieldName(var($listeratorAction + '_table'))));
								var('thisUID'=column('UID'));
								var('thisKeyword_URL'=column('Keyword_URL'));
								$showListeratorDetails = true;
							/rows;
					/if;
			/inline;
			
			$content_primary += ('
				<ul class="ui-helper-reset ui-helper-clearfix sf-menu sf-navbar ui-widget ui-widget-header ui-corner-all listerator-toolbar ui-widget-toolbar">
					<li class="ui-state-default ui-corner-all ui-clickable button"><a class="button" href="' + $makerator_pathToAdmin + '' + $listeratorContentType + '/' + $listeratorNoun + '/edit/">Edit this ' + $this + '</a></li>
					<li class="ui-state-default ui-corner-all ui-clickable button"><a class="button" href="' + $makerator_pathToAdmin + '' + $listeratorContentType + '/' + 'create' + '/">Create new ' + $this + '</a></li>
					<li class="ui-state-default ui-corner-all ui-clickable button"><a class="button" href="' + $makerator_pathToAdmin + '' + $listeratorContentType + '/">View all ' + $these + '</a></li>
				</ul>
			');
			if(file_exists('/_site/listerators/' + $listeratorContentType + '/admin-details.lasso'));
				// app-specific details
				library('/_site/listerators/' + $listeratorContentType + '/admin-details.lasso');
			else(file_exists('/_site/listerators/admin-details.lasso'));
				// site-specific details
				library('/_site/listerators/admin-details.lasso');
			else;
				//the default makerator details
				library('/_makerator/listerators/admin-details.lasso');
			/if;
	/handle;
	
	
	
	
	handle($showEditForm);
			var('doUpdate' = false);
			var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
			$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
			var('sql'=string);
			$content_primary = ('');
			$content_primary += ('
				<ul class="ui-helper-reset ui-helper-clearfix sf-menu sf-navbar ui-widget ui-widget-header ui-corner-all listerator-toolbar ui-widget-toolbar">
					<li class="ui-state-default ui-corner-all ui-clickable button"><a class="button" href="' + $makerator_pathToAdmin + '' + $listeratorContentType + '/' + $listeratorNoun + '/">View this ' + $this + '</a></li>
					<li class="ui-state-default ui-corner-all ui-clickable button"><a class="button" href="' + $makerator_pathToAdmin + '' + $listeratorContentType + '/' + 'Create' + '/">Create new ' + $this + '</a></li>
					<li class="ui-state-default ui-corner-all ui-clickable button"><a class="button" href="' + $makerator_pathToAdmin + '' + $listeratorContentType + '/">View all ' + $these + '</a></li>
				</ul>
			');
			
			
			
			
			
			$sql = '
						SELECT ' + (var($listeratorAction + '_UIDfieldName')) + ', ' + var($listeratorAction + '_titleFieldName') + '
						FROM ' $tablePrefix + var($listeratorAction + '_table') + '
						WHERE ' + $tablePrefix + var($listeratorAction + '_table') + '.Keyword_URL = "' + encode_SQL($listeratorNoun) + '"
					';
			inline(
				$authForDatabase
			,	-sql=$sql
			);
				if(found_count == 0);
						$sql = '
											SELECT ' + (var($listeratorAction + '_UIDfieldName')) + ', ' + $tablePrefix + var($listeratorAction + '_titleFieldName') + '
											FROM ' + $tablePrefix + var($listeratorAction + '_table') + '
											WHERE ' + $tablePrefix + var($listeratorAction + '_table') + '.' + (var($listeratorAction + '_UIDfieldName')) + ' = "' + encode_SQL($listeratorNoun) + '"
										';
						inline(
							$authForDatabase
						,	-sql=$sql
						);
								if(error_code != 0);
										error_setErrorCode(-09911);
										error_setErrorMessage('Error trying to retrieve columns to build form with.');
										$makerator_errorStack->insert(map(
											'include_currentPath' = include_currentPath
										,	'action_statement' = action_statement
										,	'error_code' = error_code
										,	'error_msg' = error_msg
										));
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
														There has been an error: ' + error_msg + '
													</p>
												</div>
											</div>
										');
										error_reset;
								else;
									rows;
										
										$content_pageTitle->replace($this, column(var($listeratorAction + '_titleFieldName')));
										var(var($listeratorAction + '_UIDfieldName')=column('UID'));
									/rows;
								/if;
						/inline;
				else;
						rows;
							$content_pageTitle->replace($this, column(var($listeratorAction + '_titleFieldName')));
							var((var($listeratorAction + '_UIDfieldName'))=column((var($listeratorAction + '_UIDfieldName'))));
						/rows;
				/if;
			/inline;
			
			
			inline($authForDatabase, -sql='SELECT * FROM ' var($listeratorAction + '_table') ' WHERE ' var($listeratorAction + '_UIDfieldName') ' = "' var(var($listeratorAction + '_UIDfieldName')) '"');
				//$content_debug += found_count;
				rows;
					loop(field_name(-count));
							var(field_name(loop_count)	=	field(field_name(loop_count)));
							
					/loop;
					
				/rows;
				library('/_makerator/_library/form_generator.lasso');
			/inline;
	/handle;
	
	handle($showCreateForm);
		$content_primary += ('
			<ul class="ui-helper-reset ui-helper-clearfix sf-menu sf-navbar ui-widget ui-widget-header ui-corner-all listerator-toolbar ui-widget-toolbar">
				<li class="ui-state-default ui-corner-all ui-clickable button">
					<a class="button" href="' + $makerator_pathToAdmin + '' + $listeratorContentType + '/' + 'Create' + '/">
						Create new ' + $this + '</a>
				</li>
				<li class="ui-state-default ui-corner-all ui-clickable button">
					<a class="button" href="' + $makerator_pathToAdmin + '' + $listeratorContentType + '/">
						View all ' + $these + '</a>
				</li>
			</ul>
		');
		var('sql'=string);
		$sql = ('
			SELECT ' + (var($listeratorAction + '_UIDfieldName')) + ', ' + var($listeratorAction + '_titleFieldName') + '
			FROM ' + $tablePrefix + var($listeratorAction + '_table') + '
			WHERE ' + $tablePrefix + var($listeratorAction + '_table') + '.Keyword_URL = "' + $listeratorNoun + '"
		');
		inline($authForDatabase
		,	client_params
		,	-sql=$sql
		);
		
				if(found_count == 0);
						$sql = ('
							SELECT ' + (var($listeratorAction + '_UIDfieldName')) + ', ' + $tablePrefix + var($listeratorAction + '_titleFieldName') + '
							FROM ' + $tablePrefix + var($listeratorAction + '_table') + '
							WHERE ' + $tablePrefix + var($listeratorAction + '_table') + '.' + (var($listeratorAction + '_UIDfieldName')) + ' = "' + $listeratorNoun + '"
						');
						inline($authForDatabase
						,	action_params
						,	-sql=$sql
						);
								if(error_code != 0);
										makerator_errorManager(
											$makerator_currentInclude
										,	error_code
										,	error_msg
										,	action_statement
										);
								else(found_count != 0);
										rows;
											var(var($listeratorAction + '_UIDfieldName')=column('UID'));
										/rows;
								else;
$content_debug += ('
<div class="ui-widget">
<div class="ui-state-debug ui-corner-all">
<h5>' + include_currentPath + '</h5>
<p><strong>$content_pageTitle:</strong> <pre>' + $content_pageTitle + '</pre></p>
<p><strong>$listeratorContentType:</strong> <pre>' + $listeratorContentType + '</pre></p>
<p><strong>$listeratorNoun:</strong> <pre>' + $listeratorNoun + '</pre></p>
<p><strong>$listeratorVerb:</strong> <pre>' + $listeratorVerb + '</pre></p>
<p><strong>action_statment:</strong><br><pre>' + action_statement + '</pre></p>
</div>
</div>
');
							$content_pageTitle->replace($this + ' &#x3E;', $these + ' &#x3E;');
								/if;
						/inline;
				else;
						rows;
							$content_pageTitle->replace($this, column(var($listeratorAction + '_titleFieldName')));
							var((var($listeratorAction + '_UIDfieldName'))=column((var($listeratorAction + '_UIDfieldName'))));
						/rows;
				/if;
		/inline;
		library('/_makerator/_library/form_generator.lasso');
/handle;

	
	var($listeratorAction + '_pathto' = $makerator_pathToAdmin +  $listeratorContentType + '/');
	var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
	library('/_makerator/listerators/listerator_intro.lasso');
	// set the table for this database action 
	// build the initial fields array
	
	// set the table for this database action 
	var('this_table'=var($listeratorAction + '_table'));
	// build the initial fields array
	var($listeratorAction + '_fields'=array);
	inline($authForDatabase
	,	-table=$tablePrefix + $this_table
	,	-sql='SHOW COLUMNS FROM ' + $tablePrefix + $this_table + ';'
	);
			var($listeratorContentType + '_cols'=array);
			if(error_msg == 'No error');
					iterate(column_names, var('a_column'));
							var($listeratorContentType '_cols')->insert($a_column);
					/iterate;
					
					var('field_params'			=	array('Field'
													,	'Length'
													,	'Type'
													,	'Default'
													,	'Required'
													,	'NULL'
													,	'Table'
													,	'Options'
													)
					,	'formFields'=array
					,	'varchar_fields'=array
					);
					rows;
							var('this_group'		=	map);
							iterate($field_params, var('a_param'));
									$this_group->insert($a_param=column($a_param));
							/iterate;
							$formFields->insert($this_group);
					/rows;
					
					iterate($formFields, var('a_group'));
							//$content_primary += '<p>' $a_group'</p>';
							var('field'=$a_group->find('Field'));
							var('required'=$a_group->find('NULL') == 'YES' ? false | true);
							var('table'=var($listeratorAction + '_table'));
							var('default'=$a_group->find('Default'));
							select(true);
									case($a_group->find('Type')->beginswith('VarChar'));
											var('type'					=	$a_group->find('Type'));
											$varchar_fields->insert($field);
											var('size')					=	$type->split('(')->get(2)->removetrailing(')') & ;
											var('type')					=	$type->split('(')->get(1)->removetrailing('(') & ;
											var('options'				=	$a_group->find('Type'));
									case($a_group->find('Type')->beginswith('set'));
											var('type'					=	$a_group->find('Type'));
											var('options'				=	$a_group->find('Type'));
											$options						=	$options->substring(5, $options->length - 5)->split(',');
											var('size')					=	$type->split('(')->get(2)->removetrailing(')') & ;
											var('type')					=	$type->split('(')->get(1)->removetrailing('(') & ;
									case($a_group->find('Type')->beginswith('enum'));
											var('type'					=	$a_group->find('Type'));
											var('length')				=	$type->split('(')->get(2)->removetrailing(')') & ;
											var('options'				=	$a_group->find('Type'));
											$options						=	$options->substring(5, $options->length - 5)->split(',');
									case($a_group->find('Type')->equals('date'));
											var('type'					=	$a_group->find('Type'));
											var('options'				=	$a_group->find('Type'));
											var('length'				=	'');
											var('type')					=	$type->split('(')->get(1)->removetrailing('(') & ;
									case($a_group->find('Type')->equals('datetime'));
											var('length'				=	'');
											var('type'					=	$a_group->find('Type'));
											var('type')					=	$type->split('(')->get(1)->removetrailing('(') & ;
											var('options'				=	$a_group->find('Type'));
									case($a_group->find('Type')->equals('text'));
											var('length'				=	'');
											var('type'					=	$a_group->find('Type'));
											var('type')					=	$type->split('(')->get(1)->removetrailing('(') & ;
											var('options'				=	$a_group->find('Type'));
							/select;
							
							
							
							var('this_group'=map);
							iterate($field_params, var('a_param'));
									$this_group->insert($a_param=var($a_param));
							/iterate;
							
							var($listeratorAction + '_fields')->insert($this_group);
					/iterate;
					library('/_makerator/listerators/listerator_outro.lasso');
			else;
					$content_pageTitle = 'Error: ' + $content_pageTitle;
					$json_data->insert('error_msg show columns' = error_msg);
			/if;
	/inline;
	select(true);
	case($show_content_siteAdmin && string(response_path)->equals($makerator_pathToAdmin +  $listeratorContentType + '/'));
		var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
		$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
		$content_pageTitle->replace($this, $these);
		$content_primary += ('
			<ul class="ui-helper-reset ui-helper-clearfix sf-menu sf-navbar ui-widget ui-widget-header ui-corner-all listerator-toolbar ui-widget-toolbar">
				<li class="ui-state-default ui-corner-all ui-clickable button"><a class="button" href="' + $makerator_pathToAdmin + '' + $listeratorContentType + '/' + 'Create' + '/">Create new ' + $this + '</a></li>
				<li class="ui-state-default ui-corner-all ui-clickable button"><a class="button" href="' + $makerator_pathToAdmin + '">Back to Admin</a></li>
			</ul>
		');
		
		
		if(file_exists('/_site/listerators/' + $listeratorContentType + '/admin-list_records.lasso'));
				//app-specific listing 
				library('/_site/listerators/' + $listeratorContentType + '/admin-list_records.lasso');
		else(file_exists('/_site/listerators/admin-list_records.lasso'));
				// site-specific listing
				library('/_site/listerators/admin-list_records.lasso');
		else;
				//the default makerator listing
				library('/_makerator/listerators/admin-list_records.lasso');
		/if;
		
	case($show_content_siteAdmin && response_path->beginswith($makerator_pathToAdmin +  $listeratorContentType + '/') && string(response_path)->endswith('/reset/'));
			var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
			$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
			If(var_defined('listeratorAction'));
				session_end(-name=$sessionName);
				cookie_set($sessionName='kilt off', -domain=server_name, -expires=-9000, -path='/');
				session_end(-name=$sessionName);
			else;
			/if;
			redirect_URL(var($listeratorAction + '_exitTo'));
	case($show_content_siteAdmin && response_path->beginswith($makerator_pathToAdmin +  $listeratorContentType + '/') && string(response_path)->endswith('/search/'));
			var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
			$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
			$content_pageTitle->replace($this, $these);
			if(file_exists('/_site/listerators/' + $listeratorContentType + '/admin-search.lasso'));
				// app-specific search
				include('/_site/listerators/'  + $listeratorContentType +  '/admin-search.lasso');
			else(file_exists('/_site/listerators/admin-search.lasso'));
				// site-specific search
				include('/_site/listerators/admin-search.lasso');
			else;
				//the default Makerator search
				include('/_makerator/listerators/admin-search.lasso');
			/if;
	case($show_content_siteAdmin && response_path->beginswith($makerator_pathToAdmin +  $listeratorContentType + '/') && string(response_path)->contains('/create/'));
			var('showCreateForm' = true);
			var('doAdd' = false);
			var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | '') + 'do/');
			
			if(string(response_path)->endswith('/do/'));
					protect;
							handle_error;
									makerator_errorManager(
										$makerator_currentInclude
									,	error_code
									,	error_msg
									,	action_statement
									);
							/handle_error;
							var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
							library('/_makerator/_library/form_processor.lasso');
							var('for_add'=array);
							iterate(var($listeratorAction + '_tables'), var('a_table_pair'));
									var('a_table' = $a_table_pair->first);
									iterate(var($a_table '_params'), var('a_pair'));
											var('this_column'=$a_pair->first);
											var('this_value'=$a_pair->second);
											iterate(var($listeratorAction + '_fields'), var('a_map'));
													if($a_map->find('Field') == $this_column);
															var('this_type'=$a_map->find('type'));
															select($this_type);
																	case('Set');
																			$this_value->removeleading('set_');
																	case('Datetime');
																			$this_value = date($this_value)->format('%Q %T');
																	case('Date');
																			$this_value = date($this_value)->format('%Q');
															/select;
															$for_add->insert($this_column=$this_value);
													/if;
											/iterate;
									/iterate;
									var('a_titleFieldName' = get_listeratorTitleFieldName(-table=$a_table));
									iterate($for_add, var('a_pair'));
											handle_error;
													makerator_errorManager(
														$makerator_currentInclude
													,	error_code
													,	error_msg
													,	action_statement
													);
											/handle_error;
											$a_pair->first == 'Keyword_URL' || $a_pair->first == 'Table_Name' ? $a_pair->second->lowercase;
											$a_pair->first == 'Keyword_URL' ? var('new_Keyword_URL') = $a_pair->second;
											$a_pair->first == $a_titleFieldName ? var('new_' + $a_titleFieldName) = $a_pair->second;
											// grab keyword URL in case this is listerator admin
											$a_pair->first == 'Keyword_URL' && $listeratorContentType == 'listerators' ? var('new_Keyword_URL' = $a_pair->second);
											
											$a_pair->first == 'Title_Field_Name' && $listeratorContentType == 'listerators' ? var('new_Title_Field_Name'=$a_pair->second);
											$a_pair->first == 'Table_Name' && $listeratorContentType == 'listerators' ? var('new_Table_Name' = $a_pair->second);
											$a_pair->first == 'Display_Status_Defaults' && $listeratorContentType == 'listerators' ? var('new_Display_Status_Defaults'=$a_pair->second);
									/iterate;
									
									
									if(var($listeratorAction + '_invalid')->size == 0 && var($listeratorAction + '_missing')->size == 0);
											$doAdd = true;
											var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + $new_Keyword_URL + '/');
											$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
									else;
											if(var($listeratorAction + '_invalid')->size);
													error_setErrorCode(-09904);
													error_setErrorMessage('Error: Invalid data supplied.');
													makerator_errorManager(
														$makerator_currentInclude
													,	error_code
													,	error_msg
													);
											/if;
											
											if(var($listeratorAction + '_missing')->size);
													error_setErrorCode(-09902);
													error_setErrorMessage('Error: Required fields were missing.');
													makerator_errorManager(
														$makerator_currentInclude
													,	error_code
													,	error_msg
													);
											/if;
									/if;
									
									
									if(var_defined('new_Keyword_URL'));
											//check to see if library with that Keyword_URL already exists
											local('query_isKeywordUrlAlreadyTaken' = ('
												SELECT ' + (var($listeratorAction + '_UIDfieldName')) + ' FROM ' + $a_table +  ' WHERE Keyword_URL = "' + $new_Keyword_URL + '"
											'));
											
											inline(
												$authForDatabase
											,	-sql=#query_isKeywordUrlAlreadyTaken
											);
													if(found_count >= 1);
															$doAdd = false;
															(var($listeratorAction + '_invalid')->insert('Keyword_URL' = ' this is the invalid warning'));
															(var($listeratorAction + '_validationWarnings')->insert('Keyword_URL' = ('
																<p>
																	You have chosen a Keyword URL that already exists in this system.
																</p>
																<p>
																	Please choose a different Keyword URL and submit again.
																</p>
															')));
															
															var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
															$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
															error_setErrorCode(-09909);
															error_setErrorMessage('"Keyword_URL" (' + $new_Keyword_URL + ') already exists in this system.');
															makerator_errorManager(
																$makerator_currentInclude
															,	error_code
															,	error_msg
															,	action_statement
															);
													else;
															// does not exist -- make one
															if(var($listeratorAction + '_invalid')->size == 0 && var($listeratorAction + '_missing')->size == 0);
																	$doAdd = true;
															/if;
													/if;
													
													
											/inline;
									/if;
									
$content_debug += ('
	<div class="ui-widget">
		<div class="ui-state-debug ui-corner-all">
			<h5>' + include_currentPath + '</h5>
			<p><strong>$doAdd:</strong> <pre>' + $doAdd + '</pre></p>
			<p><strong>$for_add:</strong> <pre>' + $for_add + '</pre></p>
		</div>
	</div>
');
									handle($doAdd);
											//$for_add->insert((var($listeratorAction + '_UIDfieldName'))=var(var($listeratorAction + '_UIDfieldName')));
											var('new_' + $a_table + '_UID' = lasso_uniqueid);
											$for_add->insert('UID'=var('new_' + $a_table + '_UID'));
											var(var($listeratorAction + '_UIDfieldName') = var('new_' + $a_table + '_UID'));
											inline(
												$authForDatabase
											,	-add
											,	-table=$a_table
											,	$for_add
											);
													$content_debug += ('
														<div class="ui-widget">
															<div class="ui-state-debug ui-corner-all">
																<h5>' + include_currentPath + '</h5>
																<p><strong>$doAdd:</strong> <pre>' + $doAdd + '</pre></p>
																<p><strong>$for_add:</strong> <pre>' + $for_add + '</pre></p>
															</div>
														</div>
													');
													if(error_code == 0);
															$showCreateForm = false;
															$showListeratorDetails = true;
															$listeratorNoun = $new_Keyword_URL;
															$content_primary = string;
															
															var('sql' = 'SELECT First_Name, Last_Name, Login_Name, Keyword_URL FROM users WHERE UID = "' $User_UID '";');
															inline($authForDatabase, -sql=$sql);
																	if(found_count == 1);
																			rows;
																				var('User__Keyword_URL') = column('Keyword_URL');
																				var('User__loginname') = column('Login_Name');
																				var('User__First_Name') = column('First_Name');
																				var('User__Last_Name') = column('Last_Name');
																				var('User__Name') = ($User__First_Name->size ? $User__First_Name | '') + ' ' + ($User__Last_Name->size ? $User__Last_Name | '');
																				$User__Name == ' ' ? $User__Name = $User__loginname;
																			/rows;
																	else;
																			error_setErrorCode(-09904);
																			error_setErrorMessage('Error trying to retrieve user information for _audit');
																			makerator_errorManager(
																				$makerator_currentInclude
																			,	error_code
																			,	error_msg
																			,	action_statement
																			);
																	/if;
															/inline;
															
															
															if($listeratorContentType == 'listerators');
																	/*
																		Listerator Creation
																		===================
																		
																		For Listerator creation/destruction/modification, we need to do some special
																		stuff that we don't do for listerator *objects*.
																		
																		First off: when creating a Listerator, we will create not only the 
																		table in question but also the directory in /_site/listerators.
																		
																		Any code that will override the default Listerator behaviors can go in that 
																		directory.
																		
																		Note that when a Listerator type is destroyed, this directory will only be 
																		removed IF IT IS EMPTY.
																		
																		Makerator will not delete custom code, under any circumstance.
																		
																		This means that when we create a listerator, of course, we musTt also 
																		CHECK TO SEE if the directory already exists.
																		
																		Let us do taht first:
																	*/
																	local('newListeratorDirectoryExists' = false);
																	inline($authForFileOperations);
																			#newListeratorDirectoryExists = file_exists('/_site/listerators/' + $new_Keyword_URL + '/');
																	/inline;
																	
																	
																	handle(!#newListeratorDirectoryExists);
																	/handle;
																	if(#newListeratorDirectoryExists);
																			$content_primary += '<p class="">Directory exists</p>';
																	else;
																			$content_primary += '<p class="">Directory does not exist</p>';
																			file_create('/_site/listerators/' + $new_Keyword_URL + '/');
																			inline($authForFileOperations);
																					handle_error;
																							makerator_errorManager(
																								$makerator_currentInclude
																							,	error_code
																							,	error_msg
																							,	action_statement
																							);
																					/handle_error;
																					file_CurrentError != 'No Error' ? error_setErrorMessage = 'Directory was unable to be created';
																					file_CurrentError != 'No Error' ? error_setErrorCode = -02230943;
																			/inline;
																	/if;
																	
																	if(error_code == 0);
																			inline(-sql='show tables WHERE Tables_in_' + $siteDB + ' = "' $new_Table_Name '"');
																					$content_primary += '<p class="">found:' found_count'</p>';
																					$content_primary += '<p class="">error:' error_msg'</p>';
																					rows;
																							$content_primary += '<p class="">'loop_count ': ' field('Tables_in_' + $siteDB) '</p>';
																					/rows;
																			/inline;
																			//*/
																			
																			// we also need to do a similar thing with tables
																			var('newTableExistsAlready'=false);
																			
																			inline(-sql='show tables WHERE Tables_in_' + $siteDB + ' = "' $new_Table_Name '"');
																					$content_primary += error_msg;
																					rows;
																							column('Tables_in_' + $siteDB);
																					/rows;
																					found_Count ? $newTableExistsAlready = true;
																			/inline;
																			
																			
																			handle(!$newTableExistsAlready);
																					// create the table!
																					var('create_statement' = string);
																					$create_statement += '
																					CREATE TABLE `' string_lowerCase($new_Table_Name) '` (
																						`' + $new_Title_Field_Name + '` varchar(255) NOT NULL default \'\'
																					,	`Description` text
																					,	`Date` datetime NOT NULL default \'0000-00-00 00:00:00\'
																					,	`Keyword_URL` varchar(255) NOT NULL default \'Must Be Unique\'
																					,	`Display_Status` set(' ($new_Display_Status_Defaults)') NOT NULL default ' $new_Display_Status_Defaults->split(',')->get(1) '
																					,	`UID` varchar(28) NOT NULL default \'\'
																					,	PRIMARY KEY  (`UID`)
																					,	UNIQUE KEY `Keyword_URL` (`Keyword_URL`)
																					) ENGINE=MyISAM DEFAULT CHARSET=utf8
																					';
																					
																					inline($authForDatabase, -sql=$create_statement);
																							if(error_code != 0);
																									makerator_errorManager(
																										$makerator_currentInclude
																									,	error_code
																									,	error_msg
																									,	action_statement
																									);
																							else;
																									$showCreateForm = false;
																									$showListeratorDetails = true;
																									$listeratorNoun = $new_Keyword_URL;
																									$content_primary = string;
																							/if;
																					/inline;
																			/handle;
																	else;
																			makerator_errorManager(
																				$makerator_currentInclude
																			,	error_code
																			,	error_msg
																			,	action_statement
																			);
																	/if;
															/if;
															
															
															var('audit'	=	array(
																'UID'							=	lasso_uniqueID
															,	'Audit_Action_ID'				=	3
															,	'Audit_Statement'				=	'User ' $User__Name ' created a ' + $this + ' named "' var('new_' + $a_titleFieldName) '"'
															,	'Affected_Table_Name'			=	$tablePrefix + $a_table
															,	'Affected_Keyfield_Name'		=	var($listeratorAction + '_UIDfieldName')
															,	'Affected_Keyfield_Value'		=	var(var($listeratorAction + '_UIDfieldName'))
															,	'Edited_by_users_UID'			=	$User_UID
															,	'Edited_by_users_Login_Name'	=	$User__loginname
															,	'Date_Updated'					=	date->format('%Q')
															,	'Time_Updated'					=	date->format('%T')
															,	'URL_Initiated_From'			=	response_filepath
															,	'Server_Name'					=	server_name
															,	'SQL_Statement_Used'				=	Action_statement
															,	'Session_ID'					=	session_id(-name							=	$sessionName)
															,	'Client_IP'						=	client_ip
															,	'Client_Browser'				=	encode_json(lp_client_browser)
															,	'Client_Headers'				=	encode_json(content_header->split('\r\n'))
															));
															
															inline(
																$authForDatabase
															,	-table=$tablePrefix + '_audit'
															,	-add
															,	$audit
															);
																	handle_error;
																			makerator_errorManager(
																				$makerator_currentInclude
																			,	error_code
																			,	error_msg
																			,	action_statement
																			);
																	/handle_error;
															/inline;
															
															var($listeratorAction + '_exitTo' = var($listeratorAction + '_pathto')  + $new_Keyword_URL + '/edit/');
															$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
															$json_data->insert('listeratorVerb' = 'create');
															$listeratorVerb = 'edit';
															$showEditForm = true;
															$showCreateForm = false;
															
															
															var($listeratorAction + '_invalid'						=	map);
															var($listeratorAction + '_missing'						=	map);
															var($listeratorAction + '_okay'							=	map);
															var($listeratorAction + '_optional'						=	array);
															var($listeratorAction + '_savedSearchParams'			=	array);
															var($listeratorAction + '_savedSortField'				=	'UID');
															var($listeratorAction + '_savedSortOrder'				=	'ASC');
															var($listeratorAction + '_savedStatement'				=	string);
															var($listeratorAction + '_savedStatementModifiers'		=	string);
															var($listeratorAction + '_sortOn'						=	array);
															var($listeratorAction + '_status'						=	string);
															var($listeratorAction + '_validation'					=	array);
															var($listeratorAction + '_validationWarnings'			=	array);
															session_end(-name=$sessionName);
															cookie_set(
																$sessionName='kilt off'
																,	-domain=server_name
																,	-expires=-9000
																,	-path=var($listeratorAction + '_pathto')
															);
															library('/_makerator/listerators/listerator_intro.lasso');
															session_start(
																-usecookie
															,	-name			=	$sessionName
															,	-expires		=	var($listeratorAction + '_sessionexpires')
															,	-path			=	var($listeratorAction + '_pathto')
															);
													else;
															handle_error;
																	error_setErrorCode(-09904);
																	error_setErrorMessage('Error trying to retrieve user information for _audit');
																	makerator_errorManager(
																		$makerator_currentInclude
																	,	error_code
																	,	error_msg
																	,	action_statement
																	);
															/handle_error;
													/if;
											/inline;
									/handle;
							/iterate;
							
							
					/protect;
			/if;
			
			
			
	case($show_content_siteAdmin && response_path->beginswith($makerator_pathToAdmin +  $listeratorContentType + '/') && string(response_path)->contains('/edit/'));
			var('showEditForm' = false);
			var('doUpdate' = false);
			var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
			$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
			if(string(response_path)->endswith('/do/'));
					library('/_makerator/_library/form_processor.lasso');
					var('for_update'=array);
					iterate(var($listeratorAction + '_tables'), var('a_table_pair'));
							var('a_table' = $a_table_pair->first);
							iterate(var($a_table '_params'), var('a_pair'));
									var('this_column'=$a_pair->first);
									var('this_value'=$a_pair->second);
									iterate(var($listeratorAction + '_fields'), var('a_map'));
											if($a_map->find('Field') == $this_column);
													var('this_type'=$a_map->find('type'));
													$this_type->beginsWith('enum') ? $this_type = 'enum';
													select($this_type);
													case('set');
															$this_value->removeleading('set_');
													case('enum');
															$this_value->removeleading('set_');
													case('Datetime');
															$this_value = date($this_value)->format('%Q %T');
													case('Date');
															$this_value = date($this_value)->format('%Q');
													/select;
													$for_update->insert($this_column=$this_value);
											/if;
									/iterate;
							/iterate;
							var('a_titleFieldName' = get_listeratorTitleFieldName(-table=$a_table));
							iterate($for_update, var('a_pair'));
								$a_pair->first == 'Keyword_URL' || $a_pair->first == 'Table_Name' ? $a_pair->second->lowercase;
								$a_pair->first == $a_titleFieldName ? var('new_' + $a_titleFieldName) = $a_pair->second;
								$a_pair->first == 'Keyword_URL' ? var('new_Keyword_URL') = $a_pair->second;
								// grab keyword URL in case this is listerator admin
								$a_pair->first == 'Keyword_URL' && $listeratorContentType == 'listerators' ? var('new_Keyword_URL'=$a_pair->second);
								
								$a_pair->first == 'Title_Field_Name' && $listeratorContentType == 'listerators' ? var('new_Title_Field_Name'=$a_pair->second);
								$a_pair->first == 'Table_Name' && $listeratorContentType == 'listerators' ? var('new_Table_Name'=$a_pair->second);
								$a_pair->first == 'Display_Status_Defaults' && $listeratorContentType == 'listerators' ? var('new_Display_Status_Defaults'=$a_pair->second);
							/iterate;
							
							if(var($listeratorAction + '_invalid')->size == 0 && var($listeratorAction + '_missing')->size == 0);
									$doUpdate = true;
									var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
									$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
							else;
									if(var($listeratorAction + '_invalid')->size);
											error_setErrorCode(-09904);
											error_setErrorMessage('Error: Invalid data supplied.');
											$makerator_errorStack->insert(map(
												'include_currentPath' = include_currentPath
											,	'action_statement' = action_statement
											,	'error_code' = error_code
											,	'error_msg' = error_msg
											));
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
															There has been an error: ' + error_msg + '
														</p>
													</div>
												</div>
											');
											error_reset;
									/if;
									
									if(var($listeratorAction + '_missing')->size);
											local('errorMap' = map(
												'include_currentPath' = include_currentPath
											,	'error_code' = error_code
											,	'error_msg' = error_msg
											));
											
											action_statement->size ? #errorMap->insert('action_statement' = action_statement);
											params->size ? #errorMap->insert('params' = params);
											params_up->size ? #errorMap->insert('params_up' = params_up);
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
															There has been an error: ' + error_msg + '
														</p>
													</div>
												</div>
											');
											error_setErrorCode(-09902);
											error_setErrorMessage('Error: Required fields were missing.');
											$makerator_errorStack->insert(map(
												'include_currentPath' = include_currentPath
											,	'action_statement' = action_statement
											,	'error_code' = error_code
											,	'error_msg' = error_msg
											));
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
															There has been an error: ' + error_msg + '
														</p>
													</div>
												</div>
											');
									/if;
									
									$showEditForm = true;
							/if;
							
							
							if(var_defined('new_Keyword_URL'));
									
									handle($new_Keyword_URL != $listeratorNoun);
											//check to see if library with that Keyword_URL already exists
											local('query_isKeywordUrlAlreadyTaken' = ('
												SELECT ' + (var($listeratorAction + '_UIDfieldName')) + ' FROM ' + $a_table +  ' WHERE Keyword_URL = "' + $new_Keyword_URL + '"
											'));
											
											inline(
												$authForDatabase
											,	-sql=#query_isKeywordUrlAlreadyTaken
											);
													if(found_count >= 1);
															// probably should error here...
															$doUpdate = false;
															$showEditForm = true;
															(var($listeratorAction + '_invalid')->insert('Keyword_URL' = ' this is the invalid warning'));
															(var($listeratorAction + '_validationWarnings')->insert('Keyword_URL' = ('
																<p>
																	You have chosen a Keyword URL that already exists in this system.
																</p>
																<p>
																	Please choose a different Keyword URL and submit again.
																</p>
															')));
															var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
															$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
															error_setErrorCode(-09909);
															error_setErrorMessage('"Keyword_URL" (' + $new_Keyword_URL + ') already exists in this system.');
															$makerator_errorStack->insert(map(
																'include_currentPath' = include_currentPath
															,	'action_statement' = 'yer mom'
															,	'error_code' = error_code
															,	'error_msg' = error_msg
															));
															error_reset;
													else;
															// does not exist -- make one
															if(var($listeratorAction + '_invalid')->size == 0 && var($listeratorAction + '_missing')->size == 0);
																	$doUpdate = true;
															/if;
													/if;
													
													
											/inline;
											
									/handle;
							/if;
							
							
							if(var_defined('new_Table_Name'));
									
									handle($new_Table_Name != $a_table);
											//check to see if library with that Keyword_URL already exists
											local('query_isTableNameAlreadyTaken' = ('
												SELECT Table_Name FROM listerators WHERE Table_Name = "' + $new_Table_Name + '"
											'));
											
											
											inline(
												$authForDatabase
											,	-sql=#query_isTableNameAlreadyTaken
											);
													handle_error;
															$doUpdate = false;
															$showEditForm = true;
															(var($listeratorAction + '_invalid')->insert('Keyword_URL' = ' this is the invalid warning'));
															(var($listeratorAction + '_validationWarnings')->insert('Keyword_URL' = ('
																<p>
																	There has been an error.
																</p>
																<p>
																	The error reported was <q>' + error_msg + '</q>.
																</p>
															')));
															var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
															$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
															error_setErrorCode(-09909);
															error_setErrorMessage('"Keyword_URL" (' + $new_Table_Name + ') already exists in this system.');
// 															$makerator_errorStack->insert(map(
// 																'include_currentPath' = include_currentPath
// 															,	'action_statement' = 'yer mom'
// 															,	'error_code' = error_code
// 															,	'error_msg' = error_msg
// 															));
// 															error_reset;
															makerator_errorManager($makerator_currentInclude, error_code, error_msg, action_statement);
													/handle_error;
													if(found_count >= 1);
															// we found a table --- that's good, since we're EDITING a table.
															
															// since there's a new table name, it means we're going to
															// a) back the current SQL schema up
															// b) duplicate the current table to a new name
															// c) remove the old table
															// d) back the old Listerator directory up, zip it
															// e) duplicate the old Listerator dirctory into the new name
															// f) remove the old Listerator directory
															// g) set a new "exit", just like when we create a new Keyword_URL
															
															
															
															// let's get started, shall we?
															
															
															// a) Back current SQL statement up
															
															
													else;
															// does not exist -- make one
															if(var($listeratorAction + '_invalid')->size == 0 && var($listeratorAction + '_missing')->size == 0);
																	$doUpdate = true;
															/if;
													/if;
													
													
											/inline;
											
									/handle;
							/if;
							
							handle($doUpdate);
									var(var($listeratorAction + '_UIDfieldName') = listerator_getUID(-Keyword_URL=$listeratorNoun, -table=$a_table));
									$listeratorNoun = $new_Keyword_URL;
									inline(
										$authForDatabase
									,	-update
									,	-table=$a_table
									,	-keyfield=(var($listeratorAction + '_UIDfieldName'))
									,	-keyvalue=(var(var($listeratorAction + '_UIDfieldName')))
									,	$for_update
									);
$content_debug += ('
	<div class="ui-widget">
		<div class="ui-state-debug ui-corner-all">
			<h5>' + include_currentPath + '</h5>
			<p><strong>action_statement:</strong> <pre>' + action_statement + '</pre></p>
		</div>
	</div>
');
											if(error_code == 0);
													//lookup user's keyword URL and name and such
													var('sql') = 'SELECT First_Name, Last_Name, Login_Name, Keyword_URL FROM ' + $tablePrefix + 'users WHERE UID = "' $User_UID '";';
													inline($authForDatabase, -sql=$sql);
														if(found_count == 1);
																rows;
																		var('User__Keyword_URL') = column('Keyword_URL');
																		var('User__loginname') = column('Login_Name');
																		var('User__First_Name') = column('First_Name');
																		var('User__Last_Name') = column('Last_Name');
																		var('User__Name') = ($User__First_Name->size ? $User__First_Name | '') + ' ' + ($User__Last_Name->size ? $User__Last_Name | '');
																		$User__Name == ' ' ? $User__Name = $User__loginname;
																/rows;
														else;
																error_setErrorCode(-09904);
																error_setErrorMessage('Error trying to retrieve user information for _audit');
																$makerator_errorStack->insert(map(
																	'include_currentPath' = include_currentPath
																,	'action_statement' = action_statement
																,	'error_code' = error_code
																,	'error_msg' = error_msg
																));
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
																				There has been an error: ' + error_msg + '
																			</p>
																		</div>
																	</div>
																');
																error_reset;
														/if;
													/inline;
													var('audit'	=	array(
														'UID'							=	lasso_uniqueID
													,	'Audit_Action_ID'				=	4
													,	'Audit_Statement'				=	'User ' $User__Name ' updated a ' + $this + ' named "' var('new_' + $a_titleFieldName) '"'
													,	'Affected_Table_Name'			=	$tablePrefix + $a_table
													,	'Affected_Keyfield_Name'		=	'UID'
													,	'Affected_Keyfield_Value'		=	var(var($listeratorAction + '_UIDfieldName'))
													,	'Edited_by_users_UID'			=	$User_UID
													,	'Edited_by_users_Login_Name'	=	$User__loginname
													,	'Date_Updated'					=	date->format('%Q')
													,	'Time_Updated'					=	date->format('%T')
													,	'URL_Initiated_From'			=	response_filepath
													,	'Server_Name'					=	server_name
													,	'SQL_Statement_Used'			=	Action_statement
													,	'Session_ID'					=	session_id(-name							=	$sessionName)
													,	'Client_IP'						=	client_ip
													,	'Client_Browser'				=	encode_json(lp_client_browser)
													,	'Client_Headers'				=	encode_json(content_header->split('\r\n'))
													));
													inline($authForDatabase, -table=$tablePrefix + '_audit'
	,															-add, $audit
													);
															handle_error;
																	makerator_errorManager($makerator_currentInclude, error_code, error_msg, action_statement);
															/handle_error;
													/inline;
													// session_end(-Name=$sessionName);
													// redirect_url('../');
													var($listeratorAction + '_exitTo' = var($listeratorAction + '_pathto')  + $new_Keyword_URL + '/edit/');
													$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
													$showEditForm = true;
													$showListeratorDetails = false;
											else;
													$makerator_errorStack->insert(map(
														'include_currentPath' = include_currentPath
													,	'action_statement' = action_statement
													,	'error_code' = error_code
													,	'error_msg' = error_msg
													));
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
																	There has been an error: ' + error_msg + '
																</p>
															</div>
														</div>
													');
													error_reset;
											/if;
									/inline;
							/handle;
					/iterate;
			else;
					$showEditForm = true;
			/if;
			
			
	case;
			
			
			
			select(true);
			case(response_path->endswith('do_upload/'));
					var('sql'=string);
					var('pathTo_parent'=var('pathTo_level_' + $levels_count - 1));
					var('parent_levelName'=$pathto_parent->split('/')->get($pathto_parent->split('/')->size - 1));
					$sql = 'SELECT * FROM ' var($listeratorAction + '_table') ' WHERE ' var($listeratorAction + '_table') '.Keyword_URL = "' + $parent_levelName + '"';
					//$sql;
					inline($authForDatabase, action_params
	,							-sql=$sql, -inlinename='show' + $this);
						rows;
							var('sponsorUID'=column('UID'));
						/rows;
					/inline;
					if(file_exists('/_site/listerators/' $listeratorcontenttype '/do_image_upload.lasso'));
							// app-specific 
							library_once('/_site/listerators/' + $listeratorcontenttype + '/do_image_upload.lasso');
					else(file_exists('/_site/listerators/do_image_upload.lasso'));
							// site-specific
							library_once('/_site/listerators/do_image_upload.lasso');
					else;
							//the default 
							$content_primary += library_once('/_makerator/listerators/do_image_upload.lasso');
					/if;
					
			case;
					var($listeratorAction + '_exitTo') = (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + ($listeratorVerb->size ? $listeratorVerb + '/' | ''));
					$json_data->insert('listeratorExitTo' = var($listeratorAction + '_exitTo'));
					$showListeratorDetails = true;
			/select;
			
	/select;
/*	$content_siteAdminToolbar += '<a class="button" href="' + var($listeratorAction + '_pathto') + $listeratorNoun + '/edit/' + '">Edit this ' + $this + '</a>'; */
/*	$content_siteAdminToolbar += include('/_makerator/_library/app_create_link.lasso'); */
/*	$content_siteAdminToolbar += include('/_makerator/_library/app_listing_link.lasso'); */



// 					<p><strong>Sets:</strong> ' + (var($listeratorAction + '_sets')) + ' </p>
// 					<p><strong>client_params:</strong> ' + (client_params) + ' </p>
// 					<p><strong>Exit To:</strong> ' + (var($listeratorAction + '_exitTo')) + ' </p>
// 					<p><strong>Form Action:</strong> ' + (var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + $listeratorVerb + '/do/') + ' </p>
// 					<p><strong>Session Name:</strong> ' + $sessionName + ' </p>
// 					<p><strong>$listeratorAction + \'_titleFieldName\':</strong> ' + ($listeratorAction + '_titleFieldName') + ' </p>
// 					<p><strong>var($listeratorAction + \'_titleFieldName\'):</strong> ' + var($listeratorAction + '_titleFieldName') + ' </p>
// 					<p><strong>var(var($listeratorAction + \'_titleFieldName\')):</strong> ' + var(var($listeratorAction + '_titleFieldName')) + ' </p>
// 					<p><strong>listeratorAction:</strong> ' + $listeratorAction + ' </p>
// 					<p><strong>listeratorContentType:</strong> ' + $listeratorContentType + ' </p>
// 					<p><strong>listeratorNoun:</strong> ' + $listeratorNoun + ' </p>
// 					<p><strong>listeratorVerb:</strong> ' + $listeratorVerb + ' </p>
// 					<p><strong>var($listeratorAction + \'_pathto\'):</strong> ' + var($listeratorAction + '_pathto') + ' </p>
// 					<p><strong>Stuff:</strong> ' + (($show_content_siteAdmin && response_path->beginswith($makerator_pathToAdmin +  $listeratorContentType + '/') && string(response_path)->contains('/create/'))) + ' </p>



]