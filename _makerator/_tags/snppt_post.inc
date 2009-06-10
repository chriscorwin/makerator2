[//lasso
	define_type(
		'post',
		-namespace='snppt_',
		// -prototype,
		-description='Reads/inserts posts for snppt.'
	);
		local(
			'parent' = 0,
			'uid' = string,
			'created' = date,
			'authorname' = string,
			'authoremail' = string,
			'post' = string,
			'connection' = null
		);
	
		define_tag(
			'oncreate', 
			-opt='uid', -type='string',
			-opt='connection', -type='array'
		);
			if(var_defined('connection'));
				self->connection = $connection;
			else(local_defined('connection'));
				self->connection = #connection;
			/if;
			
			!self->connection ? fail( -1, 'No database connection defined.');			
			local_defined('uid') ? self->load(#uid);
		/define_tag;
		
		define_tag('load', -req='uid');
			self->uid = #uid;
			
			local('sql' = '
				SELECT parent, created, authorname, authoremail, post 
				FROM posts 
				WHERE uid = ' + #uid + '
				LIMIT 1
			');
			
			inline(
				self->connection,
				-sql=#sql
			);
				self->parent = integer(field('parent'));
				self->created = date(field('created'));
				self->authorname = field('authorname');
				self->authoremail = field('authoremail');
				self->post = field('post');
			/inline;
		/define_tag;
		
		define_tag('save');
			local('sql' = '
				INSERT INTO posts (
					uid,
					parent,
					created,
					authorname,
					authoremail,
					post
				) VALUES (
					\'' + encode_sql(self->uid) + '\',
					\'' + encode_sql(self->parent) + '\',
					\'' + date->format('%Q %T') + '\',
					\'' + encode_sql(self->authorname) + '\',
					\'' + encode_sql(self->authoremail) + '\',
					\'' + encode_sql(self->post) + '\'
				)
			');
			
			inline(
				self->connection,
				-sql=#sql
			);
			/inline;
		/define_tag;

		define_tag('getparents', -opt='parent', -opt='list');
			!local_defined('parent') ? local('parent') = self->parent;
			!local_defined('list') ? local('list') = array;
			local('sql' = 'SELECT uid, parent FROM posts WHERE uid = \'' + #parent + '\' ORDER BY created');
			inline(self->connection, -sql=#sql);
				rows;
					#list->insert(field('uid'));
					local('parents') = self->getparents( -parent=field('parent'), -list=#list);
					#parents->size ? #list->merge(#parents);
				/rows;
			/inline;
			return(#list);
		/define_tag;
		
		define_tag('getchildren', -opt='uid', -opt='list');
			!local_defined('uid') ? local('uid') = self->uid;
			!local_defined('list') ? local('list') = array;
			local('sql' = 'SELECT uid FROM posts WHERE parent = \'' + #uid + '\' ORDER BY created');
			inline(self->connection, -sql=#sql);
				rows;
					#list->insert(field('uid'));
					local('children') = self->getchildren( -uid=field('uid'), -list=#list);
					#children->size ? #list->merge(#children);
				/rows;
			/inline;
			return(#list);
		/define_tag;
		
		define_tag('history');
			local('out') = array;
			!self->uid ? return(#out);
			local('children') = self->getchildren;
			local('parents') = self->getparents;
			local('uids') = #parents->merge(#children)&;
			#uids->insert(self->uid);
			!#uids->size ? return(#out);
			
			local('sql' = '
				SELECT
					uid,
					created,
					authorname,
					authoremail
				FROM posts
				WHERE uid IN (\'' + #uids->join('\',\'') + '\')
				ORDER BY created DESC
			');
			
			inline(
				self->connection,
				-sql=#sql
			);
				rows;
					#out->insert(field('created') = map(
						'uid' = field('uid'),
						'created' = date(field('created')),
						'authorname' = field('authorname'),
						'authoremail' = field('authoremail')
					));
				/rows;
			/inline;
			
			#out->sort&reverse;
			return(#out);
		/define_tag;

		define_tag('recent');
			local('out') = array;
			
			local('sql' = '
				SELECT
					uid,
					created,
					authorname,
					authoremail
				FROM posts
				ORDER BY created DESC
				LIMIT 10
			');
			
			inline(
				self->connection,
				-sql=#sql
			);
				rows;
					#out->insert(field('created') = map(
						'uid' = field('uid'),
						'created' = date(field('created')),
						'authorname' = field('authorname'),
						'authoremail' = field('authoremail')
					));
				/rows;
			/inline;
			
			#out->sort&reverse;
			return(#out);
		/define_tag;
	/define_type;
]