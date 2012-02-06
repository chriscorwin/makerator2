[

	// Look for this Listerator in the Listorators table, and get heuristic settings from there
	// if there are none, no problem! the defaults will work
	var('getListeratorSettings' = 'SELECT * FROM ' $tablePrefix 'Listerators WHERE Keyword_URL = "' $listeratorContentType'"');
	Var: 'listeratorAction' = ('Makerator_Action'); 
	inline($authForDatabase, -sql=$getListeratorSettings);
			if(found_count == 1);
					// we have configured heuristics
					rows;
							var(
								'these'=column('Pluralized'),
								'this'=column('Singular'),
								);
							var($listeratorAction + '_Table') = column('Table_name');
							var($listeratorAction + '_Title_Field_Name') = column('Title_Field_Name');
						
							
					/rows;
			else;
			
					var(
						'these'=($listeratorContentType),
						'this'=($listeratorContentType),
						);
				
					if($listeratorContentType->endswith('y'));
							$these->removetrailing('y');
							$these += 'ies';
							var($listeratorAction + '_Table') = $these;
							var($listeratorAction + '_Title_Field_Name') = 'Title';
					else($listeratorContentType->endswith('ies'));
							$this->removetrailing('ies');
							$this += 'y';
							var($listeratorAction + '_Table') = $listeratorContentType;
							var($listeratorAction + '_Title_Field_Name') = 'Title';
					else;
							$this->removetrailing('s');
							var($listeratorAction + '_Table') = $listeratorContentType;
							var($listeratorAction + '_Title_Field_Name') = 'Title';
					/if;
			/if;
	/inline;
	
	
	
	var($listeratorAction + '_UIDfieldName') = 'UID'; //should this be in REW?
	
	// set the table for this database action 
	var('this_table' = (var($listeratorAction + '_Table')));
	// build the initial fields array
	var($listeratorAction + '_Fields'=array);

	
	//here we are going to populate an arary with informatino about the table we'lle be reading data from.
	inline($authForDatabase, -table=$this_table, -sql='SHOW COLUMNS FROM '+$this_table+';');
			var($listeratorContentType'_cols'= array);
			if(error_code == 0);
					iterate(column_names, var('a_column'));
							var($listeratorContentType'_cols')->insert($a_column);
							//$content_primary += $a_column '\r';
					/iterate;
					
					
					var('field_params' = array('Field', 'Length', 'Type', 'Default', 'Required','NULL','Table')); // this is the type of information we can get out of a mysql database
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
					
					
			else;
					$content_pageTitle = 'Oops! The server made a boo&ndash;boo';
					$content_primary += '<p>'error_msg'</p>';
			/if;
	/inline;
	
	select(true);
	
	// list records
	case(string_uppercase(response_path) == string_uppercase(var($listeratorAction + '_pathTo')));
			$content_pageTitle = $these;
			$content_pageTitle->replace('_and_', '&nbsp&amp;&nbsp;');
			$content_pageTitle->replace('~per-cent~', '%');
			$content_pageTitle->replace('--', ': ');
			$content_pageTitle->replace('~', '&rsquo;');
			$content_pageTitle->replace('__', ' / ');
			$content_pageTitle->replace('_', ' ');
			var('content_pageTitle_base' = $these); //this is what *would* have been the title before any errors but after we do the string manipulations
			
			if(file_exists('/_Site/Listerators/'$listeratorContentType'/public-list_records.lasso'));
					// app-specific
					$content_primary += include('/_Site/Listerators/'$listeratorContentType'/public-list_records.lasso');
			else(file_exists('/_Site/Listerators/public-list_records.lasso'));
					// site-specific
					$content_primary +=include('/_Site/Listerators/public-list_records.lasso');
			else;
					//the default application listing_all
					$content_primary +=include('/_makerator/listerators/public-list_records.lasso');
			/if;
	case(((response_path)->endswith('/Reset/')));
			If: (Variable_Defined: 'listeratorAction');
					Session_End: -Name=(Var: ($listeratorAction + '_SessionName'));
					Cookie_Set:
						(Var: ($listeratorAction + '_SessionName'))='kilt off',
						-Domain=(Server_Name),
						-Expires=-9000,
						-Path='/',
						;
					Session_End: -Name=(Var: ($listeratorAction + '_SessionName'));
					if: action_param: 'exit';
							Redirect_URL: Action_Param('exit');
					else;
							Redirect_URL: (Var: ($listeratorAction + '_pathTo'));
					/if;
			Else;
					 Var: 'new_exit' = (Response_Path);
					$new_exit->(RemoveTrailing: $thisLevel_Name + '/');
					Redirect_URL: '../';
			/If;
	case($show_content_siteAdmin && ((response_path)->endswith('/Reset/')));
			If: (Variable_Defined: 'listeratorAction');
					Session_End: -Name=(Var: ($listeratorAction + '_SessionName'));
					Cookie_Set:
						(Var: ($listeratorAction + '_SessionName'))='kilt off',
						-Domain=(Server_Name),
						-Expires=-9000,
						-Path='/',
						;
					Session_End: -Name=(Var: ($listeratorAction + '_SessionName'));
					if: action_param: 'exit';
							Redirect_URL: Action_Param('exit');
					else;
							Redirect_URL: (Var: ($listeratorAction + '_pathTo'));
							//redirect_url('../');
					/if;
			Else;
					Var: 'new_exit' = (Response_Path);
					$new_exit->(RemoveTrailing: $thisLevel_Name + '/');
					Redirect_URL: '../';
			/If;
	case((response_path)->beginswith('/'$listeratorContentType'/') && (response_path)->endswith('/Search/'));
			$content_pageTitle = $these;
			if(file_exists('/_Site/Listerators/'$listeratorContentType'/public-search.lasso'));
					// app-specific
					$content_primary += include('/_Site/Listerators/'$listeratorContentType'/public-search.lasso');
			else(file_exists('/_Site/Listerators/public-search.lasso'));
					// site-specific
					$content_primary += include('/_Site/Listerators/public-search.lasso');
			else;
					//the default Makerator search
					$content_primary +=include('/_makerator/listerators/public-search.lasso');
			/if;
	case;
	
	
			//might be a specific '$listeratorContentType' item
			var('sql' = string);
			
			
			
			$sql = 'SELECT * FROM ' (var($listeratorAction + '_Table')) ' WHERE ' (var($listeratorAction + '_Table')) '.Keyword_URL = "' + $thisLevel_Name + '"';
			inline($authForDatabase, action_params, -sql=$sql, -inlinename=('show'+$this));
					if(found_count == 0);
							
							
							// this record no existee
							$content_pageTitle = '<code>You are standing in an empty field, looking<br>at a sign that reads "404: File Not Found"_</code>';
							
							$content_primary = '<p class="">Perhaps you followed a bad link?</p>
							';
							
					
					else(error_code != 0);
					
							$content_primary += '<div class="warning">'error_msg'</div>';
							$content_primary += '<textarea>'action_statement'</textarea>';
					else;
					
							var('virtual_params' = response_path);
							$content_primary += '<p>virtual_params are: '$virtual_params '</p>';
							$virtual_params = ((($virtual_params)->split('/'))->removeall('') &);
							var('saved'=false, 'saved_params' = array);
							
							if($virtual_params->size >= 2);
									loop($virtual_params->size, -by=2);
											var($virtual_params->get(loop_count)) = $virtual_params->get(loop_count + 1);
											$saved_params->insert($virtual_params->get(loop_count));
											$content_primary += ($virtual_params->get(loop_count)) ', ';
									/loop;
							/if;
							
							iterate($saved_params, local('a_param'));
									$content_primary += '<p>'#a_param  ' = ' var(#a_param)'</p>';
							/iterate;
					
							rows;
									$Current_UID_Value = column(var($listeratorAction + '_UIDfieldName'));
									$Current_UID_Name = column(var($listeratorAction + '_Title_Field_Name'));
									$Current_UID_Table = var($listeratorAction + '_Table');
							/rows;
							
							
							if(file_exists('/_Site/Listerators/'$listeratorContentType'/public-details.lasso'));
									// app-specific
									$content_primary += include('/_Site/Listerators/'$listeratorContentType'/public-details.lasso');
							else(file_exists('/_Site/Listerators/public-details.lasso'));
									// site-specific
									$content_primary += include('/_Site/Listerators/public-details.lasso');
							else;
									//the default Makerator listing_all
									$content_primary +=include('/_makerator/listerators/public-details.lasso');
							/if;
					/if;
					
					
			/inline;
			
			
	/select;
	



]