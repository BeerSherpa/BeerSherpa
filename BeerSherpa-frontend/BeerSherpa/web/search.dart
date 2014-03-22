part of BeerSherpa;

int MAX_RESULTS = 40; //Limit search to x results (note: we only consider beers and breweries from the first x results -- therefore this number does not guarentee x hits)

void initSearch(){
  //Init listener for advice button
  querySelector("#advice-button-submit")..onClick.listen((MouseEvent e) => advice());
}

void Search(String query){
  //Create url 
  String url = "http://beersherpaapp.appspot.com/api?endpoint=search&q=$query&withBreweries=Y";
  //Send request
  var request = HttpRequest.getString(url).then(showResults);
}

void SearchBeer(String query){
  //Create url 
  String url = "http://beersherpaapp.appspot.com/api?endpoint=search&q=$query&type=beer&withBreweries=Y";
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
  
  LIElement newli = new LIElement()..setAttribute("data-dismiss", "modal")..onClick.listen((MouseEvent e) => selectedResult(singleResult));
  DivElement row = new DivElement()..className="row";
  DivElement col4 = new DivElement()..className="col-sm-4";
  DivElement col8 = new DivElement()..className="col-sm-8"..text="${singleResult["description"]}";
  DivElement panel = new DivElement()..className="panel panel-info";
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
  if(iconURL != null){
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
 * 
 * LISTENER CALLBACKS:
 * 
 */
void selectedResult(Map singleResult){
  
  print(singleResult["id"]);
  
  
}

void advice(){
  querySelector("#scroll-results").children.clear();
  SearchBeer((querySelector("#advice-input-beer") as InputElement).value);
}






