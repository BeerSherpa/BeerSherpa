part of BeerSherpa;

int MAX_RESULTS = 40; //Limit search to x results (note: we only consider beers and breweries from the first x results -- therefore this number does not guarentee x hits)

var currentResult;
var currentCard;
NumberFormat formatter = new NumberFormat("##%");


void initSearch(){
  //Init listener for advice button
  querySelector("#advice-button-submit")..onClick.listen((MouseEvent e) => advice());
  //Same for tasts textfield
  querySelector("#tastes-button-submit")..onClick.listen((MouseEvent e) => tastes());
  //ftu
  querySelector("#ftu-button-submit")..onClick.listen((MouseEvent e) => ftu());
  
  
  //Set button listens
  querySelector("#ftu-yum")..onClick.listen((MouseEvent e) //SPECIAL YAY
  {
    currentUser.like(currentResult, true);
    fadeFtuCard();//SPECIAL
  });
  querySelector("#advice-yum")..onClick.listen((MouseEvent e)
  {
    currentUser.like(currentResult, true);
    fadeCard(currentCard);
  });
  querySelector("#advice-yuk")..onClick.listen((MouseEvent e)
  {
    currentUser.like(currentResult, false);
    fadeCard(currentCard);
  });
  querySelector("#tastes-yum")..onClick.listen((MouseEvent e)
  {
    currentUser.like(currentResult, true);
    fadeCard(currentCard);
  });
  querySelector("#tastes-yuk")..onClick.listen((MouseEvent e)
  {
    currentUser.like(currentResult, false);
    fadeCard(currentCard);
  });
}

void Search(String query){
  //Create url
  String url = "http://beersherpaapp.appspot.com/api?endpoint=search&q=$query&withBreweries=Y&withIngredients=Y";
  //Send request
  var request = HttpRequest.getString(url).then(showResults);
}

void SearchBeer(String query){
  //Create url 
  String url = "http://beersherpaapp.appspot.com/api?endpoint=search&q=$query&type=beer&withBreweries=Y&withIngredients=Y";
  //Send request
  var request = HttpRequest.getString(url).then(showResults);
}

/*
 * Go through all results and build HTML
 */
void showResults(String responseText) {
  
  String jsonString = responseText;

  //Decode the response
  Map parsedMap = JSON.decode(jsonString);
  
  //Get the Total Number of Results from header
  int totalResults = parsedMap["totalResults"];

  //If no results, display the label and thats it
  if(totalResults == null){
  
    HeadingElement h1 = new HeadingElement.h1();
    SpanElement noresultsfound = new SpanElement()..className="label label-warning"..text="No results found.";
    
    h1.append(noresultsfound);
    
    querySelector("#scroll-results").append(h1);

  } else { //We have results, so do things with them
    
    //Limit to MAX_RESULTS results
    if(totalResults > MAX_RESULTS){
      totalResults = MAX_RESULTS;
    }
    
    //Get just the data
    List dataList = parsedMap["data"];
    Map singleResult; //declare
    UListElement newul = new UListElement()..className="list-unstyled"; //declare
    
    //build html for each result
    for(int i = 0; i < totalResults; i++){
      
      singleResult = dataList[i]; //Get the map of data from the list
      
      //Only consider beers and breweries from MAX_RESULTS number of results
      if(singleResult["type"] == "beer"){
        //set image of beer (labels{})
        Map images = singleResult["labels"];
        addResult(singleResult, newul, images);   
      } else if (singleResult["type"] == "brewery"){
        //set image of brewery (images{})
        Map images = singleResult["images"];        
        addResult(singleResult, newul, images); //catch body to add img to         
      }
        
      
    } //end for
    
    //Add the UL to the search result modal
    querySelector("#searchResults").querySelector("#scroll-results").append(newul);
    

  } //end else
  
}

/*
 * Add result as a list item to the UL
 * returns the panelBody for image placement
 */
