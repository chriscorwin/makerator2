[

	// this sucker is included by various form generating files
	
	// the idea is to insert a classname of "required" or "optional", to be styled as needed

	(var($listeratorAction + '_Required')->find($a_column))->size ? 'required' | 'optional';

]