[//I CAN HAS LASSOSCRIPT?
$content_primary += '\r'*40; // put some whitespace in the source


//$content_primary += '<code>'+(xs_cat->(fullCatSQL(-cattable='Pages',-xtraReturn='',-xtraWhere='')))+'</code><br>';
var('treesql'=(xs_cat->(fullCatSQL(-id=1, -cattable='Pages',-orderby='node.lft',-xtrareturn=', node.lft, node.page_url, node.content, node.visible_in_menu ', -xtraWhere=' '))));
//$content_primary += '<textarea rows="5" cols="40">'+$treesql+'</textarea>';
	$content_primary += '<select name="newparent">';

inline($authForDatabase, -sql=$treesql);
		var('lastDepth' = -1);
		//$content_primary += error_msg;
		local('lasttarget'=1);
		rows;
				//$content_primary += '<div class="catTree">';
				var('thisDepth' = integer(column('depth')));
				
				local('target'=column('id'));
				if($thisdepth == $lastdepth);
						$content_primary += '</option>';
								$content_primary += '<option value="'+column('id')+'">';
								var('get_page_url'=string);
								var('path_to_node' = (xs_cat->getURLpath(-id=column('id'), -cattable='Pages')));
								$path_to_node->replace('/', ' &gt; ');
								$path_to_node->replace('_and_', '&nbsp&amp;&nbsp;');
								$path_to_node->replace('~', '&rsquo;');
								$path_to_node->replace('__', ' / ');
								$path_to_node->replace('_', ' ');
								$content_primary += 'Home '$path_to_node;
				else;
						if($lastDepth == -1);
								//root level
								$content_primary += '<optgroup label="'$thisDepth+'">';
								$content_primary += '<option value="'+column('id')+'">';
								var('path_to_node' = (xs_cat->getURLpath(-id=column('id'), -cattable='Pages')));
								$path_to_node->replace('/', ' &gt; ');
								$path_to_node->replace('_and_', '&nbsp&amp;&nbsp;');
								$path_to_node->replace('~', '&rsquo;');
								$path_to_node->replace('__', ' / ');
								$path_to_node->replace('_', ' ');
								$content_primary += 'Home '$path_to_node;
						else($thisDepth > $lastDepth);
								$content_primary += '<optgroup label="'$thisDepth+'">';
								$content_primary += '<option value="'+column('id')+'">';
								var('path_to_node' = (xs_cat->getURLpath(-id=column('id'), -cattable='Pages')));
								$path_to_node->replace('/', ' &gt; ');
								$path_to_node->replace('_and_', '&nbsp&amp;&nbsp;');
								$path_to_node->replace('~', '&rsquo;');
								$path_to_node->replace('__', ' / ');
								$path_to_node->replace('_', ' ');
								$content_primary += 'Home '$path_to_node;
						else($thisDepth < $lastDepth);
								$content_primary += '</option>';
								var('diff' = ($lastDepth - $thisDepth));
								$content_primary += ('</optgroup>' * ($diff + 1));
								$content_primary += '<optgroup label="'$thisDepth+'">';
								$content_primary += '<option value="'+column('id')+'">';
								var('path_to_node' = (xs_cat->getURLpath(-id=column('id'), -cattable='Pages')));
								$path_to_node->replace('/', ' &gt; ');
								$path_to_node->replace('_and_', '&nbsp&amp;&nbsp;');
								$path_to_node->replace('~', '&rsquo;');
								$path_to_node->replace('__', ' / ');
								$path_to_node->replace('_', ' ');
								$content_primary += 'Home '$path_to_node;
						/if;
				/if;
				
				$lastDepth = $thisDepth;
				local('lasttarget'=column('id'));
		/rows;
		$content_primary += '</optgroup>';
/inline;

$content_primary += '</select>';


$content_primary += '\r'*40; // put some whitespace in the source
]