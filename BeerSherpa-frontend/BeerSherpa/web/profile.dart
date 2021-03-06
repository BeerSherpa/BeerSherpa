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

	
	 

	
}