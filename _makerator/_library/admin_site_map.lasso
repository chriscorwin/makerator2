[//I CAN HAS LASSOSCRIPT?
$content_primary += '<div id="sitemap">'; // put some whitespace in the source


//$content_primary += '<code>'+(xs_cat->(fullCatSQL(-cattable='Pages',-xtraReturn='',-xtraWhere='')))+'</code><br>';
var('treesql'=(xs_cat->(fullCatSQL(-id=1, -cattable='Pages',-orderby='node.lft',-xtrareturn=', node.lft, node.page_url, node.content, node.visible_in_menu ', -xtraWhere=' '))));

inline($authForDatabase, -sql=$treesql);
		var('lastDepth' = -1);
		//$content_primary += error_msg;
		local('lasttarget'=1);
		rows;
				//$content_primary += '<div class="catTree">';
				var('thisDepth' = integer(column('depth')));
				var('toggle_button_says' = 'Show');
				$toggle_button_says = (column('visible_in_menu') == 1 ? 'Hide' | 'Show');
				
				local('target'=column('id'));
				if($thisdepth == $lastdepth);
						$content_primary += '</li>';
						$content_primary += '<li id="'#target'">';
								var('get_page_url'=string);
								var('path_to_node' = (xs_cat->getURLpath(-id=column('id'), -cattable='Pages')));
								$content_primary += '<a href="'+$path_to_node+'" name="'#target'">';
								$content_primary += '<span class="sitemap_label_'+$toggle_button_says+'">'column('name')'</span> ';
								$content_primary += '</a>';
								$content_primary += '<div class="sitemap_admin_icons">
								
									<a class="move_top" href="' + $makerator_pathToAdmin + 'Move_Page_to_Top/Page-'column('id')'"><strong>Move to top</strong></a>
									<a class="move_up" href="' + $makerator_pathToAdmin + 'Move_Page_Up/Page-'column('id')'"><strong>Move page up</strong></a>
									<a class="move_down" href="' + $makerator_pathToAdmin + 'Move_Page_Down/Page-'column('id')'"><strong>Move page down</strong></a>
									<a class="move_bottom" href="' + $makerator_pathToAdmin + 'Move_Page_to_Bottom/Page-'column('id')'"><strong>Move tp bottom</strong></a>
									<a class="move_page" href="' + $makerator_pathToAdmin + 'Move_Page_To/Page-'column('id')'"><strong>Move Page</strong></a>
									<a class="edit_content" href="' + $makerator_pathToAdmin + 'Edit_Content/Page-'column('id')'"><strong>Edit Content</strong></a>
									<a class="toggle_visibility_'+$toggle_button_says+'" href="' + $makerator_pathToAdmin + 'Toggle_Visibility/Page-'+column('id')+'/'+$toggle_button_says+'/"><strong>'+$toggle_button_says+'</strong> </a>
									<a class="delete_page" href="' + $makerator_pathToAdmin + 'Delete_Page/Page-'column('id')'"><strong>Delete Page</strong></a>
									</div>
									';

				else;
						if($lastDepth == -1);
								//root level
								$content_primary += '<ol class="catTree level'+$thisDepth+'">';
								$content_primary += '<li id="'#target'">';
								var('path_to_node' = (xs_cat->getURLpath(-id=column('id'), -cattable='Pages')));
								$content_primary += '<a href="'+$path_to_node+'" name="'#target'">';
								$content_primary += ''column('name')' (You can not move nor delete the home page.) ';
								$content_primary += '</a>';
						else($thisDepth > $lastDepth);
								$content_primary += '<ol class="catTree level'+$thisDepth+'">\r';
								$content_primary += '<li id="'#target'">';
								var('path_to_node' = (xs_cat->getURLpath(-id=column('id'), -cattable='Pages')));
								$content_primary += '<a href="'+$path_to_node+'" name="'#target'">';
								$content_primary += '<span class="sitemap_label_'+$toggle_button_says+'">'column('name')'</span> ';
								$content_primary += '</a>';
								$content_primary += '<div class="sitemap_admin_icons">
								
									<a class="move_top" href="' + $makerator_pathToAdmin + 'Move_Page_to_Top/Page-'column('id')'"><strong>Move to top</strong></a>
									<a class="move_up" href="' + $makerator_pathToAdmin + 'Move_Page_Up/Page-'column('id')'"><strong>Move page up</strong></a>
									<a class="move_down" href="' + $makerator_pathToAdmin + 'Move_Page_Down/Page-'column('id')'"><strong>Move page down</strong></a>
									<a class="move_bottom" href="' + $makerator_pathToAdmin + 'Move_Page_to_Bottom/Page-'column('id')'"><strong>Move tp bottom</strong></a>
									<a class="move_page" href="' + $makerator_pathToAdmin + 'Move_Page_To/Page-'column('id')'"><strong>Move Page</strong></a>
									<a class="edit_content" href="' + $makerator_pathToAdmin + 'Edit_Content/Page-'column('id')'"><strong>Edit Content</strong></a>
									<a class="toggle_visibility_'+$toggle_button_says+'" href="' + $makerator_pathToAdmin + 'Toggle_Visibility/Page-'+column('id')+'/'+$toggle_button_says+'/"><strong>'+$toggle_button_says+'</strong> </a>
									<a class="delete_page" href="' + $makerator_pathToAdmin + 'Delete_Page/Page-'column('id')'"><strong>Delete Page</strong></a>
									</div>
									';

						else($thisDepth < $lastDepth);
								$content_primary += '</li>';
								var('diff' = ($lastDepth - $thisDepth));
								$content_primary += ('</ol>' * ($diff + 1));
								$content_primary += '<ol class="catTree level'+$thisDepth+'">';
								$content_primary += '<li id="'#target'">';
								var('path_to_node' = (xs_cat->getURLpath(-id=column('id'), -cattable='Pages')));
								$content_primary += '<a href="'+$path_to_node+'" name="'#target'">';
								$content_primary += '<span class="sitemap_label_'+$toggle_button_says+'">'column('name')'</span> ';
								$content_primary += '</a>';
								$content_primary += '<div class="sitemap_admin_icons">
								
									<a class="move_top" href="' + $makerator_pathToAdmin + 'Move_Page_to_Top/Page-'column('id')'"><strong>Move to top</strong></a>
									<a class="move_up" href="' + $makerator_pathToAdmin + 'Move_Page_Up/Page-'column('id')'"><strong>Move page up</strong></a>
									<a class="move_down" href="' + $makerator_pathToAdmin + 'Move_Page_Down/Page-'column('id')'"><strong>Move page down</strong></a>
									<a class="move_bottom" href="' + $makerator_pathToAdmin + 'Move_Page_to_Bottom/Page-'column('id')'"><strong>Move tp bottom</strong></a>
									<a class="move_page" href="' + $makerator_pathToAdmin + 'Move_Page_To/Page-'column('id')'"><strong>Move Page</strong></a>
									<a class="edit_content" href="' + $makerator_pathToAdmin + 'Edit_Content/Page-'column('id')'"><strong>Edit Content</strong></a>
									<a class="toggle_visibility_'+$toggle_button_says+'" href="' + $makerator_pathToAdmin + 'Toggle_Visibility/Page-'+column('id')+'/'+$toggle_button_says+'/"><strong>'+$toggle_button_says+'</strong> </a>
									<a class="delete_page" href="' + $makerator_pathToAdmin + 'Delete_Page/Page-'column('id')'"><strong>Delete Page</strong></a>
									</div>
									';

						/if;
				/if;
				
				$lastDepth = $thisDepth;
				local('lasttarget'=column('id'));
		/rows;
		$content_primary += '</ol>';
/inline;




$content_primary += '</div>'; // put some whitespace in the source
$content_primary += '<textarea rows="5" cols="40">'+$treesql+'</textarea>';
]