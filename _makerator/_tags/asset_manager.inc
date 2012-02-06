[//lasso

	handle_error;
			// copy error message and code in case they get reset
				var('desc') = ('Asset Manager: [' + client_url + ']' + ' (' + response_filepath + ')' + ' ' + error_msg + ': ' + error_code);
				log_critical($desc);
	/handle_error;
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
				!var_defined('__amPages')		?	var('__amPages'		=	array_unique);
				!var_defined('__amModules')		?	var('__amModules'	=	array_unique);
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
				,	'paths'					=	map(
							'yui'					=	server_webroot + '/lib/tools/yui_compressor.jar'
						,	'scriptbase'			=	'/lib/scripts/base/'
						,	'scriptcache'			=	'/lib/scripts/cache/'
						,	'scriptModules'			=	'/lib/scripts/modules/'
						,	'stylebase'				=	'/lib/styles/base/'
						,	'stylecache'			=	'/lib/styles/cache/'
						,	'styleModules'			=	'/lib/styles/modules/'
						,	'pagesbase'				=	'/lib/pages/'
						,	'pagescache'			=	'/lib/pages/cached/'
						,	'modulesbase'			=	'/lib/modules/'
						,	'modulescache'			=	'/lib/modules/cached/'
						,	'modulesbase'			=	'/lib/templates/'
						,	'modulescache'			=	'/lib/templates/cached/'
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
		
		
// 		
// 		
// 		
// 		define_tag('loadpage', -req='path', -copy, -encodenone);
// 				
// 				local('stub' = ($__amOptions->find('paths')->find('pagesbase') + ((((#path)->replace('/','__')&)->removeleading('__')&)->removeTrailing('__')&)));
// 				
// 				
// 				local('pageScriptFile'		=	#stub + '.js');
// 				local('pageStyleFile'		=	#stub + '.css');
// 				local('pageFile'			=	#stub + '.lasso');
// 				
// 				
// 				file_exists(#pageScriptFile)	?	$__amScripts->insert(#pageScriptFile);
// 				file_exists(#pageStyleFile)		?	$__amStyles->insert(#pageStyleFile);
// 				file_exists(#pageFile)			?	$__amPages->insert(#pageFile);
// 				file_exists(#pageFile)			?	return(include(#pageFile));
// 				
// 		/define_tag;
// 		
		
		
		define_tag('loadpage', -req='path', -copy, -encodenone);
				local('out' = string);
				
				local('thisPageScripts' = array_unique);
				local('thisPageStyles' = array_unique);
				local('thisPageIncludes' = array_unique);
				
				local('ext' = #path->split('.')->last);
				local('shortStub' = ((((#path)->replace('/','__')&)->removeleading('__')&)->removeTrailing('__')&));
				local('stub' = string(#path)->removetrailing(#path->split('.')->last)&->removetrailing('.')&);
				local('name' = string(#path)->split('/')->last&->last);
				
				
				#name == #ext ? #ext = 'inc';
				#stub == '' ? #stub = #name;
				#name == #stub ? #name += ('.' + #ext);
				
				local('allPagesBasePath' = $__amOptions->find('paths')->find('pagesbase'));
				local('thisPageBasePath' = $__amOptions->find('paths')->find('pagesbase') + #stub + '/');
				local('thisPagesScriptPath' = $__amOptions->find('paths')->find('scriptPages') + #stub + '/');
				local('thisPagesStylePath' = $__amOptions->find('paths')->find('stylePages') + #stub + '/');
				
				local('allPagesFiles' = file_listdirectory(#allPagesBasePath));
				local('thisPageFiles' = file_listdirectory(#thisPageBasePath));
				local('thisPagesScriptFiles' = file_listdirectory(#thisPagesScriptPath));
				local('thisPagesStyleFiles' = file_listdirectory(#thisPagesStylePath));
				
				iterate(#allPagesFiles, local('i'));
						!#i->beginswith('.') && #i->endswith('.js') && #i->split('.')->first->equals(#stub) ? $__amScripts->insert(#allPagesBasePath + #i);
						!#i->beginswith('.') && #i->endswith('.css') && #i->split('.')->first->equals(#stub) ? $__amStyles->insert(#allPagesBasePath + #i);
						!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) && (#i->split('.')->first->equals(#stub) || #i->split('.')->first->equals(#shortStub)) ? $__amPages->insert(#allPagesBasePath + #i);
						
						!#i->beginswith('.') && #i->endswith('.js') && #i->split('.')->first->equals(#stub) ? #thisPageScripts->insert(#allPagesBasePath + #i);
						!#i->beginswith('.') && #i->endswith('.css') && #i->split('.')->first->equals(#stub) ? #thisPageStyles->insert(#allPagesBasePath + #i);
						!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) && (#i->split('.')->first->equals(#stub) || #i->split('.')->first->equals(#shortStub)) ? #thisPageIncludes->insert(#allPagesBasePath + #i);
				/iterate;
				
				
				iterate(#thisPageFiles, local('i'));
						!#i->beginswith('.') && #i->endswith('.js') ? $__amScripts->insert(#thisPageBasePath + #i);
						!#i->beginswith('.') && #i->endswith('.css') ? $__amStyles->insert(#thisPageBasePath + #i);
						!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) ? $__amPages->insert(#thisPageBasePath + #i);
						
						!#i->beginswith('.') && #i->endswith('.js') ? #thisPageScripts->insert(#thisPageBasePath + #i);
						!#i->beginswith('.') && #i->endswith('.css') ? #thisPageStyles->insert(#thisPageBasePath + #i);
						!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) ? #thisPageIncludes->insert(#thisPageBasePath + #i);
				/iterate;
				
				
				iterate(#thisPagesScriptFiles, local('i'));
						!#i->beginswith('.') && #i->endswith('.js') ? $__amScripts->insert(#thisPagesScriptPath + #i);
						!#i->beginswith('.') && #i->endswith('.js') ? #thisPageScripts->insert(#thisPagesScriptPath + #i);
				/iterate;
				
				iterate(#thisPagesStyleFiles, local('i'));
						!#i->beginswith('.') && #i->endswith('.css') ? $__amStyles->insert(#thisPagesStylePath + #i);
						!#i->beginswith('.') && #i->endswith('.css') ? #thisPageStyles->insert(#thisPagesStylePath + #i);
				/iterate;
				
				
				iterate(#thisPageIncludes, local('i'));
						#out += include(#i);
				/iterate;
				return(#out);
				
		/define_tag;
		
		
		define_tag('loadmodule', -req='path', -copy, -encodenone);
					local('out' = string);
					
					local('thisModuleScripts' = array_unique);
					local('thisModuleStyles' = array_unique);
					local('thisModuleIncludes' = array_unique);
					
					local('ext' = #path->split('.')->last);
					local('stub' = string(#path)->removetrailing(#path->split('.')->last)&->removetrailing('.')&);
					local('name' = string(#path)->split('/')->last&->last);
					
					
					#name == #ext ? #ext = 'inc';
					#stub == '' ? #stub = #name;
					#name == #stub ? #name += ('.' + #ext);
					
					local('allModulesBasePath' = $__amOptions->find('paths')->find('modulesbase'));
					local('thisModuleBasePath' = $__amOptions->find('paths')->find('modulesbase') + #stub + '/');
					local('thisModulesScriptPath' = $__amOptions->find('paths')->find('scriptModules') + #stub + '/');
					local('thisModulesStylePath' = $__amOptions->find('paths')->find('styleModules') + #stub + '/');
					
					local('allModulesFiles' = file_listdirectory(#allModulesBasePath));
					local('thisModuleFiles' = file_listdirectory(#thisModuleBasePath));
					local('thisModulesScriptFiles' = file_listdirectory(#thisModulesScriptPath));
					local('thisModulesStyleFiles' = file_listdirectory(#thisModulesStylePath));
					
					iterate(#allModulesFiles, local('i'));
							!#i->beginswith('.') && #i->endswith('.js') && #i->split('.')->first->equals(#stub) ? $__amScripts->insert(#allModulesBasePath + #i);
							!#i->beginswith('.') && #i->endswith('.css') && #i->split('.')->first->equals(#stub) ? $__amStyles->insert(#allModulesBasePath + #i);
							!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) && #i->split('.')->first->equals(#stub) ? $__amModules->insert(#allModulesBasePath + #i);
							
							!#i->beginswith('.') && #i->endswith('.js') && #i->split('.')->first->equals(#stub) ? #thisModuleScripts->insert(#allModulesBasePath + #i);
							!#i->beginswith('.') && #i->endswith('.css') && #i->split('.')->first->equals(#stub) ? #thisModuleStyles->insert(#allModulesBasePath + #i);
							!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) && #i->split('.')->first->equals(#stub) ? #thisModuleIncludes->insert(#allModulesBasePath + #i);
					/iterate;
					
					
					iterate(#thisModuleFiles, local('i'));
							!#i->beginswith('.') && #i->endswith('.js') ? $__amScripts->insert(#thisModuleBasePath + #i);
							!#i->beginswith('.') && #i->endswith('.css') ? $__amStyles->insert(#thisModuleBasePath + #i);
							!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) ? $__amModules->insert(#thisModuleBasePath + #i);
							
							!#i->beginswith('.') && #i->endswith('.js') ? #thisModuleScripts->insert(#thisModuleBasePath + #i);
							!#i->beginswith('.') && #i->endswith('.css') ? #thisModuleStyles->insert(#thisModuleBasePath + #i);
							!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) ? #thisModuleIncludes->insert(#thisModuleBasePath + #i);
					/iterate;
					
					
					iterate(#thisModulesScriptFiles, local('i'));
							!#i->beginswith('.') && #i->endswith('.js') ? $__amScripts->insert(#thisModulesScriptPath + #i);
							!#i->beginswith('.') && #i->endswith('.js') ? #thisModuleScripts->insert(#thisModulesScriptPath + #i);
					/iterate;
					
					iterate(#thisModulesStyleFiles, local('i'));
							!#i->beginswith('.') && #i->endswith('.css') ? $__amStyles->insert(#thisModulesStylePath + #i);
							!#i->beginswith('.') && #i->endswith('.css') ? #thisModuleStyles->insert(#thisModulesStylePath + #i);
					/iterate;
					
					
					iterate(#thisModuleIncludes, local('i'));
							#out += include(#i);
					/iterate;
					return(#out);
					
			/define_tag;
		
			define_tag('load', -req='path', -copy, -encodenone);
					local('out' = string);
					local('stub')					=	string(#path)->removetrailing(#path->split('.')->last)&->removetrailing('.')&;
					local('moduleName')				=	(#path->split('/')->last)->split('.')->first;
					local('moduleScriptFile')		=	@$__amOptions->find('paths')->find('scriptModules') + #moduleName + '/' + #moduleName + '.js';
					local('moduleStyleFile')		=	@$__amOptions->find('paths')->find('styleModules') + #moduleName + '/' + #moduleName + '.css';
					
					
					file_exists(#moduleScriptFile)	?	$__amScripts->insert(#moduleScriptFile);
					file_exists(#stub + '.js')		?	$__amScripts->insert(#stub + '.js');
					file_exists(#moduleStyleFile)	?	$__amStyles->insert(#moduleStyleFile);
					file_exists(#stub + '.css')		?	$__amStyles->insert(#stub + '.css');
					
					
					file_exists(#path)			?	#out += include(#path);
					return(#out);
			/define_tag;
		
		
// 		define_tag('loadtemplate', -req='path', -copy, -encodenone);
// 					local('out' = string);
// 					
// 					local('thisTemplateScripts' = array_unique);
// 					local('thisTemplateStyles' = array_unique);
// 					local('thisTemplateIncludes' = array_unique);
// 					
// 					local('ext' = #path->split('.')->last);
// 					local('stub' = string(#path)->removetrailing(#path->split('.')->last)&->removetrailing('.')&);
// 					local('name' = string(#path)->split('/')->last&->last);
// 					
// 					
// 					#name == #ext ? #ext = 'inc';
// 					#stub == '' ? #stub = #name;
// 					#name == #stub ? #name += ('.' + #ext);
// 					
// 					local('allTemplatesBasePath' = $__amOptions->find('paths')->find('templatesbase'));
// 					local('thisTemplateBasePath' = $__amOptions->find('paths')->find('templatesbase') + #stub + '/');
// 					local('thisTemplatesScriptPath' = $__amOptions->find('paths')->find('scriptTemplates') + #stub + '/');
// 					local('thisTemplatesStylePath' = $__amOptions->find('paths')->find('styleTemplates') + #stub + '/');
// 					
// 					local('allTemplatesFiles' = file_listdirectory(#allTemplatesBasePath));
// 					local('thisTemplateFiles' = file_listdirectory(#thisTemplateBasePath));
// 					local('thisTemplatesScriptFiles' = file_listdirectory(#thisTemplatesScriptPath));
// 					local('thisTemplatesStyleFiles' = file_listdirectory(#thisTemplatesStylePath));
// 					
// 					iterate(#allTemplatesFiles, local('i'));
// 							!#i->beginswith('.') && #i->endswith('.js') && #i->split('.')->first->equals(#stub) ? $__amScripts->insert(#allTemplatesBasePath + #i);
// 							!#i->beginswith('.') && #i->endswith('.css') && #i->split('.')->first->equals(#stub) ? $__amStyles->insert(#allTemplatesBasePath + #i);
// 							!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) && #i->split('.')->first->equals(#stub) ? $__amTemplates->insert(#allTemplatesBasePath + #i);
// 							
// 							!#i->beginswith('.') && #i->endswith('.js') && #i->split('.')->first->equals(#stub) ? #thisTemplateScripts->insert(#allTemplatesBasePath + #i);
// 							!#i->beginswith('.') && #i->endswith('.css') && #i->split('.')->first->equals(#stub) ? #thisTemplateStyles->insert(#allTemplatesBasePath + #i);
// 							!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) && #i->split('.')->first->equals(#stub) ? #thisTemplateIncludes->insert(#allTemplatesBasePath + #i);
// 					/iterate;
// 					
// 					
// 					iterate(#thisTemplateFiles, local('i'));
// 							!#i->beginswith('.') && #i->endswith('.js') ? $__amScripts->insert(#thisTemplateBasePath + #i);
// 							!#i->beginswith('.') && #i->endswith('.css') ? $__amStyles->insert(#thisTemplateBasePath + #i);
// 							!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) ? $__amTemplates->insert(#thisTemplateBasePath + #i);
// 							
// 							!#i->beginswith('.') && #i->endswith('.js') ? #thisTemplateScripts->insert(#thisTemplateBasePath + #i);
// 							!#i->beginswith('.') && #i->endswith('.css') ? #thisTemplateStyles->insert(#thisTemplateBasePath + #i);
// 							!#i->beginswith('.') && (#i->endswith('.inc') || #i->endswith('.lasso')) ? #thisTemplateIncludes->insert(#thisTemplateBasePath + #i);
// 					/iterate;
// 					
// 					
// 					iterate(#thisTemplatesScriptFiles, local('i'));
// 							!#i->beginswith('.') && #i->endswith('.js') ? $__amScripts->insert(#thisTemplatesScriptPath + #i);
// 							!#i->beginswith('.') && #i->endswith('.js') ? #thisTemplateScripts->insert(#thisTemplatesScriptPath + #i);
// 					/iterate;
// 					
// 					iterate(#thisTemplatesStyleFiles, local('i'));
// 							!#i->beginswith('.') && #i->endswith('.css') ? $__amStyles->insert(#thisTemplatesStylePath + #i);
// 							!#i->beginswith('.') && #i->endswith('.css') ? #thisTemplateStyles->insert(#thisTemplatesStylePath + #i);
// 					/iterate;
// 					
// 					
// 					iterate(#thisTemplateIncludes, local('i'));
// 							#out += include(#i);
// 					/iterate;
// 					return(#out);
// 					
// 			/define_tag;
		
// 		define_tag('loadmodule', -req='path', -copy, -encodenone);
// 				local('stub')					=	string(#path)->removetrailing(#path->split('.')->last)&->removetrailing('.')&;
// 				local('moduleName')				=	(#path->split('/')->last)->split('.')->first;
// 				local('moduleScriptFile')		=	@$__amOptions->find('paths')->find('scriptModules') + #moduleName + '/' + #moduleName + '.js';
// 				local('moduleStyleFile')		=	@$__amOptions->find('paths')->find('styleModules') + #moduleName + '/' + #moduleName + '.css';
// 				
// 				
// 				file_exists(#moduleScriptFile)	?	$__amScripts->insert(#moduleScriptFile);
// 				file_exists(#stub + '.js')		?	$__amScripts->insert(#stub + '.js');
// 				file_exists(#moduleStyleFile)	?	$__amStyles->insert(#moduleStyleFile);
// 				file_exists(#stub + '.css')		?	$__amStyles->insert(#stub + '.css');
// 				file_exists(#path)			?	return(include(#path));
// 		/define_tag;


		
		
		
		
		
		
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