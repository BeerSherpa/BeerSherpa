part of BeerSherpa;

void Search(){
  var url = "http://beersherpaapp.appspot.com/api?endpoint=beers";  
  var request = HttpRequest.getString(url).then(onDataLoaded);
}

void onDataLoaded(String responseText) {
  var jsonString = responseText;
  print(jsonString);
}