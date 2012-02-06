[//lasso
	define_type(
		'user',
		// -prototype,
		-description='Automatically retrieves, sets, and/or displays user data.'
	);
		
		
		
		
		define_tag('UID', -required='Keyword_URL', -type='string');
				
				local('a_sql' = 'SELECT UID FROM users WHERE Keyword_URL = "'#Keyword_URL'"');
				inline(
					$authForDatabase, 
					-table='users', 
					-sql=#a_sql
					);
						if(found_count == 1);
								rows;
									return(column('UID'));
								/rows;
						else;
						/if;
				/inline;
		/define_tag;

		define_tag(
			'Keyword_URL', 
			-required='UID'
			);
				local('a_sql' = 'SELECT Keyword_URL FROM users WHERE UID = "'#UID'"');
				inline(
					$authForDatabase, 
					-table='users', 
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
		
		define_tag(
			'Email_Address', 
			-required='UID'
			);
				local('a_sql' = 'SELECT Email_Address FROM users WHERE UID = "'#UID'"');
				inline(
					$authForDatabase, 
					-table='users', 
					-sql=#a_sql
					);
						if(found_count == 1);
								rows;
									return(column('Email_Address'));
								/rows;
						else;
						/if;
				/inline;
		/define_tag;


	/define_type;
]