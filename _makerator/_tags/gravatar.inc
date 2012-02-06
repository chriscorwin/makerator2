[//lasso
	define_tag(
		'gravatar',
		-req='email',
		-opt='rating',
		-opt='default',
		-opt='size', -type='integer',
		-priority='replace',
		-encodenone,
		-description='Retrieves the Gravatar for the given email address.'
	);
		fail_if(
			!valid_email(#email),
			-1, 'Email address supplied is not valid.'
		);
	
		fail_if(
			local_defined('rating') && (:'G','PG','R','X') !>> #rating,
			-1, 'Rating must be one of G, PG, R, or X.'
		);
		
		fail_if(
			local_defined('size') && (#size < 1 || #size > 80),
			-1, 'Size must be between 1 and 80.'
		);
		
		fail_if(
			local_defined('default') && !valid_url(#default),
			-1, 'Default must be a complete, valid URL.'
		);
	
		local('hash') = encrypt_md5(#email);
		local('url') = 'http://www.gravatar.com/avatar.php?gravatar_id=' + #hash;
		local_defined('rating') ? #url += '&rating=' + #rating;
		local_defined('size') ? #url += '&size=' + #size;
		local_defined('default') ? #url += '&default=' + encode_stricturl(#default);
		return(#url);		
	/define_tag;



	/* SVN: $Id: gravatar.inc 593 2008-04-16 23:23:09Z Jason Huck $ */
]
