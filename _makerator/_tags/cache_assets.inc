[//lasso
	define_tag(
		'compress',
		-namespace='yui_',
		-req='source', -type='string',
		-opt='target', -type='string',
		-opt='yuipath', -type='string',
		-priority='replace',
		-encodenone,
		-description='Compresses the specified file using the YUI Compressor.'
	);
		// path to YUI Compressor
		if(!local_defined('yuipath'));
			if(var_defined('__amOptions'));
				local('yuipath') = $__amOptions->find('paths')->find('yui');
			else;
				local('yuipath') = server_webroot + '/lib/tools/yuicompressor.jar';
			/if;
		/if;
	
		local('cmd') = 'java -jar ' + #yuipath + ' ' + #source;
		local_defined('target') ? #cmd += ' -o ' + #target;	
		local('out') = shell('java -jar ' + #yuipath + ' ' + #source);

		return(#out);
	/define_tag;

	define_tag(
		'assets',
		-namespace='cache_',
		-req='in', -type='array',
		-opt='target', -type='string',
		-opt='usecache', -type='boolean',
		-opt='refresh', -type='boolean',
		-opt='minify', -type='boolean',
		-opt='compress', -type='boolean',
		-priority='replace',
		-encodenone,
		-description='Concatenates, minifies, and compresses JS and CSS files and returns a link to the resulting file(s).'
	);
		local('srcfiles') = #in;

		local(
			'out' 		= string,
			'cacheid'	= string,
			'cachepath'	= string,
			'tempdata'	= string,
			'cachetype'	= #srcfiles->first->split('.')->last
		);
		
		local('defaults') = array(
			'target'	= '/site/' + (#cachetype == 'js' ? 'scripts' | 'styles') + '/cache/',
			'usecache'	= true,
			'refresh'	= false,
			'minify'	= true,
			'compress'	= true
		);
		
		iterate(#defaults, local('i'));
			!local_defined(#i->first) ? local(#i->first) = #i->second;
		/iterate;
		
		// if caching is on	
		if(#usecache);		
			// generate unique path for the cached file per the given list of source files
			local('token') = string;
			
			iterate(#srcfiles, local('i'));
				local('d') = file_moddate(#i);
				#token += #i + #d;
			/iterate;
						
			#cacheid = encrypt_hmac(
				-token=#token,
				-password=server_name,
				-digest='md5',
				-cram		
			);
			
			!#target->endswith('/') ? #target += '/';
			#cachepath = #target + #cacheid + '.' + #cachetype;
	
			// if refresh command is given or cached file is not found
			if(#refresh || !file_exists(#cachepath));
				// concatenate source files into cached file
				iterate(#srcfiles, local('i'));
					local('src') = (#cachetype == 'css' ? css_normalizeurls(#i) | string(include_raw(#i)));
					#tempdata += #src + '\n\n';
				/iterate;
								
				// if using minification
				if(#minify);				
					// compress/pack/minify cached file (YUI can handle both js and css)
					file_write(#cachepath, #tempdata, -fileoverwrite);
					#tempdata = yui_compress(server_webroot + #cachepath);
					#cachepath->replace('.' + #cachetype,'-min.' + #cachetype);
				/if;
				
				if(#compress);
					// gzip result
					#tempdata = compress_gzip(#tempdata);
					#cachepath += '.gz';
				/if;
				
				// write cached file to disk
				file_write(#cachepath, #tempdata, -fileoverwrite);
			/if;
			
			// make sure cachepath is correct even when not refreshing
			#minify && #cachepath !>> '-min' ? #cachepath->replace('.' + #cachetype,'-min.' + #cachetype);
			#compress && !#cachepath->endswith('.gz') ? #cachepath += '.gz';
			
			// generate link to cached file
			if(#cachetype == 'js');
				#out += '<script type="text/javascript" src="' + #cachepath + '"></script>\n';
			else;
				#out += '<link rel="stylesheet" type="text/css" href="' + #cachepath + '">\n';
			/if;
		
		// else just generate separate links for the individual source files
		else;	
			iterate(#srcfiles, local('i'));
				if(#cachetype == 'js');
					#out += '<script type="text/javascript" src="' + #i + '"></script>\n';
				else(#cachetype == 'css');
					#out += '<link rel="stylesheet" type="text/css" href="' + #i + '">\n';
				/if;
			/iterate;
		/if;
		
		return(#out);
	/define_tag;



	/* SVN: $Id: assetmanager.inc 548 2007-12-16 01:07:03Z Jason Huck $ */
]