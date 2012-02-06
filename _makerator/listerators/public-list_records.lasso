[

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
			');








	// the /_Site/*Listerator-name*/public-sql file is where you do any customizations that are required for this Listerator
	if(file_exists('/_Site/Listerators/'$listeratorContentType'/public-sql.lasso'));
			$content_primary += include('/_Site/Listerators/'$listeratorContentType'/public-sql.lasso');
	else(file_exists('/_Site/Listerators/public-sql.lasso'));
			// if all the Listerators you create for this site share commen things, this is a good place to do that
			$content_primary +=include('/_Site/Listerators/public-sql.lasso');
	else;
			// otherwise, makerator's defaults should work, at least, even if it doesn't look exactly like you want yet.
			$content_primary +=include('/_makerator/listerators/public-sql.lasso');
	/if;



	if(action_param('print'));
			$maxresults = 'all'; //this is self-explainitory, right? ideally your CSS will take care of how it looks. but you still want all your records if you're printing a report out. anyway, this gives you that option
	/if;


	var('search_type'=action_param('searchType'));
	//$search_type = 'New'; // this is useful when you're building a new Listerator, or debugging something. it "Resets" the search params every time.
	select($search_type);
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
			if(action_param('keyword'));



				//iterate through our fields looking for this keyword
				iterate((var($listeratorAction + '_Fields')), local('a_field'));
						 (loop_count == 1) ? $statementModifiers += (' AND ( ') | $statementModifiers +=  ' OR ';
								$statementModifiesr += $tablePrefix+(var($listeratorAction + '_Table'))'.'#a_field' LIKE "%' action_param('keyword') '%"';
						(loop_count == var($listeratorAction + '_Fields')->size) ? $statementModifiers += ') ';
				/iterate;
				/*				$statementModifiers += '*/
				/*							AND ( */
				/*							'(var($listeratorAction + '_Table'))'.Title LIKE "%' action_param('keyword') '%"  */
				/*							OR*/
				/*							'(var($listeratorAction + '_Table'))'.Summary LIKE "%' action_param('keyword') '%"  */
				/*							OR*/
				/*							'(var($listeratorAction + '_Table'))'.Description LIKE "%' action_param('keyword') '%"  */
				/*							) */
				/*							\r';*/
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

	if(error_code != 0);
			$content_pageTitle = 'Oops! The server made a boo&ndash;boo';
			$content_primary += '<p>'error_msg'</p>';
	/if;

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

	//debug
	//$content_primary += '<pre>'$thisStatement'</pre>';


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
	var('tableColumns'=array);
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


	var: 'showing' = string;



	if(file_exists('/_Site/Listerators/'$listeratorContentType'/public-search_results.lasso'));
			//custom results (try never to use!)
			$content_primary += include('/_Site/Listerators/'$listeratorContentType'/public-search_results.lasso');
	else(file_exists('/_Site/Listerators/public-search_results.lasso'));
			//custom results (try never to use!)
			$content_primary += include('/_Site/Listerators/public-search_results.lasso');
	else;
			//the default application results
			$content_primary +=include('/_makerator/listerators/public-search_results.lasso');
	/if;
	//include('/_makerator/_library/REW_results_nav.lasso');



	if($searchErr != 'No Error');
		var('page_output'=string);
		var('o'=@$page_output);
		var('showing'=string);
		'<p>' $searchErr '</p>';
		'<pre>' $thisStatement '</pre>';
	/if;


]