[
	if(file_exists('/userfiles/Image/' $listeratorContentType '/.DS_Store'));
		file_delete('/userfiles/Image/' $listeratorContentType '/.DS_Store');
	/if;
	
	
	
	var('previous' = '');
	var('counter' = 1);
	var('images' = file_listdirectory('/userfiles/Image/' $listeratorContentType));
	
	var('otherprojectsnav' = array);
	var('projects' = array);
	
	iterate($images, local('a_image'));
			var('this_image' = #a_image);
			var('current' = $this_image->split('--')->first);
			
			local('y' = #a_image);
			local('temp' = string);
			if($current != $previous);
			
					
					#temp += '<li>';
					#y->removetrailing('.png');
			
/*					#y;*/
/*					'<br>';*/
					$projects->insert($current);
					if(#y >> $thisLevel_Name->split('--')->first);
							#temp +='<strong>'$counter'</strong>';
							var('this_is' = $counter);
							var('previous_is' = $counter - 1);
							var('next_is' = $counter + 1);
					else;
							#temp +='<a href="/' $listeratorContentType '/' #y '/">' $counter '</a>';
					/if;
					#temp += '</li>';
					var('previous' = $current);
					$counter += 1;
					$otherprojectsnav->insert(#temp);
			/if;
	/iterate;
	
	
/*	$projects;*/
/*	'<br>';*/
/*	'Previous: ';$projects->get($previous_is);*/
/*	'<br>';*/
/*	'This: ';$projects->get($this_is);*/
/*	'<br>';*/
/*	'Next: ';$projects->get($next_is);*/
/*	'<br>';*/
	
	
	var('numberofprojects' = ($otherprojectsnav->size));
	
	
	'<ol class="siblings-listing '$listeratorContentType'">';
	$previous_is > 0 ? '<li><a href="/' $listeratorContentType '/' $projects->get($previous_is) '--1/"><strong>&lt;</strong></a></li>' | '<li><strong>&lt;</strong></li>';
	iterate($otherprojectsnav, local('ooo'));
			#ooo;
	/iterate;
	$next_is <= $numberofprojects ? '<li><a href="/' $listeratorContentType '/' $projects->get($next_is) '--1/"><strong>&gt;</strong></a></li>' | '<li><strong>&gt;</strong></li>';
	'</ol>';









]