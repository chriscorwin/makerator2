<div class="adminaction">
	[//lasso
	
	
	$content_primary += '<p>levels: '+$levels+'</p>';
	
		var('parentID' = integer);
		var('get_parentID' = string);
		$get_parentID += 'SELECT id FROM Pages WHERE page_url = "' + $thisLevel_Name + '"';
		inline($authForDatabase, -sql=$get_parentID);
				rows;
					$parentID = column('id');
				/rows;
		/inline;
	
	]
	<form action="[$makerator_pathToAdmin]create_page/" method="post">
		<input name="parent" id="parent" type="text" value="[$parentID]">
		Title: 
		<input name="title" id="newpagetitle" type="text" value="[$content_pageTitle_base]" style="width: [($content_pageTitle_base->size) +1]ex">
		&nbsp; 
		<input name="page_url" id="page_url" type="text" value="[$thisLevel_Name]" style="width: [(response_path->size) +9]ex">
		<button type="submit" id="createpage" value="Create a page here">
			Create a child here 
		</button>
	</form>
</div>
