[
/*----------------------------------------------------------------------------

[lp_date_leapyear]
Given a year (or date), it returns true if it is a Gregorian leap year, or false if it is not.

Author: Bil Corry
Last Modified: Dec. 03, 2005
License: Public Domain

Description:
Given a year (or date), it returns true if it is a Gregorian leap year, or 
false if it is not.  If no year is passed, it assumes the current year.


Sample Usage:
<pre>
<b>LeapYear Example</b>
[loop: -from=1800, -to=2200][if: (lp_date_leapyear: loop_count)]
[loop_count] is a leap year[/if][/loop]
</pre>

[lp_date_leapyear]
[lp_date_leapyear: date]

Downloaded from tagSwap.net on Jul. 12, 2006.
Latest version available from <http://tagSwap.net/lp_date_leapyear>.

----------------------------------------------------------------------------*/
		
]

[

define_tag:'lp_date_leapyear',
	-description='Given a year (or date), it returns true if it is a Gregorian leap year, or false if it is not.  If no year is passed, it assumes the current year.',
	-priority='replace',
	-optional='year',-copy;

	// gregorian leap year algorithm from http://mindprod.com/jglossleapyear.html (now MIA)
	// valid roughly from 1800 forward 

	if: !(local_defined:'year');
		local:'year' = date;
	/if;

	if: #year->type == 'date';
		#year = (integer: #year->year);
	else; // assume integer year
		#year = integer: #year;
	/if;

	if: #year % 4 != 0;
		return: false;
	else: #year % 100 != 0;
		return: true; 
	else: #year % 400 != 0;
		return: false;
	else;
		return: true;
	/if;

/define_tag;

]