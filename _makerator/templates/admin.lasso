<!DOCTYPE HTML> 
<html>
	<head>
		<meta http-equiv="Content-Language" content="en" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<title>[$content_pageTitle] &mdash; Job Welder Dot Com</title>
		
	</head>
	<body>
		[$show_content_siteAdmin && $content_siteAdminToolbar->size > 8 ? $content_siteAdminToolbar] 
		<div class="container">
				<h1 class="header column  span-24" title="Sweet.">
					<a href="/" id="logo">
						<strong>
							Makerator
						</strong>
					</a>
				</h1>
		</div>
		<div class="container">
			<div class="span-24 first last">
							[/*include('/_makerator/_library/navbar.lasso')*/] 
			</div>
		</div>
		
		<div class="container">
				<div class="span-16 prepend-0 append-1 first content">
					[@$crumbtrail]
					[
						$content_pageTitle->totitle;
						$content_pageTitle->replace('_and_', '&nbsp&amp;&nbsp;');
						$content_pageTitle->replace('~per-cent~', '%');
						$content_pageTitle->replace('--', ': ');
						$content_pageTitle->replace('~', '&rsquo;');
						$content_pageTitle->replace('__', ' / ');
						$content_pageTitle->replace('_', ' ');
					]
					<h1>[$content_pageTitle]</h1>
							[$content_primary->size > 0 ?  @$content_primary]
							[$show_content_siteAdmin ? $content_siteAdmin]
				</div>
				<div class="span-7 prepend-0 append-0 last content">
				</div>
		</div>
		
		[$apparent_AuthenticationStatus == 'Unauthorized' ? '<a href="'response_path'Account/Sign_In/" id="signin"><strong>Sign In</strong></a>' | '<a title="You are signed in. Click to sign out." href="'response_path'Account/Sign_Out/" id="signout"><strong>Sign Out</strong></a>'] 
	</body>
</html>
