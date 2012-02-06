[






	rows(-inlinename=('show'+$this));
			$content_pageTitle = column('Title');
			
			iterate((var($listeratorAction + '_Fields')), local('a_column'));
					
					local('column_name') = #a_column->find('Field');
					string(#column_name)->contains('UID') ? loop_continue;
					$content_primary += column(#column_name);
					$content_primary += '<br>';
			/iterate;
	/rows;

	header('Content-Type: text/xml; charset=' . get_option('blog_charset'), true);
$more = 1;

	'<?xml version="1.0" encoding="'.get_option('blog_charset').'"?'.'>'; 

	'<!-- generator="makerator/' $makerator_version '" -->';
]
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:ng="http://newsgator.com/schema/extensions" xmlns:wfw="http://wellformedweb.org/CommentAPI/">
<channel>
	<title>[$content_siteTitle]</title>
	<link>http://[server_name]/</link>
	<copyright>Copyright retained by original author, refer to http://[server_name]/rss.xml for further information</copyright><description />
	<webMaster>[$site_webmaster]</webMaster>
	<lastBuildDate>2008-02-01T11:07:37</lastBuildDate><image><url />
	<title>[$content_siteTitle]</title>
	<link>http://[server_name]/</link></image>
	<ng:id>476450</ng:id><ttl>60</ttl>
	<ng:token>MDIyMDA4LTAyLTAxVDExOjA3OjM3LjkxMyA0Mjg0MTA1NTY1</ng:token>

<item>
	<title>X-ray art installation depicts injuries from terrorism</title>
	<link>http://feeds.feedburner.com/~r/boingboing/iBag/~3/227359124/xray-project-art-ins.html</link>
	<description>
            
            
&lt;img src="http://www.boingboing.net/images/ridingbussss.jpg" height="295" width="498" border="1" align="left" hspace="4" vspace="4" alt="Ridingbussss" /&gt;
&lt;br clear="all"&gt;
Inside Terrorism: The X-Ray Project is an art exhibition of X-rays and CT-scans from Jerusalem hospitals depicting civilian injuries from terrorist attacks. The full text accompanying the piece shown here reads, "I was in college then, riding the bus to campus. When he exploded, his watch blasted into my neck. Some of the shrapnel tore through my cartoid artery, which carries blood to my brain." The following is from artist Diane Covert's statement about the project:
&lt;blockquote&gt;The idea for Inside Terrorism began to coalesce in my mind in 2002 as a personal response to terrorism and to my discomfort with the way terrorism has been justified in some circles.  This is a documentary of survivors of terrorism.  Much like photographer Mathew Brady documented the Civil War, people in emergency rooms today are documenting the effects of terrorism. The exhibit is another form of "straight" photography - that is photographs made with an unaltered spectrum of light. With that technology, we are able to look inside terrorism.&lt;/blockquote&gt;


&lt;a href="http://www.x-rayproject.org"&gt;Link&lt;/a&gt; &lt;em&gt;(Thanks, &lt;a href="http://www.surgery.medicine.iu.edu/people/detail.php?perID=40"&gt;Mark Pescovitz&lt;/a&gt;!)&lt;/em&gt;
            
            

  
 
  


        
&lt;p&gt;&lt;a href="http://feeds.feedburner.com/~a/boingboing/iBag?a=2rIDBl"&gt;&lt;img src="http://feeds.feedburner.com/~a/boingboing/iBag?i=2rIDBl" border="0"&gt;&lt;/img&gt;&lt;/a&gt;&lt;/p&gt;&lt;img src="http://feeds.feedburner.com/~r/boingboing/iBag/~4/227359124" height="1" width="1"/&gt;</description>
	<guid isPermaLink="false">tag:www.boingboing.net,2008://1.42259</guid>
	<pubDate>Fri, 01 Feb 2008 17:32:34 GMT</pubDate>
	<ng:modifiedDate>Fri, 01 Feb 2008 10:48:07 GMT</ng:modifiedDate>
	<ng:postId>4284105565</ng:postId>
	<ng:read>False</ng:read>
	<author>David Pescovitz</author>
	<ng:avgRating>0.000000</ng:avgRating>
	<ng:clipped>False</ng:clipped>
	<category>Art</category><feedburner:origLink xmlns:feedburner="http://rssnamespace.org/feedburner/ext/1.0">http://www.boingboing.net/2008/02/01/xray-project-art-ins.html</feedburner:origLink>
</item>
</channel>
</rss>