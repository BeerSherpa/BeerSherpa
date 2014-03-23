part of BeerSherpa;

class User
{
	String email, password;
	FlavorProfile flavorProfile;
	
	User(this.email,this.password)
	{
		flavorProfile = new FlavorProfile();
	}
	
	User.fromJSON(Map map)
	{
		email = map["email"];
		password = map["password"];
		flavorProfile = new FlavorProfile();
		(map["flavorProfile"]["hops"] as List<Map<String,Map<String,String>>>).forEach((Map map)
		{
			map.forEach((String key, Map<String,String> value)
			{
				Liked liked = new Liked(value["total"],value["liked"]);
				flavorProfile.hops[key] = liked;
			});
		});
		(map["flavorProfile"]["malt"] as List<Map<String,Map<String,String>>>).forEach((Map map)
		{
			map.forEach((String key, Map<String,String> value)
			{
				Liked liked = new Liked(value["total"],value["liked"]);
				flavorProfile.malt[key] = liked;
			});
		});
		(map["flavorProfile"]["yeast"] as List<Map<String,Map<String,String>>>).forEach((Map map)
		{
			map.forEach((String key, Map<String,String> value)
			{
				Liked liked = new Liked(value["total"],value["liked"]);
				flavorProfile.yeast[key] = liked;
			});
		});
		(map["flavorProfile"]["ibu"] as List<Map<String,Map<String,String>>>).forEach((Map map)
		{
			map.forEach((String key, Map<String,String> value)
			{
				Liked liked = new Liked(value["total"],value["liked"]);
				flavorProfile.ibu[key] = liked;
			});
		});
		(map["flavorProfile"]["abv"] as List<Map<String,Map<String,String>>>).forEach((Map map)
		{
			map.forEach((String key, Map<String,String> value)
			{
				Liked liked = new Liked(value["total"],value["liked"]);
				flavorProfile.abv[key] = liked;
			});
		});
		(map["flavorProfile"]["style"] as List<Map<String,Map<String,String>>>).forEach((Map map)
		{
			map.forEach((String key, Map<String,String> value)
			{
				Liked liked = new Liked(value["total"],value["liked"]);
				flavorProfile.style[key] = liked;
			});
		});
		(map["flavorProfile"]["brewery"] as List<Map<String,Map<String,String>>>).forEach((Map map)
		{
			map.forEach((String key, Map<String,String> value)
			{
				Liked liked = new Liked(value["total"],value["liked"]);
				flavorProfile.brewery[key] = liked;
			});
		});
	}
	
	Map<String,double> getVector()
	{
		Map<String,double> map = new Map();
		flavorProfile.hops.forEach((String key, Liked value)
		{
			map[key] = value.liked/value.total;
		});
		flavorProfile.malt.forEach((String key, Liked value)
		{
			map[key] = value.liked/value.total;
		});
		flavorProfile.yeast.forEach((String key, Liked value)
		{
			map[key] = value.liked/value.total;
		});
		flavorProfile.abv.forEach((String key, Liked value)
		{
			map[key] = value.liked/value.total;
		});
		flavorProfile.ibu.forEach((String key, Liked value)
		{
			map[key] = value.liked/value.total;
		});
		flavorProfile.brewery.forEach((String key, Liked value)
		{
			map[key] = value.liked/value.total;
		});
		flavorProfile.style.forEach((String key, Liked value)
		{
			map[key] = value.liked/value.total;
		});
		
		return map;
	}
	
