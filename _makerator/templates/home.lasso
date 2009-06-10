<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Content-Style-Type" content="text/css">
		<meta http-equiv="Content-Script-Type" content="text/javascript">
		<link rel="stylesheet" href="/_Assets/css/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="/_Assets/css/print.css" type="text/css" media="print">
		<script type="text/javascript" src="/_Assets/jquery/jquery-1.2.1.min.js"></script>
		<script type="text/javascript" src="/_Assets/jquery/superfish.js"></script> 
		<script type="text/javascript">
			$(function() {
				$("div#saved").ready(function(){
						$("div#saved").fadeOut(1000);
						$("#editor").show(1000);
					});
				$('.nav').superfish({
					pathClass : 'current',
					animation : {opacity:'show'},
					delay : 1000
				});
			});
			
			$(function(){
				$('a.new-window').click(function(){
					window.open(this.href);
					return false;
				});
			});
		</script>
		
		
		[$head_insert->size > 2 ? @$head_insert]
		
		<link href="/_Assets/css/branding.css" rel="stylesheet" type="text/css">
		[$show_content_siteAdmin ? '<link href="/_Assets/css/admin.css" rel="stylesheet" type="text/css"']
<title>
[$content_pageTitle] - Indiana Convention Center
</title>
</head>
<body>
	<div class="container">
			<h1 class="header column  span-16">
				<a href="/" id="logo">
					<strong>
						[$content_pageTitle] &mdash; Lucas Oil Stadium
					</strong>
				</a>
			</h1>
			<div class="vcard-top column span-4 last">
				<strong>Indiana Convetion Center</strong><br>
				100 South Capitol Ave<br>
				Indianapolis, IN 46225<br>
				317&nbsp;262&nbsp;3400
			</div>
			<div class="column span-20 first last">
				[include('/_makerator/_library/navbar.lasso')] 
			</div>
			<div class="column span-20 building-home first last">
					
			</div>
	</div>
	<div class="container">
			<h2 id="welcome-message" class="column span-20  first last">
					Welcome to the Indiana Convention Center &amp; Lucas Oil Stadium
			</h2>
	</div>
	<div class="container">
			<ul class="home-nav">
				<li class="column span-4 first"><a href="/About/Events/">Upcoming Events</a></li>
				<li class="column span-4 second"><a href="/Visitor_Info/">Visitor Info</a></li>
				<li class="column span-4 third"><a href="/Exhibitor_Info/">Exhibitor Info</a></li>
				<li class="column span-4 fourth"><a href="/RCA_Dome/">RCA Dome</a></li>
				<li class="column span-4 fifth last"><a href="http://LucasOilStadium.com">Lucas Oil Stadium</a></li>
			</ul>
	</div>
	<div class="container">
			<div class="column span-10 prepend-0 append-0 first pad-top-2">
				[$content_primary->size > 40 ? ('<div class="content pad-left-1"><h1>' $content_pageTitle '</h1>' @$content_primary '</div>') | action_param('content') ? '<div class="content">' include('/_Assets/Templates/content.html') '</div>'] 
				[$show_content_siteAdmin ? $content_siteAdmin]
			</div>
			<div class="column span-8 prepend-1 append-1 last pad-top-2">
					<div class="content pad-left-1"><h3>What&rsquo;s News</h3>[include('/_Assets/news_ol.lasso')]</div>
			</div>
			
	</div>
	[include('/_Assets/footer.lasso')]
	[$head_insert->size > 2 ? @$head_insert] 
</body>
</html>
