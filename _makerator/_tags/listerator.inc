[//lasso

// 	protect;
// 
// 	handle_error;
// 			log_critical("Error Handled: " error_msg);
// 	/handle_error;
// 
// 	define_type(
// 		'listerator',
// 		// -prototype,
// 		-description='Automatically retrieves, sets, and/or displays Listerator data.'
// 	);
// 		
// 		
// 		define_tag('title_field_name', -required='table', -type='string');
// 				
// 				local('a_sql' = 'SELECT title_field_name FROM ' + $tablePrefix + 'listerators WHERE Table_Name = "'#table'"');
// 				inline(
// 					$authForDatabase, 
// 					-table=#table, 
// 					-sql=#a_sql
// 					);
// 						if(found_count == 1);
// 								rows;
// 									return(column('title_field_name'));
// 								/rows;
// 						else;
// 						/if;
// 				/inline;
// 		/define_tag;
// 		
// 		define_tag(
// 			'column_default', 
// 			-required='table', 
// 			-required='column'
// 			);
// 				local('sql' = 'SHOW COLUMNS FROM ' #table ' LIKE "'#column'"');
// 				inline(
// 					$authForDatabase, 
// 					-table=#table, 
// 					-sql=#sql
// 					);
// 						rows;
// 							return(column('Default'));
// 						/rows;
// 				/inline;
// 		/define_tag;
// 		
// 		define_tag(
// 			'singular', 
// 			-required='table'
// 			);
// 				local('a_sql' = 'SELECT Singular FROM ' + $tablePrefix + 'listerators WHERE Table_Name = "'#table'"');
// 				inline(
// 					$authForDatabase, 
// 					-table=#table, 
// 					-sql=#a_sql
// 					);
// 						if(found_count == 1);
// 								rows;
// 									return(column('Singular'));
// 								/rows;
// 						else;
// 						/if;
// 				/inline;
// 		/define_tag;
// 
// 
// 		define_tag(
// 			'table_name', 
// 			-required='Keyword_URL'
// 			);
// 				local('a_sql' = 'SELECT Table_Name FROM ' + $tablePrefix + 'listerators WHERE Keyword_URL = "'#Keyword_URL'"');
// 				inline(
// 					$authForDatabase, 
// 					-table=#table, 
// 					-sql=#a_sql
// 					);
// 						if(found_count == 1);
// 								rows;
// 									return(column('Table_Name'));
// 								/rows;
// 						else;
// 						/if;
// 				/inline;
// 		/define_tag;
// 		
// 		
// 		
// 		define_tag(
// 			'current_name', 
// 			-priority='replace',
// 			-required='table',
// 			-required='title_field_name',
// 			-required='UID'
// 			);
// 				local('a_sql' = 'SELECT ' #title_field_name ' FROM ' #table ' WHERE UID = "'#UID'"');
// 				inline(
// 					$authForDatabase, 
// 					-table=#table, 
// 					-sql=#a_sql
// 					);
// 						if(found_count == 1);
// 								rows;
// 									return(column(#title_field_name));
// 								/rows;
// 						else;
// 						/if;
// 				/inline;
// 		/define_tag;
// 		
// 
// 
// 	/define_type;

	/protect;
]