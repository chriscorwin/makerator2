/*
	Makerator Javascript String Library 1.0
	====================================================
	Copyright (c) 2009 Chris Corwin
	
	http://chriscorwin.com/about/
	
	
	
	String.contains
	====================================================
	Returns true if the base string contains value
	parameter, false otherwise. 
	
	Requires a single string parameter.
	
	There is a second, optional, boolean paramater to
	turn off case-sensitivity.
	
	
	
	Usage:
	====================================================
	var myString = 'The cat and Bob and the dog are all alcoholics.';
	myString.contains('bob');                      // false
	myString.contains('Bob');                      // true
	myString.contains('cat');                      // true
	myString.contains('Cat');                      // false
	myString.contains('Cat', true);                // false
	myString.contains('Cat', false);               // true
	myString.contains('The cat and');              // true
	myString.contains('are alcoholics.');          // false
	myString.contains(' are all alcoholics.');     // true
	myString.contains(' ');                        // true
	
*/
String.prototype.contains = function(value, caseFlag) {
	if (this.length < value.length) {
		return false;
	} else {
		var regExPattern_value = (caseFlag === false ? new RegExp(value, '\i') : new RegExp(value));
		return Boolean(this.match(regExPattern_value));
	}
}