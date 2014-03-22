package com.beersherpa;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;

@SuppressWarnings("serial")
public class CreateUserServlet extends HttpServlet
{
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	MemcacheService memcache = MemcacheServiceFactory.getMemcacheService();
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		String email = (String) req.getParameter("email");
		String password = (String) req.getParameter("password");
		
		Entity user = getUserEntity(email);
		if(user == null)
		{
			user = new Entity("User",email);
			user.setProperty("email", email);
			user.setProperty("password", password);
			user.setProperty("flavorProfile", new FlavorProfile());
			
			memcache.put(user, "user_"+email);
			datastore.put(user);
			
			resp.setContentType("text/plain");
			resp.getWriter().println("success");
		}
		else
		{
			resp.setContentType("text/plain");
			resp.getWriter().println("already exists");
		}
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
