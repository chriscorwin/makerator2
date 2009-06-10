[//I CAN HAS LASSO?

	var('path_to_node' = (xs_cat->getURLpath(-id=$pageID, -cattable='Pages')));

	inline($authForDatabase, -sql='select page_url from Pages where id = '$pageID);
		rows;
				var('name'=column('page_url'));
		/rows;
	/inline;

]<div class="instructions"><p>You are editing the URL for the page called &ldquo;<strong>[$pageName]</strong>.&rdquo;
</p><p>It is currently at the path: &ldquo;<a href="[$path_to_node]"><code style="font-size: 130%;">[$path_to_node]</code> </a>&rdquo;</p></div>

	<form action="[$makerator_pathToAdmin]change_url/do/" method="post">
		<input name="pageID" id="page" type="hidden" value="[$pageID]">
		<input name="page_url" id="page_url" type="text" value="[$name]">
		
		
		<button type="submit" id="createpage" value="Submit new URL">Submit new URL</button>
		<button 
			name="-Nothing" 
			class="button"
			value="Done" 
			onclick="javascript:window.location=('[$path_to_node]'); return false;"
			>Cancel</button>
	</form>