void addResult(Map singleResult, UListElement ul, Map images){
  
  LIElement newli = new LIElement()..className="result-li"..setAttribute("data-dismiss", "modal")..onClick.listen((MouseEvent e) => selectedResult(singleResult));
  DivElement row = new DivElement()..className="row";
  DivElement col4 = new DivElement()..className="col-sm-4";
  DivElement col8 = new DivElement()..className="col-sm-8"..text="${singleResult["description"]}";
  DivElement panel = new DivElement()..className="panel panel-default";
  DivElement panelHeading = new DivElement()..className="panel-heading";
  DivElement panelBody = new DivElement()..className="panel-body";
  HeadingElement panelTitle = new HeadingElement.h3()..className="panel-title"..text="${singleResult["name"]}  ";

  //Get brewery name
  List listd = singleResult["breweries"];
  
  if (listd != null){
    Map brewery = listd[0];
    SpanElement brewspan = new SpanElement()..className="text-muted small"..text="${brewery["name"]}";
    panelTitle.append(brewspan);
  }
  
  panelBody.append(row);
  row.append(col4);
  row.append(col8);
  
  String iconURL;
  if(images != null){
    iconURL = images["medium"];
  }
  
  //Create img and add it if needed
  if(iconURL != "null"){
    ImageElement icon = new ImageElement(src: iconURL);
    icon.className="img-responsive img-rounded";
    col4.append(icon);
  } else {
    col4.text = "[ no picture ]";
  }
  
  if(col8.text == "null"){
    panelBody.text = "[ no description ]";
  }
  

  
  panelHeading.append(panelTitle);
  panel.append(panelHeading);
  panel.append(panelBody);
  
  newli.append(panel);
  
  ul.append(newli);
  
}

/*
 * Create/edit the beer info card html
 */
void createBeerInfoCard(DivElement card, Map singleResult){  
    
    //Set Title
     card.querySelector(".beer-title").text = singleResult["name"];
     List listd = singleResult["breweries"];
    if (listd != null){
      Map brewery = listd[0];
      SpanElement brewspan = new SpanElement()..className="text-muted"..text="  --  ${brewery["name"]}";
      card.querySelector(".beer-title").append(brewspan);
    }
    
    
    //Set Description
    if(singleResult["description"] == null){
      card.querySelector(".beer-desc").text = "[ no description ]";
    } else {
      card.querySelector(".beer-desc").text = singleResult["description"];
    }
    
   
    //Create img and add it if can
    Map images = singleResult["labels"];
    if(images == null){
      //try images
      images = singleResult["images"];
    }
    String iconURL;
    if(images != null){
      iconURL = images["medium"];
    }
    if(iconURL != null){
      ImageElement icon = new ImageElement(src: iconURL);
      icon.className="img-responsive img-rounded";
      card.querySelector(".beer-img").append(icon);
    } else {
      card.querySelector(".beer-img").text = "[ no picture ]";
    }
    
    //Set ibu and abv
    if(singleResult["abv"] != null){
      card.querySelector(".beer-abv").classes.remove("hidden");
      card.querySelector(".beer-abv").text = singleResult["abv"] + " ABV";
    }
    
    if(singleResult["ibu"] != null){
      card.querySelector(".beer-ibu").classes.remove("hidden");
      card.querySelector(".beer-ibu").text = singleResult["ibu"] + " IBU";
      
    }
    
    currentCard = card;
    currentResult = singleResult;
    
    card.classes.remove("hidden");
	window.scroll(0, querySelector("#results-jumbotron").offsetTop-70);
}

void fadeCard(Element card)
{
	card.classes.add("fade");
	new Timer.periodic(new Duration(seconds:1), (Timer timer)
	{
		timer.cancel();
		card.classes.remove("fade");
		card.classes.add("hidden");
	});
}

void fadeFtuCard()
{
  querySelector("#ftu-page").classes.add("fade");
  querySelector("#normal-nav").classes.remove("hidden");
  querySelector("#ftu-style-jumbotron").querySelectorAll("input").forEach((Element e) {
   
    String style = e.id;
    
    if((e as InputElement).checked){
      currentUser.flavorProfile.style[style]=new Liked(1.0,1.0);
    }
    
  });
  new Timer.periodic(new Duration(seconds:1), (Timer timer)
  {
    timer.cancel();
    querySelector("#ftu-page").classes.remove("fade");
    querySelector("#ftu-page").classes.add("hidden");
    currentCard.classes.add("hidden");
    querySelector("#results-jumbotron").classes.add("hidden");
    querySelector("#advice-page").classes.remove("hidden");
  });
}


/*
 * 
 * LISTENER CALLBACKS:
 * 
 */
