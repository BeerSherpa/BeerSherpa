part of BeerSherpa;

void refreshWordCloud()
{
	getWordCloudUrl().then((String url)
	{
      	ImageElement img = new ImageElement()
      		..src = url
      		..className = "img-responsive img-rounded center-block";
      	img.onLoad.listen((_)
  		{
      		querySelector("#wordcloud-row").children.clear();
      		querySelector("#wordcloud-row").append(img);
  		});
	});
}

Future<String> getWordCloudUrl()
{
	Completer c = new Completer();
	
	String text = "";
	if(currentUser != null)
	{
		text = currentUser.flavorProfile.toString();
	}
	
    text = Uri.encodeComponent(text);
    String url = "https://gatheringpoint-word-cloud-maker.p.mashape.com/index.php?height=400&width=800&textblock=$text";
	Map headers = {'X-Mashape-Authorization': 'Q5d3oXAVSAsamyr9yvcf9V8VEQihfeqW'};
    
	HttpRequest.request(url, method: 'GET', requestHeaders: headers).then((HttpRequest request)
  	{
		Map map = JSON.decode(request.response.toString());
		c.complete(map["url"]);
  	});
    
	return c.future;
}