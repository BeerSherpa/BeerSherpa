part of BeerSherpa;

int MAX_RESULTS = 40; //Limit search to x results (note: we only consider beers and breweries from the first x results -- therefore this number does not guarentee x hits)

void Search(String query){
  //Create url 
  String url = "http://beersherpaapp.appspot.com/api?endpoint=search&q=$query";
  //Send request
  var request = HttpRequest.getString(url).then(showResults);
}

void SearchBeer(String query){
  //Create url 
  String url = "http://beersherpaapp.appspot.com/api?endpoint=search&q=$query&type=beer";
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
    querySelector("#searchResults").querySelector("#modal-no-results").classes.remove("hidden");
  } else { //We have results, so do things with them
    
    //Limit to MAX_RESULTS results
    if(totalResults > MAX_RESULTS){
      totalResults = MAX_RESULTS;
    }
    
    //Get just the data
    List dataList = parsedMap["data"];
    Map singleResult; //declare
    
    for(int i = 0; i < totalResults; i++){
      
      singleResult = dataList[i]; //Get the map of data from the list
      
      //Only consider beers and breweries from MAX_RESULTS number of results
      if(singleResult["type"] == "beer"){
        addResult(singleResult);
        //set image of beer (labels{})
        singleResult["labels"];
        
        
      } else if (singleResult["type"] == "brewery"){
        addResult(singleResult);
        //set image of brewery (images{})
        singleResult["images"];
        
      }
        
      
    } //end for
    

  } //end else
  
}

/*
 * Add result as a list item to the UL
 */
void addResult(Map singleResult){
  
  LIElement newli = new LIElement()..onClick.listen((MouseEvent e) => selectedResult(singleResult));
  DivElement panel = new DivElement()..className="panel panel-default";
  DivElement panelHeading = new DivElement()..className="panel-heading";
  DivElement panelBody = new DivElement()..className="panel-body"..text="${singleResult["description"]}";
  HeadingElement panelTitle = new HeadingElement.h3()..className="panel-title"..text="${singleResult["name"]}";
  
  if(panelBody.text == "null"){
    panelBody.text = "[ no description ]";
  }
  
  panelHeading.append(panelTitle);
  panel.append(panelHeading);
  panel.append(panelBody);
  
  newli.append(panel);
  
  querySelector("#actual-results").append(newli);
  
  
  
}

void selectedResult(Map singleResult){
  
}







