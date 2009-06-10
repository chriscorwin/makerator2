[

	library('/_Assets/config_database.lasso');




	var: 'uploads' = file_uploads;
	
	var('sql' = string);
	
	$sql = 'SELECT * FROM ' ((response_path)->split('/')->get(((response_path)->split('/')->size)-1)) ' WHERE Keyword_URL = "' + ((response_path)->split('/')->get(((response_path)->split('/')->size)-1)) + '"';
	inline($authForDatabase, action_params, -sql=$sql, -inlinename=('show'));
			if(found_count == 0);
				//$sql;
			else;
				rows;
						var('sponsorUID' = column('UID'));
				/rows;
			/if;
	/inline;

	
	var('msg' = string);
	var('filename' = string);
	var('filetype' = string);
	var('error' = string);
	if: $uploads->size > 0;
	
	
			iterate: $uploads, (var: 'upload');
					$filename +=  encode_html($upload->find('origname'));
					$msg += ' File Size: ' (encode_html($upload->find('size')));
			/iterate;
			// Process uploaded files
			inline($authForFileOperations);
					var('oldname' = $uploads->get(1)->find('upload.realname')->split('.'));
					$filetype = $oldname->last;
					
					if($filetype == 'gif' || $filetype == 'jpg' || $filetype == 'png');
					
					file_exists( '/userfiles/Image/Sponsor_Content/'+$sponsorUID '.gif') ? file_delete( '/userfiles/Image/Sponsor_Content/'+$sponsorUID '.gif');
					file_exists( '/userfiles/Image/Sponsor_Content/'+$sponsorUID '.jpg') ? file_delete( '/userfiles/Image/Sponsor_Content/'+$sponsorUID '.jpg');
					file_exists( '/userfiles/Image/Sponsor_Content/'+$sponsorUID '.png') ? file_delete( '/userfiles/Image/Sponsor_Content/'+$sponsorUID '.png');
					
					
					
					var('new_path' = '/userfiles/Image/Sponsor_Content/'+$sponsorUID '.' $filetype);
					file_copy($uploads->get(1)->find('path'), $new_path);
/*					var('new_image' = image($new_path));*/
/*					$new_image->Height;*/
/*					abort;*/
					error_code != 0 ? $error = file_currenterror ;
					
					else;
						redirect_url('../');
					
					/if;
			/inline;
			
			

			$error == '' ? redirect_url('../');
	else;
			$content_primary += '<h3>No upload</h3>';
			'<p>
			
					You did not upload an images.
			</p>';


		
		//($NewFile->find('path'), $NewFilePath)
	/if;
	
	
	
/*	 "{";*/
/*					"error: '" + $sponsorUID + "',\n";*/
/*					"filename: '" + $filename + "'\n";*/
/*	 "}";*/


/*		'<ol class="files">';*/
/*		inline(-username='chrisc', -password='aju6Uujovith');*/
/*			var('dansimages' = file_listdirectory('/incoming/dan/'));*/
/*			iterate($dansimages, local('x'));*/
/*					'<li>'#x'</li>';*/
/*			/iterate;*/
/*		/inline;*/
/*		'</ol>';*/
]