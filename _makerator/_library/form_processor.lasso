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
	
	
/* 	var($listeratorAction + '_invalid'						=	map); */
/* 	var($listeratorAction + '_message'						=	string); */
/* 	var($listeratorAction + '_missing'						=	map); */
/* 	var($listeratorAction + '_okay'							=	map); */
/* 	var($listeratorAction + '_optional'						=	array); */
/* 	var($listeratorAction + '_validation'					=	array); */
/* 	var($listeratorAction + '_validationWarnings'			=	array); */
/* 	local('content_prevoiusDebug' = $content_debug); */
/* 	$content_debug = string; */
	var: 'to_processMultiples' = array;
	iterate:(client_params), var: 'a_Param';
			var: 'a_paramName' = ($a_Param->first);
			var: 'a_decryptedParamName' = $a_paramName;
			var: 'a_paramValue' = ($a_Param->second);
			if: !($a_paramName->BeginsWith: '-') && !($a_decryptedParamName->BeginsWith: '-');
					if: client_param($a_param->first, -count) > 1;
							// $content_debug += '<p>' $a_param '</p>';
							if: ($to_processMultiples->find($a_param->first))->size == 0;
									if: $a_param->second != '';
											$to_processMultiples->insert($a_param->first);
											var: 'multiple_' $a_param->first = $a_param->second;
									/if;
							else;
									if: $a_param->second != '';
											(var: 'multiple_' $a_param->first) += (',' $a_param->second);
									/if;
							/if;
					/if;
			/if;
	/iterate;
	
	
	
	iterate:(client_params), var: 'a_Param';
			var: 'a_paramName' = ($a_Param->first);
			var: 'a_decryptedParamName' = $a_paramName;
			var: 'a_paramValue' = ($a_Param->second);
			if: !($a_paramName->BeginsWith: '-') && !($a_decryptedParamName->BeginsWith: '-');
					/*
						No Hyphens
						
						Ignoring any parameters that start with a dash "-", becuase
						those are Lasso•s reserved ones, and are irrelevant to our
						purposes here.
					*/
					
					// $content_debug += '<p>Processing the param&ldquo;'$a_paramName'&rdquo;, value: '$a_paramValue'</p>';
					
					if:($a_paramValue->Size);
							/*
								Value is NOT NULL -- okay
							*/
							(var:($listeratorAction + '_Okay'))->(insert:$a_decryptedParamName = $a_paramValue);
							var($a_decryptedParamName = $a_paramValue);
							(var:($listeratorAction + '_Missing'))->(Remove: $a_decryptedParamName);
							(var:($listeratorAction + '_Empty'))->(Remove:$a_decryptedParamName);
							// $content_debug += '<p>Okay so far is: ' (var:($listeratorAction + '_Okay')) '</p>';
					else;
							/*
								Value IS NULL -- NOT okay
							*/
							(var:($listeratorAction + '_Okay'))->(Remove:$a_decryptedParamName);
							if:((var:($listeratorAction + '_Required'))->(Find: $a_decryptedParamName))->Size;
									'<p>Is required!</p>'
									/*
										Missing
									*/
									(var:($listeratorAction + '_Missing'))->(insert: ($a_decryptedParamName)=('missing'));
							else;
									/*
										Empty
									*/
									(var:($listeratorAction + '_Empty'))->(insert:  ($a_decryptedParamName)=('empty'));
							/If;
					/If;
			/If;
	/Iterate;
	
	
	//run through known checkboxes and see if any were not submitted, to remove them
	(var:($listeratorAction + '_Checkboxes')) = (Array);
	iterate:(client_params), var:('a_param');
			var: 'a_paramName' = ($a_Param->first);
			//var: 'a_decryptedParamName' = (decrypt_blowfish2: ($a_Param->first), -Seed='fwpro');
			var('a_decryptedParamName' = $a_paramName);
			var: 'a_paramValue' = ($a_Param->second);
			if:($a_decryptedParamName->(BeginsWith:'ch3ckb0x_'));
					(var:($listeratorAction + '_Checkboxes'))->(insert: ($a_decryptedParamName)= ($a_paramValue));
			/If;
	/Iterate;
	
	var($listeratorAction + '_Sets' = array);
	
	iterate:(client_params), var:('a_param');
			if($a_param->second != null);
					if(string($a_param->second)->beginsWith('set_'));
							$content_debug += ('
								<div class="ui-widget">
									<div class="ui-state-debug ui-corner-all">
										<h5>' + include_currentPath + '</h5>
										<p><strong>$a_param:</strong> ' + $a_param + ' </p>
									</div>
								</div>
							');
							var: 'a_paramName' = ($a_Param->first);
							var('a_decryptedParamName' = $a_paramName);
							var: 'a_paramValue' = ($a_Param->second);
							$a_paramValue =  $a_paramvalue->removeleading('set_')&;
							var($listeratorAction + '_Sets')->insert($a_decryptedParamName = $a_paramValue);
					else;
							//(var:($listeratorAction + '_Sets'))->(insert: ($a_decryptedParamName) = ($a_paramValue));
					/if;
					
			/If;
	/Iterate;

	$content_debug += ('
		<div class="ui-widget">
			<div class="ui-state-debug ui-corner-all">
				<h5>' + include_currentPath + '</h5>
				<p><strong>Sets:</strong> ' + (var($listeratorAction + '_sets')) + ' </p>
			</div>
		</div>
	');



	var:'theseParams' = (Array); // theseParams is the default insert

	
	// Any missing?
	if:((((var:$listeratorAction + '_Missing'))->Size) > 0);
			//Some are missing - Redirecting back to the form with errors
			(var:'someAreMissing') = true;
			(var:$listeratorAction + '_Invalid') = Map;
			
			// redirect_URL(referer_url);

	else;
			// None are missing
			var:'someAreMissing' = false;
			var: 
				'currentDate' = Date->(Format:'%Q'),
				'currentTime' = Date->(Format:'%H:%M:%S'),
				;
			// Set vars from Okay
			iterate: (var:$listeratorAction + '_Okay'), (var:'x');
					if:(!($x->first)->(BeginsWith:'this_'));
							var('this_fieldName' = $x->first);
							iterate: (var:$listeratorAction + '_Fields'), var('a_map');
									//$content_debug += '<p>a map: '$a_map'</p>';
									if: $a_map->find('field') == $this_fieldName;
										if: boolean(($a_map->find('table'))->size);
												var('this_tableName' = $a_map->find('table'));
												!var_defined(($this_tableName '_params')) ? var(($this_tableName '_params') = array);
												
												
												
												var($this_tableName '_params')->insert($x->first=$x->second);
										else;
												$theseParams->(insert:($x->first) = ($x->second));
										/if;
									/if;
							/iterate;
							(var:$x->first) = ($x->second);
					else;
							// param begins with "this_"
							(var:$x->first) = ($x->second);
							
							
							
							var('this_fieldName' = $x->first);
							($x->first)->(RemoveLeading:'this_');
							iterate: (var:$listeratorAction + '_Fields'), var('a_map');
									if: $a_map->find('Title') == $this_fieldName;
										if: boolean(($a_map->find('table'))->size);
												var('this_tableName' = $a_map->find('table'));
												!var_defined(($this_tableName '_params')) ? var(($this_tableName '_params') = (array));
												(var: ($this_tableName '_params'))->insert($x->first=$x->second);
										else;
												$theseParams->(insert:($x->first) = ($x->second));
										/if;
									/if;
							/iterate;
					/If;
			/Iterate;
			iterate: (var:$listeratorAction + '_Empty'), (var:'temp');
					if:(!($temp->first)->(BeginsWith:'this_'));
							(var:$temp->first) = '';
							
							
							var('this_fieldName' = $temp->first);
							iterate: (var:$listeratorAction + '_Fields'), var('a_map');
									if: $a_map->find('Title') == $this_fieldName;
										if: boolean(($a_map->find('table'))->size);
												// got it
												var('this_tableName' = $a_map->find('table'));
												!var_defined(($this_tableName '_params')) ? var(($this_tableName '_params') = array);
												var($this_tableName '_params')->insert($temp->first='');
										else;
												$theseParams->insert($temp->first = '');
										/if;
									/if;
							/iterate;
							
					else;
							(var:$temp->first) = $temp->second;
							var('this_fieldName' = $temp->first);
							($temp->first)->(RemoveLeading:'this_');
							iterate: (var:$listeratorAction + '_Fields'), var('a_map');
									if: $a_map->find('Title') == $this_fieldName;
										if: boolean(($a_map->find('table'))->size);
												// got it
												var('this_tableName' = $a_map->find('table'));
												!var_defined(($this_tableName '_params')) ? var(($this_tableName '_params') = array);
												var($this_tableName '_params')->insert($temp->first='');
										else;
												$theseParams->insert($temp->first = '');
										/if;
									/if;
							/iterate;
					/If;
			/Iterate;
			

			
			// re-set the validators back to empty
			var($listeratorAction + '_ValidationWarnings')= array;
			var($listeratorAction + '_Invalid')= map;
			
			
			iterate: (var:($listeratorAction + '_Fields')), var: 'a_fieldMap';
					iterate: $listeratorValidationKeys, var: 'a_validationKey';
							if: boolean($a_FieldMap->Find($a_validationkey));
									var: 'input' = var($a_fieldMap->find('Title'));
									var: 'destination_table' = var($a_fieldMap->Find('table'));
									var: 'required' =  $a_FieldMap->Find($a_validationkey);
									
									select: $a_validationKey;
											case: 'alpha';
													if: !(Makerator_Valid_Alpha: $input);
															'Alpha: ' (Makerator_Valid_Alpha: $input);
															var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
															var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply an alphabetic string.');
													/if;
											case: 'AlphaNumeric';
													if: !(Makerator_Valid_AlphaNumeric: $input);
															'AlphaNumeric: ' (Makerator_Valid_AlphaNumeric: $input);
															var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
															var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply an alpha&ndash;numeric string.');
													/if;
											case: 'Date';
													if:(((var:($listeratorAction + '_Required'))->(Find: $input))->Size) && boolean($input->Size);
															if: !(Makerator_Valid_Date: $input);
																	var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
																	var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply a date.');
															/if;
													else;
															if: !(Makerator_Valid_Date: $input) && boolean($input->Size) && $input != 'empty';
																	var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
																	var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply a date like &ldquo;mm/dd/yyyy&rdquo;, you supplied &ldquo;' $input'&rdquo;');
															/if;
													
													/if;
											case: 'decimal';
													if: !(Makerator_Valid_Decimal: $input);
															'Decimal: ' (Makerator_Valid_Decimal: $input);
															var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
															var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply a number.');
													/if;
											case: 'Email';
													if:(((var:($listeratorAction + '_Required'))->(Find: $input))->Size) && boolean($input->Size);
															if: !(Makerator_Valid_Email: $input);
																	var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
																	var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply a valid email address.');
															/if;
													/if;
											case: 'Integer';
													if: !(Makerator_Valid_Integer: $input);
															var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
															var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply only a number.');
													/if;
											case: 'Numeric';
													if: $input != 'empty';
															if: !(Makerator_Valid_Numeric: $input);
																	var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
																	var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply a numeric string.');
															/if;
													/if;
											case: 'Phone';
													if: $input != 'empty';
															if: !(Makerator_Valid_Phone: $input);
																	var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
																	var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply a valid phone number, like: &ldquo;(xxx) xxx-xxxx&rdquo;.');
															/if;
													/if;
											case: 'SSN';
													if: $input != 'empty';
															if: !(Makerator_Valid_SSN: $input);
																	var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
																	var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply a valid SSN, like: &ldquo;xxx-xx-xxxx&rdquo;.');
															/if;
													/if;
											case: 'URL';
													if: !(Makerator_Valid_URL: $input);
															var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
															var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply a valid URL.');
													/if;
											case: 'maxLength';
													if: $input != 'empty';
															if: !(Makerator_Valid_MaxLength: $input, -Size=$required);
																	var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
																	var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply a value that is no more than ' $required ' characters long.');
															/if;
													/if;
											case: 'minLength';
													if: $input != 'empty';
															if: !(Makerator_Valid_MinLength: $input, -Size=$required);
																	var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' this is the invalid warning');
																	var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply a value that is no shorter than ' $required ' characters long.');
															/if;
													/if;
											case: 'maxValue';
													'<var>MaxValue:</var> <samp>' (Makerator_Valid_MaxValue: $input, -Max=$required)'</samp>';
													if: !(Makerator_Valid_MaxValue: $input, -Max=$required);
															var($listeratorAction + '_Invalid')->insert(($a_fieldMap->find('Title')) = ' maxvalue was invalid');
															var($listeratorAction + '_ValidationWarnings')->insert(($a_fieldMap->find('Title')) = 'Please supply a value that is no greater than &ldquo;' $required '&rdquo;');
													/if;
											case;
													$a_validationKey;
													var($listeratorAction + '_Invalid')->remove(($a_fieldMap->find('Title')));
													var($listeratorAction + '_ValidationWarnings')->removeall(($a_fieldMap->find('Title')));
													// actually not all that sure about this one here, but
													// then again, they do START empty, so it can't hurt to be here
									/select;
									
							/if;
					/iterate;
			/iterate;
			
			
			
			
			
			// Any invalid?
			if:((var:$listeratorAction + '_Invalid')->Size > 0); // Some are invalid - Redirecting
					(var:'someAreInvalid') = true;
					
					//Redirect_URL($listeratorAction);
					
			else; // None are invalid
					(var:'someAreInvalid') = false;
					// re-set the validators back to empty
					var($listeratorAction + '_ValidationWarnings')= array;
					var($listeratorAction + '_Invalid')= map;
			
			/If;

	/If; // End of missing parameters switch
	

/* 	$content_debug += '<h2>Dumped</h2>'; */
/* 	$content_debug += '<h3>'; */
/* 	$content_debug += 		'Tables stuff'; */
/* 	$content_debug += '</h3>'; */
/* 	$content_debug += '<ul class="paramlist">'; */
/* 	iterate: (var($listeratorAction + '_Tables')), var('this_tableName'); */
/* 			$content_debug += 		'<li><dfn>' ($this_tableName->first '_params') ':</dfn> <samp>' (var: ($this_tableName->first '_params')) '</samp>'; */
/* 			$content_debug += 		'</li>'; */
/* 	/iterate; */
/* 	 */
/* 	 */
/* 	iterate: $to_processMultiples, var: 'temp'; */
/* 	//					var: 'to_save' = (decrypt_blowfish: -Seed='fwpro', $temp); */
/* 	(var: (mhc_decrypt_blowfish: -Seed='fwpro', $temp)) =  (var: 'multiple_' $temp); */
/* 	($theseParams->insert((mhc_decrypt_blowfish: -Seed='fwpro', $temp)=(var:(mhc_decrypt_blowfish: -Seed='fwpro', $temp)))); */
/* 	//'<dfn>HI: ' $temp '</dfn>: <samp>' (var: 'multiple_' $temp)'</samp>'; */
/* 	/iterate; */
/* 	 */
/* 	$content_debug += 	'</ul><p>'; */
/* 	$content_debug += 			'<strong>' + include_currentPath + '</strong>'; */
/* 	$content_debug += 	'</p>'; */
/* 	$content_debug += 	'<h4>'; */
/* 	$content_debug += 			'theseParams'; */
/* 	$content_debug += 	'</h4>'; */
/* 	 */
/* 	$content_debug += 	'params: '$theseParams; */
/* 	 */
/* 	Iterate: $theseParams, var: 'a_Param'; */
/* 	$content_debug += 			'<p>'; */
/* 	$content_debug += 					$a_param; */
/* 	$content_debug += 			'</p>'; */
/* 	/Iterate; */
/* 	 */
/* 	 */
/* 	$content_debug += 	'<h4>'; */
/* 	$content_debug += 			'_Validation'; */
/* 	$content_debug += 	'</h4>'; */
/* 		Iterate: (Var:($listeratorAction + '_Validation')), var: 'a_Param'; */
/* 	$content_debug += 			'<p>'; */
/* 						$a_param; */
/* 	$content_debug += 			'</p>'; */
/* 		/Iterate; */
/* 	$content_debug += 	'<h4>'; */
/* 	$content_debug += 			'_ValidationWarnings'; */
/* 	$content_debug += 	'</h4>'; */
/* 		Iterate: (Var:($listeratorAction + '_ValidationWarnings')), var: 'a_Param'; */
/* 	$content_debug += 			'<p>'; */
/* 	$content_debug += 					$a_param; */
/* 	$content_debug += 			'</p>'; */
/* 		/Iterate; */
/* 	$content_debug += 	'<h4>'; */
/* 	$content_debug += 			'_Invalid'; */
/* 	$content_debug += 	'</h4>'; */
/* 		Iterate: (Var:($listeratorAction + '_Invalid')), var: 'a_Param'; */
/* 	$content_debug += 			'<p>'; */
/* 	$content_debug += 					$a_param; */
/* 	$content_debug += 			'</p>'; */
/* 		/Iterate; */
/* 	$content_debug += 	'<h4>'; */
/* 	$content_debug += 			'Okay'; */
/* 	$content_debug += 	'</h4>'; */
/* 		Iterate: (Var:($listeratorAction + '_Okay')), var: 'a_Param'; */
/* 	$content_debug += 			'<p>'; */
/* 	$content_debug += 					$a_param; */
/* 	$content_debug += 			'</p>'; */
/* 		/Iterate; */
/* 	$content_debug += 	'<h4>'; */
/* 	$content_debug += 			'Missing'; */
/* 	$content_debug += 	'</h4>'; */
/* 		Iterate: (Var:($listeratorAction + '_Missing')), var: 'a_Param'; */
/* 	$content_debug += 			'<p>'; */
/* 	$content_debug += 					$a_param; */
/* 	$content_debug += 			'</p>'; */
/* 		/Iterate; */
/* 	$content_debug += 	'<h4>'; */
/* 	$content_debug += 			'Empty'; */
/* 	$content_debug += 	'</h4>'; */
/* 		Iterate: (Var:($listeratorAction + '_Empty')), var: 'a_Param'; */
/* 	$content_debug += 			'<p>'; */
/* 	$content_debug += 					$a_param; */
/* 	$content_debug += 			'</p>'; */
/* 		/Iterate; */
/* 	$content_debug += 	'<h4>'; */
/* 	$content_debug += 			'Required'; */
/* 	$content_debug += 	'</h4>'; */
/* 		Iterate: (Var:($listeratorAction + '_Required')), var: 'a_Param'; */
/* 	$content_debug += 			'<p>'; */
/* 	$content_debug += 					$a_param; */
/* 	$content_debug += 			'</p>'; */
/* 		/Iterate; */
/* 	$content_debug += 	'<h4>'; */
/* 	$content_debug += 			'Checks'; */
/* 	$content_debug += 	'</h4>'; */
/* 		Iterate: (Var:($listeratorAction + '_Checkboxes')), var: 'a_Param'; */
/* 	$content_debug += 			'<p>'; */
/* 	$content_debug += 					$a_param; */
/* 	$content_debug += 			'</p>'; */
/* 		/Iterate; */

	
	
/* 	$content_debug = $content_debug + #content_prevoiusDebug; */

	/protect;
]
