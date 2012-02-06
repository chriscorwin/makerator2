[//lasso
	
		var('parentID' = integer);
		var('get_parentID' = string);
		
		
		var('this') = $levels_names->get($levels_count - 1);
		$this == 'Home' ? $this = '';
		$get_parentID += 'SELECT * FROM Pages WHERE page_url = "' + $this + '"';
		
		//'<p>this: '$this'</p>';
		//'<pre>'$get_parentID'</pre>';
		inline($authForDatabase, -sql=$get_parentID);
				if(found_count == 1);
						rows;
							$parentID = column('id');
						/rows;
						var('path_to_node' = (xs_cat->getURLpath(-id=$parentID, -cattable='Pages')));
				else(found_count > 1);
				
						rows;
								var('path_to_page' = (xs_cat->getURLpath(-id=column('id'), -cattable='Pages'))+'/');
								$parentID = column('id');
								$path_to_page == (var('pathTo_level_'($levels_count - 1))) ? loop_abort;
						/rows;
				else;
				
				/if;
		/inline;
		
		
	]
	
 
<form action="[$makerator_pathToAdmin]Create_Page/" method="post">
	<fieldset>
		<legend>
			Use this form to create a new page
		</legend>
		<input name="parent" id="parent" type="hidden" value="[$parentID == 0 ? 'Error!' | $parentID]">
		<label for="newpagetitle" class="">
			Name of page 
		</label>
		<input name="title" id="newpagetitle" type="text" value="[$content_pageTitle_base]">
		<br />
		
		
		<label for="page_url" class="">
			URL of page 
		</label>
		<label for="page_url" class="">
			[(var('pathTo_level_'($levels_count - 1)))]
		</label>
		<input name="page_url" id="page_url" type="text" value="[$thisLevel_Name]">
		<br />
		
		
	<button type="submit" id="createpage" value="Create a page here">
		Create a page here!
	</button>
	<button 
				name="-Nothing" 
				value="Done" 
				onclick="javascript:window.location=('[$path_to_page]'); return false;"
				>Cancel</button>
</form>


