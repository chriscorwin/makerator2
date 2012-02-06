[

	if((string(response_path) >>  + $makerator_pathToAdmin + ) && $AuthenticationStatus == 'Authorized');
		
			$css_src_head->insert(pair('/_makerator/css/blueprintcss/screen.css'='screen, projection'));
			$css_src_head->insert(pair('/_makerator/css/blueprintcss/print.css'='print'));
			$css_src_head->insert(pair('/_makerator/css/site.css'='screen, projection'));
		
		
			$javascripts_src_head->insert('/_makerator/jquery/jquery-1.2.3.min.js');
			//$javascripts_src_head->insert('/_makerator/jquery/jquery.bgiframe.js');
			//$javascripts_src_head->insert('/_makerator/jquery/interface.js');
			$javascripts_src_head->insert('/_makerator/jquery/jquery.dimensions.min.js');
			$javascripts_src_head->insert('/_makerator/jquery/jquery.date_input.js');
			$javascripts_src_head->insert('/_makerator/jquery/ui.mouse.js');
			//$javascripts_src_head->insert('/_makerator/jquery/ui.sortable.ext.js');
			$javascripts_src_head->insert('/_makerator/jquery/ui.draggable.js');
			$javascripts_src_head->insert('/_makerator/jquery/ui.droppable.js');
			$javascripts_src_head->insert('/_makerator/jquery/ui.sortable.js');
			//$javascripts_src_head->insert('/_makerator/jquery/inestedsortable.pack.js');
	
	/if;
	


]