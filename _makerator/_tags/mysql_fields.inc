[//lasso
/*----------------------------------------------------------------------------

[mysql_fields]
For MySQL, returns details about the table used in the current inline.

Author: Jason Huck
Last Modified: Feb. 15, 2008
License: Public Domain

Description:



Sample Usage:
inline( ...params... );
    // return all settings for all fields
    mysql_fields;

    // return settings for a single field
    mysql_fields->first_name;

    // return a single setting for a single field
    mysql_fields->first_name( -type);
/inline;

Downloaded from tagSwap.net on Mar. 04, 2008.
Latest version available from <http://tagSwap.net/mysql_fields>.

----------------------------------------------------------------------------*/
		

define_type(
	'fields',
	-namespace='mysql_',
	-prototype,
	-description='For MySQL, returns details about the table used in the current SELECT inline.'
);
	local('data' = map);

	define_tag('oncreate');
		local('query') = action_statement;

		// remove whole line comments
		#query = string_replaceregexp(
			#query, 
			-find='\\s*#.*', 
			-replace=''
		);
		
		#query->trim&removetrailing(';');
		
		// remove LIMIT
		#query = string_replaceregexp(
			#query, 
			-find='(?im)\\sLIMIT\\s+\\d+(,\\d+)?\\s*$', 
			-replace=''
		);

		if(#query->beginswith('SELECT') && lasso_datasourceismysql(database_name));
			local('sql' = '
			   DROP TEMPORARY TABLE IF EXISTS TEMP_COLUMNFINDER;
			   
			   CREATE TEMPORARY TABLE TEMP_COLUMNFINDER
			   ' + #query + '
			   LIMIT 0;
			   
			   SHOW FULL COLUMNS FROM TEMP_COLUMNFINDER;\				
			');
		
			inline( -sql=#sql);
				rows;
					local('tmp') = map(
					   'type' 		= field('Type'),
					   'collation'	= field('Collation'),
					   'null'		= field('Null'),
					   'key'		= field('Key'),
					   'default'	= field('Default'),
					   'extra'		= field('Extra'),
					   'privileges'	= field('Privileges'),
					   'comment'	= field('Comment')
					);

					self->'data'->insert(field('Field') = #tmp);
				/rows;
			/inline;
		/if;
	/define_tag;

	define_tag('_unknowntag');
		local('field') = @self->'data'->find(tag_name);
	
		if(#field->isa('map'));
			!params->size ? return(#field);
			local('key') = params->first->removeleading('-')&;
			return(#field->find(#key));
		/if;
	/define_tag;

	define_tag('onconvert');
		return(self->'data');
	/define_tag;
/define_type;

namespace_import('mysql_fields','mysql_columns');
]