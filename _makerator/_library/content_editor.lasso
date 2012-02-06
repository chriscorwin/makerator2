[
	local('path_to_node' = (xs_cat->getURLpath(-id=$pageID, -cattable='Pages'))); 
	local('current_navbarGroup' = 1); //default group
	var('get_group_options'='SELECT id, name AS `group` FROM NavbarGroups ;'); 
	var('group_options' = array);
	
	inline($authForDatabase, -sql=$get_group_options);
		rows; 
			$group_options->insert(pair(column('id')=column('group'))); 
		/rows; 
	/inline;
	
	var('get_group_info'='SELECT visible_in_menu AS `group` FROM Pages WHERE id = ' $pageID ';'); 
	inline($authForDatabase, -sql=$get_group_info); 
		rows; 
			#current_navbarGroup = (column('group')); 
		/rows; 
	/inline;
	
	
	local('current_template' = 1); //default template
	var('get_template_options'='SELECT id, name AS `template` FROM Templates ;'); 
	var('template_options' = array);
	
	inline($authForDatabase, -sql=$get_template_options);
		rows; 
			$template_options->insert(pair(column('id')=column('template'))); 
		/rows; 
	/inline;
	
	var('get_template_info'='SELECT template AS `template` FROM Pages WHERE id = ' $pageID ';'); 
	inline($authForDatabase, -sql=$get_template_info); 
		rows; 
			#current_template = (column('template')); 
		/rows; 
	/inline; 
]
<div class="instructions">
	<p>
		You are editing &ldquo;<strong>[$pageName]</strong>&rdquo; and is currently in the navbar group &ldquo;[#current_navbarGroup]&rdquo;
	</p>
	<p>
		It is viewable at the path: &ldquo;<a href="[#path_to_node]"><code style="font-size: 130%">[#path_to_node]</code></a>&rdquo; 
	</p>
</div>
<a id="edit"></a>
<form action="[$makerator_pathtoadmin]edit_content/do/" method="post" id="editor">
	<input name="pageID" id="page" type="hidden" value="[$pageID]"> <input name="page_url" id="page_url" type="hidden" value="[response_path]"> 
	<fieldset>
		<label for"navbargroup">Navbar Group</label> 
		<select id="navbarGroup" name="group"> [ iterate($group_options, local('a_group')); '
			<option name="'#a_group->second'" id="group_'#a_group->first'" value="'#a_group->first'" '; #current_navbarGroup == #a_group->first ? 'selected="selected"'; ' >
				'#a_group->second'
			</option>
			'; /iterate; ] 
		</select> 
		
		
		<label for"templateChooser">Template</label> 
		<select id="templateChooser" name="template"> [ iterate($template_options, local('a_template')); '
			<option name="'#a_template->second'" id="template_'#a_template->first'" value="'#a_template->first'" '; #current_template == #a_template->first ? 'selected="selected"'; ' >
				'string_uppercase(#a_template->second)'
			</option>
			'; /iterate; ] 
		</select> 
	</fieldset>
	[ include('/_makerator/fckeditor/fckeditor.lasso'); var('basepath'='/_makerator/fckeditor/'); var('myeditor') = fck_editor( -instancename='content', -basepath=$basepath, -initialvalue=string($page_content) ); if(action_param('Toolbar')); $myeditor->toolbarset = action_param('Toolbar'); /if; $myeditor->create; ] 
	<fieldset>
		<button class="button" type="submit" id="richtexteditor" value="Submit Content">
			Submit Content
		</button>
		
		<button class="button" name="-Nothing" value="Done" onclick="javascript:window.location=('[#path_to_node]'); return false;">
			Done
		</button>
	</fieldset>
</form>
