package com.beersherpa;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;

public class FlavorProfile implements Serializable
{
	private static final long serialVersionUID = 1223834394709789457L;
	ArrayList<HashMap<String,Liked>> hops, malt, yeast, abv, ibu, style, brewery;
	
	public FlavorProfile()
	{
		hops = new ArrayList<HashMap<String,Liked>>();
		malt = new ArrayList<HashMap<String,Liked>>();
		yeast = new ArrayList<HashMap<String,Liked>>();
		abv = new ArrayList<HashMap<String,Liked>>();
		ibu = new ArrayList<HashMap<String,Liked>>();
		style = new ArrayList<HashMap<String,Liked>>();
		brewery = new ArrayList<HashMap<String,Liked>>();
	}
}