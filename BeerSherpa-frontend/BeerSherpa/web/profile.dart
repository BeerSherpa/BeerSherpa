part of BeerSherpa;

Future<String> getWordCloudUrl()
{
	Completer c = new Completer();
	String text = 'Fireside Chat 7.9 45 Herb and Spice Beer Golding (American) Hop Magnum Hop Aromatic Malt  Black Malt - Debittered Caramel/Crystal Malt Chocolate Malt Munich Malt Pale Malt Wheat Malt';
    text = Uri.encodeComponent(text);
    String url = "https://gatheringpoint-word-cloud-maker.p.mashape.com/index.php?height=400&width=600&textblock=$text";
	Map headers = {'X-Mashape-Authorization': 'Q5d3oXAVSAsamyr9yvcf9V8VEQihfeqW'};
    var request = HttpRequest.getString(url).then((result)
	{
		print(result);
		c.complete(result.toString());
	});
    
	return c.future;
}