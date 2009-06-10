[

	protect;
			handle;
					debug('in the first handle');
			/handle;
			
			handle;
					debug('in the second handle');
			/handle;
			
			handle($doTask == true);
					debug('$doTask was "true"');
					$content_primary += '<p>$doTask was "true"</p>';
			/handle;
			
			handle($doTask->isa('boolean'));
					debug('$doTask is type "boolean"');
					$content_primary += '<p>$doTask is type "boolean"</p>';
			/handle;
			
			handle($doTask->isa('date'));
					debug('$doTask is type "date"');
					$content_primary += '<p>$doTask is type "date"</p>';
			/handle;
			
			$content_primary += '<h1>This is the Testing Page</h1>';
			$content_primary += '<p>Here we are going to test the protect/handle tags:</p>';
			$content_primary += '<h2>Set "doTask" now...</h2>';
			
			
			var('doTask' = date);
			debug('$doTask is type "' + $doTask->type + '"');
			fail_if((!$doTask->isa('boolean')), 2000, 'the var "doTask" needs to be boolean but was type "' + $doTask->type + '"');
			
			handle_error;
					debug(error_msg, -error);
			/handle_error;
			
	/protect;

]