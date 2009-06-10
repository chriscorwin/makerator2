[
	define_tag(
		'debug'
	, 	-optional	=	'title', -type = 'string'
	, 	-optional	=	'process', -type = 'boolean'
	, 	-optional	=	'corner', -type = 'string'
	, 	-optional	=	'fades', -type = 'boolean'
	, 	-optional	=	'additionalClasses', -type = 'string'
	, 	-optional	=	'id', -type = 'string'
	,	-required	=	'body'
	,	-namespace	=	'makerator_content_'
	);
			local('out' = string);
			!local_defined('additionalClasses') ? local('additionalClasses' = string);
			!local_defined('corner') ? local('corner' = 'ui-corner-all') | #corner = 'ui-corner-' + #corner;
			!local_defined('fades') ? local('fades' = 'ui-helper-fades') | (#fades ? #fades = 'ui-helper-fades' | #fades = string);
			!local_defined('id') ? local('id' = string);
			
			local('bodyOut' = string);
			select(#body->type);
					case('string');
							!local_defined('process') ? local('process' = false);
							if(#process);
									!local_defined('title') ? local('titleOut' = string) | local('titleOut') = '<h6>' + #title + '</h6>';
									#bodyOut += ('
										' + #titleOut + '
										<var>' + #body + '</var>
										<code>' + lasso_process(#body) + '</code>
									');
							else;
									!local_defined('title') ? local('titleOut' = string) | local('titleOut') = '<strong>' + #title + '</strong>';
									#bodyOut += ('
										<p>' + #titleOut + #body + '</p>
									');
							/if;
					case('integer');
							!local_defined('title') ? local('titleOut' = string) | local('titleOut') = '<strong>' + #title + '</strong>';
							#bodyOut += ('
								<p>' + #titleOut + #body + '</p>
							');
					case('pair');
							!local_defined('title') ? local('titleOut' = string) | local('titleOut') = '<h6>' + #title + '</h6>';
							!local_defined('process') ? local('process' = false);
							if(#process);
									!local_defined('title') ? local('titleOut' = string) | local('titleOut') = '<h6>' + #title + '</h6>';
									#bodyOut += ('
										' + #titleOut + '
										<var>' + #body->first + '</var>
										<code>' + lasso_process(#body->second) + '</code>
									');
							else;
									#bodyOut += ('
										' + #titleOut + '
										<p><strong>' + #body->first + '</strong>' + #body->second + '</p>
									');
							/if;
					case('array');
							!local_defined('title') ? local('titleOut' = string) | local('titleOut') = '<h6>' + #title + '</h6>';
							iterate(#body, local('line'));
									select(#line->type);
											case('string');
													#bodyOut += ('
														<p>' + #line + '</p>
													');
											case('integer');
													#bodyOut += ('
														<p>' + #line + '</p>
													');
											case('pair');
													#bodyOut += ('
														<p><strong>' + #line->first + '</strong>' + #line->second + '</p>
													');
											case;
													#bodyOut += ('
														<p>
															<span class="ui-icon ui-icon-info ui-icon-left"><strong class="ui-helper-hidden-accessible"></strong></span>
															<ul class="' + #line->type + '">
													');
													iterate(#line, local('subLine'));
															#bodyOut += ('
																<li class="' + #subLine->type + '">
																	' + #subLine + '
																</li>
															');
													/iterate;
													#bodyOut += ('
															</ul>
														</p>
													');
									/select;
							/iterate;
							
					case('set');
							!local_defined('title') ? local('titleOut' = string) | local('titleOut') = '<h6>' + #title + '</h6>';
							iterate(#body, local('line'));
									select(#line->type);
											case('string');
													#bodyOut += ('
														<p>' + #line + '</p>
													');
											case('integer');
													#bodyOut += ('
														<p>' + #line + '</p>
													');
											case('pair');
													#bodyOut += ('
														<p><strong>' + #line->first + '</strong>' + #line->second + '</p>
													');
											case;
													#bodyOut += ('
														<p>
															<span class="ui-icon ui-icon-info ui-icon-left"><strong class="ui-helper-hidden-accessible"></strong></span>
															<ul class="' + #line->type + '">
													');
													iterate(#line, local('subLine'));
															#bodyOut += ('
																<li class="' + #subLine->type + '">
																	' + #subLine + '
																</li>
															');
													/iterate;
													#bodyOut += ('
															</ul>
														</p>
													');
									/select;
							/iterate;
							
					case;
							!local_defined('process') ? local('process' = false);
							if(#process);
									!local_defined('title') ? local('titleOut' = string) | local('titleOut') = '<h6>' + #title + '</h6>';
									#bodyOut += ('
										' + #titleOut + '
										<var>' + #body + '</var>
										<code>' + lasso_process(#body) + '</code>
									');
							else;
									!local_defined('title') ? local('titleOut' = string) | local('titleOut') = '<strong>' + #title + '</strong>';
									#bodyOut += ('
										<p>' + #titleOut + #body + '</p>
									');
							/if;
			/select;
			
			#out += ('
				<div ' + (#id->size ? 'id="' + #id + '"') + ' class="ui-widget' + (#additionalClasses->size ? #additionalClasses) + '">
					<div class="ui-state-debug ' + #corner + ' ' + #fades + '">
						' + #bodyOut + '
					</div>
				</div>
			');
			
			return(@#out);
			
	/define_tag;
	
]