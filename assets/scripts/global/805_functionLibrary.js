var anchor = String(jQuery.url.attr('anchor'));
var directory = String(jQuery.url.attr('directory'));
var toLoad = '';
var toActivate = null;
var blankRegEx = /^[\s]*$/;

if (toLoad == 'null' || toLoad == '' || blankRegEx.test(toLoad)) {
		toLoad = anchor;
}

if (anchor == 'null' || anchor == '' || blankRegEx.test(anchor)) {
		toLoad = directory;
}

if (directory == 'null' || directory == '' || blankRegEx.test(directory)) {
		toLoad = '/';
}

if (toLoad == 'null' || toLoad == '' || blankRegEx.test(toLoad)) {
		toLoad.endsWith('/') == true ? '': toLoad += '/';
}


function layoutInitialize() {
	/*	testForJavascriptEnabled(); */
	setMakeratorOption('pageLoadsUseAjax', true);
/* 	removeStylesheets(); */
	
	$('#debugContent').addClass('ui-helper-clearfix ui-corner-all ui-widget ui-helper-reset');
	
	$('#navbarTop').addClass('loader sf-menu sf-navbar ui-helper-reset ui-widget ui-widget-header ui-helper-clearfix ui-corner-all').supersubs({
		minWidth: 12,
		maxWidth: 27,
		extraWidth: 1
	}).superfish({
		hoverClass: 'ui-state-hover',
		pathClass: 'ui-state-active',
		pathLevels: 1,
		delay: 800,
		animation: {
			opacity: 'show'
		},
		speed: 'normal',
		autoArrows: true,
		dropShadows: true,
		disableHI: false,
		onInit: function() {},
		onBeforeShow: function() {},
		onShow: function() {},
		onHide: function() {}
	});
	$('body').addClass('l1').addClass('wide').addClass('equal');
	$('#navbarTop li').each(function(i) {
		$(this).addClass('ui-state-default ui-corner-all');
		$(this).children('a').addClass('button');
		$(this).hover(function() {
			$(this).addClass('ui-state-hover');
		},
		function() {
			$(this).removeClass('ui-state-hover');
		});
	});
	
	if (anchor == directory) {
	} else if (anchor == toLoad) {
			loadInitialContent();
	} else {
		loadingIndicatorShow('#primaryContentWrapper');
		primaryContentLoad(toLoad, toActivate);
/* 		$('#primaryContent').hide('fast', primaryContentLoad(toLoad)); */
	}
	
	
	$('.results-listing li.ui-clickable h3 a').live('mouseover',
	function(event) {
		$(this).closest('li').unbind('click');
	});
	
	$('.results-listing li.ui-clickable h3 a').live('mouseout',
	function(event) {
		var href = $(this).attr('href');
		var toActivate = $(this);
		var toLoad = href;
		if (toLoad.endsWith('/', true) == true) {} else {
			toLoad = toLoad + '/';
		}
		$(this).closest('li').one('click', function(event) {
			loadingIndicatorShow('#primaryContentWrapper');
/* 			$('#primaryContent').fadeOut(25, primaryContentLoad(toLoad, toActivate)); */
			primaryContentLoad(toLoad, toActivate);
			$('a.active').each(function() {
				$(this).removeClass('active');
			});
			window.location.hash = toLoad;
		});
	});
	/*
		a:not([href^="http://"]), , a:not(.ui-datepicker-next),
	*/
	$('.loader a:not(.ui-datepicker-prev, .ui-datepicker-next, [href^="#"], [href^="http://"])').live('click',
	function(event) {
		$(this).closest('li').die();
		event.preventDefault();
		loadingIndicatorShow('#primaryContentWrapper');
		var toActivate = $(this);
		var toLoad = $(this).attr('href');
		if (toLoad.endsWith('/', true) == true) {} else {
			toLoad = toLoad + '/';
		}
/* 		$('#primaryContent').fadeOut(25, primaryContentLoad(toLoad, toActivate)); */
		primaryContentLoad(toLoad, toActivate);
		$('a.active').each(function() {
			$(this).removeClass('active');
		});
		window.location.hash = toLoad;
	});
}

