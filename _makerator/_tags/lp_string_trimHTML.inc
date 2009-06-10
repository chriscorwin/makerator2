[
/*----------------------------------------------------------------------------

[lp_string_trimHTML]
Returns HTML with unneeded whitespace removed.

Author: Bil Corry
Last Modified: Oct. 30, 2006
License: Public Domain

Description:
Returns HTML with unneeded whitespace removed.  Preserves whitespace within 
angled-brackets, html comments, textarea, pre and script.


Sample Usage:
var:'test' = '




<br>
<br>
Some text<br>
<b>Hello!</b>
	<br>

<textarea name="test2" cols="40" rows="10">
	Test1

		Test3

<br>


.

Downloaded from tagSwap.net on Apr. 03, 2009.
Latest version available from <http://tagSwap.net/lp_string_trimHTML>.

----------------------------------------------------------------------------*/

define_tag:'lp_string_trimHTML',
	-description='Returns HTML with unneeded whitespace removed.  Preserves whitespace within angled-brackets, html comments, textarea, pre and script.',
	-priority='replace',
	-encodenone,
	-required='html';
		
	local:'chunks' = (string:#html)->(split:'<');
	
	// easy method? no angled brackets to deal with?
	if: #chunks->size == 1;
		return: (string_replaceregexp: #chunks->(get:1), -find='([^\\S]+)', -replace=' ');
	/if;

	// start building #return
	local:'return' = (string_replaceregexp: #chunks->(get:1), -find='([^\\S]+)', -replace=' ');
	#chunks->(remove: 1);

	// process the rest of it
	local:'find' = string;
	iterate: #chunks, local:'chunk';
		#return += '<';
		if: #find->size;
			if: #chunk->(contains: #find);
				#return += #chunk->(substring: 1, #chunk->(find:#find) + #find->size - 1);
				#return += (string_replaceregexp: (#chunk->(substring: #chunk->(find:#find) + #find->size)), -find='([^\\S]+)', -replace=' ');
				#find = string;		
			else; // not what we're looking for, just return it raw
				#return += #chunk;
			/if;
		else; // not in the middle of a html container
			if: #chunk->(substring: 1, 8) == 'textarea';
				#return += #chunk;
				#find = '/textarea>';
			else: #chunk->(substring: 1, 3) == 'pre';
				#return += #chunk;
				#find = '/pre>';	
			else: #chunk->(substring: 1, 6) == 'script';
				#return += #chunk;
				#find = '/script>';
			else: #chunk->(substring: 1, 3) == '!--';
				if: #chunk->(contains:'-->'); // simple html comment
					#return += #chunk->(substring: 1, #chunk->(find:'-->') + 2);
					#return += (string_replaceregexp: (#chunk->(substring: #chunk->(find:'-->') + 3)), -find='([^\\S]+)', -replace=' ');				
				else; // comment with angled-bracket within it
					#return += #chunk;
					#find = '-->';
				/if;
			else; // some html tag, find closing bracket
				#return += #chunk->(substring: 1, #chunk->(find:'>'));
				#return += (string_replaceregexp: (#chunk->(substring: #chunk->(find:'>') + 1)), -find='([^\\S]+)', -replace=' ');
			/if;
		/if;
	/iterate;
	
	return: #return;
		
/define_tag;

]