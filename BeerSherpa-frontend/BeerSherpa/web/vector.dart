part of BeerSherpa;


/*
 * This method will calculate the Euclidean distance between the beer vector and the person vector.
 */
double getDistance(Map<String,double> beerVector, Map<String,double> userVector)
{
  
  return 0.0;
}

Map<String,double> getBeerVector(Map map)
{
	Map<String,double> vector = new Map();
	
	double abv = double.parse(map["abv"]);
	if(abv <= 4.5)
		vector["low-abv"] = 1.0;
	else if(abv > 4.5 && abv <= 7)
		vector["mid-abv"] = 1.0;
	else
		vector["high-abv"] = 1.0;
	
	double ibu = double.parse(map["ibu"]);
	if(ibu <= 20)
		vector["xlow-ibu"] = 1.0;
	
	return vector;
}