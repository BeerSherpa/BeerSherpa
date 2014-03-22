part of BeerSherpa;

class User
{
	String email, password;
	FlavorProfile flavorProfile;
	
	User(this.email,this.password)
	{
		flavorProfile = new FlavorProfile();
	}
	
	User.fromMap(Map map)
	{
		print(map);
	}
}

class FlavorProfile
{
	Map<String,Liked> hops, malt, yeast, abv, ibu, style, brewery;
}

class Liked
{
	int total, liked;
}

void checkLogin()
{
	String loggedIn = localStorage["loggedIn"];
	querySelector("#login-nav").classes.remove("hidden");

	if(loggedIn == null) //first time here
		pageDivs["landing-page"].classes.remove("hidden");
	else if(loggedIn != "none") //someone has logged in
	{
		pageDivs["advice-page"].classes.remove("hidden");
		querySelector("#normal-nav").classes.remove("hidden");
		querySelector("#login-nav").classes.add("hidden");
	}
	else if(loggedIn == "none") //user logged out
    	pageDivs["landing-page"].classes.remove("hidden");
	
	attachListeners();
}

void loginUser(String email, String password)
{
	String url = "http://beersherpaapp.appspot.com/login?email=$email&password=$password";
	HttpRequest.getString(url).then((response)
	{
		try
		{
			User user = new User.fromMap(JSON.decode(response));
					
			localStorage["loggedIn"] = email;
        	pageDivs["advice-page"].classes.remove("hidden");
        	querySelector("#normal-nav").classes.remove("hidden");
        	querySelector("#login-nav").classes.add("hidden");
		}
		catch(error) //couldn't login with given credentials
		{
			return;
		}
	});
}

void attachListeners()
{
	querySelector("#li-logout").onClick.listen((MouseEvent event)
	{
		localStorage["loggedIn"] = "none";
		hideAllPages();
		pageDivs["landing-page"].classes.remove("hidden");
    	querySelector("#normal-nav").classes.add("hidden");
    	querySelector("#login-nav").classes.remove("hidden");
	});
	
	//get new user email and password fields
	InputElement emailInput = querySelector("#signup-input-email");
	InputElement passwordInput = querySelector("#signup-input-password");
	
	//get login user email and password fields
	InputElement loginEmail = querySelector("#navbar-input-email");
    InputElement loginPassword = querySelector("#navbar-input-password");
    
    querySelector("#signup-button-submit").onClick.listen((MouseEvent event)
	{
    	if(!validateInput(emailInput,passwordInput))
			return;
		else
			newUser(emailInput.value,passwordInput.value);
	});
    
    querySelector("#navbar-button-login").onClick.listen((MouseEvent event)
	{
    	if(!validateInput(loginEmail,loginPassword))
			return;
		else
			loginUser(loginEmail.value,loginPassword.value);
	});
	
	emailInput.onKeyPress.listen((KeyboardEvent key)
	{
		if(key.keyCode != 13) //listen for enter key
		{
			removeError(emailInput);
			return;
		}
		
		if(!validateInput(emailInput,passwordInput))
			return;
		else
			newUser(emailInput.value,passwordInput.value);
	});
	passwordInput.onKeyPress.listen((KeyboardEvent key)
	{
		if(key.keyCode != 13) //listen for enter key
		{
			removeError(passwordInput);
			return;
		}
		
		if(!validateInput(passwordInput,passwordInput))
			return;
		else
        	newUser(emailInput.value,passwordInput.value);
	});
	
	loginEmail.onKeyPress.listen((KeyboardEvent key)
	{
		if(key.keyCode != 13) //listen for enter key
		{
			removeError(passwordInput);
			return;
		}
	});
}

void newUser(String email, String password)
{
	Element signupButton = querySelector("#signup-button-submit")
			..text = "Creating..."
			..classes.add("disabled");
	
	String url = "http://beersherpaapp.appspot.com/createUser?email=$email&password=$password";
	HttpRequest.getString(url).then((response)
	{
		signupButton
			..text = "Create an Account"
			..classes.remove("disabled");
		
		try
		{
			Map map = JSON.decode(response);
			User user = new User(email,password);
			
			localStorage["loggedIn"] = email;
			hideAllPages();
			querySelector("#normal-nav").classes.remove("hidden");
		}
		catch(error)
		{
			querySelector("#signup-error").classes.remove("hidden");
		}
	});
}

bool validateInput(InputElement emailInput, InputElement passwordInput)
{
	if(emailInput.value.trim() == "")
	{
		print("email blank");
		addError(emailInput);
		
		return false;
	}
	if(passwordInput.value.trim() == "")
	{
		print("password blank");
		addError(passwordInput);
		
		return false;
	}
	
	return true;
}

void addError(InputElement element)
{
	SpanElement glyphicon = new SpanElement()
		..className = "glyphicon glyphicon-remove form-control-feedback";
	element.parent.classes
		..add("has-error")
		..add("has-feedback");
	element.parent.append(glyphicon);
}

void removeError(InputElement element)
{
	SpanElement span = element.parent.querySelector(".form-control-feedback");
	if(span != null)
	{
		span.remove();
		element.parent.classes
			..remove("has-error")
			..remove("has-feedback");
	}
}