function applyStriping() {
		$('.results-listing li:even').addClass('ui-stripped');
}
function applyClickableStyles() {
		$('.results-listing li.ui-clickable').each(function(i) {
			var $targetLI = $(this);
			var $targetAnchor = $targetLI.find('a');
			$targetLI.bind('mouseover',
			function() {
				$targetLI.addClass('ui-state-hover');
				$targetLI.removeClass('ui-state-default');
			});
			
			$targetLI.bind('mouseout',
			function() {
				$targetLI.removeClass('ui-state-hover');
				$targetLI.addClass('ui-state-default');
			});
			
			$targetLI.bind('mousedown',
			function() {
				$targetLI.removeClass('ui-state-hover');
				$targetLI.addClass('ui-state-active');
			});
			
			$targetLI.one('click', function(event) {
				var href = $targetAnchor.attr('href');
				event.stopPropagation();
				loadingIndicatorShow('#primaryContentWrapper');
				var toActivate = $targetAnchor;
				var toLoad = href;
				if (toLoad.endsWith('/', true) == true) {} else {
					toLoad = toLoad + '/';
				}
				primaryContentLoad(toLoad, toActivate);
				window.location.hash = toLoad;
			});
			
			$targetLI.bind('focus',
			function() {
				$targetLI.removeClass('ui-state-hover');
				$targetLI.removeClass('ui-state-default');
				$targetLI.addClass('ui-state-active');
				$targetLI.addClass('ui-state-focus');
			});
			$targetLI.bind('blur',
			function() {
				$targetLI.removeClass('ui-state-active');
				$targetLI.removeClass('ui-state-hover');
				$targetLI.removeClass('ui-state-focus');
				$targetLI.addClass('ui-state-default');
			});
			
			
			
		});
		
		$('a, button').each(function(i) {
				if($(this).hasClass('ui-clickable')) {
					$(this).bind('mouseover',
					function() {
						$(this).addClass('ui-state-hover');
					});
					$(this).bind('mouseout',
					function() {
						$(this).removeClass('ui-state-hover');
					});
					$(this).bind('focus',
					function() {
						$(this).removeClass('ui-state-hover');
						$(this).removeClass('ui-state-default');
						$(this).addClass('ui-state-active');
						$(this).addClass('ui-state-focus');
					});
					$(this).bind('blur',
					function() {
						$(this).removeClass('ui-state-active');
						$(this).removeClass('active');
						$(this).removeClass('ui-state-focus');
						$(this).addClass('ui-state-default');
					});
				} else {
				}
		});
}



function testForStylesheets() {
		$('link[rel="stylesheet"]').each(function() {
			var aHref = $(this).attr('href');
			
		});
		
		
}

function removeStylesheets() {
	$('link[rel="stylesheet"]').each(function() {
		var aHref = $(this).attr('href');
		$(this).remove();
	});
}

function testForJavascriptEnabled() {
	$('#javascriptTester').fadeOut('slow').fadeIn('slow').fadeOut('slow').fadeIn('slow').fadeOut('slow').fadeIn('slow').fadeOut('slow').fadeIn('slow')
	.fadeOut('slow').fadeIn('slow',
	function() {
		$('#javascriptTester div h1').text('Here we go!');
		$(this).fadeOut();
		
		if (window.location.hash.length == 0 && window.location.pathname.length >= 1) {
			var path = window.location.pathname;
			if (path.endsWith("/") == true) {} else {
				path += "/";
			}
			window.location = 'http://' + window.location.hostname + '#' + path.toLowerCase();
		}
		
		else if (window.location.hash.length >= 1 && window.location.pathname.length >= 1) {
			var path = window.location.pathname;
			var hash = window.location.hash;
			if (path.endsWith("/") == true) {} else {
				path += "/";
			}
			window.location = 'http://' + window.location.hostname + '#' + path.toLowerCase();
		}
		
		else if (window.location.hash.length != 0) {
			var x = window.location.hash;
			if (x.endsWith("/") == true) {} else {
				x += "/";
			}
			window.location = 'http://' + window.location.hostname + x.toLowerCase();
		}
		
		else {
			var hash = window.location.hash;
			primaryContentLoad(hash, null);
		};
	});
}



function loadInitialContent() {
		var hash = window.location.hash;
		loadingIndicatorShow('#primaryContentWrapper');
		primaryContentLoad(toLoad, toActivate);
/* 		$('#primaryContent').fadeOut('fast', primaryContentLoad(toLoad, null)); */
}





function accordionInitialize() {
	$('#accordion').accordion({
		header: '.ui-accordion-header',
		collapsible:true,
		autoHeight: true,
		active: false,
		clearStyle: true
	});
	
}

