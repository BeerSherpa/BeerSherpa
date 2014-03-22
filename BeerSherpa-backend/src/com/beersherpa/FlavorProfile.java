package com.beersherpa;

import java.io.Serializable;
import java.util.HashMap;

public class FlavorProfile implements Serializable
{
	private static final long serialVersionUID = 1223834394709789457L;
	HashMap<String,Liked> hops, malt, yeast, abv, ibu, style, brewery;
	
	public FlavorProfile()
	{
		hops = new HashMap<String,Liked>();
		malt = new HashMap<String,Liked>();
		yeast = new HashMap<String,Liked>();
		abv = new HashMap<String,Liked>();
		ibu = new HashMap<String,Liked>();
		style = new HashMap<String,Liked>();
		brewery = new HashMap<String,Liked>();
	}
}