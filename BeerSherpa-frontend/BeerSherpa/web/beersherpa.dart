library BeerSherpa;
import 'dart:html';
import 'dart:convert';
import 'dart:async';

part 'search.dart';
part 'account.dart';
part 'vector.dart';
part 'profile.dart';

Map<String,Element> pageDivs = new Map();
Storage localStorage = window.localStorage;

void main() 
{
	pageDivs["landing-page"] = querySelector("#landing-page");
	pageDivs["advice-page"] = querySelector("#advice-page");
	pageDivs["tastes-page"] = querySelector("#tastes-page");
	pageDivs["profile-page"] = querySelector("#profile-page");
		
	checkLogin();
	initListeners();
	
	//DEBUG
	SearchBeer("Sierra Nevada");
	//ENDDEBUG
}

void initListeners()
{
	querySelector("#li-advice").onClick.listen((MouseEvent event)
	{
		print("here");
		print("id"+(event.target as Element).id);
		hideAllPages();
		pageDivs["advice-page"].classes
			..remove("hidden")
			..add("active");
	});
	querySelector("#li-tastes").onClick.listen((MouseEvent event)
	{
		print((event.target as Element).id);
		hideAllPages();
		pageDivs["tastes-page"].classes
	        ..remove("hidden")
            ..add("active");
	});
	querySelector("#li-profile").onClick.listen((MouseEvent event)
	{print((event.target as Element).id);
		hideAllPages();
		pageDivs["profile-page"].classes
			..remove("hidden")
			..add("active");
	});
}

void hideAllPages()
{
	pageDivs.forEach((String name, Element element)
	{
		pageDivs[name].classes
			..add("hidden")
			..remove("active");
	});
}