void selectedResult(Map singleResult){
  
  if(!querySelector("#advice-page").classes.contains("hidden")){ //if the advice page is not hidden, we will assume we are seeking advice
  
    querySelector("#advice-beer-card").classes.remove("hidden");
    querySelector("#results-jumbotron").classes.remove("hidden");
    DivElement card = querySelector("#advice-beer-card");   
    createBeerInfoCard(card, singleResult);
    
    if(currentUser != null)
    {
    	Map<String,double> userVector = currentUser.getVector();
    	querySelector("#hops-list-group").children.clear();
    	querySelector("#malt-list-group").children.clear();
    	querySelector("#yeast-list-group").children.clear();
    	querySelector("#abv-list-group").children.clear();
    	querySelector("#ibu-list-group").children.clear();
    	
    	double similarity = getDistance(getBeerVector(singleResult),userVector);
        querySelector("#distance").text = formatter.format(similarity);
        if(similarity <= .25)
        	querySelector("#love-word").text = "Hate";
        else if(similarity > .25 && similarity <= .50)
        	querySelector("#love-word").text = "Tolerate";
        else if(similarity > .50 && similarity <= .75)
            querySelector("#love-word").text = "Like";
        else if(similarity > .75)
            querySelector("#love-word").text = "Love";
        
        Map<String,double> hopsVector = getBeerVector(singleResult,type:"hops");
        hopsVector.forEach((String name, double value) => buildList("hops",name,userVector));
        similarity = getDistance(hopsVector,userVector);
        if(similarity > 0)
        {
        	Element e = querySelector("#hops-match");
        	e.text = formatter.format(similarity);
        	e.parent.classes.remove("hidden");
        }
        else
        	querySelector("#hops-match").parent.classes.add("hidden");
        
        Map<String,double> maltVector = getBeerVector(singleResult,type:"malt");
        maltVector.forEach((String name, double value) => buildList("malt",name,userVector));
        similarity = getDistance(maltVector,userVector);
        if(similarity > 0)
        {
        	Element e = querySelector("#malt-match");
        	e.text = formatter.format(similarity);
        	e.parent.classes.remove("hidden");
        }
        else
        	querySelector("#malt-match").parent.classes.add("hidden");
        
        Map<String,double> yeastVector = getBeerVector(singleResult,type:"yeast");
        hopsVector.forEach((String name, double value) => buildList("yeast",name,userVector));
		similarity = getDistance(yeastVector,userVector);
		if(similarity > 0)
        {
        	Element e = querySelector("#yeast-match");
        	e.text = formatter.format(similarity);
        	e.parent.classes.remove("hidden");
        }
        else
        	querySelector("#yeast-match").parent.classes.add("hidden");
		
		Map<String,double> abvVector = getBeerVector(singleResult,type:"abv");
        abvVector.forEach((String name, double value) => buildList("abv",name,userVector));
		similarity = getDistance(abvVector,userVector);
		if(similarity > 0)
        {
        	Element e = querySelector("#abv-match");
        	e.text = formatter.format(similarity);
        	e.parent.classes.remove("hidden");
        }
        else
        	querySelector("#abv-match").parent.classes.add("hidden");
		
		Map<String,double> ibuVector = getBeerVector(singleResult,type:"ibu");
        ibuVector.forEach((String name, double value) => buildList("ibu",name,userVector));
		similarity = getDistance(ibuVector,userVector);
		if(similarity > 0)
        {
        	Element e = querySelector("#ibu-match");
        	e.text = formatter.format(similarity);
        	e.parent.classes.remove("hidden");
        }
        else
        	querySelector("#ibu-match").parent.classes.add("hidden");
		
		getBeerVector(singleResult,type:"brewery").forEach((String name,double score)
		{
			if(userVector.containsKey(name))
				querySelector("#fav-brewery").classes.remove("hidden");
			else
				querySelector("#fav-brewery").classes.add("hidden");
		});
		getBeerVector(singleResult,type:"style").forEach((String name,double score)
		{
			if(userVector.containsKey(name))
				querySelector("#fav-style").classes.remove("hidden");
			else
				querySelector("#fav-style").classes.add("hidden");
		});
		
		print(confidence(singleResult,userVector));
    }
    
    //format the styling
    
  } else if (!querySelector("#tastes-page").classes.contains("hidden")) { //the advice page is hidden, we will check the tastes
    
    querySelector("#tastes-beer-card").classes.remove("hidden");
    DivElement card = querySelector("#tastes-beer-card");   
    createBeerInfoCard(card, singleResult);
    
  } else if (!querySelector("#ftu-page").classes.contains("hidden")) {
    
    querySelector("#ftu-beer-card").classes.remove("hidden");
    DivElement card = querySelector("#ftu-beer-card");   
    createBeerInfoCard(card, singleResult);
    
  }
  
  
}