function accordionReInitialize() {
	$('#accordion .ui-accordion-header').each(function(i) {
		var linky = (($(this).children('a').attr('href')).toLowerCase());
		var patt1 = new RegExp(linky);
		var anchor = jQuery.url.attr('anchor').toLowerCase();
		var myBoolean = new Boolean(anchor.match(patt1));
		if (myBoolean == true) {
			$('#accordion').accordion('activate', i);
			return false;
		} else {
		};
	});
	$('#accordion').accordion('activate', -1);
}



function anchorsActivateFocusStyles() {
	$('.loader a:not(.ui-datepicker-prev, .ui-datepicker-next, [href^="#"], [href^="http://"])').each(function(i) {
		
		var aLink = $(this).attr('href').toLowerCase();
		if (aLink.endsWith('/', true) == true) {} else {
			aLink = aLink + '/';
		}
		// normalize links on page
		$(this).attr('href', aLink);
		
		var regExPattern_link = new RegExp(aLink);
		var anchor = String(jQuery.url.attr('anchor'));
		var directory = String(jQuery.url.attr('directory'));
		var toMatchAgainst = '';
		var blankRegEx = /^[\s]*$/;
		if (toMatchAgainst == 'null' || toMatchAgainst == '' || blankRegEx.test(toMatchAgainst)) {
				toMatchAgainst = anchor;
		}
		if (directory == 'null' || directory == '' || blankRegEx.test(directory)) {
				toMatchAgainst = anchor;
		}
		if (anchor == 'null' || anchor == '' || blankRegEx.test(anchor)) {
				toMatchAgainst = '/';
		}
		var setToActive = new Boolean(toMatchAgainst.match(regExPattern_link));
		
		
		if (setToActive == true && aLink != '/') {
			$(this).addClass('active ui-state-active');
			$('a[href="' + aLink + '"]').addClass('ui-state-active');
		} else {
			$(this).removeClass('ui-state-active');
			$('a[href="' + aLink + '"]').removeClass('ui-state-active').removeClass('active');
		}
		
	});
}




function primaryContentLoad(toLoad, toActivate) {
	$('#primaryContent').effect('slide', { direction: 'left', mode: 'hide' }, 125);
	$.ajax({
		url: toLoad,
		data: {
			content_body_dataType: 'html'
		},
		async: true,
		type: 'post',
		cache: false,
		dataType: 'json',
		error: function (xhr, textStatus, errorThrown) {
			var _errorRT = xhr.responseText;
			
			var errorText = $(_errorRT).children('div#primary').contents();
			$('#primaryContent').effect('drop', { direction: 'up', mode: 'hide' }, 500).html(errorText);
			$('#primaryContent').html(errorText);
			
			primaryContentShow('error', toActivate);
			
		},
		complete: function(xhr) {
			$('.ui-state-clickable, .ui-state-active, .ui-state-hover').removeClass('active').removeClass('ui-state-active').removeClass('ui-state-hover').removeClass('ui-state-focus').addClass('ui-state-default');
		},
		success: function(xhr) {
			
			if (xhr.error_code == 0) {
					$('#debugContent').effect('drop', { direction: 'up', mode: 'hide' }, 125).html(xhr.content_debug).fadeIn().effect('highlight');
					var errorStack = xhr.errorStack;
					if(Object.size(errorStack)){
						
						jQuery.each(errorStack, function(i, errorInfo) {
							errorStackDisplay(xhr.makerator_responseUID, xhr.response_filepath, errorInfo);
						});
					}
			} else {
					$('#debugContent').effect('drop', { direction: 'up', mode: 'hide' }, 125).html(xhr.content_debug).fadeIn().effect('highlight');
					var errorStack = xhr.errorStack;
					if(Object.size(errorStack)){
						jQuery.each(errorStack, function(i, errorInfo) {
							errorStackDisplay(xhr.makerator_responseUID, xhr.response_filepath, errorInfo);
						});
					} else {
							xhrErrorDisplay(xhr);
					}
			}
			$('#primaryContent').html(xhr.content_primary);
			
			setPageTitle(xhr.content_pageTitle);
			
			primaryContentShow(xhr.response_filepath, toActivate);
			
			if (xhr.scripts != '') {
				eval(xhr.scripts);
			}
		}
	});
}




$().ajaxComplete(function(ev, xhr, s) {
	var anchor = String(jQuery.url.attr('anchor'));
	signInFormInitializeForAjax();
	listeratorFormInitializeForAjax();
	anchorsActivateFocusStyles();
	applyClickableStyles();
	applyStriping();
/* 	console.log('errorStack:'  + xhr.errorStack); */
/* 	doErrorNotifications(xhr.errorStack); */
/*     alert('event type: ' + ev.type); */
/*     alert('status: ' + xhr.status); */
/*     alert('url: ' + s.url); */
});



