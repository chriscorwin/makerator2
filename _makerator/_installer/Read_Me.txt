There is no installer yet.

Get over it.


To install:

1) You need to create a lasso site just for Makerator. I call this site "Makerator" -- and you probably should, too.

2) Put the proper files in Makerators Lasso site folder --in the "LassoStartup" one, and restart the site.

3) Add your host and db and change security to your liking, but then add .lasso, .inc, .txt, and .html to the list of files that Lasso is allowed to inspect.

4) Edit the "/_site/config.lasso.txt" to match your security settings, and re-name it to: "config.lasso".

5) Set up your vhost in apache. There is an example virtual host config file in "/_makerator/_installer/apache_config_example/vhost.conf".

6) Put the tables into your database. Look in "/_makerator/_installer/sql/makerator_install_dump.sql"

7) Refresh your site.

8) Restart apache.

9) Pray.

10) Just kidding about praying.

