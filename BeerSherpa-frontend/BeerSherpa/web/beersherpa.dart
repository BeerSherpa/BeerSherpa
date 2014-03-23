library BeerSherpa;
import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

part 'search.dart';
part 'account.dart';
part 'vector.dart';
part 'profile.dart';
part 'user.dart';
part 'randombeer.dart';

Map<String,Element> pageDivs = new Map();
Storage localStorage = window.localStorage;

void main() 
{
	pageDivs["landing-page"] = querySelector("#landing-page");
	pageDivs["ftu-page"] = querySelector("#ftu-page");
	pageDivs["advice-page"] = querySelector("#advice-page");
	pageDivs["tastes-page"] = querySelector("#tastes-page");
	pageDivs["profile-page"] = querySelector("#profile-page");
		
	checkLogin();
	initListeners();
	
	initSearch();
	initRandom();
	
}

void initListeners()
{
	querySelector("#li-advice").onClick.listen((MouseEvent event)
	{
		hideAllPages();
		pageDivs["advice-page"].classes.remove("hidden");
        (event.target as LIElement).classes.add("active");
        
        //hide jumbotrons
        querySelector("#advice-beer-card").classes.add("hidden");
        querySelector("#tastes-beer-card").classes.add("hidden");
        querySelector("#results-jumbotron").classes.add("hidden");
                
        //clear search box
        (querySelector("#advice-input-beer") as InputElement).value = "";
	});
	querySelector("#li-tastes").onClick.listen((MouseEvent event)
	{
		hideAllPages();
		
		populateRandom();
		
		pageDivs["tastes-page"].classes.remove("hidden");
        (event.target as LIElement).classes.add("active");
        
        //clear search box
        (querySelector("#tastes-input-beer") as InputElement).value = "";
	});
	querySelector("#li-profile").onClick.listen((MouseEvent event)
	{
		hideAllPages();
		pageDivs["profile-page"].classes.remove("hidden");
        (event.target as LIElement).classes.add("active");
	});
}

void hideAllPages()
{
	pageDivs.forEach((String name, Element element)
	{
		pageDivs[name].classes.add("hidden");
		String subName = name.substring(0,name.indexOf("-"));
		Element listElement = querySelector("#li-$subName");
		if(listElement != null)
			listElement.classes.remove("active");
	});
	
}