function primaryContentShow() {
	$('#primaryContent').effect('slide', { direction: 'right', mode: 'show' }, 125);
	loadingIndicatorHide('#primaryContentWrapper');
	$.scrollTo({top: 0, left: 0}, 400);
}


function loadingIndicatorHide(block) {
		$(block + ' .ui-state-loading').fadeOut('fast', function(){
				$(block + ' .ui-state-loading').css({opacity: 0}).remove();
		});
}

function loadingIndicatorShow(block) {
		$(block + ' .ui-state-loading').fadeOut(10, function(){
				$(block + ' .ui-state-loading').css({opacity: 0}).remove();
		});
		var offset = $(block).offset();
		$(block).append('<span class="ui-state-loading"><strong>LOADING...<\/strong><\/span>');
		
		$(block + ' .ui-state-loading').css({
			position: 'fixed',
			left: (offset.left - 58),
			top: (offset.top - 8)
		}).fadeIn(10);
}


function toggleDebugLayoutStyles( ) {
		$('head link[rel="stylesheet"]:last').after('<link rel="stylesheet" type="text/css" href="/assets/css/modules/debugLayout.css">');
		$('head link[href="/assets/css/modules/debugLayout.css"]').remove();
}







function listeratorFormInitializeForAjax() {
	var patt2 = new RegExp('(/makerator_admin/)(\S)*');
	var patt3 = new RegExp('(/create|edit/)');
	var anchor = String(jQuery.url.attr('anchor'));
	var myBoolean2 = patt2.test(anchor);
	var myBoolean3 = patt3.test(anchor);
	if (myBoolean2 == true && myBoolean3 == true) {
		formKillFocusStyles('#listeratorForm');
		formActivateFocusStyles('');
		$("#revertListerator").unbind();
		formLockResetButton('#listeratorForm');
		
		
		
/* 		jQuery("#reset").click(function() { */
/* 			v.resetForm(); */
/* 		}); */
		
		
		
		var listeratorFormValidated = $("#listeratorForm").validate({
				debug: false
			,	submitHandler: function(form) {
					var options = {
						target: '#primaryContent'
					,	dataType: 'json'
					,	beforeSubmit: listeratorFormBeforeSubmit
					,	success: listeratorFormResponseShow
					,	error: listeratorFormError
					
					};
					$("#saveListerator").unbind().click(function(){
						jQuery(form).ajaxSubmit(options);
					});
				}
			,	errorElement: 'label'
			,	errorClass: 'ui-widget-content ui-corner-all ui-state-highlight ui-state-invalid'
			,	messageWrapperElement: 'p'
			,	messages: {
					Keyword_URL: {
						alphanumeric: jQuery.format('<q>{0}</q> contains invalid characters.<br>URL Keywords may contain letters, numbers, hyphens and underscrores, but no spaces or punctuation. <a href="/makerator_admin/help/Keyword_URL/" title="Help is available">Tips &amp; Tricks</a>')
					,	remote: jQuery.format('<q>{0}</q> is already taken, please enter a different Keyword URL.')
					},
					'Date': {
						remote: jQuery.format('<q>{0}</q> is not a valid date.')
					}
				}
			,	focusCleanup: false
			,	focusInvalid: false
		});
		
		$('input.datetime').datepicker('destroy').datepicker({
			showButtonPanel: true
		,	dateFormat: 'yy-mm-dd'
		,	showOptions: {direction: 'up' }
		});
		
		function showTitlePullButton(  ) {
/* 			$('#Keyword_URL').bind('keypress', */
/* 			function(e) { */
				var currentKeywordUrlValue = $('#Keyword_URL').val();
				var potentialKeywordUrlValue = friendlyToURLConversion($('.createKeywordUrlFromTitle').val());
				if(potentialKeywordUrlValue != currentKeywordUrlValue){
					$('#makeKeywordUrlMatch').fadeIn(250);
				}
				$('#makeKeywordUrlMatch').click(function (event) {
					event.preventDefault();
					var currentKeywordUrlValue = $('#Keyword_URL').val();
					var potentialKeywordUrlValue = friendlyToURLConversion($('.createKeywordUrlFromTitle').val());
					$('#Keyword_URL').val(potentialKeywordUrlValue);
					$('#Keyword_URL').parent().stop({goToEnd: true})
					.effect('bounce', { times:1, distance: 4, direction: 'left' }, 8)
					.effect('bounce', { times:1, distance: 4, direction: 'right' }, 7)
					.effect('bounce', { times:1, distance: 2, direction: 'left' }, 6)
					.effect('bounce', { times:1, distance: 2, direction: 'right' }, 5);
					$('#Keyword_URL').focus();
				});
				
/* 				if(event.keyCode == 13) { */
/* 					$('#makeKeywordUrlMatch').trigger('click'); */
/* 				} */
				return false;
/* 			}); */
		}
		
		$('#Keyword_URL').bind('focus', function ( ) {
			$('#makeKeywordUrlMatch').length == 0 ? $('#Keyword_URL').after('<button id="makeKeywordUrlMatch" class="ui-state-hidden ui-state-clickable ui-state-default ui-corner-all">Pull from Title</button>'): '';
			showTitlePullButton();
		});
		$('#Keyword_URL').bind('keypress', function (event) {
			$('#makeKeywordUrlMatch').length == 0 ? $('#Keyword_URL').after('<button id="makeKeywordUrlMatch" class="ui-state-hidden ui-state-clickable ui-state-default ui-corner-all">Pull from Title</button>'): '';
			if(event.keyCode == 13) {
				$('#makeKeywordUrlMatch').trigger('click');
			}
			showTitlePullButton();
		});
		$('#Keyword_URL').bind('blur', function ( ) {
			var currentKeywordUrlValue = $('#Keyword_URL').val();
			var potentialKeywordUrlValue = friendlyToURLConversion(currentKeywordUrlValue);
			$('#Keyword_URL').val(potentialKeywordUrlValue);
			
			$('#makeKeywordUrlMatch').fadeOut(250);
		});
	} else {
	}
}

