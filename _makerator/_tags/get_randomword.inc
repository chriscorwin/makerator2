[
	if(!lasso_tagExists('get_randomWord'));
		define_tag(
			'get_randomWord', 
			-priority='replace'
			);
				local('a_sql' = 'SELECT * FROM _words 
WHERE related_table_Name = "" 
ORDER by rand() 
LIMIT 1');
				inline(
					$authForDatabase, 
					-table='_words', 
					-sql=#a_sql
					);
						if(found_count == 1);
								rows;
									return(pair(column('UID')=column('word')));
								/rows;
						else;
								debug('ERROR: ' response_path ': ' #a_sql ', ' error_msg, -error);
						/if;
				/inline;
		/define_tag;
	/if;

]
