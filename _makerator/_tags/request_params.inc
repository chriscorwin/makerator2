[//lasso
/*----------------------------------------------------------------------------

[request_params]
Returns a map of items in the client request header.

Author: Jason Huck
Last Modified: Jan. 01, 0001
License: 

Description:
Returns a map of items in the client request header.


Sample Usage:
request_params->find('Host');

-> 'www.omnipilot.com'


Downloaded from tagSwap.net on Mar. 05, 2009.
Latest version available from <http://tagSwap.net/request_params>.

----------------------------------------------------------------------------*/
		
if(!lasso_tagExists('request_params'));
		define_tag(
			'params',
			-namespace='request_',
			-priority='replace',
			-description='Returns a map of the items in the request header.'
		);
			local('in') = client_headers;
			#in->replace('\r\n','\r')&replace('\n','\r');
			#in = #in->split('\r');
			
			local('out' = map);
			
			iterate(#in, local('i'));
				local('name') = #i->split(':')->first;
				local('value') = #i->removeleading(#name + ':')&trim&;
				#out->insert(#name = #value);
			/iterate;
		
			return(@#out);
		/define_tag;
/if;
]