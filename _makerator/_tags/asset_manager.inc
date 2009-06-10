[//lasso
	define_type(
		'asset_manager',
		// -prototype,
		-description='Automatically includes optimized scripts and styles in pages.'
	);
// 		define_tag('dumpcache');
// 			var('__amIsCached') = false;
// 			var('__amScripts') = array_unique;
// 			var('__amStyles') = array_unique;
// 			var('__amOptions') = map;
// 		/define_tag;
		
		define_tag('oncreate');
				!var_defined('__amScripts')		?	var('__amScripts'	=	array_unique);
				!var_defined('__amStyles')		?	var('__amStyles'	=	array_unique);
		/define_tag;
		
		
		define_tag(
			'options'
		,	-opt		=	'usecache',		-type	=	'boolean'
		,	-opt		=	'minify',		-type	=	'boolean'
		,	-opt		=	'compress',		-type	=	'boolean'
		,	-opt		=	'refresh',		-type	=	'boolean'
		,	-opt		=	'paths',			-type	=	'map'
		,	-opt		=	'subdomains',	-type	=	'array'
		);
				!var_defined('__amOptions') ? var('__amOptions') = map;
				
				local('defaults' = map(
					'usecache'				=	true
				,	'minify'				=	true
				,	'compress'				=	false
				,	'refresh'				=	false
				,	'paths'					=	map('yui'		=	server_webroot + '/lib/tools/yui_compressor.jar'
											,	'scriptbase'		=	'/lib/scripts/base/'
											,	'scriptcache'	=	'/lib/scripts/cache/'
											,	'scriptModules'	=	'/lib/scripts/modules/'
											,	'stylebase'		=	'/lib/styles/base/'
											,	'stylecache'	=	'/lib/styles/cache/'
											,	'styleModules'	=	'/lib/styles/modules/'
											)
				,	'subdomains'		=	array
				));
				
				
				iterate(#defaults->keys, local('i'));
						!local_defined(#i) ? local(#i) = #defaults->find(#i);
						$__amOptions->insert(#i = local(#i));
				/iterate;
				
				// load base assets
				self->loadbasejs;
				self->loadbasecss;
				
				// trigger automatic caching at end
				//define_atend({ asset_manager->cache });
		/define_tag;
		
		define_tag('loadbasejs');
				local('base') = $__amOptions->find('paths')->find('scriptbase');
				local('files') = file_listdirectory(#base);
				
				iterate(#files, local('i'));
					!#i->beginswith('.') && #i->endswith('.js') ? $__amScripts->insert(#base + #i);
				/iterate;
		/define_tag;
		
		define_tag('loadbasecss');
				local('base') = @$__amOptions->find('paths')->find('stylebase');
				local('files') = file_listdirectory(#base);
				
				iterate(#files, local('i'));
					!#i->beginswith('.') && #i->endswith('.css') ? $__amStyles->insert(#base + #i);
				/iterate;
		/define_tag;
		
		
		/*
			this is the loadmodule tag as jason huck had it.
			
			see below for changes for makerator.
		
		define_tag('loadmodule', -req='path', -copy, -encodenone);
			local('stub') = string(#path)->removetrailing(#path->split('.')->last)&;
			file_exists(#stub + 'js') ? $__amScripts->insert(#stub + 'js');
			file_exists(#stub + 'css') ? $__amStyles->insert(#stub + 'css');
			return(include(#path));
		/define_tag;
		*/
		
		
		define_tag('loadmodule', -req='path', -copy, -encodenone);
				local('stub')					=	string(#path)->removetrailing(#path->split('.')->last)&->removetrailing('.')&;
				local('moduleName')				=	(#path->split('/')->last)->split('.')->first;
				local('moduleScriptFile')		=	@$__amOptions->find('paths')->find('scriptModules') + #moduleName + '/' + #moduleName + '.js';
				local('moduleStyleFile')		=	@$__amOptions->find('paths')->find('styleModules') + #moduleName + '/' + #moduleName + '.css';
				
				
				file_exists(#moduleScriptFile)	?	$__amScripts->insert(#moduleScriptFile);
				file_exists(#stub + 'js')		?	$__amScripts->insert(#stub + '.js');
				file_exists(#moduleStyleFile)	?	$__amStyles->insert(#moduleStyleFile);
				file_exists(#stub + 'css')		?	$__amStyles->insert(#stub + '.css');
				return(include(#path));
		/define_tag;
		
		
		define_tag('add', -req='path');
				local('ext') = string(#path)->split('.')->last;
				#ext == 'js' && file_exists(#path) ? $__amScripts->insert(#path);
				#ext == 'css' && file_exists(#path) ? $__amStyles->insert(#path);
		/define_tag;
		
		
		
		define_tag('cache');
		
				var_defined('__amIsCached') && $__amIsCached ? return;
				
				local('scripts'					=	cache_assets($__amScripts
													,	-target			=	$__amOptions->find('paths')->find('scriptcache')
													,	-usecache		=	$__amOptions->find('usecache')
													,	-minify			=	$__amOptions->find('minify')
													,	-compress		=	$__amOptions->find('compress')
													,	-refresh		=	$__amOptions->find('refresh')
				));
				
				local('styles'					=	cache_assets($__amStyles
													,	-target			=	$__amOptions->find('paths')->find('stylecache')
													,	-usecache		=	$__amOptions->find('usecache')
													,	-minify			=	$__amOptions->find('minify')
													,	-compress		=	$__amOptions->find('compress')
													,	-refresh		=	$__amOptions->find('refresh')
				));
				
				content_body					=	string(content_body)->replace('</head>', #styles + '</head>')&replace('</body>', #scripts + '</body>')&;
				
				iterate($__amOptions->find('subdomains'), local('i'));
						#i->isa('pair') ? content_body	=	string_replaceregexp(content_body
															,	-find					=	'="(' + #i->first + ')"'
															,	-replace					=	'="' + #i->second + '"'
															,	-ignorecase
						);
						log_always(#i->first);
						log_always(#i->second);
				/iterate;
				
				var('__amIsCached')				=	true;
				
		/define_tag;
	/define_type;
]