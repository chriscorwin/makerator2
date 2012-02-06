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
	
	
	if(string(response_path)->beginsWith('/api/validation/date/') && client_params->size >= 1);
		/*
			/api/validation/date/Preferences/edit/Date/?Date=2009-02-0
		*/
		
		var('isValidDate' = valid_date(client_param('Date'), -format='%Q'));
		
		
		content_body = $isValidDate;
		content_body;
		abort;
		
	else(string(response_path)->beginsWith('/api/validation/unique/') && client_params->size >= 1);
		/*
			/api/validation/Strings/create/Keyword_URL/?Keyword_URL=some_new_string
		*/
		var('validation_action' = encode_SQL(response_path->split('/')->removeAll('')&->get(3)));
		var('listeratorContentType' = encode_SQL(response_path->split('/')->removeAll('')&->get(4)));
		var('listeratorVerb' = encode_SQL(response_path->split('/')->removeAll('')&->get(5)));
		var('listeratorColumn' = encode_SQL(response_path->split('/')->removeAll('')&->get(6)));
		var('listeratorAction' = 'listerator-' + $listeratorContentType + ($listeratorVerb->size ? $listeratorVerb));
		var('new_ThingToBeUniqueName' = encode_SQL(client_params->get(1)));
		var('new_ThingToBeUnique' = encode_SQL(client_param($new_ThingToBeUniqueName)));
		
		
		var('getListeratorSettings'='SELECT * FROM ' + $tablePrefix + 'listerators WHERE ' + $listeratorColumn + ' = "' + $listeratorContentType + '"');
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
		/inline;
		
		var('newOneIsUnique' = false);
		
		if(var_defined('new_ThingToBeUnique'));
				//check to see if library with that Keyword_URL already exists
				local('query_isUniqueThingAlreadyTaken' = ('
					SELECT ' + $listeratorColumn + ' FROM ' + $tablePrefix + var($listeratorAction + '_table') +  ' WHERE ' + $listeratorColumn + ' = "' + $new_ThingToBeUnique + '"
				'));
				
				inline(
					$authForDatabase
				,	-sql=#query_isUniqueThingAlreadyTaken
				);
						if(found_count == 1);
								if($listeratorVerb == 'create');
										$newOneIsUnique = false;
								else($listeratorVerb == 'edit');
										rows;
												$newOneIsUnique = ($new_ThingToBeUnique != encode_sql(column($listeratorColumn)) ? false | true);
										/rows;
								/if;
						else;
								$newOneIsUnique = true;
						/if;
						
						content_body = $newOneIsUnique;
						content_body;
						abort;
				/inline;
		else;
				content_body = 'not defined';
				content_body;
				abort;
		/if;
		
		
	else;
		content_body = false;
		content_body;
		abort;
	/if;
	
	/protect;
]