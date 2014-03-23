package com.beersherpa;

import java.io.Serializable;

public class Liked implements Serializable
{
	private static final long serialVersionUID = 8302093454018839080L;
	int total, liked;
	
	Liked(int liked, int total)
	{
		this.liked = liked;
		this.total = total;
	}
	
	Liked()
	{
		
	}
}