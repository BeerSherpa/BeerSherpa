part of BeerSherpa;

void Search(){
  var url = "http://api.brewerydb.com/v2/?key=$APIKEY";  
  var request = HttpRequest.getString(url).then(onDataLoaded);
}

void onDataLoaded(String responseText) {
  var jsonString = responseText;
  print(jsonString);
}