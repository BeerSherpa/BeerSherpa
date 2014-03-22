part of BeerSherpa;

void loginUser()
{
	//get entered email and password
}

void createUser()
{
	//get entered email and password
	TextInputElement emailInput = querySelector("#signup-input-email");
	emailInput.onKeyPress.listen((KeyboardEvent key)
	{
		if(!validateInput(emailInput))
			return;
	});
	TextInputElement passwordInput = querySelector("#signup-input-password");
	emailInput.onKeyPress.listen((KeyboardEvent key)
	{
		if(!validateInput(emailInput))
			return;
	});
}

bool validateInput(TextInputElement textInput)
{
	if(textInput.text.trim() == "")
	{
		SpanElement glyphicon = new SpanElement()
			..className = "glyphicon glyphicon-remove form-control-feedback";
		textInput.parent.classes
			..add("has-error")
			..add("has-feedback");
		textInput.parent.append(glyphicon);
		
		return false;
	}
	
	return true;
}