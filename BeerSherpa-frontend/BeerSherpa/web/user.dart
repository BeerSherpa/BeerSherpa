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
		flavorProfile.hops = map["flavorProfile"]["hops"];
		flavorProfile.malt = map["flavorProfile"]["malt"];
		flavorProfile.yeast = map["flavorProfile"]["yeast"];
		flavorProfile.ibu = map["flavorProfile"]["abv"];
		flavorProfile.abv = map["flavorProfile"]["ibu"];
		flavorProfile.style = map["flavorProfile"]["style"];
		flavorProfile.brewery = map["flavorProfile"]["brewery"];
	}
	
	void like(Map map)
	{
		if(map["data"]["style"]["name"] != null)
		{
			String style = map["data"]["style"]["name"];
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
			
			if(flavorProfile.style[style] != null)
			{
				flavorProfile.style[style].total++;
				flavorProfile.style[style].liked++;
			}
			else
				flavorProfile.style[style] = new Liked(1,1);
		}
		if(map["data"]["abv"] != null)
		{
			int abv = int.parse(map["data"]["abv"]);
			if(abv <= 4.5)
			{
				if(flavorProfile.abv["low-abv"] != null)
				{
					flavorProfile.abv["low-abv"].total++;
                    flavorProfile.abv["low-abv"].liked++;
				}
				else
					flavorProfile.abv["low-abv"] = new Liked(1,1);
			}
			else if(abv > 4.5 && abv <= 7)
			{
				if(flavorProfile.abv["mid-abv"] != null)
				{
					flavorProfile.abv["mid-abv"].total++;
                    flavorProfile.abv["mid-abv"].liked++;
				}
				else
					flavorProfile.abv["mid-abv"] = new Liked(1,1);
			}
			else
			{
				if(flavorProfile.abv["high-abv"] != null)
				{
					flavorProfile.abv["high-abv"].total++;
                    flavorProfile.abv["high-abv"].liked++;
				}
				else
					flavorProfile.abv["high-abv"] = new Liked(1,1);
			}
		}
		if(map["data"]["ibu"] != null)
		{
			int ibu = int.parse(map["data"]["ibu"]);
			if(ibu <= 20)
			{
				if(flavorProfile.ibu["xlow-ibu"] != null)
                {
					flavorProfile.ibu["xlow-ibu"].total++;
					flavorProfile.ibu["xlow-ibu"].liked++;
                }
                else
                	flavorProfile.ibu["xlow-ibu"] = new Liked(1,1);
			}
			else if(ibu > 20 && ibu <= 40)
			{
				if(flavorProfile.ibu["low-ibu"] != null)
                {
					flavorProfile.ibu["low-ibu"].total++;
					flavorProfile.ibu["low-ibu"].liked++;
                }
                else
                	flavorProfile.ibu["low-ibu"] = new Liked(1,1);
			}
			else if(ibu > 40 && ibu <= 60)
			{
				if(flavorProfile.ibu["mid-ibu"] != null)
                {
					flavorProfile.ibu["mid-ibu"].total++;
					flavorProfile.ibu["mid-ibu"].liked++;
                }
                else
                	flavorProfile.ibu["mid-ibu"] = new Liked(1,1);
			}
			else
			{
				if(flavorProfile.ibu["high-ibu"] != null)
                {
					flavorProfile.ibu["high-ibu"].total++;
					flavorProfile.ibu["high-ibu"].liked++;
                }
                else
                	flavorProfile.ibu["high-ibu"] = new Liked(1,1);
			}
		}
		if(map["data"]["ingredients"] != null)
		{
			if(map["data"]["ingredients"]["hops"] != null)
			{
				List<Map<String,String>> hops = map["data"]["ingredients"]["hops"];
				hops.forEach((Map<String,String> hop)
				{
					if(flavorProfile.hops["name"] != null)
					{
						flavorProfile.hops[hop["name"]].total++;
						flavorProfile.hops[hop["name"]].liked++;
					}
					else
						flavorProfile.hops[hop["name"]] = new Liked(1,1);
				});
				List<Map<String,String>> malts = map["data"]["ingredients"]["malt"];
				malts.forEach((Map<String,String> malt)
				{
					if(flavorProfile.malt["name"] != null)
					{
						flavorProfile.malt[malt["name"]].total++;
						flavorProfile.malt[malt["name"]].liked++;
					}
					else
						flavorProfile.malt[malt["name"]] = new Liked(1,1);
				});
				List<Map<String,String>> yeasts = map["data"]["ingredients"]["yeast"];
				yeasts.forEach((Map<String,String> yeast)
				{
					if(flavorProfile.yeast["name"] != null)
					{
						flavorProfile.yeast[yeast["name"]].total++;
						flavorProfile.yeast[yeast["name"]].liked++;
					}
					else
						flavorProfile.yeast[yeast["name"]] = new Liked(1,1);
				});
			}
		}
		if(map["data"]["breweries"] != null)
		{
			List<Map<String,String>> breweries = map["data"]["breweries"];
			breweries.forEach((Map<String,String> brewery)
			{
				if(flavorProfile.brewery["name"] != null)
				{
					flavorProfile.brewery[brewery["name"]].total++;
					flavorProfile.brewery[brewery["name"]].liked++;
				}
				else
					flavorProfile.brewery[brewery["name"]] = new Liked(1,1);
			});
		}
	}
}

class FlavorProfile
{
	Map<String,Liked> hops, malt, yeast, abv, ibu, style, brewery;
	
	FlavorProfile()
	{
		hops = new Map();
		malt = new Map();
		yeast = new Map();
		abv = new Map();
		ibu = new Map();
		style = new Map();
		brewery = new Map();
	}
	
	String toString()
	{
		String profile = "";
		hops.forEach((String key, Liked value)
		{
			for(int i=0; i<value.liked; i++)
				profile += " $key";
		});
		malt.forEach((String key, Liked value)
		{
			for(int i=0; i<value.liked; i++)
				profile += " $key";
		});
		yeast.forEach((String key, Liked value)
		{
			for(int i=0; i<value.liked; i++)
				profile += " $key";
		});
		ibu.forEach((String key, Liked value)
		{
			for(int i=0; i<value.liked; i++)
				profile += " $key";
		});
		abv.forEach((String key, Liked value)
		{
			for(int i=0; i<value.liked; i++)
				profile += " $key";
		});
		style.forEach((String key, Liked value)
		{
			for(int i=0; i<value.liked; i++)
				profile += " $key";
		});
		brewery.forEach((String key, Liked value)
		{
			for(int i=0; i<value.liked; i++)
				profile += " $key";
		});
		return profile;
	}
}

class Liked
{
	int total, liked;
	
	Liked(this.total,this.liked);
}