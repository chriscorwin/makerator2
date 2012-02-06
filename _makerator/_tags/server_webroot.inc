[//lasso
	define_tag(
		'webroot',
		-namespace='server_',
		-priority='replace',
		-description='Returns the full path to the virtual host root.'
	);
		local('out' = response_localpath);
		#out->removetrailing(response_filepath);
		return(#out);
	/define_tag;
	
	
	/* SVN: $Id: server_webroot.inc 546 2007-12-15 22:27:54Z Jason Huck $ */
]