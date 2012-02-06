/*
	Makerator Javascript String Library 1.0
	====================================================
	Copyright (c) 2009 Chris Corwin
	
	http://chriscorwin.com/about/
	
	
	
	String.endsWith
	====================================================
	Returns true if the base string ends with the string
	parameter, false otherwise.
	
	Requires a single string parameter.
	
	The test is case sensitive.
	
	
	
	Usage:
	====================================================
	myString.endsWith('bob');                      // false
	myString.endsWith('Bob');                      // false
	myString.endsWith('The');                      // false
	myString.endsWith('alcoholics.');              // true
	myString.endsWith('all alcoholics.');          // true
	myString.endsWith(' are all alcoholics.');     // true
	myString.endsWith('.');                        // true	
*/
String.prototype.endsWith = function(value) {
	if (this.length < value.length) {
		return false;
	} else {
		return Boolean(this.substr((this.length - value.length), (value.length + 1)) === value);
	}
}
