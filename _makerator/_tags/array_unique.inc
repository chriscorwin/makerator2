[//lasso
	define_type(
		'array_unique', 'array',
		-prototype,
		-description='An array that will only hold unique values.'
	);
		define_tag('insert');
			local('v') = @params->first;
			local('p') = (params->size > 1 ? @params->second | self->parent->size + 1);			
			!self->parent->find(#v) ? self->parent->insert(#v, #p);
		/define_tag;
		
		define_tag('insertfirst');
			self->insert(params->first, 1);
		/define_tag;
		
		define_tag('insertfrom');
			local('c') = @params->first;
			
			while(!#c->atend);
				self->insert(#c->value);
				null(#c->forward);
			/while;
		/define_tag;
		
		define_tag('insertlast');
			self->insert(params->first, self->parent->size + 1);
		/define_tag;
		
		define_tag('onconvert');
			return(self->parent);
		/define_tag;
	/define_type;



	/* SVN: $Id: array_unique.inc 598 2008-06-19 02:41:41Z Jason Huck $ */
]