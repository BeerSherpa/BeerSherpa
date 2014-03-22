package com.beersherpa;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class APIRequestServlet extends HttpServlet
{
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException
	{
		Map<String,String[]> params = req.getParameterMap();
		
		String response = "";
		String urlString = "http://api.brewerydb.com/v2/";
		urlString += params.get("endpoint")[0];
		urlString += "?key=877b236e6d5925c5f85e795986ee5737";
		
		for(Map.Entry<String,String[]> param : params.entrySet())
		{
			if(!param.getKey().equals("endpoint"))
			{
				urlString += "&"+ param.getKey() + "=" + param.getValue()[0].replace(" ", "+");
			}
		}
				
		try
		{
			URL url = new URI(urlString).toURL();
			HttpURLConnection yc = (HttpURLConnection) url.openConnection();
	        BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream()));
	        String inputLine;

	        while ((inputLine = in.readLine()) != null) 
	            response += inputLine;
	        in.close();
	        
	        resp.addHeader("Access-Control-Allow-Origin", "*");
	        resp.setContentType("application/json");
			resp.getWriter().println(response);
		}
		catch(URISyntaxException e)
		{
			System.out.println("error: " + e.getMessage());
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
