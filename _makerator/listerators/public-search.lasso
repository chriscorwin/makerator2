[
	$maxresults = 6;

	var('baseStatement'=string, 
		'statementModifiers'=string, 
		'thisStatement'=string, 
		'thisSearch'=array, 
		'searchType'=string
		);
	var('searchInputs'=array('TXT-maxRecords', 
		'TXT-SkipRecords'), 
		'defaultSearch'=array('-maxRecords'=$maxresults, 
		'-SkipRecords'=0)
		);
		
		
		$baseStatement += (
			'

SELECT * FROM ' var($listeratorAction + '_Table') '
    

WHERE 1 = 1


					\r');
					
					
					
	
	if($user_Access_Level == 0);
			$baseStatement += ' AND ' var($listeratorAction + '_Table')'.Display_Status = "Show" ';
	else;
			$baseStatement += ' AND ' var($listeratorAction + '_Table')'.Display_Status = "Show" ';
	/if;
	
	
	if(action_param('print'));
			$maxresults = 'all';
	/if;
	
	
	select(action_param('searchType'));
		case('new');
			$searchType = action_param('searchType');
			iterate($searchInputs, 
				var('a_Input'));
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
			var('potential_modifiers' = array);
			if(action_param('keyword'));
					iterate((var($listeratorAction + '_Fields')), local('a_map'));
									if(((#a_map->find('type') == 'varchar') || (#a_map->find('type') == 'text')) && (#a_map->find('field') != 'UID'));
											$potential_modifiers->insert($tablePrefix+(var($listeratorAction + '_Table'))'.'#a_map->find('field')' LIKE "%' action_param('keyword') '%" ');
									/if;
					/iterate;
					iterate($potential_modifiers, local('a_modifier'));
							(loop_count == 1) ? $statementModifiers += (' AND ( ') | $statementModifiers +=  ' OR ';
									$statementModifiers += #a_modifier;
					
					/iterate;
					($potential_modifiers->size) ? $statementModifiers += ') ';

	
					var('keyword' = action_param('keyword'));
					var($listeratorAction + '_savedStatementModifiers') += $statementModifiers;
			/if;
		case;
			select(var($listeratorAction + '_savedSearchParams')->Size > 0);
			case(true);
				$thisSearch = var($listeratorAction + '_savedSearchParams');
				$searchType = 'saved';
				iterate($searchInputs, 
					var('a_Input'));
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
				iterate($searchInputs, 
					var('a_Input'));
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
			if(var($listeratorAction + '_savedStatementModifiers')->Size > 0);
				$statementModifiers += var($listeratorAction + '_savedStatementModifiers');
				var($listeratorAction + '_savedStatementModifiers') = $statementModifiers;
			else;
				$statementModifiers += var($listeratorAction + '_savedStatementModifiers');
				var($listeratorAction + '_savedStatementModifiers') = $statementModifiers;
			/if;
	/select;
	
	
	
	// GROUP BY MODIFIER
	$statementModifiers += ' GROUP BY ' var($listeratorAction + '_Table')'.UID \r';
	
	

	
	
	// SORT MODIFIER
	var('newSort'=((action_params)->Find('SortOrder')->Size > 0));
	
	select($newSort);
		case(true);
			var('SortOrder'=action_params->Find('SortOrder')->Get(1)->second);
			var('SortField'=action_params->Find('SortField')->Get(1)->second);
			$statementModifiers += ' ORDER BY ' + $SortField + ' ' + $SortOrder + '\r';
			var($listeratorAction + '_savedSortField') = $sortField;
			var($listeratorAction + '_savedSortOrder') = $sortOrder;
		case;
			$statementModifiers += ' ORDER BY ' + var($listeratorAction + '_savedSortField') + ' ' + var($listeratorAction + '_savedSortOrder') + '\r';
			var('sortField'=var($listeratorAction + '_savedSortField'));
			var('sortOrder'=var($listeratorAction + '_savedSortOrder'));
	/select;
	
	
	$thisStatement = $baseStatement + $statementModifiers;
	var($listeratorAction + '_savedSearchParams') = $thisSearch;
	var($listeratorAction + '_savedStatement') = $thisStatement;
	
	
	/*
	$debug_variablesList->insert('searchType');
	$debug_variablesList->insert('addtl_params');
	$debug_variablesList->insert('baseStatement');
	$debug_variablesList->insert('statementModifiers');
	$debug_variablesList->insert('thisStatement');
	$debug_variablesList->insert($listeratorAction + '_savedStatementModifiers');
	*/
	
	if(action_param('print'));
			$maxresults = 'all';
			$thisSearch->insert(-skiprecords=0);
			
	/if;
	
	
	inline(
		$authForDatabase, 
		-SQL=$thisStatement, 
		$thisSearch, 
		-inlineName=var($listeratorAction + '_Table'), 
		-Table=(var($listeratorAction + '_Table')), 
		-maxRecords=$maxresults
		);
			var('foundCount'=Found_Count);
			var('SkipRecords'=SkipRecords_Value);
			var('searchErr'=error_currenterror);
	/inline;
	
	
	$content_primary += '<pre>'$thisStatement'</pre>';
	
	
	/*
		Catching action_params
	*/
	var('this_exit'=action_param('exit'));
	if($this_exit != '');
		var('exit'=$this_exit);
	/if;
	iterate(var($listeratorAction + '_Okay'), 
		var('temp'));
		var($temp->first=$temp->second);
	/iterate;
	if(var($listeratorAction + '_Missing')->Size > 0);
		var('showMissingError'=true);
	else;
		var('showMissingError'=false);
	/if;
	if(var($listeratorAction + '_Invalid')->Size > 0);
		var('showInvalidError'=true);
	else;
		var('showInvalidError'=false);
	/if;
	iterate(var($listeratorAction + '_Missing'), 
		var('temp'));
		var($temp->first=null);
	/iterate;
	iterate(var($listeratorAction + '_Invalid'), 
		var('temp'));
		var($temp->first=null);
	/iterate;



			inline($authForDatabase, -table=$this_table, -sql='SHOW COLUMNS FROM '+$this_table+';');
					var($listeratorContentType'_cols'= array);
					if(error_code == 0);
							iterate(column_names, var('a_column'));
									var($listeratorContentType'_cols')->insert($a_column);
									//$content_primary += $a_column '\r';
							/iterate;
							
							
							var('field_params' = array('Field', 'Length', 'Type', 'Default', 'Required','NULL','Table'));
							var('formFields'=array);
							rows;
									var('this_group'=map);
									iterate($field_params, var('a_param'));
											$this_group->insert($a_param=column($a_param));
									/iterate;
									$formFields->insert($this_group);
							/rows;
							iterate($formFields, var('a_group'));
									var('field' = $a_group->find('Field'));
									var('required'=(($a_group->find('NULL')) == 'YES' ? false | true));
									var('table'=var($listeratorAction + '_Table'));
									var('default' = $a_group->find('Default'));
									select(true);
										case(($a_group->find('Type'))->beginswith('VarChar'));
											var('type' = $a_group->find('Type'));
											var('size') = ($type->split('(')->get(2)->removetrailing(')')&);
											var('type') = ($type->split('(')->get(1)->removetrailing('(')&);
										case(($a_group->find('Type'))->beginswith('set'));
											var('type' = $a_group->find('Type'));
											var('size') = ($type->split('(')->get(2)->removetrailing(')')&);
											var('type') = ($type->split('(')->get(1)->removetrailing('(')&);
										case(($a_group->find('Type'))->beginswith('enum'));
											var('type' = $a_group->find('Type'));
											var('length') = ($type->split('(')->get(2)->removetrailing(')')&);
										case(($a_group->find('Type'))->equals('date'));
											var('type' = $a_group->find('Type'));
											var('length'='');
											var('type') = ($type->split('(')->get(1)->removetrailing('(')&);
										case(($a_group->find('Type'))->equals('datetime'));
											var('length'='');
											var('type' = $a_group->find('Type'));
											var('type') = ($type->split('(')->get(1)->removetrailing('(')&);
										case(($a_group->find('Type'))->equals('text'));
											var('length'='');
											var('type' = $a_group->find('Type'));
											var('type') = ($type->split('(')->get(1)->removetrailing('(')&);
									/select;
									var('this_group'=map);
									iterate($field_params, var('a_param'));
											$this_group->insert($a_param=var($a_param));
									/iterate;
									(var($listeratorAction + '_Fields'))->insert($this_group);
									
									
									
							/iterate;
							
							include('/_makerator/_library/REW_finish.lasso');
							
					else;
							$content_pageTitle = 'Oops! The server made a boo&ndash;boo';
							$content_primary += '<p>'error_msg'</p>';
					/if;
			/inline;






	var('tableColumns'=array);
	$tableColumns->insert(
		map(
			'type'      ='field',
			'shortName' ='FirsT_Name',
			'label'     ='Title',
			'sortOn'    =true,
			'linkOn'    =true,
			/*'linkTo'    =('/Summit/Attendees/Select/?and='),*/
			'linkUID'   = 'UID',
			'td_class'='width_medium',
			),
		);
	$tableColumns->insert(
		map(
			'type'      ='field',
			'shortName' ='Summary',
			'label'     ='Summary',
			'sortOn'    =false,
			'linkOn'    =false,
			/*'linkTo'    =('/Summit/Attendees/Select/?and='),*/
			'linkUID'   = 'Keyword_URL',
			'td_class'='width_small',
			),
		);
	$tableColumns->insert(
		map(
			'type'      ='field',
			'shortName' ='Title',
			'label'     ='Title',
			'sortOn'    =true,
			'linkOn'    =true,
			/*'linkTo'    =('/Summit/Attendees/Select/?and='),*/
			'linkUID'   = 'Keyword_URL',
			'td_class'='width_medium',
			),
		);


	var: 'showing' = string;
	

	
	include('/_makerator/_library/REW_results_table.lasso');
	include('/_makerator/_library/REW_results_nav.lasso');
	
	
	
	if: $searchErr != 'No Error';
			var: 'page_output' = (string);
			var: 'o' = @$page_output;
			var: 'showing' = string;
			'<p>' $searchErr '</p>';
	/if;



	if($searchErr != 'No Error');
		var('page_output'=string);
		var('o'=@$page_output);
		var('showing'=string);
		'<p>' $searchErr '</p>';
		'<pre>' $thisStatement '</pre>';
	/if;
	
	
	]
