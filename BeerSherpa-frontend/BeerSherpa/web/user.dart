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
}