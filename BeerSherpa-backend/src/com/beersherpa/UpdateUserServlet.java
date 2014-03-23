package com.beersherpa;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;

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
public class UpdateUserServlet extends HttpServlet
{
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	MemcacheService memcache = MemcacheServiceFactory.getMemcacheService();
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		resp.addHeader("Access-Control-Allow-Origin", "*");
		
		String email = (String) req.getParameter("email");
		String password = (String) req.getParameter("password");
		
		String userString = (String) req.getParameter("user");
		userString.replace("%22", "\"");
		
		Gson gson = new Gson();
		User u = gson.fromJson(userString, User.class);
		
		Entity user = getUserEntity(email);
		if(user == null)
		{
			resp.setContentType("text/plain");
			resp.getWriter().println("no user exists");
		}
		else
		{
			ByteArrayOutputStream stream = new ByteArrayOutputStream();
			ObjectOutputStream os = new ObjectOutputStream(stream);
			os.writeObject(u);
			Blob blob = new Blob(stream.toByteArray());
			user.setProperty("userObject", blob);
			user.setProperty("password", password);
			
			memcache.put(user, "user_"+email);
			datastore.put(user);
			
			resp.setContentType("text/plain");
			resp.getWriter().println("success");
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
