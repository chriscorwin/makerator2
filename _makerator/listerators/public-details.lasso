[


	rows(-inlinename=('show'+$this));
		
			loop_count == 1 ? $content_primary += '<table>';
			
			iterate((var($listeratorAction + '_Fields')), var('a_column'));
			
					var('column_name') = $a_column->find('Field');
					var('formatted_column_name' = $column_name);
					string($column_name)->contains('UID') ? loop_continue;
					loop_count == 1 ? 	$content_pageTitle = column($column_name);
					
					iterate($field_params, var('a_param'));
							var($a_param = $a_column->find($a_param));
					/iterate;
					
					
					
					var('formatted'= string);
					select($type);
					case('datetime');
							var:'date' = column($Field);
							$date = (date_localtogmt: $date);
							var:'datestring' = $date->(format:'%QT%TZ');
							//$content_primary += $datestring;'<br>';
							$formatted += '<span class="prettydate" title="'$datestring'">'+(column($field))+'</span>';
							$templating_inlineJquery->insert(' $(".prettydate").prettyDate(); ');
							$javascripts_src_head->insert('/Assets/jquery/pretty.js');
/*					case('varchar');*/
/*					case('text');*/
/*					case('set');*/
					case;
							
					/select;
					
					
					
					
					
					
					$content_primary += '<tr>';
						$content_primary += '<th>';
								
								$formatted_column_name == 'Home' ? $formatted_column_name = 'Home';
								$formatted_column_name->replace('_and_', '&nbsp&amp;&nbsp;');
								$formatted_column_name->replace('~per-cent~', '%');
								$formatted_column_name->replace('--', ': ');
								$formatted_column_name->replace('~', '&rsquo;');
								$formatted_column_name->replace('__', ' / ');
								$formatted_column_name->replace('_', ' ');
								$content_primary += ($formatted_column_name);
						$content_primary += '</th>';
						$content_primary += '<td>';
								$formatted->size ? $content_primary += $formatted | $content_primary += column($column_name);
						$content_primary += '</td>';
					//$content_primary += ($column_name);
					$content_primary += '</tr>';
			/iterate;
			loop_count == 1 ? $content_primary += '</table>';
	/rows;

]