double confidence(Map singleResult, Map<String,double> userVector)
{
	double confidence = 0.0;
	double hitceil = 200.0;
	int numHits = currentUser.numHits;
	bool hit = false;
	
	confidence = .05+((hitceil-numHits)*(.5-.15)/hitceil) + .15 + 3*(.2-((hitceil-numHits)*(.2-0)/hitceil)) + .15 - ((hitceil - numHits)*(.15-0)/hitceil) + .05- ((hitceil-numHits)*(.05-0)/hitceil);
	getBeerVector(singleResult,type:"brewery").forEach((String name, double value)
	{
		if(userVector[name] != null)
			hit = true;
	});
	if(!hit)
		confidence -= .01;
	hit = false;
	getBeerVector(singleResult,type:"style").forEach((String name, double value)
	{
		if(userVector[name] != null)
        	hit = true;
	});
	if(!hit)
    	confidence -= .09;
    hit = false;
	getBeerVector(singleResult,type:"hops").forEach((String name, double value)
	{
		if(userVector[name] != null)
                	hit = true;
	});
	if(!hit)
    	confidence -= .05;
    hit = false;
	getBeerVector(singleResult,type:"malt").forEach((String name, double value)
	{
		if(userVector[name] != null)
        	hit = true;
	});
	if(!hit)
    	confidence -= .05;
    hit = false;
	getBeerVector(singleResult,type:"yeast").forEach((String name, double value)
	{
		if(userVector[name] != null)
        	hit = true;
	});
	if(!hit)
    	confidence -= .05;
    hit = false;
	getBeerVector(singleResult,type:"ibu").forEach((String name, double value)
	{
		if(userVector[name] != null)
        	hit = true;
	});
	if(!hit)
    	confidence -= .05;
    hit = false;
	getBeerVector(singleResult,type:"abv").forEach((String name, double value)
	{
		if(userVector[name] != null)
        	hit = true;
	});
	if(!hit)
    	confidence -= .01;
	
	return confidence;
}

void buildList(String type, String name, Map userVector)
{
	UListElement element = new UListElement();
	
	if(userVector[name] != null)
		element.className = "list-group-item list-group-item-success";
	else
		element.className = "list-group-item";
	element.text = name;
	
	querySelector("#$type-list-group").append(element);
}

void advice(){ //cant implement keyboard listener until we figure out how to triggle a data-toggle for the modal
  querySelector("#scroll-results").children.clear();
  querySelector("#advice-beer-card").classes.add("hidden");
  querySelector("#results-jumbotron").classes.add("hidden");
  querySelectorAll(".beer-img").forEach((Element e) => e.text=""); 
  querySelectorAll(".beer-desc").forEach((Element e) => e.text=""); 
  querySelectorAll(".beer-label").forEach((Element e) => e.text=""); 
  SearchBeer((querySelector("#advice-input-beer") as InputElement).value);
}

void tastes(){
  querySelector("#scroll-results").children.clear();
  querySelector("#tastes-beer-card").classes.add("hidden");
  querySelectorAll(".beer-img").forEach((Element e) => e.text=""); 
  querySelectorAll(".beer-desc").forEach((Element e) => e.text="");
  querySelectorAll(".beer-label").forEach((Element e) => e.text=""); 
  Search((querySelector("#tastes-input-beer") as InputElement).value);
}

void ftu(){
  querySelector("#scroll-results").children.clear();
  querySelector("#ftu-beer-card").classes.add("hidden");
  querySelectorAll(".beer-img").forEach((Element e) => e.text=""); 
  querySelectorAll(".beer-desc").forEach((Element e) => e.text="");
  querySelectorAll(".beer-label").forEach((Element e) => e.text=""); 
  Search((querySelector("#ftu-input-beer") as InputElement).value);
}





