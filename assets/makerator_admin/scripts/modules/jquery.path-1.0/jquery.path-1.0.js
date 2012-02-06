/**
 * :path (http://devkick.com/lab/path/)
 *
 * :path is a useful jquery selector. 
 * It filters out anchors that matches their href attribute with the window location and their ancestor's trail.
 *
 * Adding active classes is very common in navigational elements in order to style an 'active state'. This is normally added server-side. 
 * Instead of adding classes server-side using complicated logic, the :path selector uses javascript to parse the window.location and match it with href attributes. 
 * The plugin works recursively, meaning it can take the entire path to your page and return navigational anchors that points to the page's ancestors as well as itself.
 * Use CSS or jQuery to parse and style the active element properly.
 *
 * :path is a pseudo-class selector so you can continue the chain for easy manipulation
 *
 * FEATURES
 *   Works on all relative href paths (including '../') as well as absolute paths
 *   Returns empty if the href points to root
 *   Ignores a custom array of file names, such as index.html
 *   Works on query strings, such as ?s1=home&s2=blog
 *   includes a :current pseudo-class so you can style the anchor that links to the current page location
 *   Tested in Safari 3, Firefox 2, MSIE 6, MSIE 7, Opera 9
 *
 * Version 1.0
 * April 28, 2008
 *
 * Copyright (c) 2008 David Hellsing (http://monc.se)
 * Licensed under the GPL licenses.
 * http://www.gnu.org/licenses/gpl.txt
 **/



;(function($){

/**
 * 
 * @desc Filters out anchors that matches the window.location trail
 * @author David Hellsing
 * @version 1.0
 *
 * @name :path
 * @type jQuery
 *
 * @cat plugins/Utilities
 * 
 * @example $('ul a:path').parent().addClass('active');
 * @desc Adds an 'active' class to the filtered anchors parent inside every <ul>
 *
 * @options
 *   strictQuery: Boolean if you want the query string to be strict (ex: a=b&b=a equals b=a&a=b). Defaults true.
 *   ignoreFiles: Array of file names to ignore. ['index.htm','index.html','index.shtml','index.cgi','index.php']
 *
**/

$.extend({path : {
	
	// array of files to ignore
	ignoreFiles : ['index.htm','index.html','index.shtml','index.cgi','index.php'],
	
	// strict mode boolean
	strictQuery : true,
	
	// regexp for ignored file names
	ignore : function() {
		return new RegExp('('+$.path.ignoreFiles.join('|')+')','i');
	},
	
	// grab and parse the location
	window : function() {

		// define window.location as a short variable
		var _l = window.location;
		
		// grab the window path, split & and parse
		var _w = (_l.protocol + '//' + _l.hostname + _l.pathname + _l.hash).cleanPath($.path.ignore()).split('/');
		
		// grab the query string, split & sort if not in strict mode
		var _q = _l.search.substring(1).length > 0 ? _l.search.substring(1).split('&') : [];
		if (!$.path.strictQuery) { _q.sort(); }
		
		// merge the arrays
		return _w.concat(_q);
	},
	
	// grab and parse the anchor
	anchor : function(_this) {
		
		// grab the hrefs
		var _org = _this.getAttribute('href',1);
		
		// return false if node is not anchor or href is not present
		if (!_org || _this.nodeName != 'A') { return false; }
		
		var _l = window.location;
		
		// parse href
		var _href = _org.absUrl().cleanPath($.path.ignore());
		
		// return if href is root
		if (_href === (_l.protocol + '//' + _l.hostname).replace(/www\./,'').noSlash()) {
			return false;
		}

		// split href into path & query
		var _s = _href.split("?");
		var _a = _s[0].noSlash().split('/');
		var _q = _s.length > 1 ? _s[1].split('&') : [];
		
		// sort query if not in strict mode
		if (!$.path.strictQuery) { _q.sort(); }
		
		// merge the arrays
		return _a.concat(_q);
		
	},
	
	// match the anchor with window
	match : function(_this) {

		var _a = $.path.anchor(_this);
		var _w = $.path.window();
		
		// compare and return
		return _w.length < _a.length ? false : _w.slice(0,_a.length).compare(_a);
	},
	
	current : function(_this) {

		var _a = $.path.anchor(_this);
		var _w = $.path.window();
		
		// compare and return
		return _w.length == _a.length ? true : false;
	}
}});


// Extend jQuery with the :path selector
$.extend($.expr[":"], { path : 'jQuery.path.match(a);' });

// Extend jQuery with the :current selector
$.extend($.expr[":"], { current : 'jQuery.path.current(a);' });


/*
 * @name noSlash()
 * @desc String prototype that removes ending slashes
**/

String.prototype.noSlash = function() {
	return this.lastIndexOf('/') === this.length-1 ? this.substr(0,this.length-1) : this.toString();
};

/*
 * @name absUrl()
 * @desc String prototype that returns the absolute URL
**/

String.prototype.absUrl = function() {
	var l = window.location, h, p, f, i;
	if (/^\w+:/.test(this)) {
		return this.toString();
	}
	h = l.protocol + '//' + l.host;
	if (this.indexOf('/') === 0) {
		return h + this.toString();
	}
	p = l.pathname.replace(/\/[^\/]*$/, '');
	f = this.match(/\.\.\//g);
	if (f) {
		var n = this.substring(f.length * 3);
		for (i = f.length; i--;) {
			p = p.substring(0, p.lastIndexOf('/'));
		}
	} else {
		n = this.toString();
	}
	return h + p + '/' + n;
};

/*
 * @name cleanPath()
 * @desc String prototype that cleans up the URL path
**/

String.prototype.cleanPath = function(ignore) {
	return this.replace(/www\./i,'').replace(ignore,'').replace(/\.\//,'').noSlash().toString();
};

/*
 * @name compare()
 * @desc Array prototype that compares two arrays and returns a boolean
**/

Array.prototype.compare = function(t) {
	if (this.length != t.length) { return false; }
	for (var i = 0; i < t.length; i++) {
		if (this[i] !== t[i]) { 
			return false;
		}
	}
	return true;
};

})(jQuery);