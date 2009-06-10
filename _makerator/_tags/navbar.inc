[
 
	define_tag('navbar'
	,	-optional	=	'additionalColumnsToReturn'
	,	-optional	=	'childElement'
	,	-optional	=	'class'
	,	-optional	=	'depth', -type = 'integer'
	,	-optional	=	'extraSqlQueryParams'
	,	-optional	=	'group'
	,	-optional	=	'id'
	,	-optional	=	'leadingHTML'
	,	-optional	=	'multiLevel', -type = 'boolean'
	,	-optional	=	'pageId'
	,	-optional	=	'parentElement'
	,	-optional	=	'refresh', -type = 'boolean'
	,	-optional	=	'relative'
	,	-optional	=	'showRoot'
	,	-optional	=	'table'
	,	-optional	=	'trailingHTML'
	,	-priority	=	'replace'
	);
		!var_defined('makeratorCacheNavbars') ? var('makeratorCacheNavbars' = map);
		protect;
// 				log('/_logs/navbar.txt');
// 						'Init: =========================================' + '\r';
// 						response_filepath + '\r';
// 						date + '\r';
// 						'client_params: ' + client_params + '\r';
// 						'params: ' + params + '\r';
// 						'params_up: ' + params_up + '\r';
// 						'error_msg: ' + error_msg + '\r';
// 						'-----------------------------------------' + '\r';
// 				/log;
				
				
				local('out'=string);
				local('cached' = string);
				
				
				handle_error;
// 						log('/_logs/navbar.txt');
// 								'handle_error : =========================================' + '\r';
// 								response_filepath + '\r';
// 								date + '\r';
// 								'client_params: ' + client_params + '\r';
// 								'params: ' + params + '\r';
// 								'params_up: ' + params_up + '\r';
// 								'error_msg: ' + error_msg + '\r';
// 								'-----------------------------------------' + '\r';
// 						/log;
				/handle_error;
				
				handle;
						return(@#out);
				/handle;
				
				
// 				
// 				!local('refresh')->size					?	local('refresh' = false) | local('refresh' = #refresh);
// 				!local('group')->size					?	local('group' = 1) | integer(local('group' = 1));
// 				!local('id')->size						?	local('id'='navbarGroup-' + #group);
				
				
// 				log('/_logs/navbar.txt');
// 						'Check Refresh: =========================================' + '\r';
// 						response_filepath + '\r';
// 						date + '\r';
// 						'Refresh: ' + #refresh + '\r';
// 						'-----------------------------------------' + '\r';
// 				/log;
				
// 				log('/_logs/navbar.txt');
// 						'Check Cache: =========================================' + '\r';
// 						response_filepath + '\r';
// 						date + '\r';
// 						'Cached: ' + var('makeratorCacheNavbars') + '\r';
// 						'-----------------------------------------' + '\r';
// 				/log;
				
				
				protect;
						handle_error;
								#refresh = true;
								#cached = string;
								#out = string;
								
// 								log('/_logs/navbar.txt');
// 										'handle_error 2 : =========================================' + '\r';
// 										response_filepath + '\r';
// 										date + '\r';
// 										'client_params: ' + client_params + '\r';
// 										'params: ' + params + '\r';
// 										'params_up: ' + params_up + '\r';
// 										'error_msg: ' + error_msg + '\r';
// 										'Refresh: ' + #refresh + '\r';
// 										'Cached: ' + #cached + '\r';
// 										'Out: ' + #out + '\r';
// 										'-----------------------------------------' + '\r';
// 								/log;
								
						/handle_error;
						#cached = var('makeratorCacheNavbars')->find(#id);
				/protect;
				
				#refresh ? local('out'=string) | local('out' = @#cached);
				
				if(#out->size == 0);
						// if these params are not is not submitted we submit defaults
						!local('additionalColumnsToReturn')->size		?	local('additionalColumnsToReturn'=', node.navorder, node.page_url, node.lft, node.rgt') | local('additionalColumnsToReturn'=', node.navorder, node.page_url, ' + #additionalColumnsToReturn);
						!local('childElement')->size					?	local('childElement'='li');
						!local('class')->size							?	local('class'=string);
						!local('currentDirClass')->size					?	local('currentDirClass'=string);
						!local('parentDirClass')->size					?	local('parentDirClass'=string);
						!local('depth')->size							?	local('depth'=1);
						!local('extraSqlQueryParams')->size				?	local('extraSqlQueryParams'=string);
						!local('leadingHTML')->size						?	local('leadingHTML'=string);
						!local('pageId')->size							?	local('pageId'=1);
						!local('parentElement')->size					?	local('parentElement'='ul');
						!local('relative')->size						?	local('relative'=false);
// 						!local('showRoot')->size						?	local('showRoot'=false);
// 						!local('multiLevel')->size						?	local('multiLevel'=true);
						!local('table')->size							?	local('table'='pages');
						!local('trailingHTML')->size					?	local('trailingHTML'=string);
						
						
						#depth = 1;
						
						local('get1'=xs_cat->subtreesql(
									-id=#pageId
								,	-cattable=#table
								,	-depth=#depth
								,	-orderby='node.lft'
								,	-relative=false
								,	-xtrareturn=#additionalColumnsToReturn
								,	-xtrawhere=#extraSqlQueryParams + ' and node.visible_in_menu = ' + #group + ' '
						));
						
						
// 						log('/_logs/navbar.txt');
// 								'Grab SQL: =========================================' + '\r';
// 								response_filepath + '\r';
// 								date + '\r';
// 								'params: ' + params + '\r';
// 								'params_up: ' + params_up + '\r';
// 								'-----------------------------------------' + '\r';
// 								(@#get1)  + '\r\r\r';
// 						/log;
						
						
						inline($authForDatabase, -sql=#get1);
								
								
								local('thisNodeClass' = string);
								#class->size ? #thisNodeClass += ' class="' + #class + '" ';
								#out += '<' + #parentElement + ' ' + #thisNodeClass + ' id="' + #id + '">';
									rows;
											local('pageName'=column('name'));
											local('url'=column('page_url'));
											local('nodeid'=column('id'));
											local('pathToNode'=xs_cat->geturlpath(-id=#nodeid, -cattable=#table));
											!#showRoot && #pathToNode == '/' ? loop_continue;
											
											local('thisNodeClass' = string);
											response_path == #pathToNode ? #thisNodeClass += #currentDirClass;
											response_path >> #pathToNode ? #thisNodeClass += #parentDirClass;
											
											local('classOut' = string);
											#thisNodeClass->size ? #classOut += ' class="' + #thisNodeClass + '" ';
											#out += '<' + #childElement + '' + #classOut + '>';
											
											// link
											#out += '<a href="' + #pathToNode->lowercase& + '" title="' + #pageName + '">';
											#out += #pageName;
											#out += '</a>';
											
											if(#multiLevel);
													local('get2'=xs_cat->subtreesql(
															-id=#nodeid
															,	-cattable='pages'
															,	-depth=1
															,	-relative=true
															,	-xtrawhere=#extraSqlQueryParams
															,	-xtrareturn=#additionalColumnsToReturn + ' and node.visible_in_menu = ' + #group + ' '
													));
													inline($authForDatabase, -sql=#get2);
															handle_error;
																	return(action_statement);
															/handle_error;
															if(found_count > 1);
																	#out += '<' + #parentElement + '>';
																	rows;
																			column('depth') == 0 ? loop_continue;
																			local('pageName'=column('name'));
																			local('url'=column('page_url'));
																			local('nodeid'=column('id'));
																			local('pathToNode'=xs_cat->geturlpath(-id=#nodeid, -cattable=#table));
																			!#showRoot && #pathToNode == '/' ? loop_continue;
																			
																			local('thisNodeClass' = string);
																			response_path == #pathToNode ? #thisNodeClass += #currentDirClass;
																			response_path >> #pathToNode ? #thisNodeClass += #parentDirClass;
																			
																			local('classOut' = string);
																			#thisNodeClass->size ? #classOut += ' class="' + #thisNodeClass + '" ';
																			#out += '<' + #childElement + '' + #classOut + '>';
																			
																			// link
																			#out += '<a href="' + #pathToNode->lowercase& + '" title="' + #pageName + '">';
																			#out += #pageName;
																			#out += '</a>';
																	/rows;
																	#out += '</' + #parentElement + '>';
															/if;
													/inline;
											/if;
											#out += '</' + #childElement + '>';
									/rows;
								#out += '</' + #parentElement + '>';
						/inline;
						var('makeratorCacheNavbars')->insert('navbar-'+ #group = @#out);
				else;
						return('');
				/if;
		/protect;
	/define_tag;
	
	
	//navbar;
]