function listeratorFormError(xhr) {
		var _errorRT = xhr.responseText;
		
		var errorText = $(_errorRT).children('div#primary').contents();
		$('#primaryContent').html(errorText);
		
		primaryContentShow('error', toActivate);
}

function listeratorFormBeforeSubmit(formData, jqForm, options) {
	// formData is an array; here we use $.param to convert it to a string to display it 
	// but the form plugin does this for you automatically when it submits the data 
	var queryString = $.param(formData);
	// jqForm is a jQuery object encapsulating the form element.  To access the 
	// DOM element for the form do this: 
	// var formElement = jqForm[0];
	
	
	
	var formElement = jqForm[0];
	console.log("formElement;      // " + formElement);
	
	
	var patt = new RegExp('reset=reset');
	var doNotSubmitForm = patt.test(queryString);
	if (doNotSubmitForm) {
		$('input.datetime').datepicker('destroy').datepicker({
			showButtonPanel: true
		,	dateFormat: 'yy-mm-dd'
		,	showOptions: {direction: 'up' }
		});
		if ($('#revertListerator').hasClass('ui-state-default')) {
			$('#revertListerator').effect('transfer',{ to: '#listeratorForm', className: 'ui-effects-transfer' }, 250, function () {
				$('#listeratorForm').addClass('ui-state-disabled');
				loadingIndicatorShow('#primaryContentWrapper');
				var anchor = jQuery.url.attr('anchor').toLowerCase();
				var toLoad = anchor + 'reset/';
				var toActivate = null;
				formKillFocusStyles('#listeratorForm');
				primaryContentLoad(toLoad, toActivate);
				return false;
			});
		} else {
			
			// listeratorFormInitializeForAjax();
			formKillFocusStyles('#listeratorForm');
			formActivateFocusStyles('#listeratorForm');
			return false;
		}
	} else {
		$('input.date').datepicker('destroy');
		$('#listeratorForm').addClass('ui-state-disabled');
		formKillFocusStyles('#listeratorForm');
		loadingIndicatorShow('#primaryContentWrapper');
		return true;
	}
	
	
}

