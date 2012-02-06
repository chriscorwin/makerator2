[//lasso
/*----------------------------------------------------------------------------

[file_pathfromroot]
Converts a relative path to a root path.

Author: Jason Huck
Last Modified: Jan. 16, 2006
License: 

Description:
Converts a relative path to a root path.


Sample Usage:
file_pathfromroot('../../images/foo.gif');

-> /images/foo.gif

Downloaded from tagSwap.net on Dec. 15, 2008.
Latest version available from <http://tagSwap.net/file_pathfromroot>.

----------------------------------------------------------------------------*/
		

define_tag(
	'pathfromroot',
	-namespace='file_',
	-priority='replace',
	-description='Converts a relative path to a root path.'
);
	fail_if(
		!params->size || !params->first->isa('string'),
		-1,
		'[file_pathfromroot] requires a file path as a parameter.'
	);
	
	local('in' = params->first);
	
	if(#in->beginswith('/'));
		return(#in);
	else(#in->beginswith('../'));
		local('steps' = #in->split('../')->size - 1);
		local('out' = '/');
		
		iterate(response_path->split('/'), local('i'));
			loop_count > 1 ? #out += #i + '/';
			loop_count == #steps ? loop_abort;
		/iterate;
		
		#out += #in;
		return(#in);
	else;
		return(response_path + #in);
	/if;
/define_tag;
]