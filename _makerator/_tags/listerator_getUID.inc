[
	define_tag('listerator_getUID', -required='Keyword_URL', -type='string', -required='table', -type='string');
			
			local('a_sql' = 'SELECT UID FROM ' + #table + ' WHERE Keyword_URL = "' + #Keyword_URL + '"');
			inline(
				$authForDatabase
	,					-table=#table
	,					-sql=#a_sql
				);
					if(found_count == 1);
							rows;
								return(column('UID'));
							/rows;
					else;
					/if;
			/inline;
	/define_tag;
]