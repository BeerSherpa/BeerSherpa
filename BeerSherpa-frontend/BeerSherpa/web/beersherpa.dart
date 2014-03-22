library BeerSherpa;
import 'dart:html';

part 'search.dart';
part 'brewerydb.dart';

Map<String,Element> pageDivs = new Map();

void main() 
{
	pageDivs["landing-page"] = querySelector("#landing-page");
	pageDivs["advice-page"] = querySelector("#advice-page");
	pageDivs["tastes-page"] = querySelector("#tastes-page");
	pageDivs["profile-page"] = querySelector("#profile-page");
	
	pageDivs.forEach((String key, Element value)
	{
		value.style.display = "none";
	});
}