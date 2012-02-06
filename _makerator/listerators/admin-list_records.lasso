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
		'baseStatement'									=	string
	,	'statementModifiers'							=	string
	,	'thisStatement'									=	string
	,	'thisSearch'									=	array
	,	'searchType'									=	string
	,	'searchInputs'									=	array(
																'TXT-maxRecords'
															,	'TXT-skipRecords'
															)
	,	'defaultSearch'									=	array(
																'-maxRecords'		=	$maxresults
															,	'-skipRecords'		=	0
															)
	);
	$baseStatement += ('
		SELECT * FROM ' + var($listeratorAction + '_Table') + '
		WHERE 1 = 1
	');
	// the /_Site/*listerator-name*/public-sql file is where you do any customizations that are required for this listerator
	if(file_exists('/_site/listerators/' + $listeratorContentType + '/admin-sql.lasso'));
			library('/_site/listerators/' + $listeratorContentType + '/admin-sql.lasso');
	else(file_exists('/_site/listerators/admin-sql.lasso'));
			// if all the listerators you create for this site share common things, this is a good place to do that
			library('/_site/listerators/admin-sql.lasso');
	else;
			// otherwise, makerator's defaults should work, at least, even if it doesn't look exactly like you want yet.
			library('/_makerator/listerators/admin-sql.lasso');
	/if;
	if(action_param('print'));
			$maxresults = 'all';
	/if;
	var('search_type'=action_param('searchType'));
	$search_type = 'new';
	select($search_type);
			case('new');
					$searchType = action_param('searchType');
					iterate($searchInputs, var('a_Input'));
							if(action_param($a_Input));
									if($a_Input->beginsWith('TXT'));
											var('thisFieldName'=$a_Input);
											$thisFieldName->removeLeading('TXT');
									else;
											var('thisFieldName'=$a_Input);
									/if;
									$thisSearch->insert($thisFieldName=action_param($a_Input));
							/if;
					/iterate;
					$statementModifiers = string;
					var($listeratorAction + '_savedStatementModifiers') = string;
					if(action_param('keyword'));
							iterate($varchar_fields, var('a_field'));
									loop_count == 1 ? $statementModifiers += ' AND ( ' | $statementModifiers += ' OR ';
									$statementModifiers += var($listeratorAction + '_Table') '.' $a_field ' LIKE "%' action_param('keyword') '%" ';
									loop_count == $varchar_fields->size ? $statementModifiers += ' )';
							/iterate;
							var('keyword'=action_param('keyword'));
							var($listeratorAction + '_savedStatementModifiers') += $statementModifiers;
					/if;
					
			case;
					select(var($listeratorAction + '_savedSearchParams')->size > 0);
							case(true);
									$thisSearch = var($listeratorAction + '_savedSearchParams');
									$searchType = 'saved';
									iterate($searchInputs, var('a_Input'));
											if(action_param($a_Input));
													if($a_Input->beginsWith('TXT'));
															var('thisFieldName'=$a_Input);
															$thisFieldName->removeLeading('TXT');
															$thisSearch->removeAll($thisFieldName);
													else;
															var('thisFieldName'=$a_Input);
													/if;
													$thisSearch->insert($thisFieldName=action_param($a_Input));
											/if;
									/iterate;
							case;
									$thisSearch = $defaultSearch;
									$searchType = 'default';
									iterate($searchInputs, var('a_Input'));
											if(action_param($a_Input));
													if($a_Input->beginsWith('TXT'));
															var('thisFieldName'=$a_Input);
															$thisFieldName->removeLeading('TXT');
													else;
															var('thisFieldName'=$a_Input);
													/if;
													$thisSearch->insert($thisFieldName=action_param($a_Input));
											/if;
									/iterate;
					/select;
					if(var($listeratorAction + '_savedStatementModifiers')->size > 0);
							$statementModifiers += var($listeratorAction + '_savedStatementModifiers');
							var($listeratorAction + '_savedStatementModifiers') = $statementModifiers;
					else;
							$statementModifiers += var($listeratorAction + '_savedStatementModifiers');
							var($listeratorAction + '_savedStatementModifiers') = $statementModifiers;
					/if;
	/select;
	// GROUP BY MODIFIER
	$statementModifiers += ' GROUP BY ' + var($listeratorAction + '_table') + '.UID \r';
	// SORT MODIFIER
	var('newSort'=action_params->find('sortOrder')->size > 0);
	select($newSort);
	case(true);
			var('sortOrder'=action_params->find('sortOrder')->get(1)->second);
			var('sortField'=action_params->find('sortField')->get(1)->second);
			$statementModifiers += ' ORDER BY ' + $sortField + ' ' + $sortOrder + '\r';
			var($listeratorAction + '_savedSortField') = $sortField;
			var($listeratorAction + '_savedSortOrder') = $sortOrder;
	case;
			var($listeratorAction + '_savedSortField') == '' ? var($listeratorAction + '_savedSortField' = 'UID');
			var($listeratorAction + '_savedSortOrder') == '' ? var($listeratorAction + '_savedSortField' = 'ASC');
			$statementModifiers += ' ORDER BY ' + var($listeratorAction + '_savedSortField') + ' ' + var($listeratorAction + '_savedSortOrder') + '\r';
			var('sortField'=var($listeratorAction + '_savedSortField'));
			var('sortOrder'=var($listeratorAction + '_savedSortOrder'));
	/select;
	
	
	
	$thisStatement = $baseStatement + $statementModifiers;
	var($listeratorAction + '_savedSearchParams') = $thisSearch;
	var($listeratorAction + '_savedStatement') = $thisStatement;
	
/* 	$content_debug += (' */
/* 		<p><strong>$sortOrder:</strong> ' + $sortOrder + ' </p> */
/* 		<p><strong>$thisStatement:</strong> ' + $thisStatement + ' </p> */
/* 	'); */
	
	if(action_param('print'));
			$maxresults = 'all';
			$thisSearch->insert(-skiprecords=0);
	/if;
	
	inline(
		$authForDatabase
	,	-SQL=$thisStatement
	,	$thisSearch
	,	-inlineName=var($listeratorAction + '_Table')
	,	-table=var($listeratorAction + '_Table')
	,	-maxRecords=$maxresults
	);
			handle_error;
					$content_pageTitle = 'Ooops!';
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
					$makerator_errorStack->insert(map(
						'include_currentPath' = include_currentPath
					,	'action_statement' = action_statement
					,	'error_code' = error_code
					,	'error_msg' = error_msg
					,	'params' = params
					));
			/handle_error;
			var('foundCount'=found_Count);
			var('skipRecords'=skipRecords_Value);
			var('searchErr'=error_currenterror);
	/inline;
	/*
			Catching action_params
	*/
	var('this_exit'=action_param('exit'));
	if($this_exit != '');
			var('exit'=$this_exit);
	/if;
	iterate(var($listeratorAction + '_Okay'), var('temp'));
			var($temp->first=$temp->second);
	/iterate;
	if(var($listeratorAction + '_Missing')->size > 0);
			var('showMissingError'=true);
	else;
			var('showMissingError'=false);
	/if;
	if(var($listeratorAction + '_Invalid')->size > 0);
			var('showInvalidError'=true);
	else;
			var('showInvalidError'=false);
	/if;
	iterate(var($listeratorAction + '_Missing'), var('temp'));
			var($temp->first=null);
	/iterate;
	iterate(var($listeratorAction + '_Invalid'), var('temp'));
			var($temp->first=null);
	/iterate;
	var('tableColumns'=array);
	$tableColumns->insert(map('type'='field', 'shortName'=var($listeratorAction + '_titleFieldName'), 
			'label'=var($listeratorAction + '_titleFieldName'), 'sortOn'=true, 
			'linkOn'=true, /*'linkTo'    =('/Summit/Attendees/Select/?and='),*/'linkUID'='Keyword_URL', 
			'td_class'='width_medium'));
	$tableColumns->insert(map('type'='field', 'shortName'='Summary', 
			'label'='Summary', 'sortOn'=false, 
			'linkOn'=false, /*'linkTo'    =('/Summit/Attendees/Select/?and='),*/'linkUID'='Keyword_URL', 
			'td_class'='width_small'));
	var('showing'=string);
	if(file_exists('/_site/listerators/' + $listeratorContentType + '/admin-search-results.lasso'));
			library('/_site/listerators/' + $listeratorContentType + '/admin-search-results.lasso');
	else(file_exists('/_site/listerators/admin-search-results.lasso'));
			library('/_site/listerators/admin-search-results.lasso');
	else;
			library('/_makerator/listerators/admin-search-results.lasso');
	/if;
	
	/protect;
]