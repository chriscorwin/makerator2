[
	$makerator_includes->insert(include_currentPath);
	$makerator_currentInclude							=	$makerator_includes->last;
	handle;
			$makerator_includes->remove;
			$makerator_currentInclude					=	$makerator_includes->last;
	/handle;
	
	
	protect;
	
	handle_error;
			makerator_errorManager(
				$makerator_currentInclude
			,	error_code
			,	error_msg
			,	action_statement
			);
	/handle_error;
	
	
	
	
	$content_primary += '<h3>Listerators Admin</h3>';
	$content_primary += '<ol class="results-listing">';
		rows(-inlinename='listerators');
			if: loop_count == 1;
			/if;
			var: 'rowClass' = 'alt';
			If((Loop_Count) % 2);
					$rowClass = 'normal';
			/If;
			$content_primary += '<li><a href="' + $makerator_pathToAdmin + column('Keyword_URL')'">' + column('Pluralized') + '</a></li>';
		/rows;
	$content_primary += '</ol>';
	
	inline($authForFileOperations);
		//load makerator config files
		if(file_exists('/_site/_library/content_siteAdmin.lasso'));
				//load site config files, if they exist
				include('/_site/_library/content_siteAdmin.lasso');
		/if;
	
	/inline;
	
	
	$content_primary += '<h3>Makerator</h3>';
	
	$content_primary += '<ol class="results-listing">';
		$content_primary += '<li><a href="' + $makerator_pathToAdmin + 'site_map/">Site Map</a></li>';
		$apparent_User_Access_Level == 0 ? $content_primary += '<li><a href="' + $makerator_pathToAdmin + 'listerators/">Listerators</a></li>';
		$content_primary += '<li><a href="' + $makerator_pathToAdmin + 'site_refresh/">Refresh Listerators</a></li>';
		$content_primary += '<li><a href="/account/sign_out/">Sign Out</a></li>';
	$content_primary += '</ol>';
	
	
	


	/protect;
]