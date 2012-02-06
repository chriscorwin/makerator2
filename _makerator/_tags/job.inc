[//lasso
	protect;

	handle_error;
			debug("Error Handled: " error_msg);
	/handle_error;

	define_type(
		'job',
		// -prototype,
		-description='Automatically retrieves, sets, and/or displays job data.'
	);
			define_tag(
				'keyword_url', 
				-required='UID'
				);
					local('a_sql' = 'SELECT Keyword_URL FROM jobs WHERE UID = "'#UID'"');
					inline(
						$authForDatabase, 
						-table='jobs', 
						-sql=#a_sql
						);
							if(found_count == 1);
									rows;
										return(column('Keyword_URL'));
									/rows;
							else;
							/if;
					/inline;
			/define_tag;


	/define_type;
	
	/protect;
]