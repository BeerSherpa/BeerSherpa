package com.beersherpa;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.Blob;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.gson.Gson;

@SuppressWarnings("serial")
public class LoginServlet extends HttpServlet
{
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	MemcacheService memcache = MemcacheServiceFactory.getMemcacheService();
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		resp.addHeader("Access-Control-Allow-Origin", "*");
		
		String email = (String) req.getParameter("email");
		String password = (String) req.getParameter("password");
				
		Entity user = getUserEntity(email);
		if(user == null)
		{
			fail(resp);
		}
		else
		{
			if(!user.getProperty("password").toString().equals(password))
				fail(resp);
			
			User u = new User();
			u.email = email;
			u.password = password;
			
			Blob profile = (Blob)user.getProperty("flavorProfile");
			if(profile != null)
			{
				try
				{
					ObjectInputStream ois = new ObjectInputStream(new ByteArrayInputStream(profile.getBytes()));
					u.flavorProfile = (FlavorProfile) ois.readObject();
				}
				catch(ClassNotFoundException ex){}
			}
			else
				u.flavorProfile = new FlavorProfile();
			
			resp.setContentType("application/json");
			Gson gson = new Gson();
			String json = gson.toJson(u);
			resp.getWriter().print(json);
		}
	}
	
	private void fail(HttpServletResponse resp) throws IOException
	{
		resp.setContentType("text/plain");
		resp.getWriter().println("no user exists");
	}
	
	private Entity getUserEntity(String email)
	{
		Entity user = null;
		if(memcache.contains("user_" + email))
			user = ((Entity) memcache.get("user_" + email));
		else
		{
			try
			{
				user = datastore.get(KeyFactory.createKey("User", email));
			}
			catch(EntityNotFoundException ex)
			{}
		}
		return user;
	}
}
