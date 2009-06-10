/*
	Makerator Javascript String Library 1.0
	====================================================
	Copyright (c) 2009 Chris Corwin
	
	http://chriscorwin.com/about/
	
	
	
	String.beginsWith
	====================================================
	Returns true if the base string begins with the
	string parameter, false otherwise.
	
	Requires a single string parameter.
	
	The test is case sensitive.
	
	
	Usage:
	====================================================
	var myString = 'The cat and Bob and the dog are all alcoholics.';
	myString.beginsWith('bob');                    // false
	myString.beginsWith('Bob');                    // false
	myString.beginsWith('The');                    // true
	myString.beginsWith('T');                      // true
	myString.beginsWith('t');                      // false
	myString.beginsWith('the');                    // false
	myString.beginsWith('The cat and');            // true
	myString.beginsWith('The cat and Bob');        // true
	myString.beginsWith(' are all alcoholics.')    // false
	myString.beginsWith('.');                      // false	
*/
String.prototype.beginsWith = function(value) {
		if (this.length < value.length) 
			{ return false; }
		else 
			{ return this.substring(0, value.length) === value; }
	}
