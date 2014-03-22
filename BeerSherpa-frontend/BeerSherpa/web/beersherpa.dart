library BeerSherpa;
import 'dart:html';
import 'dart:convert';

part 'search.dart';
part 'account.dart';
part 'vector.dart';

Map<String,Element> pageDivs = new Map();
Storage localStorage = window.localStorage;

void main() 
{
	pageDivs["landing-page"] = querySelector("#landing-page");
	pageDivs["advice-page"] = querySelector("#advice-page");
	pageDivs["tastes-page"] = querySelector("#tastes-page");
	pageDivs["profile-page"] = querySelector("#profile-page");
		
	checkLogin();
	
	//DEBUG
	SearchBeer("Sierra Nevada");
	//ENDDEBUG
}

void hideAllPages()
{
	pageDivs.forEach((String name, Element element)
	{
		pageDivs[name].classes.add("hidden");
	});
}