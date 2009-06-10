﻿[//lasso
/*----------------------------------------------------------------------------

[timer]
Collects and displays elapsed time between markers.

Author: Jason Huck
Last Modified: Feb. 17, 2008
License: Public Domain

Description:



Sample Usage:
// start the timer
var('runtimer') = true;
timer('started timer');

// do some stuff
sleep(200);

// set a marker
timer('did some stuff');

// do more stuff
sleep(100);

// set another marker
timer('did some more stuff');

// display results
timerstats;


Downloaded from tagSwap.net on Feb. 26, 2008.
Latest version available from <http://tagSwap.net/timer>.

----------------------------------------------------------------------------*/
		

define_tag(
	'timer',
	-opt='note', -type='string',
	-opt='collect', -type='boolean',
	-priority='replace',
	-encodenone,
	-description='Generates a list of timed events.'
);
	!var_defined('runtimer') || !$doruntimer ? return;

	!var_defined('__timerstart') ? var('__timerstart') = date_msec;
	!var_defined('__timer') ? var('__timer') = 0;
	!var_defined('__timerstats') ? var('__timerstats' = array);
	
	!local_defined('note') ? local('note') = '';
	!local_defined('collect') ? local('collect') = true;

	local('now') = date_msec;
	local('elapsed') = ($__timer == 0 ? 0 | #now - $__timer);
	#collect ? $__timer = #now;

	#collect ? $__timerstats->insert(#note = #elapsed) | return(#note + ': ' + #elapsed + 'ms.');	
/define_tag;




define_tag(
	'timerstats',
	-priority='replace',
	-encodenone,
	-description='Displays any timed events collected on the current page.'
);
	!var_defined('runtimer') || !$doruntimer ? return;
	!var_defined('__timerstats') ? return;
	
	local('total') = (date_msec - $__timerstart);
	
	local('out' = '
		<style type="text/css">
			#timerclear {
				display: block;
				width: 1px;
				height: 1px;
				line-height: 1px;
				clear: both;
				margin-bottom: 50px;
			}
		
			#timerstats {
				width: 80%;
				margin: 0 auto;
				border-collapse: collapse;
				background-color: white;
			}
			
			#timerstats * {
				font-family: verdana, arial, helvetica, sans-serif;
				font-size: 10px;
				text-align: left;
			}
			
			#timerstats th {
				font-weight: bold;
			}
							
			#timerstats th,
			#timerstats td {
				padding: 2px;
				border-bottom: 1px solid #333;
				padding-right: 50px;
			}
			
			#timerstats>tfoot>tr>th {
				border-bottom: none;
			}
			
			.ms {
				text-align: right !important;
				padding-right: 2px !important;
			}
			
			div.barbg {
				background-color: #EEE;
				border: 2px outset #EEE;
				margin-left: 40px;
			}
			
			div.barval {
				width: 30px;
				text-align: right !important;
				margin-left: -40px;
			}
		</style>
		<br id="timerclear" />
		<table id="timerstats">
			<thead>
				<tr>
					<th>Marker</th>
					<th>Percent Total</th>
					<th class="ms">Time (ms)</th>
				</tr>
			</thead>
			<tbody>\
	');
	
	iterate($__timerstats, local('i'));
		local('w') = percent(decimal(#i->second) / decimal(#total));
	
		#out += '
				<tr>
					<td nowrap>' + #i->first + '</td>
					<td nowrap><div class="barbg" style="width: ' + #w + ';"><div class="barval">' + #w + '</div></div></td>
					<td class="ms">' + #i->second + '</td>
				</tr>\
		';
	/iterate;
	
	#out += '
			</tbody>
			<tfoot>
				<tr>
					<th>Total</th>
					<th></th>
					<th class="ms">' + #total + '</th>
				</tr>
			</tfoot>
		</table>
	';
	
	return(#out);
/define_tag;
]