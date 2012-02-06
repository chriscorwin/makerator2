[//I CAN HAS LASSO?

	var('path_to_node' = (xs_cat->getURLpath(-id=$pageID, -cattable='Pages')));
	var('toggle_button_says' = 'Show');
	
	
	var('get_visibility'='SELECT visible_in_menu FROM Pages WHERE id = '+$pageID+'');
	inline($authForDatabase, -sql=$get_visibility);
			rows;
					$toggle_button_says = (column('visible_in_menu') == 1 ? 'Hide' | 'Show');
			/rows;
	/inline;

	
	
	'<button 
	name="-Nothing" 
	value="Site Map" 
	onclick="javascript:window.location=(\'[$makerator_pathToAdmin]toggle_visibility/page-'+$pageID+'/'+$toggle_button_says+'/\'); return false;"
	>'$toggle_button_says' in navbar</button>
	';
	
]