  void like(Map map, bool like)
	{
    print(map);
		if(map["style"]["name"] != null)
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
			
			if(flavorProfile.style[style] != null)
			{
				flavorProfile.style[style].total++;
				if(like)
					flavorProfile.style[style].liked++;
			}
			else
			{
				if(like)
					flavorProfile.style[style] = new Liked(1.0,1.0);
				else
					flavorProfile.style[style] = new Liked(1.0,0.0);
			}
		}
		if(map["abv"] != null)
		{
			double abv = double.parse(map["abv"]);
			if(abv <= 4.5)
			{
				if(flavorProfile.abv["low-abv"] != null)
				{
					flavorProfile.abv["low-abv"].total++;
					if(like)
                   		flavorProfile.abv["low-abv"].liked++;
				}
				else
				{
					if(like)
						flavorProfile.abv["low-abv"] = new Liked(1.0,1.0);
					else
						flavorProfile.abv["low-abv"] = new Liked(1.0,0.0);
				}
			}
			else if(abv > 4.5 && abv <= 7)
			{
				if(flavorProfile.abv["mid-abv"] != null)
				{
					flavorProfile.abv["mid-abv"].total++;
					if(like)
                   		flavorProfile.abv["mid-abv"].liked++;
					}
					else
					{
						if(like)
							flavorProfile.abv["mid-abv"] = new Liked(1.0,1.0);
						else
							flavorProfile.abv["mid-abv"] = new Liked(1.0,0.0);
					}
			}
			else
			{
				if(flavorProfile.abv["high-abv"] != null)
				{
					flavorProfile.abv["high-abv"].total++;
					if(like)
                   		flavorProfile.abv["high-abv"].liked++;
				}
				else
				{
					if(like)
						flavorProfile.abv["high-abv"] = new Liked(1.0,1.0);
					else
						flavorProfile.abv["high-abv"] = new Liked(1.0,0.0);
				}
			}
		}
		if(map["ibu"] != null)
		{
			double ibu = double.parse(map["ibu"]);
			if(ibu <= 20)
			{
				if(flavorProfile.ibu["xlow-ibu"] != null)
                {
					flavorProfile.ibu["xlow-ibu"].total++;
					if(like)
						flavorProfile.ibu["xlow-ibu"].liked++;
                }
                else
                {
                	if(like)
                		flavorProfile.ibu["xlow-ibu"] = new Liked(1.0,1.0);
                	else
                		flavorProfile.ibu["xlow-ibu"] = new Liked(1.0,0.0);
                }
			}
			else if(ibu > 20 && ibu <= 40)
			{
				if(flavorProfile.ibu["low-ibu"] != null)
                {
					flavorProfile.ibu["low-ibu"].total++;
					if(like)
						flavorProfile.ibu["low-ibu"].liked++;
                }
                else
                {
                	if(like)
                		flavorProfile.ibu["low-ibu"] = new Liked(1.0,1.0);
                	else
                		flavorProfile.ibu["low-ibu"] = new Liked(1.0,0.0);
                }
			}
			else if(ibu > 40 && ibu <= 60)
			{
				if(flavorProfile.ibu["mid-ibu"] != null)
                {
					flavorProfile.ibu["mid-ibu"].total++;
					if(like)
						flavorProfile.ibu["mid-ibu"].liked++;
                }
                else
                {
                	if(like)
                		flavorProfile.ibu["mid-ibu"] = new Liked(1.0,1.0);
                	else
                		flavorProfile.ibu["mid-ibu"] = new Liked(1.0,0.0);
                }
			}
			else
			{
				if(flavorProfile.ibu["high-ibu"] != null)
                {
					flavorProfile.ibu["high-ibu"].total++;
					if(like)
						flavorProfile.ibu["high-ibu"].liked++;
                }
                else
                {
                	if(like)
                		flavorProfile.ibu["high-ibu"] = new Liked(1.0,1.0);
                	else
                		flavorProfile.ibu["high-ibu"] = new Liked(1.0,0.0);
                }
			}
		}
		if(map["ingredients"] != null)
		{
			if(map["ingredients"]["hops"] != null)
			{
				List<Map<String,String>> hops = map["ingredients"]["hops"];
				hops.forEach((Map<String,String> hop)
				{
					if(flavorProfile.hops[hop["name"]] != null)
					{
						flavorProfile.hops[hop["name"]].total++;
						if(like)
							flavorProfile.hops[hop["name"]].liked++;
					}
					else
					{
						if(like)
							flavorProfile.hops[hop["name"]] = new Liked(1.0,1.0);
						else
							flavorProfile.hops[hop["name"]] = new Liked(1.0,0.0);
					}
				});
			}
			if(map["ingredients"]["malt"] != null)
           	{
				List<Map<String,String>> malts = map["ingredients"]["malt"];
				malts.forEach((Map<String,String> malt)
				{
					if(flavorProfile.malt[malt["name"]] != null)
					{
						flavorProfile.malt[malt["name"]].total++;
						if(like)
							flavorProfile.malt[malt["name"]].liked++;
					}
					else
					{
						if(like)
							flavorProfile.malt[malt["name"]] = new Liked(1.0,1.0);
						else
							flavorProfile.malt[malt["name"]] = new Liked(1.0,0.0);
					}
				});
			}
			if(map["ingredients"]["yeast"] != null)
            {
				List<Map<String,String>> yeasts = map["ingredients"]["yeast"];
				yeasts.forEach((Map<String,String> yeast)
				{
					if(flavorProfile.yeast[yeast["name"]] != null)
					{
						flavorProfile.yeast[yeast["name"]].total++;
						if(like)
							flavorProfile.yeast[yeast["name"]].liked++;
					}
					else
					{
						if(like)
							flavorProfile.yeast[yeast["name"]] = new Liked(1.0,1.0);
						else
							flavorProfile.yeast[yeast["name"]] = new Liked(1.0,0.0);
					}
				});
			}
		}
		if(map["breweries"] != null)
		{
			List<Map<String,String>> breweries = map["breweries"];
			breweries.forEach((Map<String,String> brewery)
			{
				if(flavorProfile.brewery[brewery["name"]] != null)
				{
					flavorProfile.brewery[brewery["name"]].total++;
					if(like)
						flavorProfile.brewery[brewery["name"]].liked++;
				}
				else
				{
					if(like)
						flavorProfile.brewery[brewery["name"]] = new Liked(1.0,1.0);
					else
						flavorProfile.brewery[brewery["name"]] = new Liked(1.0,0.0);
				}
			});
		}
		
