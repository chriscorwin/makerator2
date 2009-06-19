[
	'<p><strong>client_params:</strong> ' + client_params + '</p>';
	// text
	// password
	// checkbox
	// radio
	// submit
	// reset
	// file
	// hidden
	// image
	// button
]




<form>
	<fieldset>
		<legend>
			Disabled Elements 
		</legend>
		<input name="disabled" id="disabled" type="text" value="This input is disabled." size="15" maxlength="255" disabled="true" tabindex="1" accesskey="1">
		<input name="disabled_readonly" id="disabled_readonly" type="text" value="This input is disabled AND  read only." size="15" maxlength="255" disabled="true" readonly="true" tabindex="4" accesskey="4">
	</fieldset>
	<fieldset>
		<legend>
			Enabled Elements 
		</legend>
		<input name="enabled_readonly" id="enabled_readonly" type="text" value="This input is enabled, but read only." size="15" maxlength="255" readonly="true" tabindex="2" accesskey="2">
		<input name="enabled" id="enabled" type="text" value="This input is enabled." size="15" maxlength="255" tabindex="3" accesskey="e">
		<input name="passwordType" id="passwordType" type="password" value="somepassword" size="14" maxlength="44" tabindex="5" accesskey="5">
	</fieldset>
	<fieldset>
		<legend>
			Checkables
		</legend>
		<input type="checkbox">
		<input type="radio">
	</fieldset>
	<fieldset>
		<legend>
			Buttons &mdash; Input Type
		</legend>
		<input type="submit" name="submitInput" id="submitInput" value="Submit via Input!">
		<input type="reset" name="resetInput" id="resetInput" value="Reset via Input!">
		<input type="file">
		<input type="hidden">
		<input type="image" src="/assets/images/bin.jpg" name="deleteIt" id="deleteIt" value="deleteIt">
		<input type="button" name="someButtonInput" id="someButtonInput" value="Button!">
	</fieldset>
	<fieldset>
		<legend>
			Selects
		</legend>
		<select id="selectSingle" name="selectSingle" size="1">
			<option label="Some Option" value="someOption">Some Option</option>
		</select>
		
		<select id="selectSingle2" name="selectSingle" size="4">
			<option label="Some Option" value="someOption">Some Option</option>
		</select>
		
		<select id="selectMultiple" name="selectMultiple" size="1">
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
		</select>
		
		<select id="selectMultiple2" name="selectMultiple2" size="4">
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
		</select>
		
		<select id="selectMultiple3" name="selectMultiple3" size="1">
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
			<optgroup label="Stuff">
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
			</optgroup>
			<optgroup label="Other Stuff">
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
			</optgroup>
		</select>
		
		<select id="selectMultiple4" name="selectMultiple4" size="3">
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
			<option label="Some Option" value="someOption">Some Option</option>
			<optgroup label="Stuff">
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
			</optgroup>
			<optgroup label="Other Stuff">
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
				<option label="Some Option" value="someOption">Some Option</option>
			</optgroup>
		</select>
	</fieldset>
	<fieldset>
		<legend>
			Text Area
		</legend>
		
		<textarea id="someTextArea" name="someTextArea" rows="10" cols="70"></textarea>
		
	</fieldset>
	<fieldset>
		<legend>
			Butto-Button Elements 
		</legend>
		
		<button type="submit" id="submitIt" name="submitIt" value="submitIt">Submit it!</button>
		<button type="submit" id="submitIt2" name="submitIt2" value="submitIt2">Submit it 2!</button>
		<button type="reset" id="resetIt" name="resetIt" value="Reset It!">Reset It</button>
		<button type="button" id="buttonIt" name="buttonIt" value="buttonIt">Button it!</button>
		
	</fieldset>
</form>
