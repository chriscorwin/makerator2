<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Content-Style-Type" content="text/css">
		<meta http-equiv="Content-Script-Type" content="text/javascript">
		<link rel="stylesheet" href="/_makerator/css/blueprintcss/screen.css" type="text/css" media="screen, projection">
		<link rel="stylesheet" href="/_makerator/css/bluprintcss/print.css" type="text/css" media="print">
<script type="text/javascript" src="/_makerator/jquery/jquery-1.2.1.min.js"></script> <script type="text/javascript" src="/_makerator/jquery/superfish.js"></script> <script type="text/javascript">
			$(function() {
				$('.nav').superfish({
					pathClass : 'current',
					animation : {opacity:'show'},
					delay : 1000
				});
			});
		</script> 
<link href="/_makerator/css/site.css" rel="stylesheet" type="text/css">
<!--[if IE 6]>
		<![endif]-->
<!--[if IE 7]>
		<![endif]-->
<!--[if IE]>
			<link href="/_makerator/css/ie.css" rel="stylesheet" type="text/css">
		<![endif]-->
<title>
Overview- Makerator: Easy CMS and Learning Tool for Lasso 
</title>
<body>
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
	<div class="column span-24 first last">
	</div>
</div>
<div class="container">
	<div class="column span-12 prepend-0 append-12 first last content">
		<h1>
			There is no installer yet
		</h1>
		<div class="content">
			<p>
				Get over it. 
			</p>
			<h2>
				To install: 
			</h2>
			<ol>
				<li>
					You need to create a lasso site just for Makerator. I call this site "Makerator" &mdash; and you probably should, too. 
				</li>
				<li>
					Put the <a href="Put%20in%20LassoStartup/">proper files</a> in Makerator&rsquo;s Lasso site folder --in the "LassoStartup" one, and restart the site. 
				</li>
				<li>
					Add your host and db and change security to your liking, but then add .lasso to the files list in lasso settings. 
				</li>
				<li>
					<strong>Edit the 
					<code>/_Site/config.lasso</code>
					to match your security and <code>server_name</code>  settings. </strong>
				</li>
				<li>
					Set up your vhost in apache. You&rsquo;ll see that you&rsquo;ll need to put the 
					<code><a href="/_makerator/_installer/Apache_Config_Example/vhost.conf">/_makerator/_installer/Apache_Config_Example/vhost.conf</a></code>
					lines in your httpd.conf file. 
				</li>
				<li>
					Put the tables into your database. Look in 
					<code><a href="/_makerator/_installer/SQL/makerator_install_dump.sql">/_makerator/_installer/SQL/makerator_install_dump.sql</a></code>
				</li>
				<li>
					Refresh your site 
				</li>
				<li>
					Restart apache 
				</li>
				<li>
					Pray. 
				</li>
				<li>
					Just kidding about praying. 
				</li>
			</ol>
		</div>
	</div>
</body>
</html>