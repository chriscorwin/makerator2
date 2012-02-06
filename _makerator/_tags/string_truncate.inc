[//lasso
/*----------------------------------------------------------------------------

[string_truncate2]
Truncates the given string to the given number of characters.

Author: Jason Huck
Last Modified: Jan. 01, 0001
License: Public Domain

Description:
here.


Sample Usage:
var('str') = 'The quick, brown-fox jumps over the "lazy" dog.'; 
 
loop($str->size); 
    loop_count + ' - ' + string_truncate($str, loop_count) + '\n'; 
/loop; 

Downloaded from tagSwap.net on Jan. 31, 2008.
Latest version available from <http://tagSwap.net/string_truncate2>.

----------------------------------------------------------------------------*/
		

define_tag(
	'truncate',
	-namespace='string_',
	-req='text',
	-req='length', -type='integer', -copy,
	-priority='replace',
	-encodenone,
	-description='Truncates the given string to the given number of characters.'
);
	// if the original string is shorter than or equal to the desired length,
	// just return it unaltered.
	#text->size <= #length ? return(#text);
	
	local('out') = string;
	
	// while #out is empty, #length is still greater than zero,
	// and the last character of the new string is not whitespace...
	while(!#out->size || !#out->iswhitespace(#out->size) && #length);
		// store a new substring in #out
		#out = #text->substring(1, #length);
		// decrement #length by 1
		#length -= 1;
	/while;
	
	// if we reached zero, return nothing
	!#length ? return;
			
	// remove any trailing non-alphanumeric characters and whitespace
	#out = string_replaceregexp(
		#out,
		-find='[^A-Za-z0-9]*\\s*$',
		-replace=''
	);
	
	// return the final result with an ellipsis character appended
	return(#out + '&#8230;');	
/define_tag;
]