	[//lasso
	
		var('parentID' = integer);
		var('get_parentID' = string);
		$get_parentID += 'SELECT id, page_url, content FROM Pages WHERE page_url = "' + response_path + '"';
		inline($authForDatabase, -sql=$get_parentID);
				rows;
					$pageID = column('id');
					var('page_content') = column('content');
				/rows;
		/inline;
	
	]
	<form action="[$makerator_pathToAdmin]Edit_Content/" method="post">
		<input name="pageID" id="page" type="hidden" value="[$pageID]">
		<input name="page_url" id="page_url" type="hidden" value="[response_path]">
		[//lasso
			include('/_Assets/fckeditor/fckeditor.lasso');
			var('basepath'='/_Assets/fckeditor/');
			var('myeditor') = 
				fck_editor(
					-instancename='content',
					-basepath=$basepath,
					-initialvalue=string($page_content)
					);
			if(action_param('Toolbar'));
				$myeditor->toolbarset = action_param('Toolbar');
			/if;
			$myeditor->create;
		]
		
		<button type="submit" id="createpage" value="Create a page here">Submit Content</button></form>