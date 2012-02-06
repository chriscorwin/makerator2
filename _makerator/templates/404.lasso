<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" >
		<title>['Error: ' + error_code  + ' - ' + error_msg]</title>
		<link rel="stylesheet" type="text/css" href="/assets/makerator/css/global/000_tripoli-combo.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator/css/global/204_jquery.jgrowl-1.2.0.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator/css/global/205_jgrowl.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator/css/global/800_makerator.core.css">
		<link rel="stylesheet" type="text/css" href="/assets/makerator/css/themes/makerator/jquery-ui-1.7.1.custom.css">
	</head>
	<body class="l1 wide equal">
		<div id="container">
			<div id="header">
				<div class="content">
					<span class="loader"><a href="/" id="masthead" title=" #{content_siteTitle}# "><strong><!-- #{content_siteTitle}# --></strong></a></span>
				</div>
			</div>
			<div id="primary">
				<div id="primaryContentWrapper"  class="content loader">
				
				
					<div class="ui-widget">
						<div class="ui-state-error ui-corner-all">
							<p class=""><strong>Error:</strong> <code>['[server_name]'] </code> <em class="lighter">([server_name]) </em> does not match settings in site config.</p>
						</div>
					</div>
					
					<div class="ui-widget">
						<div class="ui-widget-header ui-corner-top"">
							<h1>
								There has been a configuration error.
							</h1>
						</div>
						<div class="ui-widget-content ui-corner-bottom">
							<p>This website has been configured only to serve content if it is being served from certain explicit domain names, and the one you are at ([server_name]) is not in that list of allowed domains.
							</p>
							<p>Would you like to go to the <a href="http://[$makerator_defaultDomainName]/">default domain for this installation ([$makerator_defaultDomainName])</a>?
							</p>
						</div>
					</div>
					
					[if(client_ip == server_ip || client_ip == 'localhost' || client_ip == '127.0.0.1')]
					<div class="ui-widget">
						<div class="ui-widget-header ui-corner-top"">
							<h3>
								If You Are the System Administrator
							</h3>
						</div>
						<div class="ui-widget-content ui-corner-bottom">
							<p>
								This error could be showing due to a configuration error, or perhaps this particular instance of Makerator is, as of this moment, only half&ndash;installed?
							</p>
						</div>
					</div>
					<div class="ui-widget">
						<div class="ui-widget-header ui-corner-top"">
							<h3>
								Basic Installation Instructions
							</h3>
						</div>
						<div class="ui-widget-content ui-corner-bottom">
							<ol>
								<li>
									You need to create a lasso site just for Makerator. The default name for this site is "Makerator" &mdash; probably best to follow that convetion, huh?
								</li>
								<li>
									Put the proper files in Makerator&rsquo;s <q><code>Lasso Site folder</code></q> &mdash; (these should go into directory called <q><code>LassoStartup</code></q>), and restart the site. 
								</li>
								<li>
									Add your host and db and change security to your liking, but then add <q><code>.lasso</code></q> to the files list in lasso settings. 
								</li>
								<li>
									<strong>Edit the <code>/_site/config.lasso.txt</code> file to match your particular security and <code>server_name</code> settings.</strong>
								</li>
								<li>
									Set up your vhost in apache. You&rsquo;ll see that you&rsquo;ll need to put the <code><a href="file://[server_webroot]_makerator/_installer/apache_config_example/vhost.conf">/_makerator/_installer/apache_config_example/vhost.conf</a></code> lines in your httpd.conf file. 
								</li>
								<li>
									Put the tables into your database. Look in <code><a href="file://[server_webroot]_makerator/_installer/sql/makerator_install_dump.sql">/_makerator/_installer/sql/makerator_install_dump.sql</a></code>
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
					[/if]
					<div id="errorContent" class="content loader ui-layout-content">
						<div class="ui-widget">
							<div class="ui-state-highlight ui-corner-all">
								<p class=""><strong>Error reported by:</strong> <code>[$makerator_include_currentPathReporting]</code>.</p>
							</div>
						</div>
						<div class="ui-widget">
							<div class="ui-widget-header ui-corner-top">
								<h3>Error Information</h3>
							</div>
							<div class="ui-widget-content ui-corner-bottom">
								<p><strong>Error Code:</strong> <code>[error_code]</code></p>
								<pre><code>[error_msg]</code></pre>
							</div>
						</div>
						[$content_error]
					</div>
				</div>
			</div>
			
			
			<div id="secondary">
				<div id="secondaryContentWrapper"  class="loader content">
					<div id="secondaryContent" class="loader content ui-layout-content">
					</div>
				</div>
			</div>
			
			
			<div id="tertiary">
				<div class="content">
				</div>
			</div>
			<div id="footer">
				<div class="content loader ui-widget">
					<div class="ui-state-error ui-corner-all">
						<p><strong>Server Info:</strong> [server_name + ' running on ' + lasso_version].</p>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
