jQuery.validator.addMethod("maxWords", function(value, element, params) { 
    return this.optional(element) || value.match(/\b\w+\b/g).length < params; 
}, $.format("Please enter {0} words or less.")); 
 
jQuery.validator.addMethod("minWords", function(value, element, params) { 
    return this.optional(element) || value.match(/\b\w+\b/g).length >= params; 
}, $.format("Please enter at least {0} words.")); 
 
jQuery.validator.addMethod("rangeWords", function(value, element, params) { 
    return this.optional(element) || value.match(/\b\w+\b/g).length >= params[0] && value.match(/bw+b/g).length < params[1]; 
}, $.format("Please enter between {0} and {1} words."));


jQuery.validator.addMethod("letterswithbasicpunc", function(value, element) {
	return this.optional(element) || /^[a-z-.,()'\"\s]+$/i.test(value);
}, "Letters or punctuation only please");  

jQuery.validator.addMethod("alphanumeric", function(value, element) {
	return this.optional(element) || /^\w+$/i.test(value);
}, "Letters, numbers, spaces or underscores only please");  

jQuery.validator.addMethod("lettersonly", function(value, element) {
	return this.optional(element) || /^[a-z]+$/i.test(value);
}, "Letters only please"); 

jQuery.validator.addMethod("nowhitespace", function(value, element) {
	return this.optional(element) || /^\S+$/i.test(value);
}, "No white space please"); 

jQuery.validator.addMethod("ziprange", function(value, element) {
	return this.optional(element) || /^90[2-5]\d\{2}-\d{4}$/.test(value);
}, "Your ZIP-code must be in the range 902xx-xxxx to 905-xx-xxxx");

jQuery.validator.addMethod("urlfriendly", function(value, element) {
	
	var friendlyValue = $('.createKeywordUrlFromTitle').val();
	var potentialValue = friendlyToURLConversion(friendlyValue);
	var currentValue = $('#Keyword_URL').val();
	
	return /[a-z\d\-_~%]+$/gi.test(potentialValue);
}, "Must be URL friendly, please.");

jQuery.validator.addMethod("createKeywordUrlFromTitle", function(value, element) {
	var friendlyValue = value; 
	var potentialValue = friendlyToURLConversion(value);
	var currentValue = $('#Keyword_URL').val();
	
	if(potentialValue == currentValue){
		return true;
	}
	if(potentialValue.beginsWith(currentValue, false)){
		$('#Keyword_URL').val(potentialValue);
		$('#Keyword_URL').parent().stop({goToEnd: true})
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5);
	}
	
	if(currentValue == ''){
		$('#Keyword_URL').val(potentialValue);
		$('#Keyword_URL').parent().stop({goToEnd: true})
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5);
	}
	if(currentValue == 'Must Be Unique') {
		$('#Keyword_URL').val(potentialValue);
		$('#Keyword_URL').parent().stop({goToEnd: true})
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5);
	}
	if(currentValue == 'must_be_unique') {
		$('#Keyword_URL').val(potentialValue);
		$('#Keyword_URL').parent().stop({goToEnd: true})
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'left' }, 5)
		.effect('bounce', { times:1, distance: 8, direction: 'right' }, 5);
	}
	return true;
}, "Hi.");


