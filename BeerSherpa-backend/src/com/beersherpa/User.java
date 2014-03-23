package com.beersherpa;

import java.io.Serializable;

public class User implements Serializable
{
	private static final long serialVersionUID = -7301129247267086477L;
	
	FlavorProfile flavorProfile;
	String email, password;
	int numHits = 0, index = 0;
}