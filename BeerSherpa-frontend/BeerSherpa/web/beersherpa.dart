library BeerSherpa;
import 'dart:html';

part 'search.dart';

Map<String,Element> pageDivs = new Map();

void main() 
{
	pageDivs["landing-page"] = querySelector("#landing-page");
	pageDivs["advice-page"] = querySelector("#advice-page");
	pageDivs["tastes-page"] = querySelector("#tastes-page");
	pageDivs["profile-page"] = querySelector("#profile-page");
	
	//DEBUG
	Search();
	//ENDDEBUG
}