function listeratorFormResponseShow(xhr) {
	$('#debugContent').fadeOut().html(xhr.content_debug).fadeIn().effect('highlight');
	$('#primaryContent').effect('transfer',{ to: '#saveListerator', className: 'ui-effects-transfer' }, 250).html(xhr.content_primary);
	if (xhr.error_code == 0) {
		var errorStack = xhr.errorStack;
		if (Object.size(errorStack)) {
			jQuery.each(errorStack,
			function(i, errorInfo) {
				errorStackDisplay(xhr.makerator_responseUID, xhr.response_filepath, errorInfo);
			});
			listeratorFormInitializeForAjax();
		} else {
			listeratorFormInitializeForAjax();
			if (xhr.listeratorExitTo != 'undefined') {
				if (xhr.listeratorVerb != 'undefined') {
					if (xhr.listeratorVerb === 'create' && xhr.response_filepath != xhr.listeratorExitTo) {
						listeratorCreated();
						window.location.hash = xhr.listeratorExitTo
					}
					if (xhr.listeratorVerb === 'edit') {
						listeratorSaved();
						window.location.hash = xhr.listeratorExitTo
					}
				}
			}
		}
	} else {
		var errorStack = xhr.errorStack;
		if (Object.size(errorStack)) {
			jQuery.each(errorStack,
			function(i, errorInfo) {
				errorStackDisplay(xhr.makerator_responseUID, xhr.response_filepath, errorInfo);
			});
		} else {
			xhrErrorDisplay(xhr);
		}
	}
	if (xhr.scripts != '') {
		eval(xhr.scripts);
	} else {}
	loadingIndicatorHide('#primaryContentWrapper');
	primaryContentShow();
	$('#listeratorForm').removeClass('ui-state-disabled');
}


/* 	primaryContentShow(xhr.response_filepath, toActivate); */
/* 	 */
/* 	if (xhr.scripts != '') { */
/* 		eval(xhr.scripts); */
/* 	} */
/*  */
/*  */
/* 	if (xhr.error_msg == 'No error') { */
/* 		listeratorSaved(); */
/* 		// xhrResponseDisplay(xhr); */
/* 		$('#primaryContent').html(xhr.content_primary); */
/* 		 */
/* 		listeratorFormInitializeForAjax(); */
/* 	} else { */
/* 		$('#primaryContent').html(xhr.content_primary); */
/* 		xhrErrorDisplay(xhr); */
/* 		listeratorFormInitializeForAjax(); */
/* 	} */


function signInFormInitializeForAjax() {
	var anchor = String(jQuery.url.attr('anchor'));
	var patt2 = new RegExp('(/account/)(\S)*');
	var myBoolean2 = patt2.test(anchor);
	if (myBoolean2 == true) {
		formKillFocusStyles('#signInForm');
		formActivateFocusStyles('#signInForm');
		formLockResetButton('#signInForm');
		var options = {
			target: '#primaryContent'
		,	dataType: 'json'
		,	beforeSubmit: signInFormBeforeSubmit
		,	success: signInFormResponseShow
		};
		$('#signInForm').ajaxForm(options);
	} else {
/* 		console.log('not initializing, anchor:'  + anchor); */
	}
}

function signInFormBeforeSubmit(formData, jqForm, options) {
	// formData is an array; here we use $.param to convert it to a string to display it 
	// but the form plugin does this for you automatically when it submits the data 
	var queryString = $.param(formData);
	// jqForm is a jQuery object encapsulating the form element.  To access the 
	// DOM element for the form do this: 
	// var formElement = jqForm[0]; 
	var patt = new RegExp('reset=reset');
	var doNotSubmitForm = patt.test(queryString);
	if (doNotSubmitForm) {
		if ($('#revertListerator').hasClass('ui-state-default')) {
			loadingIndicatorShow('#primaryContentWrapper');
			formKillFocusStyles('#signInForm');
			var anchor = jQuery.url.attr('anchor').toLowerCase();
			var toLoad = anchor + 'reset/';
			var toActivate = null;
			primaryContentLoad(toLoad, toActivate);
/* 			$('#primaryContent').fadeOut('fast', primaryContentLoad(toLoad, toActivate)); */
			return false;
		} else {
			
			// listeratorFormInitializeForAjax();
			formKillFocusStyles('#signInForm');
			formActivateFocusStyles('#signInForm');
			return false;
		}
	} else {
		loadingIndicatorShow('#primaryContentWrapper');
		formKillFocusStyles('#signInForm');
		$('.loader a.active').each(function() {
			$(this).removeClass('active');
		});
		return true;
	}
}

function signInFormResponseShow(xhr) {
	
	$('#primaryContent').html(xhr.content_primary);
	//primaryContentShow();
	if (xhr.error_msg == 'No error') {
		xhrResponseDisplay(xhr);
		
		window.location.hash = '/account/sign_in/success/';
	} else {
		xhrErrorDisplay(xhr);
		signInFormInitializeForAjax();
		window.location.hash = '/account/sign_in/error/';
	}
	if (xhr.scripts != '') {
		eval(xhr.scripts);
	} else {}
	
	loadingIndicatorHide('#primaryContentWrapper');
	
}




