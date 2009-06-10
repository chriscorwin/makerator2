[//lasso
	define_tag(
		'normalize',
		-namespace='url_',
		-req='url', -copy,
		-req='base', -copy,
		-priority='replace',
		-encodenone,
		-description='Given a base URL, converts the given relative URL to absolute.'
	);	
		// URLs beginning with / or http do not need to be converted
		(#url->beginswith('http://') || #url->beginswith('/')) ? return(#url);
		
		!#base->endswith('/') ? #base->append('/');
		
		if(#url->beginswith('../'));
			// count the number of paths to remove
			local('dirsToRemove') = #url->split('../')->size - 1;
			
			#base->removetrailing('/');
			
			loop(#dirsToRemove);
				#base->removetrailing('/' + #base->split('/')->last);
				#url->removeleading('../');
			/loop;
		
			#base->append('/');
		
			return(#base + #url);
			
		else(#url == '.');
			return(#base);
		
		else(#url->beginswith('./'));
			return(#base + #url->removeleading('./')&);
		
		else;
			return(#base + #url);
		/if;
	/define_tag;

	define_tag(
		'normalizeurls',
		-namespace='css_',
		-req='in',
		-priority='replace',
		-encodenone,
		-description='Returns a version of the given CSS file with all relative URLs converted to absolute ones.'
	);
		fail_if(!#in->endswith('.css'), -1, 'File does not have a .css extension.');

		local('file') = string(include_raw(#in));
		local('base') = string(#in)->removetrailing(#in->split('/')->last)&;
		local('regex') = regexp('url\\([\'"]?(?!/|http)(.+)?[\'"]?\\)', -input=#file);

		while(#regex->find);
			local('replacement') = 'url(' + url_normalize(#regex->matchstring(1), #base) + ')';
			#regex->appendreplacement(#replacement);
		/while;
		
		#regex->appendtail;
		return(#regex->output);
	/define_tag;
]