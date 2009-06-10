[

		define_tag(
			'highlight'
		, 	-optional	=	'title', -type = 'string'
		, 	-optional	=	'corner', -type = 'string'
		, 	-optional	=	'fades', -type = 'boolean'
		, 	-optional	=	'additionalClasses', -type = 'string'
		, 	-optional	=	'id', -type = 'string'
		,	-required	=	'body', -type = 'string'
		,	-namespace	=	'makerator_content_'
		);
				local('out' = string);
				!local_defined('additionalClasses') ? local('additionalClasses' = string);
				!local_defined('corner') ? local('corner' = 'ui-corner-all') | #corner = 'ui-corner-' + #corner;
				!local_defined('fades') ? local('fades' = 'ui-helper-fades') | (#fades ? #fades = 'ui-helper-fades' | #fades = string);
				!local_defined('id') ? local('id' = string);
				!local_defined('title') ? local('titleOut' = string) | local('titleOut') = '<strong>' + #title + '</strong>';
				
				#out += ('
					<div ' + (#id->size ? 'id="' + #id + '"') + ' class="ui-widget' + (#additionalClasses->size ? #additionalClasses) + '">
						<div class="ui-state-highlight ' + #corner + ' ' + #fades + '">
							<p>
								<span class="ui-icon ui-icon-info ui-icon-left"><strong class="ui-helper-hidden-accessible"></strong></span>
								' + #titleOut + #body + ' 
							</p>
						</div>
					</div>
				');
				
				return(@#out);
				
		/define_tag;
]