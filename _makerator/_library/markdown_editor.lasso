<style type="text/css">
	.wmd-preview
	{
		border: 1px solid silver;
		margin-top: 3em;
	}
</style>
[//I CAN HAS LASSO?

	local('path_to_node' = (xs_cat->getURLpath(-id=$pageID, -cattable='Pages')));
	local('toggle_button_says' = 'Show');
	var('get_menu_info'='SELECT visible_in_menu AS menu FROM Pages WHERE id = ' $pageID ';');
	inline($authForDatabase, -sql=$get_menu_info);
			rows;
					#toggle_button_says = (column('menu') == 1 ? 'Hide' | 'Show');
			/rows;
	/inline;
]

<div class="instructions">
	<p>
		You are editing &ldquo;<strong>[$pageName]</strong>&rdquo;
	</p>
	<a href="[$makerator_pathToAdmin]Toggle_Visibility/Page-[$pageID+'/'+#toggle_button_says+'/']" style="border: none; float: right; clear: none; margin-top: -16px;"><img src="/_Assets/Images/[#toggle_button_says].gif" width="15" height="15" border="0"></a> 
	<p>It is  viewable at the path: <a href="[#path_to_node]">&ldquo;[#path_to_node]&rdquo;</a>

	</p>
</div>
	<a id="edit">
<form action="[$makerator_pathToAdmin]edit_content/do/" method="post" id="editor">
	<input name="pageID" id="page" type="hidden" value="[$pageID]">
	<input name="page_url" id="page_url" type="hidden" value="[response_path]">

	[/*
		//lasso
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
		*/
	]
	<textarea style="height: 300px;" name="contenteditor">[string($page_content)]</textarea>
	<script type="text/javascript" src="http://box0.wmd-editor.com/1190/wmd.js"></script>
	<div class="adminaction">
	<button type="submit" id="richtexteditor" value="Submit Content">Submit Content</button>
	<button 
				name="-Nothing" 
				value="Done" 
				onclick="javascript:window.location=('[#path_to_node]'); return false;"
				>Done</button>
	<textarea class="wmd-preview" name="content"></textarea>
</div>
	</form>
	<hr>
