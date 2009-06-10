[
	define_tag('user_getUID', -required='Keyword_URL', -type='string');
			
			local('a_sql' = 'SELECT UID FROM users WHERE Keyword_URL = "' + #Keyword_URL + '"');
			inline(
				$authForDatabase
	,					-table='users'
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