/* function signInFormResponseShow(xhr) { */
/* 	console.log('xhr.error_msg:'  + xhr.error_msg); */
/* 	console.log('xhr.content_primary:'  + xhr.content_primary); */
/* 	if (xhr.error_msg == 'No error') { */
/* 			window.location.hash = '/account/sign_in/success/'; */
/* 			xhrResponseDisplay(xhr); */
/* 			loadInitialContent(); */
/* 	} else { */
/* 			xhrErrorDisplay(xhr); */
/* 			window.location.hash = '/account/sign_in/error/'; */
/* 			loadInitialContent(); */
/* 			signInFormInitializeForAjax(); */
/* 	} */
/* 	 */
/* 	if (xhr.scripts != '') { */
/* 			eval(xhr.scripts); */
/* 	} else { */
/* 	 */
/* 	} */
/* } */

function formUnformLockResetButton(formID) {
	var theFormID = formID;
	if($('#revertListerator').hasClass('ui-state-disabled')){
			$('#revertListerator').removeClass('ui-state-disabled');
			var newText = $('#revertListerator').attr('title');
			$('#revertListerator span.ui-button-label').fadeOut().attr('title','Click to revert to the last saved version.').text(newText).fadeIn();
			$('#revertListerator').children('.ui-icon-locked').removeClass('ui-icon-locked');
			$('#revertListerator').addClass('ui-state-default');
			$(theFormID + ' #revertListerator').one('click',
				function(event) {
					event.preventDefault();
					if ($('#revertListerator').hasClass('ui-state-default')) {
						$('#revertListerator').effect('transfer',{ to: '#listeratorForm', className: 'ui-effects-transfer' }, 250, function () {
							$('#listeratorForm').addClass('ui-state-disabled');
							loadingIndicatorShow('#primaryContentWrapper');
							var anchor = jQuery.url.attr('anchor').toLowerCase();
							var toLoad = anchor + 'reset/';
							var toActivate = null;
							formKillFocusStyles('#listeratorForm');
							primaryContentLoad(toLoad, toActivate);
							return false;
						});
/* 						$('#listeratorForm').addClass('ui-state-disabled'); */
/* 						loadingIndicatorShow('#primaryContentWrapper'); */
/* 						var anchor = jQuery.url.attr('anchor').toLowerCase(); */
/* 						var toLoad = anchor + 'reset/'; */
/* 						var toActivate = null; */
/* 						formKillFocusStyles('#listeratorForm'); */
/* 						primaryContentLoad(toLoad, toActivate); */
					} else {
						
						// listeratorFormInitializeForAjax();
						formKillFocusStyles('#listeratorForm');
						formActivateFocusStyles('#listeratorForm');
						formLockResetButton('#listeratorForm');
					}
			});
	} else {
	}
}

function formLockResetButton(formID) {
	var theFormID = formID;
	if($(theFormID + ' #revertListerator').hasClass('ui-state-disabled')) {
		
	} else {
			$(theFormID + ' #revertListerator').addClass('ui-state-disabled');
			var newText = $('#revertListerator').attr('title');
			$('#revertListerator span.ui-button-label').fadeOut().text(newText + ' (disabled)').attr('title','Click to enable.').fadeIn();
			$(theFormID + ' #revertListerator').removeClass('ui-state-default');
			$(theFormID + ' #revertListerator').children('.ui-icon').addClass('ui-icon-locked');
	}
	
	$(theFormID + ' #revertListerator').one('click',
		function(event) {
			event.preventDefault();
			if($(theFormID + ' #revertListerator').hasClass('ui-state-disabled')){
					formUnformLockResetButton('#listeratorForm');
			}
/* 			$(this).one('click', */
/* 			function(event) { */
/* 				console.log("reset here??"); */
/* 				event.preventDefault(); */
/* 			}); */
	});
}

