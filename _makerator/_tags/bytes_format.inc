[//lasso
/*----------------------------------------------------------------------------

[bytes_format]
Formats the output of [file->getsize] for display.

Author: Jason Huck
Last Modified: Jan. 16, 2006
License: 

Description:
Tags the supplied integer as a number of bytes and returns it as a string 
converted to kb, mb, or gb, depending on the size.


Sample Usage:
var('myFile') = file(
    'somefile.txt', 
    file_openread,
    file_modechar
);

bytes_format($myFile->getsize);

-> 2.23 mb

Downloaded from tagSwap.net on Oct. 14, 2008.
Latest version available from <http://tagSwap.net/bytes_format>.

----------------------------------------------------------------------------*/
		

define_tag(
	'format',
	-namespace='bytes_',
	-priority='replace',
	-description='Converts bytes to kilobytes, megabytes, or gigabytes for display.'
);
	fail_if(
		!params->first || !params->first->isa('integer'),
		-1,
		'[bytes_format] requires an integer as input.'
	);
	
	local(
		'in' = decimal(params->first),
		'd' = decimal(1024),
		'c' = 1,
		'u' = array(
			'bytes',
			'kb',
			'mb',
			'gb'
		)
	);
	
	#in->setformat( -precision=2);
	
	while(true);
		if(#in < #d);
			local('out') = (#c == 1 ? integer(#in) | #in);
			return(#out + ' ' + #u->get(#c));
		else;
			#in /= #d;
			#c += 1;
		/if;
	/while;
/define_tag;
]