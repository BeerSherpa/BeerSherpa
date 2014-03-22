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
		email = map["email"];
		password = map["password"];
		flavorProfile = new FlavorProfile();
		flavorProfile.hops = map["hops"];
		flavorProfile.malt = map["malt"];
		flavorProfile.yeast = map["yeast"];
		flavorProfile.ibu = map["abv"];
		flavorProfile.abv = map["ibu"];
		flavorProfile.style = map["style"];
		flavorProfile.brewery = map["brewery"];
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
	Element loginButton = querySelector("#navbar-button-login")
		..text = "Logging In..."
		..classes.add("disabled");
	
	String url = "http://beersherpaapp.appspot.com/login?email=$email&password=$password";
	HttpRequest.getString(url).then((response)
	{
		loginButton
			..text = "Login"
			..classes.remove("disabled");
		
		try
		{
			User user = new User.fromMap(JSON.decode(response));
					
			localStorage["loggedIn"] = email;
        	pageDivs["advice-page"].classes.remove("hidden");
        	querySelector("#normal-nav").classes.remove("hidden");
        	querySelector("#login-nav").classes.add("hidden");
        	hideAllPages();
        	pageDivs["advice-page"].classes.remove("hidden");
		}
		catch(error) //couldn't login with given credentials
		{
			InputElement loginEmail = querySelector("#navbar-input-email");
			InputElement loginPassword = querySelector("#navbar-input-password");
			addWarning(loginEmail,"remove","has-error");
			addWarning(loginPassword,"remove","has-error");
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
    	checkKey(newUser,false,null,emailInput,passwordInput);
	});
    
    querySelector("#navbar-button-login").onClick.listen((MouseEvent event)
	{
    	checkKey(loginUser,false,null,loginEmail,loginPassword);
	});
	
	emailInput.onKeyPress.listen((KeyboardEvent key)
	{
		checkKey(newUser,true,key,emailInput,passwordInput);
	});
	passwordInput.onKeyPress.listen((KeyboardEvent key)
	{
		checkKey(newUser,true,key,emailInput,passwordInput);
	});
	
	loginEmail.onKeyPress.listen((KeyboardEvent key)
	{
		checkKey(loginUser,true,key,loginEmail,loginPassword);
	});
	
	loginPassword.onKeyPress.listen((KeyboardEvent key)
	{
		checkKey(loginUser,true,key,loginEmail,loginPassword);
	});
}

void checkKey(Function successFunction, bool checkKeyCode, KeyboardEvent key, InputElement emailInput, InputElement passwordInput)
{
	if(checkKeyCode && key.keyCode != 13) //listen for enter key
	{
		removeError(passwordInput);
		return;
	}
	
	if(!validateInput(emailInput,passwordInput))
		return;
	else
	{
		successFunction(emailInput.value,passwordInput.value);
		emailInput.value = "";
		passwordInput.value = "";
	}
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
			pageDivs["advice-page"].classes.remove("hidden");
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
		addWarning(emailInput,"warning-sign","has-warning");
		
		return false;
	}
	if(passwordInput.value.trim() == "")
	{
		addWarning(passwordInput,"warning-sign","has-warning");
		
		return false;
	}
	
	return true;
}

void addWarning(InputElement element, String icon, String className)
{
	SpanElement glyphicon = new SpanElement()
		..className = "glyphicon glyphicon-$icon form-control-feedback";
	element.parent.classes
		..add(className)
		..add("has-feedback");
	element.parent.append(glyphicon);
}

void removeError(InputElement element)
{
	SpanElement span = element.parent.querySelector(".form-control-feedback");
	if(span != null)
		span.remove();
	
	element.parent.classes
		..remove("has-error")
		..remove("has-warning")
		..remove("has-feedback");
}