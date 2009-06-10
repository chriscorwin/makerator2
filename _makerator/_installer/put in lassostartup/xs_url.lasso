[if(!(Lasso_TagExists('xs_url')));

/*


Jono: local('urlis' = xs_url);
Jono: #urlis->ops(-depth=integer(field('depth')),-component=(field('page_url')));
Jono: '<p class="menuMainNull"><a href="'#urlis->assemble'">'(field('name'))'<a></p>';

*/
	define_type('url',
		'array',
		-namespace = 'xs_',
		-prototype,
		-description = 'provides a type storing an array of url components, and incorporates tags to add components, remove, or tuncate... and to return an assembled path.');
		
		define_tag('restart', 
			-description='destroys/empties the thingie');
			self->removeall;
		/define_tag;

		define_tag('reduce', 
			-Required = 'by',
			-description = 'truncates x items from the tree');
			loop(#by);
				self->removelast;
			/loop;
		/define_tag;

		define_tag('ops', 
			-Required = 'depth',
			-Required = 'component',
			-description = 'compares and works out what to do with it...');
			
			if(#depth == 0);
				self->restart;
				self->insert(#component);
			else(#depth > (self->size - 1));
				self->insert(#component);
			else(#depth < (self->size - 1));
				self->reduce(-by=(self->size - #depth));
				self->insert(#component);
			else(#depth == (self->size - 1));
				self->reduce(-by=1);
				self->insert(#component);
			/if;
		/define_tag;

		define_tag('assemble', 
			-returnType = 'string', 
			-description = 'returns an assembled path from root in the format of /hello/world/how/are/you/');
			local('out' = '/');
			iterate(self,local('temp'));
				#out += #temp;
				#out += '/';
			/iterate;
			return(@#out);
		/define_tag;
			
	/define_type;
/if;
]