function friendlyToURLConversion( value ) {
	var newValue = value;
	newValue = newValue.toLowerCase();
	newValue = newValue.replace(/%3F/g, '~3F~');
	newValue = newValue.replace(/%/g, '~25~');
	newValue = newValue.replace(/(~3f~)/g, '?');
	newValue = newValue.replace(/~TILDE~/g, '~7E~');
	newValue = newValue.replace(/~_~/g, 'UNDERSCOREUNDERSCOREUNDERSCORE');
	newValue = newValue.replace(/~-~/g, 'DASHDASHDASH');
	
	newValue = newValue.replace(/!/g, '');
	
	newValue = newValue.replace(/&{1}/g, '_and_');
	newValue = newValue.replace(/:( *)/g, '--');
	newValue = newValue.replace(/\//g, '__');
	newValue = newValue.replace(/( *)&{1}( *)/g, '_and_');
	newValue = newValue.replace(/(_{0,2}and_{0,2})/g, '_and_');
	
	newValue = newValue.replace(/(')/g, '\'');
	newValue = newValue.replace(/(")/g, '~22~');
	newValue = newValue.replace(/;/g, '~3B~');
	newValue = newValue.replace(/\?/g, '~3F~');
	newValue = newValue.replace(/,/g, '~2C~');
	newValue = newValue.replace(/\$/g, '~24~');
	newValue = newValue.replace(/\+/g, '~2B~');
	newValue = newValue.replace(/\//g, '~2F~');
	newValue = newValue.replace(/=/g, '~3D~');
	newValue = newValue.replace(/@/g, '~40~');
	newValue = newValue.replace(/</g, '~3C~');
	newValue = newValue.replace(/>/g, '~3E~');
	newValue = newValue.replace(/#/g, '~23~');
	newValue = newValue.replace(/\{/g, '~7B~');
	newValue = newValue.replace(/\}/g, '~7D~');
	newValue = newValue.replace(/\[/g, '~5B~');
	newValue = newValue.replace(/\]/g, '~5D~');
	newValue = newValue.replace(/\\/g, '~5C~');
	newValue = newValue.replace(/\./g, '');
	
	newValue = newValue.replace(/ /g, '_');
	
	newValue = newValue.replace(/`/g, '~');
	newValue = newValue.replace(/(~2C~)/g, '~~');
	newValue = newValue.replace(/(~3F~)/g, '%3F');
	newValue = newValue.replace(/( *)\/( *)/g, '__');
	newValue = newValue.replace(/ /g, '_');
	newValue = newValue.replace(/DASHDASHDASH/g, '~-~');
	newValue = newValue.replace(/UNDERSCOREUNDERSCOREUNDERSCORE/g, '~_~');
	return newValue;
}

/**
* Return true, if the value is a valid vehicle identification number (VIN).
*
* Works with all kind of text inputs.
*
* @example <input type="text" size="20" name="VehicleID" class="{required:true,vinUS:true}" />
* @desc Declares a required input element whose value must be a valid vehicle identification number.
*
* @name jQuery.validator.methods.vinUS
* @type Boolean
* @cat Plugins/Validate/Methods
*/ 
jQuery.validator.addMethod(
	"vinUS",
	function(v){
		if (v.length != 17)
			return false;
		var i, n, d, f, cd, cdv;
		var LL    = ["A","B","C","D","E","F","G","H","J","K","L","M","N","P","R","S","T","U","V","W","X","Y","Z"];
		var VL    = [1,2,3,4,5,6,7,8,1,2,3,4,5,7,9,2,3,4,5,6,7,8,9];
		var FL    = [8,7,6,5,4,3,2,10,0,9,8,7,6,5,4,3,2];
		var rs    = 0;
		for(i = 0; i < 17; i++){
		    f = FL[i];
		    d = v.slice(i,i+1);
		    if(i == 8){
		        cdv = d;
		    }
		    if(!isNaN(d)){
		        d *= f;
		    }
		    else{
		        for(n = 0; n < LL.length; n++){
		            if(d.toUpperCase() === LL[n]){
		                d = VL[n];
		                d *= f;
		                if(isNaN(cdv) && n == 8){
		                    cdv = LL[n];
		                }
		                break;
		            }
		        }
		    }
		    rs += d;
		}
		cd = rs % 11;
		if(cd == 10){cd = "X";}
		if(cd == cdv){return true;}
		return false; 
	},
	"The specified vehicle identification number (VIN) is invalid."
);

/**
  * Return true, if the value is a valid date, also making this formal check dd/mm/yyyy.
  *
  * @example jQuery.validator.methods.date("01/01/1900")
  * @result true
  *
  * @example jQuery.validator.methods.date("01/13/1990")
  * @result false
  *
  * @example jQuery.validator.methods.date("01.01.1900")
  * @result false
  *
  * @example <input name="pippo" class="{dateITA:true}" />
  * @desc Declares an optional input element whose value must be a valid date.
  *
  * @name jQuery.validator.methods.dateITA
  * @type Boolean
  * @cat Plugins/Validate/Methods
  */
jQuery.validator.addMethod(
	"dateITA",
	function(value, element) {
		var check = false;
		var re = /^\d{1,2}\/\d{1,2}\/\d{4}$/
		if( re.test(value)){
			var adata = value.split('/');
			var gg = parseInt(adata[0],10);
			var mm = parseInt(adata[1],10);
			var aaaa = parseInt(adata[2],10);
			var xdata = new Date(aaaa,mm-1,gg);
			if ( ( xdata.getFullYear() == aaaa ) && ( xdata.getMonth () == mm - 1 ) && ( xdata.getDate() == gg ) )
				check = true;
			else
				check = false;
		} else
			check = false;
		return this.optional(element) || check;
	}, 
	"Please enter a correct date"
);

/**
 * matches US phone number format 
 * 
 * where the area code may not start with 1 and the prefix may not start with 1 
 * allows '-' or ' ' as a separator and allows parens around area code 
 * some people may want to put a '1' in front of their number 
 * 
 * 1(212)-999-2345
 * or
 * 212 999 2344
 * or
 * 212-999-0983
 * 
 * but not
 * 111-123-5434
 * and not
 * 212 123 4567
 */
jQuery.validator.addMethod("phone", function(phone_number, element) {
    phone_number = phone_number.replace(/\s+/g, ""); 
	return this.optional(element) || phone_number.length > 9 &&
		phone_number.match(/^(1-?)?(\([2-9]\d{2}\)|[2-9]\d{2})-?[2-9]\d{2}-?\d{4}$/);
}, "Please specify a valid phone number");

// TODO check if value starts with <, otherwise don't try stripping anything
jQuery.validator.addMethod("strippedminlength", function(value, element, param) {
	return jQuery(value).text().length >= param;
}, jQuery.format("Please enter at least {0} characters"));

// same as email, but TLD is optional
jQuery.validator.addMethod("email2", function(value, element, param) {
	return this.optional(element) || /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)*(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i.test(value); 
}, jQuery.validator.messages.email);

// same as url, but TLD is optional
jQuery.validator.addMethod("url2", function(value, element, param) {
	return this.optional(element) || /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)*(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(value); 
}, jQuery.validator.messages.url);
