[//lasso
/*----------------------------------------------------------------------------

[include_once]
Only includes a file if it has not already been included.

Author: Jason Huck
Last Modified: Jan. 16, 2006
License: 

Description:
Includes the specified file only if it has not already been included using 
this tag. Based on this discussion from Lasso Talk.

Requires [file_pathfromroot], available here.


Sample Usage:
include_once('/path/to/file.inc');

Downloaded from tagSwap.net on Dec. 15, 2008.
Latest version available from <http://tagSwap.net/include_once>.

----------------------------------------------------------------------------*/
		
/*
define_tag(
	'once',
	-namespace='include_',
// 	-priority='replace',
	-description='Includes the specified file only if it has not already been included.'
);
	fail_if(
		!params->size || !params->first->isa('string'),
		-1,
		'[include_once] requires a file path as a parameter.'
	);
	
	local('path') = file_pathfromroot(params->first);		
	!var_defined('included_files') ? var('included_files' = set);		
	
	if($included_files !>> #path);
		$included_files->insert(#path);
		return(include(#path));
	/if;		
/define_tag;
*/
]