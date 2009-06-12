[
	$makerator_includes->insert(include_currentPath);
	$makerator_currentInclude							=	$makerator_includes->last;
	handle;
			$makerator_includes->remove;
			$makerator_currentInclude					=	$makerator_includes->last;
	/handle;
	
	
	handle_error;
			makerator_errorManager(
				$makerator_currentInclude
			,	error_code
			,	error_msg
			);
	/handle_error;
	
	
	library_once('/_makerator/_library/form_generator_config.lasso');
	
	$content_primary += ('
		<form 
			id="listeratorForm" 
			class="' + $makerator_admin_formClasses->find('listerator')->join(' ') + ' listerator-form listerator-form-' + $listeratorVerb + ' listerator-form-' + $listeratorContentType + ' "
			action="' + var($listeratorAction + '_pathto') + ($listeratorNoun->size ? $listeratorNoun + '/' | '') + $listeratorVerb + '/do/' + '" 
			name="' + $these + $listeratorNoun + $listeratorVerb + '" 
			method="post" 
		>
	');
	
	$json_data->insert('listeratorNoun'=$listeratorNoun);
	$json_data->insert('listeratorVerb'=$listeratorVerb);
	
	var(
		'tabindex'								=	0
	,	'date_today'							=	date->format('%Q')
	);
	iterate($formFields, var('a_map'));
			
			
			iterate($makerator_admin_formElements->keys, local('formElement'));
					var(#formElement + '_classes' = ($makerator_admin_formElements->find(#formElement))->second);
			/iterate;
			
			
			var('a_column'='');
			
			$tabindex += 1;
			
			var(
				'fieldtype'								=	$a_map->find('type')
			,	'a_column'								=	$a_map->find('field')
			,	'a_column_decrypted'						=	$a_map->find('field')
			,	'field_label'							=	$a_map->find('field')
			,	'a_onclick'								=	$a_map->find('onclick')
			,	'a_onchange'							=	$a_map->find('onchange')
			,	'a_onfocus'								=	$a_map->find('onfocus')
			,	'a_onblur'								=	$a_map->find('onblur')
			,	'a_default'								=	$a_map->find('default')
			,	'a_onsubmit'							=	$a_map->find('onsubmit')
			,	'table'									=	$a_map->find('table')
			,	'options'								=	$a_map->find('options')
			,	'a_description'							=	$a_map->find('description')
			,	'fieldlabel'							=	$a_map->find('label')
			,	'requiredornot'							=	$a_map->find('required')
			);
			
			$field_label->replace('_and_', '&nbsp&amp;&nbsp;');
			$field_label->replace('~', '&rsquo;');
			$field_label->replace('__', ' / ');
			$field_label->replace('_', ' ');
			
			
			if(variable_defined($a_column) && var($a_column) == '');
					var('a_value' = $a_default);
			else(variable_defined($a_column));
					var('a_value' = var($a_column));
			else;
					var('a_value' = $a_default);
			/if;
			
			
			
			select(true);
					case($a_map->find('Type')->beginswith('VarChar'));
							var('type'					=	$a_map->find('Type'));
							$varchar_fields->insert($field);
							var('size')					=	$type->split('(')->get(2)->removetrailing(')') & ;
							var('type')					=	$type->split('(')->get(1)->removetrailing('(') & ;
							var('options'				=	$a_map->find('Type'));
					case($a_map->find('Type')->beginswith('set'));
							var('type'					=	$a_map->find('Type'));
							var('options'				=	$a_map->find('Type'));
							$options						=	$options->substring(5, $options->length - 5)->split(',');
							var('size')					=	$type->split('(')->get(2)->removetrailing(')') & ;
							var('type')					=	$type->split('(')->get(1)->removetrailing('(') & ;
					case($a_map->find('Type')->beginswith('enum'));
							var('type'					=	$a_map->find('Type'));
							var('length')				=	$type->split('(')->get(2)->removetrailing(')') & ;
							var('options'				=	$a_map->find('Type'));
							$options						=	$options->substring(5, $options->length - 5)->split(',');
					case($a_map->find('Type')->equals('date'));
							var('type'					=	$a_map->find('Type'));
							var('options'				=	$a_map->find('Type'));
							var('length'				=	'');
							var('type')					=	$type->split('(')->get(1)->removetrailing('(') & ;
					case($a_map->find('Type')->equals('datetime'));
							var('length'				=	'');
							var('type'					=	$a_map->find('Type'));
							var('type')					=	$type->split('(')->get(1)->removetrailing('(') & ;
							var('options'				=	$a_map->find('Type'));
					case($a_map->find('Type')->equals('text'));
							var('length'				=	'');
							var('type'					=	$a_map->find('Type'));
							var('type')					=	$type->split('(')->get(1)->removetrailing('(') & ;
							var('options'				=	$a_map->find('Type'));
			/select;
			
			
			
			$fieldtype = $type;
			$a_column == 'UID' && response_path >> 'edit' ? $fieldtype = 'hidden';
			$a_column == 'UID' && response_path >> 'create' ? loop_continue;
			
			$fieldtype->beginsWith('enum') ? $fieldtype = 'enum';
			
			if($a_default->type != 'null');
					if($a_default->beginsWith('json(\''));
							$fieldtype = 'json';
							$a_value->removeLeading('json(\'')&->removeTrailing('\')');
					/if;
			/if;
			
			var('errorWarning' = string);
			var($listeratorAction + '_missing')->find($a_column)->size > 0 || var($listeratorAction + '_invalid')->find($a_column)->size > 0 ?  $section_classes->merge(array('error', 'ui-state-error'));
			var($listeratorAction + '_missing')->find($a_column)->size > 0 || var($listeratorAction + '_invalid')->find($a_column)->size > 0 ?  $input_classes->merge(array('error', 'ui-state-error'));
			var($listeratorAction + '_required')->find($a_column)->size ? $section_classes->merge(array('required')) | $section_classes->merge(array('optional'));
			var($listeratorAction + '_required')->find($a_column)->size ? $input_classes->merge(array('required')) | $input_classes->merge(array('optional'));
			
			
			if(var($listeratorAction + '_missing')->find($a_column)->size > 0  );
					$errorWarning +=  ('
						<label 
							for="' +  $a_column + '"
							class=" ' + $label_classes->join(' ') + ' ui-state-highlight ui-state-missing"
						>
								<p>This field is required.</p>
						</label>
					');
					$a_value = '';
			else(var($listeratorAction + '_invalid')->find($a_column)->size > 0);
					iterate(var($listeratorAction + '_validationwarnings'), var('a_pair'));
							if($a_pair->first == $a_column);
								$errorWarning +=  ('
									<label 
										for="' +  $a_column + '"
										class=" ' + $label_classes->join(' ') + ' ui-state-highlight ui-state-invalid "
									>
											<p>' + $a_pair->second + '</p>
									</label>
								');
							/if;
					/iterate;
			/if;
			
			
			
			$fieldtype != 'hidden' ? $content_primary += ('
				<fieldset class="' + $fieldset_classes->join(' ') + '">
			');
			
			select($fieldtype);
			case('hidden');
					$input_classes->merge($makerator_admin_formElements->find('input-hidden')->second);
					library('/_makerator/_library/form_varchar.lasso');
			case('json');
					$input_classes->merge($makerator_admin_formElements->find('select')->second);
					$input_classes->insert('combineRelIntoJson');
					library('/_makerator/_library/form_json.lasso');
					
			case('varchar');
					if($a_column->endswith('uid'));
						$input_classes->merge($makerator_admin_formElements->find('input-text')->second);
						$input_classes->insert('uid');
						library('/_makerator/_library/form_varcharuid.lasso');
					else($a_column->equals('Keyword_URL'));
						$input_classes->merge($makerator_admin_formElements->find('input-text')->second);
						$input_classes->merge(array('urlfriendly', 'unique'));
						library('/_makerator/_library/form_varchar_keyword_url.lasso');
					else;
						$a_column == var($listeratorAction + '_titleFieldName') ? $input_classes->insert('createKeywordUrlFromTitle');
						$input_classes->merge($makerator_admin_formElements->find('input-text')->second);
						library('/_makerator/_library/form_varchar.lasso');
					/if;
			case('text');
					$input_classes->merge($makerator_admin_formElements->find('textarea')->second);
					if($a_column->endswith('uid'));
							$input_classes->insert('uid');
							library('/_makerator/_library/form_textuid.lasso');
					else;
							library('/_makerator/_library/form_text.lasso');
					/if;
			case('set');
					$input_classes->merge($makerator_admin_formElements->find('select')->second);
					var('a_table'=var($listeratorAction + '_table'));
					library('/_makerator/_library/form_set.lasso');
			case('enum');
					$input_classes->merge($makerator_admin_formElements->find('select')->second);
					var('a_table'=var($listeratorAction + '_table'));
					library('/_makerator/_library/form_enum.lasso');
			case('datetime');
					$input_classes->merge($makerator_admin_formElements->find('input-datetime')->second);
					library('/_makerator/_library/form_date.lasso');
			case('date');
					$input_classes->merge($makerator_admin_formElements->find('input-date')->second);
					library('/_makerator/_library/form_date.lasso');
			case;
					$input_classes->merge($makerator_admin_formElements->find('input-text')->second);
					library('/_makerator/_library/form_varchar.lasso');
			/*
			case('review');
					library($my_rew_formreviewonly);
			case('review_ssn');
					library($my_rew_formreviewssn);
			case('groupstart');
					library($my_rew_formgroupstart);
			case('groupend');
					library($my_rew_formgroupend);
			case('comment');
					library($my_rew_formcomment);
			case('freestyle');
					var('a_freestylecontent' = $a_map->find('content');
					library($my_rew_formfreestyle);
			case('text');
					library($my_rew_formtextfield);
			case('hidden');
					library($my_rew_formhiddenfield);
			case('phone');
					library($my_rew_formphonefield);
			case('ssn');
					library($my_rew_formssnfield);
			case('textarea');
					var('some_rows' = $a_map->find('rows');
					var('some_cols' = $a_map->find('cols');
					library($my_rew_formtextareafield);
			case('password');
					library($my_rew_formpasswordfield);
			case('select');
					library($my_rew_formselectfield);
			case('enum');
					var('a_table' = $a_map->find('table');
					library($my_rew_formenumfield);
			case('set');
					var('a_column' = (encrypt_blowfish(-seed=$bfseed, ('' + ($a_map->find('name'))) );
					var('a_table' = $a_map->find('table');
					library($my_rew_formsetfield);
			case('checkbox');
					var('a_column' = (encrypt_blowfish(-seed=$bfseed, ('ch3ckb0x_' + ($a_map->find('name'))) );
					library($my_rew_formcheckboxfield);
			case('radio');
					library($my_rew_formradiofield);
			*/
			/select;
			
			
			$fieldtype != 'hidden' ? $content_primary += ('
				</fieldset>
			');
			
			
			iterate($makerator_admin_formElements->keys, local('formElement'));
					var_remove(#formElement + '_classes');
			/iterate;
			var_remove('errorWarning');
	/iterate;
	$content_primary += ('
			<fieldset class="listerator-form-buttons ui-helper-reset">
				<button id="saveListerator" class="ui-helper-reset ui-state-default ui-corner-all ui-clickable" >
					<span class="ui-icon ui-icon-left ui-icon-disk"></span>Save Changes
				</button>
				<button id="revertListerator" class="ui-helper-reset ui-state-default ui-corner-all ui-clickable" name="reset" value="reset" title="' + ($listeratorVerb >> 'edit' ? 'Revert to Last Saved' | ' Clear Errors') + '">
					<span class="ui-icon ui-icon-left ui-icon-arrowthick-1-nw"></span><span class="ui-button-label">
						' + ($listeratorVerb >> 'edit' ? 'Revert to Last Saved' | 'Clear Errors') + '
						</span>
				</button>
			</fieldset>
		</form>
	');


]