		String json = toJSON();
		localStorage["loggedIn"] = json;
		
		String url = "http://beersherpaapp.appspot.com/updateUser?email=$email&password=$password&user=$json";
		HttpRequest.request(url, method: "GET").then((HttpRequest request)
		{
			//print(request.responseText);
		});
	}
	
	String toJSON()
	{
		String jsonString = '{';
		jsonString += '"email":"$email",';
		jsonString += '"password":"$password",';
		jsonString += '"flavorProfile":{';
		
		jsonString += '"hops":[';
		flavorProfile.hops.forEach((String key, Liked value)
		{
			jsonString += '{"$key":{"liked":"${value.liked}", "total":"${value.total}"}},';
		});
		if(jsonString.endsWith(","))
        	jsonString = jsonString.substring(0, jsonString.length-1); //cut off last ','
		jsonString += "],";
		
		jsonString += '"malt":[';
		flavorProfile.malt.forEach((String key, Liked value)
		{
			jsonString += '{"$key":{"liked":"${value.liked}", "total":"${value.total}"}},';
		});
		if(jsonString.endsWith(","))
        	jsonString = jsonString.substring(0, jsonString.length-1); //cut off last ','
		jsonString += "],";
		
		jsonString += '"yeast":[';
		flavorProfile.yeast.forEach((String key, Liked value)
		{
			jsonString += '{"$key":{"liked":"${value.liked}", "total":"${value.total}"}},';
		});
		if(jsonString.endsWith(","))
        	jsonString = jsonString.substring(0, jsonString.length-1); //cut off last ','
		jsonString += "],";

		jsonString += '"ibu":[';
		flavorProfile.ibu.forEach((String key, Liked value)
		{
			jsonString += '{"$key":{"liked":"${value.liked}", "total":"${value.total}"}},';
		});
		if(jsonString.endsWith(","))
        	jsonString = jsonString.substring(0, jsonString.length-1); //cut off last ','
		jsonString += "],";

		jsonString += '"abv":[';
		flavorProfile.abv.forEach((String key, Liked value)
		{
			jsonString += '{"$key":{"liked":"${value.liked}", "total":"${value.total}"}},';
		});
		if(jsonString.endsWith(","))
        	jsonString = jsonString.substring(0, jsonString.length-1); //cut off last ','
		jsonString += "],";
        		
		jsonString += '"style":[';
		flavorProfile.style.forEach((String key, Liked value)
		{
			jsonString += '{"$key":{"liked":"${value.liked}", "total":"${value.total}"}},';
		});
		if(jsonString.endsWith(","))
        	jsonString = jsonString.substring(0, jsonString.length-1); //cut off last ','
		jsonString += "],";
        		
		jsonString += '"brewery":[';
		flavorProfile.brewery.forEach((String key, Liked value)
		{
			jsonString += '{"$key":{"liked":"${value.liked}", "total":"${value.total}"}},';
		});
		if(jsonString.endsWith(","))
        	jsonString = jsonString.substring(0, jsonString.length-1); //cut off last ','
		jsonString += "]}}";
        				
		return jsonString;
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
	
	String stringValue(String range)
	{
		String profile = "";
		
		if(range == "all" || range == "hops")
		{
			hops.forEach((String key, Liked value)
			{
				for(int i=0; i<value.liked; i++)
					profile += " $key";
			});
		}
		if(range == "all" || range == "malt")
        {
			malt.forEach((String key, Liked value)
    		{
    			for(int i=0; i<value.liked; i++)
    				profile += " $key";
    		});
        }
		if(range == "all" || range == "yeast")
        {
			yeast.forEach((String key, Liked value)
			{
				for(int i=0; i<value.liked; i++)
					profile += " $key";
			});
        }
		if(range == "all" || range == "ibu")
        {
			ibu.forEach((String key, Liked value)
			{
				for(int i=0; i<value.liked; i++)
					profile += " $key";
			});
        }
		if(range == "all" || range == "abv")
		{
			abv.forEach((String key, Liked value)
			{
				for(int i=0; i<value.liked; i++)
					profile += " $key";
			});
		}
		if(range == "all" || range == "style")
		{
			style.forEach((String key, Liked value)
			{
				for(int i=0; i<value.liked; i++)
					profile += " $key";
			});
		}
		if(range == "all" || range == "brewery")
		{
			brewery.forEach((String key, Liked value)
			{
				for(int i=0; i<value.liked; i++)
					profile += " $key";
			});
		}
		return profile;
	}
}

class Liked
{
	double total, liked;
	
	Liked(var total,var liked)
	{
		try
		{
			this.total = double.parse(total);
			this.liked = double.parse(liked);
		}
		catch(error)
		{
			this.total = total;
			this.liked = liked;
		}
	}
}