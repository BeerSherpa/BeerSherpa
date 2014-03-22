part of BeerSherpa;

Future<String> getWordCloudUrl()
{
	Completer c = new Completer();
	
	String text = "";
	if(currentUser != null)
	{
		text = currentUser.flavorProfile.toString();
	}
	
	String text1 = 'Fireside Chat 7.9 45 Herb and Spice Beer Golding (American) Hop Magnum Hop Aromatic Malt  Black Malt - Debittered Caramel/Crystal Malt Chocolate Malt Munich Malt Pale Malt Wheat Malt';
    text = Uri.encodeComponent(text);
    String url = "https://gatheringpoint-word-cloud-maker.p.mashape.com/index.php?height=400&width=800&textblock=$text1";
	Map headers = {'X-Mashape-Authorization': 'Q5d3oXAVSAsamyr9yvcf9V8VEQihfeqW'};
    
	HttpRequest.request(url, method: 'GET', requestHeaders: headers).then((HttpRequest request)
  	{
		Map map = JSON.decode(request.response.toString());
		c.complete(map["url"]);
  	});
    
	return c.future;
}