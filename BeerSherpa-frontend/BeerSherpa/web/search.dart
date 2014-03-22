part of BeerSherpa;

void Search(){
  
  var url = "http://api.brewerydb.com/v2/?key=$APIKEY";
  
  http.get(url).then((response) {
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    
    
  });
  
}