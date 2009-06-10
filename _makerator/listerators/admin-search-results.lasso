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
	
	
	rows(-inlinename=var($listeratorAction + '_table'));
			loop_count == 1 ? $content_primary += '<ol class="' + $these->lowercase& + ' results-listing ui-widget loader" >';
			local('rowclass' = string);
			#rowClass += ' ui-state-default ui-clickable ui-corner-all ui-widget-content ';
			// #rowclass += (loop_count % 2 ? ' normal ' | ' striped ');
			
			
			if(column('display_status') != '');
					#rowclass += (' ' + column('display_status'));
			/if;
			
			
			$content_primary += ('
			<li class="' + #rowclass + '">
			
					<h3>
						<a href="'  +var($listeratorAction + '_pathto') + column('Keyword_URL') +'/">
						' + column(var($listeratorAction + '_titleFieldName')) + '
						</a>
					</h3>
					<p>
						<strong>' + encode_SQL(var($listeratorAction + '_titleFieldName')) + ':</strong> ' + var($listeratorAction + '_titleFieldName') + '
					</p>
					<p>
						' + column('summary') + ' ...(<strong class="message-center-readmore">read more</strong>) 
					</p>
			</li>
			');
			(loop_count == shown_count && found_count != 0) ? $content_primary += '</ol>';
	/rows;
	
	
	/protect;
]