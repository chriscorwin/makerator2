[//lasso
    define_tag(
        'localfolder',
        -namespace='response_',
        -priority='replace',
        -description='Returns the absolute path to the current directory.'
    );
        local('out') = response_localpath;
        local('file') = #out->split('/')->last;
        #out->removetrailing(#file);
        return(#out);
    /define_tag;
 
	define_tag(
		'shell',
		-required='cmd',
		-privileged,
		-priority='replace',
		-description='Executes a single shell command via [os_process].'
	);
		local('os') = lasso_version( -lassoplatform);
	
		if(#os >> 'Win');
			local('shell') = os_process(
				'cmd',
				(: '/c cd ' + response_localfolder + ' && ' + #cmd)
			);		
		else;
			local('shell') = os_process(
				'/bin/bash',
				(: '-c', 'cd ' + response_localfolder + '; ' + #cmd)
			);
		/if;
		
		local('out') = #shell->read;
		!#out->size ? #out = #shell->readerror;
		#shell->close;
		return(#out);
	/define_tag;
]
