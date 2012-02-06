[
	
	
	
	define_tag(
		'debug'
	,	-optional	=	'body'
	,	-optional	=	'title',				-type	=	'string'
	,	-optional	=	'process',				-type	=	'boolean'
	,	-optional	=	'corner',				-type	=	'string'
	,	-optional	=	'fades',				-type	=	'boolean'
	,	-optional	=	'additionalClasses',	-type	=	'string'
	,	-optional	=	'id',					-type	=	'string'
	,	-optional	=	'mode',					-type	=	'string'
	,	-optional	=	'code'					
	,	-namespace	=	'makerator_content_'
	);
			
			!params->size ? return('');
			
			local('out' = string);
			
			
			if(#body === params->get(1));
					local('body' = params->get(1));
					if(local_defined('body'));
							iterate(#body, local('param'));
									if(#param->isA('pair'));
											if(#param->first->beginsWith('-'));
													local('paramName' = (#param->first));
													#paramName->removeLeading('-');
													local(#paramName = #param->second);
											else;
													local(#param->first = #param->second);
											/if;
									else;
											#out += ('<pre class="">(#param): ' + (#param) + '</pre>');
											if(string(#param)->beginsWith('-'));
													local('paramName' = (#param));
													#paramName->removeLeading('-');
													local(#paramName = boolean(#paramName->size));
											else;
											/if;
									/if;
							/iterate;
					/if;
			else;
					iterate(params, local('param'));
							if(#param->isA('pair'));
									if(#param->first->beginsWith('-'));
											local('paramName' = (#param->first));
											#paramName->removeLeading('-');
											local(#paramName = #param->second);
									else;
											local(#param->first = #param->second);
									/if;
							else;
									if(string(#param)->beginsWith('-'));
											local('paramName' = string(#param));
											#paramName->removeLeading('-');
											local(#paramName = boolean(#paramName->size));
									/if;
							/if;
					/iterate;
			/if;
			
			iterate(#body, local('param'));
					if(#param->isA('pair'));
							if(#param->first->beginsWith('-'));
									local('paramName' = (#param->first));
									#paramName->removeLeading('-');
									local(#paramName = #param->second);
							else;
									local(#param->first = #param->second);
							/if;
					else;
							if(string(#param)->beginsWith('-'));
									local('paramName' = (#param));
									#paramName->removeLeading('-');
									local(#paramName = boolean(#paramName->size));
							/if;
					/if;
			/iterate;
			
			!local_defined('additionalClasses') ? local('additionalClasses' = string);
			!local_defined('corner') ? local('corner' = 'ui-corner-all') | #corner = 'ui-corner-' + #corner;
			!local_defined('fades') ? local('fades' = '') | (#fades ? #fades = 'ui-helper-fades' | #fades = string);
			!local_defined('id') ? local('id' = string);
			!local_defined('code') ? local('code' = false);
			!local_defined('mode') ? local('mode' = 'debug');
			!(#mode->length) ? #mode = 'debug';
			
			
/*			if(params->size == 1); */
/*					params->get(1)->isA('array') ? #someParams = params->get(1); */
/*					 */
/*					 */
/*					if(#someParams->size == 1); */
/*							if(#someParams->get(1)->isa('boolean')); */
/*									return('nope'); */
/*							else(#someParams->get(1)->isa('string')); */
/*									!local_defined('body') ? local('body' = #someParams->get(1)); */
/*							else(#someParams->get(1)->isa('string')); */
/*							/if; */
/*					/if; */
/*					if(#someParams->size >= 1); */
/*							if(#someParams->get(1)->isa('boolean')); */
/*									return('nope'); */
/*							else(#someParams->get(1)->isa('string')); */
/*									!local_defined('body') ? local('body' = #someParams->get(1)); */
/*							/if; */
/*					/if; */
/*					if(#someParams->size == 2); */
/*							if(#someParams->get(2)->isa('boolean')); */
/*									!local_defined('process') ? local('process' = #someParams->get(2)); */
/*							else(#someParams->get(2)->isa('string')); */
/*									!local_defined('title') ? local('title' = #someParams->get(2)); */
/*							/if; */
/*					/if; */
/*					if(#someParams->size == 3); */
/*							if(#someParams->get(3)->isa('boolean')); */
/*									!local_defined('process') ? local('process' = #someParams->get(3)); */
/*									!local_defined('title') ? local('title' = #someParams->get(2)); */
/*							else(#someParams->get(3)->isa('string')); */
/*									!local_defined('title') ? local('title' = #someParams->get(3)); */
/*									!local_defined('process') ? local('process' = #someParams->get(2)); */
/*							/if; */
/*					/if; */
/*			/if; */
			
			
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
							else(#code);
									#bodyOut += ('
										<h6>' + #body->first + '</h6>
										<code>' + #body->second + '</code>
									');
							else;
									#bodyOut += ('
										<div class="ui-state-debug break ' + #corner + ' ' + #fades + ' ' + (#additionalClasses->size ? (' ' + #additionalClasses + ' ')) + '">
									');
									select(#body->second->type);
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
													else(#code);
															#bodyOut += ('
																<h6>' + #body->first + '</h6>
																<code>' + #body->second + '</code>
															');
													else;
															select(#pair->second->type);
															
															/select;
															#bodyOut += ('
																<p class="ui-helper-clearfix">
																	<var>' + #body->first + '</var> <code>' + #body->second + '</code>
																</p>
															');
													/if;
											case('array');
													iterate(#body->second, local('line'));
															#bodyOut += ('
																<div class="ui-state-debug break ' + #corner + ' ' + #fades + ' ' + (#additionalClasses->size ? (' ' + #additionalClasses + ' ')) + '">
															');
															select(#line->type);
																	case('map');
																			iterate(#line, local('line2'));
																					select(#line2->type);
																							case('string');
																									#bodyOut += ('
																										<p>' + #line + '</p>
																									');
																							case('integer');
																									#bodyOut += ('
																										<p><pre>' + #line + '</pre></p>
																									');
																							case('date');
																									#bodyOut += ('
																										<p>' + #line + '</p>
																									');
																							case('pair');
																									if(#code);
																											#bodyOut += ('
																												<h6>' + #line2->first + '</h6>
																												<code>' + #line2->second + '</code>
																											');
																									else;
																											#bodyOut += ('
																												<p class="ui-helper-clearfix">
																													<var>' + #line2->first + '</var> <code>' + #line2->second + '</code>
																												</p>
																											');
																									/if;
																							case;
																									#bodyOut += ('
																										<p class="ui-helper-clearfix">
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
																	case('string');
																			#bodyOut += ('
																				<p>' + #line + '</p>
																			');
																	case('integer');
																			#bodyOut += ('
																				<p><pre>' + #line + '</pre></p>
																			');
																	case('date');
																			#bodyOut += ('
																				<p>' + #line + '</p>
																			');
																	case('pair');
																			if(#code);
																					#bodyOut += ('
																						<h6>' + #line->first + '</h6>
																						<code>' + #line->second + '</code>
																					');
																			else;
																					#bodyOut += ('
																						<p class="ui-helper-clearfix">
																							<var>' + #line->first + '</var> <code>' + #line->second + '</code>
																						</p>
																					');
																			/if;
																	case;
																			#bodyOut += ('
																				<p class="ui-helper-clearfix">
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
															#bodyOut += ('
																</div>
															');
													/iterate;
											case('map');
													iterate(#body, local('line'));
															select(#line->type);
																	case('string');
																			#bodyOut += ('
																				<p>' + #line + '</p>
																			');
																	case('integer');
																			#bodyOut += ('
																				<p><pre>' + #line + '</pre></p>
																			');
																	case('date');
																			#bodyOut += ('
																				<p>' + #line + '</p>
																			');
																	case('pair');
																			if(#code);
																					#bodyOut += ('
																						<h6>' + #line->first + '</h6>
																						<code>' + #line->second + '</code>
																					');
																			else;
																					#bodyOut += ('
																						<p class="ui-helper-clearfix">
																							<var>' + #line->first + '</var> <code>' + #line->second + '</code>
																						</p>
																					');
																			/if;
																	case;
																			#bodyOut += ('
																				<p class="ui-helper-clearfix">
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
									/select;
									#bodyOut += ('
										</div>
									');
							/if;
					case('array');
							!local_defined('title') ? local('titleOut' = string) | local('titleOut' = '<h6>' + #title + '</h6>');
							
							
							#bodyOut += (#titleOut);
							iterate(#body, local('line'));
									select(#line->type);
											case('string');
													#bodyOut += ('
														<p>' + #line + '</p>
													');
											case('integer');
													#bodyOut += ('
														<p><pre>' + #line + '</pre></p>
													');
											case('date');
													#bodyOut += ('
														<p>' + #line + '</p>
													');
											case('pair');
													if(#code);
															#bodyOut += ('
																<h6>' + #line->first + '</h6>
																<code>' + #line->second + '</code>
															');
													else;
															#bodyOut += ('
																<p class="ui-helper-clearfix">
																	<var>' + #line->first + '</var> <code>' + #line->second + '</code>
																</p>
															');
													/if;
											case;
													#bodyOut += ('
														<p class="ui-helper-clearfix">
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
										<var>var: ' + #body + '</var>
										<code>' + lasso_process(#body) + '</code>
									');
							else;
									!local_defined('title') ? local('titleOut' = string) | local('titleOut') = '<strong>' + #title + '</strong>';
									#bodyOut += ('
										<p>' + #titleOut + #body + '</p>
									');
							/if;
			/select;
			
			#code ? #additionalClasses += ' code ';
			#out += ('
				<div ' + (#id->size ? 'id="' + #id + '"') + ' class="ui-widget">
					<div class="ui-mode-debug ' + #corner + ' ' + #fades + ' ' + (#additionalClasses->size ? (' ' + #additionalClasses + ' ')) + '">
						' + #bodyOut + '
					</div>
				</div>
			');
			
			return(#out);
			
	/define_tag;
]