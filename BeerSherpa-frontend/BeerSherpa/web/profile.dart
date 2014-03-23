part of BeerSherpa;

void initProfile()
{
	querySelectorAll(".wordcloud-button").forEach((Element element)
	{
		element.onClick.listen((MouseEvent event)
		{
			Element target = event.target;
			refreshWordCloud(target.id.substring(0, target.id.indexOf("-")));
		});
	});
}

void refreshWordCloud(String type)
{
  querySelector("#no-data-alert").classes.add("hidden");
	String text = currentUser.flavorProfile.stringValue(type);
	querySelector("#wc-row").classes.remove("hidden");
	if(querySelector("#wordcloud-img") != null)
    	querySelector("#wordcloud-img").remove();
	
	List wordList = text.split(" ");
	wordList.removeAt(0);

	if(wordList.isEmpty){
	  querySelector("#wc-row").classes.add("hidden");
	  querySelector("#no-data-alert").classes.remove("hidden");
	} else {
	 js.context.execute(new JsObject.jsify(wordList));
	}

	
	 

	
	/*getWordCloudUrl(text).then((String url)
	{
      	ImageElement img = new ImageElement()
      		..src = url
      		..id = "wordcloud-img"
      		..className = "img-responsive img-rounded center-block";
      	img.onLoad.listen((_)
  		{
      		querySelector("#spinner-img").classes.add("hidden");
      		querySelector("#wordcloud-row").append(img);
  		});
	});*/
}

Future<String> getWordCloudUrl(String text)
{
	List wordList = text.split(" ");
	wordList.removeAt(0);
	js.context.execute(new JsObject.jsify(wordList));
	
	Completer c = new Completer();
	
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