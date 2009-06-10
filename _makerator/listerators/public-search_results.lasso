[
	rows: -inlinename=(Var: ($listeratorAction + '_Table'));
			if: loop_count == 1;
					'<ol class="'$these' results-listing" >';
			/if;
			var: 'rowClass' = 'alt';
			If((Loop_Count) % 2);
					$rowClass = 'normal';
			/If;
			
			
			if(column('Display_Status') != '');
					$rowClass += (' '+column('Display_Status'));
			/if;
			
			
			
			
			'<li class="' $rowClass '">';
			'
				<a href="' var($listeratorAction + '_pathto') + column('Keyword_URL') '/">
					<h3>'
					
					column(var($listeratorAction + '_Title_Field_Name'));
					'</h3>
					<p>
						'column('summary')' ... (<strong class="message-center-readmore">read more</strong>) 
					</p>
				</a>
			</li>
			';
			if: loop_count == shown_count && found_count != 0;
					'</ol>';
			/if;
	/rows;


]