function formActivateFocusStyles(formID) {
	var theFormID = formID;
	$(formID).removeClass('ui-state-disabled');
	$(formID + ' input, ' + formID + ' textarea').each(function(i) {
		$(this).blur(function() {
			$(this).removeClass('ui-state-hover');
			$(this).siblings('label').removeClass('ui-state-hover');
			$(this).removeClass('ui-state-highlight');
			$(this).removeClass('ui-state-focus');
			$(this).siblings('label:not(.ui-state-invalid)').removeClass('ui-state-highlight');
			$(this).siblings('label:not(.ui-state-invalid)').removeClass('ui-state-focus');
			formLockResetButton(theFormID);
		});
		$(this).focus(function() {
			$(this).removeClass('ui-state-hover');
			$(this).siblings('label').removeClass('ui-state-hover');
			$(this).addClass('ui-state-highlight');
			$(this).addClass('ui-state-focus');
			$(this).siblings('label:not(.ui-state-invalid)').addClass('ui-state-highlight');
			$(this).siblings('label:not(.ui-state-invalid)').addClass('ui-state-focus');
			formLockResetButton(theFormID);
		});
		$(this).mouseover(function() {
			$(this).addClass('ui-state-hover');
			$(this).siblings('label:not(.ui-state-invalid)').addClass('ui-state-hover');
		});
		$(this).mouseout(function() {
			$(this).removeClass('ui-state-hover');
			$(this).siblings('label:not(.ui-state-invalid)').removeClass('ui-state-hover');
		});
		$(this).siblings('label:not(.ui-state-invalid)').mouseover(function() {
			$(this).addClass('ui-state-hover');
			$(this).siblings('label:not(.ui-state-invalid)').addClass('ui-state-hover');
		});
		$(this).siblings('label:not(.ui-state-invalid)').mouseout(function() {
			$(this).removeClass('ui-state-hover');
			$(this).siblings('label:not(.ui-state-invalid)').removeClass('ui-state-hover');
		});
	});
}

function formKillFocusStyles(formID) {
	var theFormID = formID;
	$(formID + ' input, ' + formID + ' textarea').each(function(i) {
		$(this).unbind();
		$(this).siblings('label:not(.ui-state-invalid)').unbind();
	});
}


function errorStackDisplay(id, path, errorInfo) {
	var thisNotificationID = id;
	var path = path;
	var errorInfo = errorInfo;
	var out = '';
	if(Object.size(errorInfo)){
		jQuery.each(errorInfo, function(key, value) {
			out += '<p><strong>' + key + ':</strong> ' + value + '</p>'
		});
	}
	$('<div id="' + thisNotificationID + '" title="' + 'Error: ' + path + '"><p>' + out + '</p></div>')
		.appendTo('body')
		.notification({
			show: 'highlight'
		,	speed: 1500
		,	notificationClass: 'ui-state-error'
		,	position: [20,10]
		,	width: 520
	});
}

function xhrErrorDisplay( xhr ) {
	var thisNotificationID = xhr.makerator_responseUID;
	$('<div id="' + thisNotificationID + '" title="' + 'Error from ' + xhr.response_filepath + '"><p>' + xhr.error_msg + '</p></div>')
		.appendTo('body')
		.notification({
			show: 'highlight'
		,	speed: 1500
		,	notificationClass: 'ui-state-error'
		,	position: [20,10]
		,	width: 520
	});
}

/* function xhrErrorDisplay( xhr ) { */
/* 		$.jGrowl(xhr.error_msg, { */
/* 			header: 'Error loading ' + xhr.response_filepath + '!' */
/* 		,	theme: 'error' */
/* 		,	closeTemplate: '<strong class="ui-helper-hidden-accessible">&times;</strong>' */
/* 		,	life: 5000 */
/* 		,	sticky: true */
/* 		,	speed: 250 */
/* 		}); */
/* } */

function xhrResponseDisplay( xhr ) {
		$.jGrowl(xhr.accept_header, {
			header: 'Loaded "' + xhr.response_filepath + '"', 
			theme: 'iphone',
			life: 5000,
			sticky: false
		});
}

function listeratorSaved( xhr ) {
		$.jGrowl('<p><span class="ui-icon ui-icon-info ui-icon-left"><strong class="ui-helper-hidden-accessible"></strong></span><strong>Saved!</strong> Your data was successfully saved.</p>', {
			theme: 'ui-state-highlight',
			life: 5000,
			sticky: false
		});
}

function listeratorCreated( xhr ) {
		$.jGrowl('<p><span class="ui-icon ui-icon-info ui-icon-left"><strong class="ui-helper-hidden-accessible"></strong></span><strong>Success!</strong> Your data was successfully created.</p>', {
			theme: 'ui-state-highlight',
			life: 5000,
			sticky: false
		});
}

function setMakeratorOption(optionName, optionValue) {
	$.ajax({
		url: '/'
	,	data: {
			setOption: 'true'
		,	name: optionName
		,	value: optionValue
		,	dataType: 'json'
		}
	,	async: true
	,	type: 'get'
	,	cache: false
	,	dataType: 'json'
	,	success: function(xhr) {
			if (xhr.error_msg == 'No error') {
						xhrResponseDisplay(xhr);
			} else {
						xhrErrorDisplay(xhr);
			}
		}
	});
}


function setPageTitle( newTitle ) {
	$('head title').html(newTitle.toTitleCase());
}