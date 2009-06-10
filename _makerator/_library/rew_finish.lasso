[
 //[

	var($listeratorAction + '_Tables') = map;
/*
	i think this nex line will break current REW pages :(
	
	it is probably a better idea, but needed to have been done from the beginning of REW.
	
	(var($listeratorAction + '_Tables'))->insert(var($listeratorAction + '_Table')=var($listeratorAction + '_Table'));
*/
	Iterate: (Var:$listeratorAction + '_Fields'), (Var:'a_Field');
			Var: 'a_Name' = $a_Field->(Find: 'Field');
			Var: 'field_label' = ($a_field->Find: 'field') ;
			$field_label->replace('_and_', '&nbsp&amp;&nbsp;');
			$field_label->replace('~', '&rsquo;');
			$field_label->replace('__', ' / ');
			$field_label->replace('_', ' ');
			Var: 'a_label' = $field_label;
			If: $a_Field->(Find:'required') == true;
					If:  $a_Field->(Find:'type') == 'checkbox';
							if: ! (((Var:$listeratorAction + '_Required')->(find: $a_Name))->Size);
									((Var:$listeratorAction + '_Required'))->(Insert:'ch3ckb0x_' + $a_Name);
							/if;
/* 					else:  $a_Field->(Find:'type') == 'set'; */
/* 							if: ! (((Var:$listeratorAction + '_Required')->(find: $a_Name))->Size); */
/* 									((Var:$listeratorAction + '_Required'))->(Insert:'' + $a_Name); */
/* 							/if; */
					Else;
							if: ! (((Var:$listeratorAction + '_Required')->(find: $a_Name))->Size);
									((Var:$listeratorAction + '_Required'))->(Insert: $a_Name);
							/if;
					/If;
			Else;
					If:  $a_Field->(Find:'type') == 'checkbox';
							if: ! (((Var:$listeratorAction + '_Optional')->(find: $a_Name))->Size);
									((Var:$listeratorAction + '_Optional'))->(Insert:'ch3ckb0x_' + $a_Name);
							/if;
/* 					else:  $a_Field->(Find:'type') == 'set'; */
/* 							if: ! (((Var:$listeratorAction + '_Required')->(find: $a_Name))->Size); */
/* 									((Var:$listeratorAction + '_Required'))->(Insert:'' + $a_Name); */
/* 							/if; */
					Else;
							((Var:$listeratorAction + '_Optional'))->(Insert:$a_Name);
							if: ! (((Var:$listeratorAction + '_Optional')->(find: $a_Name))->Size);
									((Var:$listeratorAction + '_Optional'))->(Insert: $a_Name);
							/if;
					/If;
			/If;
			If: $a_Field->(Find:'sortOn') == true;
					if: ! (((Var:$listeratorAction + '_SortOn')->(find: $a_Name))->Size);
							((Var:$listeratorAction + '_SortOn'))->(Insert: $a_Name = $a_label);
					/if;
			/If;
			If: ($a_Field->(Find:'validation'))->Size;
					if: ! (((Var:$listeratorAction + '_Validation')->(find: $a_Name))->Size);
							((Var:$listeratorAction + '_Validation'))->(Insert: $a_Name);
					/if;
			/If;
			If: ($a_Field->(Find:'table'))->Size;
					var: 'a_table' = $a_field->find('table');
					!var_defined(($a_table '_fields')) ? var(($a_table '_fields')=map);
					Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), (($a_table '_fields'));
					var($a_table '_fields')->insert($a_Field->(Find:'name'));
					if: !(var($listeratorAction + '_Tables'))->find($a_table)->size;
							(var($listeratorAction + '_Tables'))->insert($a_table=$a_table);
					else;
							
					/if;
			/if;
	/Iterate;


	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Okay');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Missing');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Required');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Optional');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Empty');
	
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_SortOn');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Invalid');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Error');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_CustomError');
	
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Table');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Validation');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_ValidationWarnings');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_UIDfieldName');
	
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Checkboxes');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Sets');
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ($listeratorAction + '_Tables');
	
	Session_AddVariable: -Name=(Var: ($listeratorAction + '_SessionName')), ('formFields');
	
	
	
	!var_defined(($listeratorAction + '_Okay')) ? var(($listeratorAction + '_Okay')=(Map));
	!var_defined(($listeratorAction + '_Missing')) ? var(($listeratorAction + '_Missing')=(Map));
	!var_defined(($listeratorAction + '_Required')) ? var(($listeratorAction + '_Required')=(Array));
	!var_defined(($listeratorAction + '_Optional')) ? var(($listeratorAction + '_Optional')=(Array));
	
	!var_defined(($listeratorAction + '_Empty')) ? var(($listeratorAction + '_Empty')=(Map));
	!var_defined(($listeratorAction + '_Invalid')) ? var(($listeratorAction + '_Invalid')=(Map));
	!var_defined(($listeratorAction + '_Error')) ? var(($listeratorAction + '_Error')=(String));
	!var_defined(($listeratorAction + '_CustomError')) ? var(($listeratorAction + '_CustomError')=(String));
	!var_defined(($listeratorAction + '_Table')) ? var(($listeratorAction + '_Table')=('users'));
	
	!var_defined(($listeratorAction + '_UIDfieldName')) ? var(($listeratorAction + '_UIDfieldName')=('userUID'));
	!var_defined(($listeratorAction + '_Checkboxes')) ? var(($listeratorAction + '_Checkboxes')=(Array));
	!var_defined(($listeratorAction + '_Sets')) ? var(($listeratorAction + '_Sets')=(Array));
	!var_defined(($listeratorAction + '_Validation')) ? var(($listeratorAction + '_Validation')=(Array));
	!var_defined(($listeratorAction + '_ValidationWarnings')) ? var(($listeratorAction + '_ValidationWarnings')=(Array));

	!var_defined(('savedSearchParams')) ? var(('savedSearchParams')=(Array));
	!var_defined(('savedStatement')) ? var(('savedStatement')=(String));
	!var_defined(('savedStatementModifiers')) ? var(('savedStatementModifiers')=(String));
	!var_defined(('savedSortField')) ? var(('savedSortField')=('lastName'));
	!var_defined(('savedSortOrder')) ? var(('savedSortOrder')=('ASC'));
	
	
	!var_defined(('formFields')) ? var(('formFields')=(array));
	
/* 	'<p>'; */
/* 			'REW Finish here!'; */
/* 	'</p>'; */
/* 	'<p>'; */
/* 			'Tesing _okay: '; */
/* 			(Var:($listeratorAction + '_Okay')); */
/* 	'</p>'; */



//]
]