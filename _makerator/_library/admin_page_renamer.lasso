[//I CAN HAS LASSO?

	var('path_to_node' = (xs_cat->getURLpath(-id=$pageID, -cattable='Pages')));
]<div class="instructions"><p>You are re&ndash;naming the page currently called &ldquo;<strong>[$pageName]</strong> &rdquo;, which is viewable at the path: <a href="[$path_to_node]">[$path_to_node]</a></p></div>

	<form action="[$makerator_pathToAdmin]rename_page/do/" method="post">
		<input name="pageID" id="page" type="hidden" value="[$pageID]">
		<input name="page_url" id="page_url" type="hidden" value="[$path_to_node]">
		<input name="pageName" id="page_url" type="text" value="[$pageName]">
		
		
		<button type="submit" id="createpage" value="Rename">Rename</button>
	<button 
				name="-Nothing" 
				value="Cancel" 
				onclick="javascript:window.location=('[$path_to_node]'); return false;"
				>Cancel</button>
	<button 
				name="-Nothing" 
				value="Done" 
				onclick="javascript:window.location=('[$path_to_node]'); return false;"
				>Done</button>

	</form>