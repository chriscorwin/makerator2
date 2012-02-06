<div class="ui-accordion-group">
	<h3><a href="/layout_controls/">Layout Controls</a></h3>
	<div class="ui-accordion-content">
		<ul>
			<li>
				<a href="#" onclick="outerLayout.toggle('north')">Toggle North</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.toggle('south')">Toggle South</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.toggle('west')"> Toggle West</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.toggle('east')"> Toggle East</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.hide('north')">Hide North</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.hide('south')">Hide South</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.hide('east')"> Hide East</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.show('east', false)">Unhide East</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.open('east')"> Open East</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.sizePane('north', 100); outerLayout.open('north')"> Resize North=100</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.sizePane('north', 300); outerLayout.open('north')"> Resize North=300</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.sizePane('north', 10000); outerLayout.open('north')">Resize North=10000</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.sizePane('south', 100); outerLayout.open('south')"> Resize South=100</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.sizePane('south', 300); outerLayout.open('south')"> Resize South=300</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.sizePane('south', 10000); outerLayout.open('south')">Resize South=10000</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.panes.north.css('backgroundColor','#FCC')">North Color = Red</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.panes.north.css('backgroundColor','#CFC')">North Color = Green</a> 
			</li>
			<li>
				<a href="#" onclick="outerLayout.panes.north.css('backgroundColor','')"> North Color = Default</a> 
			</li>
			<li>
				<a href="#" onclick="alert('outerLayout.name = \''+outerLayout.options.name+'\'')">Show Layout Name</a> 
			</li>
			<li>
				<a href="#" onclick="showOptions(outerLayout,'defaults')">Show Options.Defaults</a> 
			</li>
			<li>
				<a href="#" onclick="showOptions(outerLayout,'north')"> Show Options.North</a> 
			</li>
			<li>
				<a href="#" onclick="showOptions(outerLayout,'south')"> Show Options.South</a> 
			</li>
			<li>
				<a href="#" onclick="showOptions(outerLayout,'west')"> Show Options.West</a> 
			</li>
			<li>
				<a href="#" onclick="showOptions(outerLayout,'east')"> Show Options.East</a> 
			</li>
			<li>
				<a href="#" onclick="showOptions(outerLayout,'center')"> Show Options.Center</a> 
			</li>
			<li>
				<a href="#" onclick="showState(outerLayout,'container')"> Show State.Container</a> 
			</li>
			<li>
				<a href="#" onclick="showState(outerLayout,'north')"> Show State.North</a> 
			</li>
			<li>
				<a href="#" onclick="showState(outerLayout,'south')"> Show State.South</a> 
			</li>
			<li>
				<a href="#" onclick="showState(outerLayout,'west')"> Show State.West</a> 
			</li>
			<li>
				<a href="#" onclick="showState(outerLayout,'east')"> Show State.East</a> 
			</li>
			<li>
				<a href="#" onclick="showState(outerLayout,'center')"> Show State.Center</a> 
			</li>
		</ul>
	</div>
</div>
