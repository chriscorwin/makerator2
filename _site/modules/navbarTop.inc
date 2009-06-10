[

	
	local('out' = navbar(-id='navbarTop', -refresh=false, -multiLevel=true, -group=1, -showRoot=false));
	
	!(#out >> 'id="navbarTop"') ? navbar(-id='navbarTop', -refresh=true, -multiLevel=true, -group=1, -showRoot=false) | #out;
/* 	navbar(-multiLevel=true, -depth=2); */
/* 	'<textarea rows="8" cols="30">' + navbar + '</textarea>'; */
/* 	 */
/* 	 */
/* 	'<textarea rows="8" cols="30">' + $makeratorCacheNavbars + '</textarea>'; */
]