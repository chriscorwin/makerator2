[
	$makerator_includes->insert(include_currentPath);
	$makerator_currentInclude							=	$makerator_includes->last;
	handle;
			$makerator_includes->remove;
			$makerator_currentInclude					=	$makerator_includes->last;
	/handle;
	
	
	protect;
	
	handle_error;
			makerator_errorManager(
				$makerator_currentInclude
			,	error_code
			,	error_msg
			,	action_statement
			);
	/handle_error;
	
	

	$content_primary += ('
		<form 
			id="signInForm" 
			class="listerator-form listerator-form-signIn  ui-widget"
			action="/account/sign_in/do/" 
			method="post" 
			name="memberShort" 
			>
			
				<fieldset class="varchar ui-helper-reset ui-corner-all required">
						<label 
							class="ui-helper-reset ui-widget-header ui-clickable ui-corner-left"
							for="this" 
						>Username</label>
						<input 
							class="ui-helper-reset ui-clickable ui-widget-content ui-corner-right"
							type="text" 
							name="this" 
							id="this" 
							value="' + (var_defined('user_Login_Name') ? $user_Login_Name) + '"
						>
				</fieldset>
				<fieldset class="varchar ui-helper-reset ui-corner-all required">
						<label
							for="that"
							class="ui-helper-reset ui-widget-header ui-clickable ui-corner-left"
							>
								Password
						</label>
						<input 
							class="ui-helper-reset ui-clickable ui-widget-content ui-corner-right"
							type="password" 
							name="that" 
							id="that" 
							>
				</fieldset>
				
				<fieldset class="listerator-form-buttons ui-helper-reset">
					<button id="saveListerator" class="ui-helper-reset ui-state-default ui-corner-all ui-clickable">
						<span class="ui-icon ui-icon-left ui-icon-disk"></span>Sign In
					</button>
					<button id="revertListerator" class="ui-helper-reset ui-state-default ui-corner-all ui-clickable">
						<span class="ui-icon ui-icon-left ui-icon-help"></span><span class="ui-button-label">Help</span>
					</button>
				</fieldset>
		</form>
	');

	/protect;
]