library BeerSherpa;
import 'dart:html';
import 'dart:convert';

part 'search.dart';
part 'vector.dart';

Map<String,Element> pageDivs = new Map();

void main() 
{
	pageDivs["landing-page"] = querySelector("#landing-page");
	pageDivs["advice-page"] = querySelector("#advice-page");
	pageDivs["tastes-page"] = querySelector("#tastes-page");
	pageDivs["profile-page"] = querySelector("#profile-page");
	
	//DEBUG
	SearchBeer("Sierra Nevada");
	//ENDDEBUG
}