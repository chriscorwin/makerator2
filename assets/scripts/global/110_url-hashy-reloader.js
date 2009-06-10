/*
 	Parses the browser's location bar string and re-directs any subdirectories as a hash value
*/
 if (window.location.hash.length == 0 && window.location.pathname.length >= 1) {
     var x = window.location.pathname;
     if (x.endsWith("/") == true) {} else {
         x += "/";
     }
/*      window.location = 'http://' + window.location.hostname + '#' + x.toLowerCase(); */
     window.location.replace('/#' + x.toLowerCase());
 } else if (window.location.hash.length != 0) {
     var x = window.location.hash;
     if (x.endsWith("/") == true) {
     
     } else {
         x += "/";
     }
     window.location.replace(x.toLowerCase());
 } else {};
 
/* console.log('window.location.hostname:'  + window.location.hostname); */
/* console.log('window.location.pathname:'  + window.location.pathname); */
/* console.log('window.location.hash:'  + window.location.hash); */
