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
	
	
	var($listeratorAction + '_Tables') = map;
	iterate(var($listeratorAction + '_Fields'), var('a_Field'));
		var('a_name'=$a_Field->Find('Field'));
		var('field_label'=$a_field->Find('field'));
		$field_label->replace('_and_', '&nbsp&amp;&nbsp;');
		$field_label->replace('~', '&rsquo;');
		$field_label->replace('__', ' / ');
		$field_label->replace('_', ' ');
		var('a_label'=$field_label);
		if($a_Field->Find('required') == true);
			if($a_Field->Find('type') == 'checkbox');
				if(!var($listeratorAction + '_Required')->find($a_name)->Size);
					var($listeratorAction + '_Required')->insert('ch3ckb0x_' + $a_name);
				/if;
			Else;
				if(!var($listeratorAction + '_Required')->find($a_name)->Size);
					var($listeratorAction + '_Required')->insert($a_name);
				/if;
			/if;
		Else;
			if($a_Field->Find('type') == 'checkbox');
				if(!var($listeratorAction + '_Optional')->find($a_name)->Size);
					var($listeratorAction + '_Optional')->insert('ch3ckb0x_' + $a_name);
				/if;
			Else;
				var($listeratorAction + '_Optional')->insert($a_name);
				if(!var($listeratorAction + '_Optional')->find($a_name)->Size);
					var($listeratorAction + '_Optional')->insert($a_name);
				/if;
			/if;
		/if;
		if($a_Field->Find('sortOn') == true);
			if(!var($listeratorAction + '_SortOn')->find($a_name)->Size);
				var($listeratorAction + '_SortOn')->insert($a_name=$a_label);
			/if;
		/if;
		if($a_Field->Find('validation')->Size);
			if(!var($listeratorAction + '_Validation')->find($a_name)->Size);
				var($listeratorAction + '_Validation')->insert($a_name);
			/if;
		/if;
		if($a_Field->Find('table')->Size);
			var('a_table'=$a_field->find('table'));
			!var_defined($a_table '_fields') ? var($a_table '_fields'=map);
			session_Addvariable(-name=$sessionName, $a_table '_fields');
			var($a_table '_fields')->insert($a_Field->Find('name'));
			if(!var($listeratorAction + '_Tables')->find($a_table)->size);
				var($listeratorAction + '_Tables')->insert($a_table=$a_table);
			else;
			/if;
		/if;
	/iterate;
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Okay'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Missing'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Required'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Optional'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Empty'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_SortOn'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Invalid'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Error'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_CustomError'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Table'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Validation'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_ValidationWarnings'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_UIDfieldname'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Checkboxes'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Sets'); */
/* 	session_Addvariable(-name=$sessionName, $listeratorAction + '_Tables'); */
/* 	session_Addvariable(-name=$sessionName, 'formFields'); */
/* 	!var_defined($listeratorAction + '_Okay') ? var($listeratorAction + '_Okay'=Map); */
/* 	!var_defined($listeratorAction + '_Missing') ? var($listeratorAction + '_Missing'=Map); */
/* 	!var_defined($listeratorAction + '_Required') ? var($listeratorAction + '_Required'=Array); */
/* 	!var_defined($listeratorAction + '_Optional') ? var($listeratorAction + '_Optional'=Array); */
/* 	!var_defined($listeratorAction + '_Empty') ? var($listeratorAction + '_Empty'=Map); */
/* 	!var_defined($listeratorAction + '_Invalid') ? var($listeratorAction + '_Invalid'=Map); */
/* 	!var_defined($listeratorAction + '_Error') ? var($listeratorAction + '_Error'=String); */
/* 	!var_defined($listeratorAction + '_CustomError') ? var($listeratorAction + '_CustomError'=String); */
/* 	!var_defined($listeratorAction + '_Table') ? var($listeratorAction + '_Table'='users'); */
/* 	!var_defined($listeratorAction + '_UIDfieldname') ? var($listeratorAction + '_UIDfieldname'=''); */
/* 	!var_defined($listeratorAction + '_Checkboxes') ? var($listeratorAction + '_Checkboxes'=Array); */
/* 	!var_defined($listeratorAction + '_Sets') ? var($listeratorAction + '_Sets'=Array); */
/* 	!var_defined($listeratorAction + '_Validation') ? var($listeratorAction + '_Validation'=Array); */
/* 	!var_defined($listeratorAction + '_ValidationWarnings') ? var($listeratorAction + '_ValidationWarnings'=Array); */
/* 	!var_defined('savedSearchParams') ? var('savedSearchParams'=Array); */
/* 	!var_defined('savedStatement') ? var('savedStatement'=String); */
/* 	!var_defined('savedStatementModifiers') ? var('savedStatementModifiers'=String); */
/* 	!var_defined('savedSortField') ? var('savedSortField'='lastname'); */
/* 	!var_defined('savedSortOrder') ? var('savedSortOrder'='ASC'); */
/* 	!var_defined('formFields') ? var('formFields'=array); */

	/protect;
]