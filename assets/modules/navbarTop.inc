[

	
	local('navbarTopOut' = navbar(-id='navbarTop', -refresh=false, -multiLevel=true, -group=1, -showRoot=false));
	
	!(#navbarTopOut >> 'id="navbarTop"') ? #navbarTopOut = navbar(-id='navbarTop', -refresh=true, -multiLevel=true, -group=1, -showRoot=false);
	
	#navbarTopOut;
]