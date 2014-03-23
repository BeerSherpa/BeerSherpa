part of BeerSherpa;


/*
 * This method will calculate the Euclidean distance between the beer vector and the person vector.
 */
double getDistance(Map<String,double> beerVector, Map<String,double> userVector)
{
	double dotSum = 0.0;
	double beerSum = 0.0;
	double userSum = 0.0;
	beerVector.forEach((String name, double percent)
	{
		beerSum += pow(percent,2);
		if(userVector[name] != null)
			dotSum += percent*userVector[name];
	});
	userVector.forEach((String name, double percent)
    {
		userSum += pow(percent,2);
    });
	double denominator = sqrt(beerSum) * sqrt(userSum);
	double raw = dotSum/denominator;
	
	double normalized = (raw+1)/2;
	if(normalized < .6)
		normalized *= .6;
	else
		normalized *= 1.2;
	if(normalized > .95)
		normalized = .95;
	return normalized;
}

Map<String,double> getBeerVector(Map map)
{
	Map<String,double> vector = new Map();
	
	if(map["abv"] != null)
	{
		double abv = double.parse(map["abv"]);
    	if(abv <= 4.5)
    		vector["low-abv"] = 1.0;
    	else if(abv > 4.5 && abv <= 7)
    		vector["mid-abv"] = 1.0;
    	else
    		vector["high-abv"] = 1.0;
	}
	
	if(map["ibu"] != null)
	{
		double ibu = double.parse(map["ibu"]);
    	if(ibu <= 20)
    		vector["xlow-ibu"] = 1.0;
    	else if(ibu > 20 && ibu <= 40)
    		vector["low-ibu"] = 1.0;
    	else if(ibu > 40 && ibu <= 60)
    		vector["mid-ibu"] = 1.0;
    	else
    		vector["high-ibu"] = 1.0;
	}
	
	if(map["breweries"] != null)
	{
		List<Map<String,String>> breweries = map["breweries"];
    	breweries.forEach((Map<String,String> brewery)
    	{
    		vector[brewery["name"]] = 1.0;
    	});
	}
	
	if(map["style"] != null && map["style"]["name"] != null)
	{
		String style = map["style"]["name"];
		if(style.toLowerCase().contains("india pale ale"))
			style = "India Pale Ale";
		else if(style.toLowerCase().contains("pale ale"))
			style = "Pale Ale";
		else if(style.toLowerCase().contains("ale"))
			style = "Ale";
		else if(style.toLowerCase().contains("amber"))
			style = "Amber";
		else if(style.toLowerCase().contains("stout"))
			style = "Stout";
		else if(style.toLowerCase().contains("porter"))
			style = "Porter";
		else if(style.toLowerCase().contains("wheat"))
			style = "Wheat";
		else if(style.toLowerCase().contains("bock"))
			style = "Bock";
		else if(style.toLowerCase().contains("pilsner"))
			style = "Pilsner";
		else if(style.toLowerCase().contains("lager"))
			style = "Lager";
		
		vector[style] = 1.0;
	}
	
	if(map["ingredients"] != null)
	{
		if(map["ingredients"]["hops"] != null)
		{
			List<Map<String,String>> hops = map["ingredients"]["hops"];
			hops.forEach((Map<String,String> hop)
			{
				vector[hop["name"]] = 1.0;
			});
		}
		if(map["ingredients"]["malt"] != null)
		{
			List<Map<String,String>> malts = map["ingredients"]["malt"];
			malts.forEach((Map<String,String> malt)
			{
				vector[malt["name"]] = 1.0;
			});
		}
		if(map["ingredients"]["yeast"] != null)
		{
			List<Map<String,String>> yeasts = map["ingredients"]["yeast"];
			yeasts.forEach((Map<String,String> yeast)
			{
				vector[yeast["name"]] = 1.0;
			});
		}
	}
	
	return vector;
}