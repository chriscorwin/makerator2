/*
 * jQuery UI Notification 1.7.0
 *
 * Copyright (c) 2009 AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 * http://docs.jquery.com/UI/Notification
 *
 * Depends:
 *	ui.core.js
 *	ui.draggable.js
 *	ui.resizable.js
 */
(function($) {

var setDataSwitch = {
		dragStart: "start.draggable",
		drag: "drag.draggable",
		dragStop: "stop.draggable",
		maxHeight: "maxHeight.resizable",
		minHeight: "minHeight.resizable",
		maxWidth: "maxWidth.resizable",
		minWidth: "minWidth.resizable",
		resizeStart: "start.resizable",
		resize: "drag.resizable",
		resizeStop: "stop.resizable"
	},
	
	uiNotificationClasses =
		'ui-notification ' +
		'ui-widget ' +
		'ui-widget-content ' +
		'ui-corner-all ';

$.widget("ui.notification", {

	_init: function() {
		this.originalTitle = this.element.attr('title');
		
		if($('#ui-notifications').length == 0) {
			$(document.body).prepend('<div id="ui-notifications">&nbsp;</div>');
			$('#ui-notifications')
				.addClass('ui-widget ui-corner-all')
				.css({
					position: 'fixed'
				,	zIndex: this.options.zIndex
				})
				.andSelf().position(this.options.position);

		}

		var self = this,
			options = self.options,

			title = options.title || self.originalTitle || '&nbsp;',
			titleId = $.ui.notification.getTitleId(self.element),

			uiNotification = (self.uiNotification = $('<div></div>'))
				.appendTo('#ui-notifications')
				.hide()
				.addClass(uiNotificationClasses + options.notificationClass)
				.css({
					position: 'relative',
					overflow: 'hidden',
					zIndex: options.zIndex
				})
				// setting tabIndex makes the div focusable
				// setting outline to 0 prevents a border on focus in Mozilla
				.attr('tabIndex', -1).css('outline', 0).keydown(function(event) {
					(options.closeOnEscape && event.keyCode
						&& event.keyCode == $.ui.keyCode.ESCAPE && self.close(event));
				})
				.attr({
					role: 'notification',
					'aria-labelledby': titleId
				})
				.mousedown(function(event) {
					self.moveToTop(false, event);
				}),

			uiNotificationContent = self.element
				.show()
				.removeAttr('title')
				.addClass(
					'ui-notification-content ' +
					'ui-widget-content')
				.appendTo(uiNotification),

			uiNotificationTitlebar = (self.uiNotificationTitlebar = $('<div></div>'))
				.addClass(
					'ui-notification-titlebar ' +
					'ui-widget-header ' +
					'ui-corner-all ' +
					'ui-helper-clearfix'
				)
				.prependTo(uiNotification),

			uiNotificationTitlebarClose = $('<a href="#"></a>')
				.addClass(
					'ui-notification-titlebar-close ' +
					'ui-corner-all'
				)
				.attr('role', 'button')
				.hover(
					function() {
						uiNotificationTitlebarClose.addClass('ui-state-hover');
					},
					function() {
						uiNotificationTitlebarClose.removeClass('ui-state-hover');
					}
				)
				.focus(function() {
					uiNotificationTitlebarClose.addClass('ui-state-focus');
				})
				.blur(function() {
					uiNotificationTitlebarClose.removeClass('ui-state-focus');
				})
				.mousedown(function(ev) {
					ev.stopPropagation();
				})
				.click(function(event) {
					self.close(event);
					return false;
				})
				.appendTo(uiNotificationTitlebar),

			uiNotificationTitlebarCloseText = (self.uiNotificationTitlebarCloseText = $('<span></span>'))
				.addClass(
					'ui-icon ' +
					'ui-icon-closethick'
				)
				.text(options.closeText)
				.appendTo(uiNotificationTitlebarClose),

			uiNotificationTitle = $('<span></span>')
				.addClass('ui-notification-title')
				.attr('id', titleId)
				.html(title)
				.prependTo(uiNotificationTitlebar);

		uiNotificationTitlebar.find("*").add(uiNotificationTitlebar).disableSelection();

		(options.draggable && $.fn.draggable && self._makeDraggable());
		(options.resizable && $.fn.resizable && self._makeResizable());

		self._createButtons(options.buttons);
		self._isOpen = false;

		(options.bgiframe && $.fn.bgiframe && uiNotification.bgiframe());
		(options.autoOpen && self.open());
	},

/* 	update: function() { */
/* 		var self = this; */
/*  */
/* 		self.bind("mouseover.notification", */
/* 			function() { */
/* 				self.data("notification").pause = true; */
/* 			}).bind("mouseout.notification", */
/* 			function() { */
/* 				self.data("notification").pause = false; */
/* 		}); */
/*  */
/*  */
/* 		$(this.element).find('div.notification-notification:parent').each(function() { */
/* 			if (self.data("notification") != undefined && self.data("notification")._isOpen != undefined && (self.data("notification")._isOpen.getTime() + self.data("notification").life) < (new Date()).getTime() && self.data("notification").sticky != true && (self.data("notification").pause == undefined || self.data("notification").pause != true)) { */
/* 				self._trigger */
/* 				self.trigger('notification.close'); */
/* 			} */
/* 		}); */
/* 		if (this.notifications.length > 0 && (this.defaults.pool == 0 || $(this.element).find('div.notification-notification:parent').size() < this.defaults.pool)) { */
/* 			this.render(this.notifications.shift()); */
/* 		} */
/* 		if ($(this.element).find('div.notification-notification:parent').size() < 2) { */
/* 			$(this.element).find('div.notification-closer').animate(this.defaults.animateClose, this.defaults.speed, this.defaults.easing, */
/* 			function() { */
/* 				self.remove(); */
/* 			}); */
/* 		}; */
/* 	}, */


	destroy: function() {
		var self = this;
		
		(self.overlay && self.overlay.destroy());
		self.uiNotification.hide();
		self.element
			.unbind('.notification')
			.removeData('notification')
			.removeClass('ui-notification-content ui-widget-content')
			.hide().appendTo('body');
		self.uiNotification.remove();

		(self.originalTitle && self.element.attr('title', self.originalTitle));

		return self;
	},

	close: function(event) {
		var self = this;
		
		if (false === self._trigger('beforeclose', event)) {
			return;
		}

		(self.overlay && self.overlay.destroy());
		self.uiNotification.unbind('keypress.ui-notification');

		(self.options.hide
			? self.uiNotification.hide(self.options.hide, function() {
				self._trigger('close', event);
			})
			: self.uiNotification.hide() && self._trigger('close', event));

		$.ui.notification.overlay.resize();

		self._isOpen = false;

		// adjust the maxZ to allow other modal notifications to continue to work (see #4309)
		if (self.options.modal) {
			var maxZ = 0;
			$('.ui-notification').each(function() {
				if (this != self.uiNotification[0]) {
					maxZ = Math.max(maxZ, $(this).css('z-index'));
				}
			});
			$.ui.notification.maxZ = maxZ;
		}

		return self;
	},

	isOpen: function() {
		return this._isOpen;
	},

	// the force parameter allows us to move modal notifications to their correct
	// position on open
	moveToTop: function(force, event) {
		var self = this,
			options = self.options;
		
		if ((options.modal && !force)
			|| (!options.stack && !options.modal)) {
			return self._trigger('focus', event);
		}
		
		if (options.zIndex > $.ui.notification.maxZ) {
			$.ui.notification.maxZ = options.zIndex;
		}
		(self.overlay && self.overlay.$el.css('z-index', $.ui.notification.overlay.maxZ = ++$.ui.notification.maxZ));

		//Save and then restore scroll since Opera 9.5+ resets when parent z-Index is changed.
		//  http://ui.jquery.com/bugs/ticket/3193
		var saveScroll = { scrollTop: self.element.attr('scrollTop'), scrollLeft: self.element.attr('scrollLeft') };
		self.uiNotification.css('z-index', ++$.ui.notification.maxZ);
		self.element.attr(saveScroll);
		self._trigger('focus', event);

		return self;
	},

	open: function() {
		if (this._isOpen) { return; }

		var self = this,
			options = self.options,
			uiNotification = self.uiNotification;

		self.overlay = options.modal ? new $.ui.notification.overlay(self) : null;
		(uiNotification.next().length && uiNotification.appendTo('body'));
		self._size();
		self._position(options.position);
		uiNotification.show(options.show).fadeIn(options.speed);
		self.moveToTop(true);

		// prevent tabbing out of modal notifications
		(options.modal && uiNotification.bind('keypress.ui-notification', function(event) {
			if (event.keyCode != $.ui.keyCode.TAB) {
				return;
			}

			var tabbables = $(':tabbable', this),
				first = tabbables.filter(':first'),
				last  = tabbables.filter(':last');

			if (event.target == last[0] && !event.shiftKey) {
				first.focus(1);
				return false;
			} else if (event.target == first[0] && event.shiftKey) {
				last.focus(1);
				return false;
			}
		}));

		// set focus to the first tabbable element in the content area or the first button
		// if there are no tabbable elements, set focus on the notification itself
		$([])
			.add(uiNotification.find('.ui-notification-content :tabbable:first'))
			.add(uiNotification.find('.ui-notification-buttonpane :tabbable:first'))
			.add(uiNotification)
			.filter(':first')
			.focus();

		self._trigger('open');
		self._isOpen = true;

		return self;
	},

	_createButtons: function(buttons) {
		var self = this,
			hasButtons = false,
			uiNotificationButtonPane = $('<div></div>')
				.addClass(
					'ui-notification-buttonpane ' +
					'ui-widget-content ' +
					'ui-helper-clearfix'
				);

		// if we already have a button pane, remove it
		self.uiNotification.find('.ui-notification-buttonpane').remove();

		(typeof buttons == 'object' && buttons !== null &&
			$.each(buttons, function() { return !(hasButtons = true); }));
		if (hasButtons) {
			$.each(buttons, function(name, fn) {
				$('<button type="button"></button>')
					.addClass(
						'ui-state-default ' +
						'ui-corner-all'
					)
					.text(name)
					.click(function() { fn.apply(self.element[0], arguments); })
					.hover(
						function() {
							$(this).addClass('ui-state-hover');
						},
						function() {
							$(this).removeClass('ui-state-hover');
						}
					)
					.focus(function() {
						$(this).addClass('ui-state-focus');
					})
					.blur(function() {
						$(this).removeClass('ui-state-focus');
					})
					.appendTo(uiNotificationButtonPane);
			});
			uiNotificationButtonPane.appendTo(self.uiNotification);
		}
	},

	_makeDraggable: function() {
		var self = this,
			options = self.options,
			heightBeforeDrag;

		self.uiNotification.draggable({
			cancel: '.ui-notification-content',
			handle: '.ui-notification-titlebar',
			containment: 'document',
			start: function() {
				heightBeforeDrag = options.height;
				$(this).height($(this).height()).addClass("ui-notification-dragging");
				(options.dragStart && options.dragStart.apply(self.element[0], arguments));
			},
			drag: function() {
				(options.drag && options.drag.apply(self.element[0], arguments));
			},
			stop: function() {
				$(this).removeClass("ui-notification-dragging").height(heightBeforeDrag);
				(options.dragStop && options.dragStop.apply(self.element[0], arguments));
				$.ui.notification.overlay.resize();
			}
		});
	},

	_makeResizable: function(handles) {
		handles = (handles === undefined ? this.options.resizable : handles);
		var self = this,
			options = self.options,
			resizeHandles = typeof handles == 'string'
				? handles
				: 'n,e,s,w,se,sw,ne,nw';

		self.uiNotification.resizable({
			cancel: '.ui-notification-content',
			alsoResize: self.element,
			maxWidth: options.maxWidth,
			maxHeight: options.maxHeight,
			minWidth: options.minWidth,
			minHeight: options.minHeight,
			start: function() {
				$(this).addClass("ui-notification-resizing");
				(options.resizeStart && options.resizeStart.apply(self.element[0], arguments));
			},
			resize: function() {
				(options.resize && options.resize.apply(self.element[0], arguments));
			},
			handles: resizeHandles,
			stop: function() {
				$(this).removeClass("ui-notification-resizing");
				options.height = $(this).height();
				options.width = $(this).width();
				(options.resizeStop && options.resizeStop.apply(self.element[0], arguments));
				$.ui.notification.overlay.resize();
			}
		})
		.find('.ui-resizable-se').addClass('ui-icon ui-icon-grip-diagonal-se');
	},

	_position: function(pos) {
		var wnd = $(window), doc = $(document),
			pTop = doc.scrollTop(), pLeft = doc.scrollLeft(),
			minTop = pTop,
			uiNotification = this.uiNotification;

		if ($.inArray(pos, ['center','top','right','bottom','left']) >= 0) {
			pos = [
				pos == 'right' || pos == 'left' ? pos : 'center',
				pos == 'top' || pos == 'bottom' ? pos : 'middle'
			];
		}
		if (pos.constructor != Array) {
			pos = ['center', 'middle'];
		}
		if (pos[0].constructor == Number) {
			pLeft += pos[0];
		} else {
			switch (pos[0]) {
				case 'left':
					pLeft += 0;
					break;
				case 'right':
					pLeft += wnd.width() - uiNotification.outerWidth();
					break;
				default:
				case 'center':
					pLeft += (wnd.width() - uiNotification.outerWidth()) / 2;
			}
		}
		if (pos[1].constructor == Number) {
			pTop += pos[1];
		} else {
			switch (pos[1]) {
				case 'top':
					pTop += 0;
					break;
				case 'bottom':
					pTop += wnd.height() - uiNotification.outerHeight();
					break;
				default:
				case 'middle':
					pTop += (wnd.height() - uiNotification.outerHeight()) / 2;
			}
		}

		// prevent the notification from being too high (make sure the titlebar
		// is accessible)
		pTop = Math.max(pTop, minTop);
		uiNotification.css({top: pTop, left: pLeft});
	},

	_setData: function(key, value){
		var self = this,
			uiNotification = self.uiNotification;
		
		(setDataSwitch[key] && uiNotification.data(setDataSwitch[key], value));
		switch (key) {
			case "buttons":
				self._createButtons(value);
				break;
			case "closeText":
				self.uiNotificationTitlebarCloseText.text(value);
				break;
			case "notificationClass":
				uiNotification
					.removeClass(self.options.notificationClass)
					.addClass(uiNotificationClasses + value);
				break;
			case "draggable":
				(value
					? self._makeDraggable()
					: uiNotification.draggable('destroy'));
				break;
			case "height":
				uiNotification.height(value);
				break;
			case "position":
				self._position(value);
				break;
			case "resizable":
				var isResizable = uiNotification.is(':data(resizable)');

				// currently resizable, becoming non-resizable
				(isResizable && !value && uiNotification.resizable('destroy'));

				// currently resizable, changing handles
				(isResizable && typeof value == 'string' &&
					uiNotification.resizable('option', 'handles', value));

				// currently non-resizable, becoming resizable
				(isResizable || self._makeResizable(value));
				break;
			case "title":
				$(".ui-notification-title", self.uiNotificationTitlebar).html(value || '&nbsp;');
				break;
			case "width":
				uiNotification.width(value);
				break;
		}

		$.widget.prototype._setData.apply(self, arguments);
	},

	_size: function() {
		/* If the user has resized the notification, the .ui-notification and .ui-notification-content
		 * divs will both have width and height set, so we need to reset them
		 */
		var options = this.options;

		// reset content sizing
		this.element.css({
			height: 0,
			minHeight: 0,
			width: 'auto'
		});

		// reset wrapper sizing
		// determine the height of all the non-content elements
		var nonContentHeight = this.uiNotification.css({
				height: 'auto',
				width: options.width
			})
			.height();

		this.element
			.css({
				minHeight: Math.max(options.minHeight - nonContentHeight, 0),
				height: options.height == 'auto'
					? 'auto'
					: Math.max(options.height - nonContentHeight, 0)
			});
	}
});


$.extend(
	$.ui.notification, {
		version: "1.7.0"
	,	instances: []
	,	defaults: {
			autoOpen: true
		,	bgiframe: false
		,	buttons: {}
		,	closeOnEscape: true
		,	closeText: 'close'
		,	notificationClass: ''
		,	draggable: true
		,	hide: null
		,	height: 'auto'
		,	maxHeight: false
		,	maxWidth: false
		,	minHeight: 40
		,	minWidth: 150
		,	modal: false
		,	position: 'center'
		,	resizable: true
		,	show: null
		,	stack: true
		,	title: ''
		,	width: 300
		,	zIndex: 1000
		
		,	life: 3000
		,	speed: 'normal'
		,	easing: 'swing'
		,	theme: 'default'
	
	}
	,	uuid: 0
	,	maxZ: 0
	,	getTitleId: function($el) {
		return 'ui-notification-title-' + ($el.attr('id') || ++this.uuid);
	}
	,	overlay: function(notification) {
		this.$el = $.ui.notification.overlay.create(notification);
	}
});

$.extend($.ui.notification.overlay, {
	instances: [],
	maxZ: 0,
	events: $.map('focus,mousedown,mouseup,keydown,keypress,click'.split(','),
		function(event) { return event + '.notification-overlay'; }).join(' '),
	create: function(notification) {
		if (this.instances.length === 0) {
			// prevent use of anchors and inputs
			// we use a setTimeout in case the overlay is created from an
			// event that we're going to be cancelling (see #2804)
			setTimeout(function() {
				// handle $(el).notification().notification('close') (see #4065)
				if ($.ui.notification.overlay.instances.length) {
					$(document).bind($.ui.notification.overlay.events, function(event) {
						var notificationZ = $(event.target).parents('.ui-notification').css('zIndex') || 0;
						return (notificationZ > $.ui.notification.overlay.maxZ);
					});
				}
			}, 1);

			// allow closing by pressing the escape key
			$(document).bind('keydown.notification-overlay', function(event) {
				(notification.options.closeOnEscape && event.keyCode
						&& event.keyCode == $.ui.keyCode.ESCAPE && notification.close(event));
			});

			// handle window resize
			$(window).bind('resize.notification-overlay', $.ui.notification.overlay.resize);
		}

		var $el = $('<div></div>').appendTo(document.body)
			.addClass('ui-widget-overlay').css({
				width: this.width(),
				height: this.height()
			});

		(notification.options.bgiframe && $.fn.bgiframe && $el.bgiframe());

		this.instances.push($el);
		return $el;
	},

	destroy: function($el) {
		this.instances.splice($.inArray(this.instances, $el), 1);

		if (this.instances.length === 0) {
			$([document, window]).unbind('.notification-overlay');
		}

		$el.remove();
		
		// adjust the maxZ to allow other modal notifications to continue to work (see #4309)
		var maxZ = 0;
		$.each(this.instances, function() {
			maxZ = Math.max(maxZ, this.css('z-index'));
		});
		this.maxZ = maxZ;
	},

	height: function() {
		// handle IE 6
		if ($.browser.msie && $.browser.version < 7) {
			var scrollHeight = Math.max(
				document.documentElement.scrollHeight,
				document.body.scrollHeight
			);
			var offsetHeight = Math.max(
				document.documentElement.offsetHeight,
				document.body.offsetHeight
			);

			if (scrollHeight < offsetHeight) {
				return $(window).height() + 'px';
			} else {
				return scrollHeight + 'px';
			}
		// handle "good" browsers
		} else {
			return $(document).height() + 'px';
		}
	},

	width: function() {
		// handle IE 6
		if ($.browser.msie && $.browser.version < 7) {
			var scrollWidth = Math.max(
				document.documentElement.scrollWidth,
				document.body.scrollWidth
			);
			var offsetWidth = Math.max(
				document.documentElement.offsetWidth,
				document.body.offsetWidth
			);

			if (scrollWidth < offsetWidth) {
				return $(window).width() + 'px';
			} else {
				return scrollWidth + 'px';
			}
		// handle "good" browsers
		} else {
			return $(document).width() + 'px';
		}
	},

	resize: function() {
		/* If the notification is draggable and the user drags it past the
		 * right edge of the window, the document becomes wider so we
		 * need to stretch the overlay. If the user then drags the
		 * notification back to the left, the document will become narrower,
		 * so we need to shrink the overlay to the appropriate size.
		 * This is handled by shrinking the overlay before setting it
		 * to the full document size.
		 */
		var $overlays = $([]);
		$.each($.ui.notification.overlay.instances, function() {
			$overlays = $overlays.add(this);
		});

		$overlays.css({
			width: 0,
			height: 0
		}).css({
			width: $.ui.notification.overlay.width(),
			height: $.ui.notification.overlay.height()
		});
	}
});

$.extend($.ui.notification.overlay.prototype, {
	destroy: function() {
		$.ui.notification.overlay.destroy(this.$el);
	}
});

})(jQuery);
