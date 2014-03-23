part of BeerSherpa;

//init a list of beer id's 
List beerids = ["8vBYrZ", "qeXBVh", "hj7N75", "ULQE3L", "w1ndc4", "z4k3eU", "vbJQ8t", "Lf1c6i", "iqX54w", "baONtD", "9GtCUG", "yy3cTm", "m3xewW", "cJio9R", "WHQisc", "odItSS", "Uiol9p", "UD5Sm4", "CrEWhc", "Gkd1YS", "eqtMQs", "X4JKZd", "9kidXn", "UpiAAy", "25lKg4", "I4vp71", "187kFc", "rtMecd", "tPayGU", "zYJxUM", "KY5gtZ", "pBfN8o", "CJpcWg", "lHlnqe", "EiCuSk", "RVOBIF", "L7OSOj", "Q9PlwV"];

Map currentData;
int currentNumber;

void initRandom(){
  querySelector("#rate-button-skip")..onClick.listen((MouseEvent e) => skip());
  //Listeners for yak / yum 
  querySelector("#rate-button-yum")..onClick.listen((MouseEvent e) {
    currentUser.like(currentData, true);
    populateTrack();
  });
  querySelector("#rate-button-yuk")..onClick.listen((MouseEvent e) {
    currentUser.like(currentData, false);
    populateTrack();
  }); 
  
  currentNumber = currentUser.index;
  
  populateTrack();
  
}

//get a random one
void populateTrack(){
  if(currentNumber < beerids.length){
    int trackIndex = currentNumber++;
    currentUser.index = currentNumber;
    String id = beerids[trackIndex];
     //Create url 
    String url = "http://beersherpaapp.appspot.com/api?endpoint=beer/$id&withBreweries=Y";
    //Send request
    var request = HttpRequest.getString(url).then(buildResult);
  } else {
    populateRandom();
  }
}

void populateRandom(){
  //get header info
  String url = "http://beersherpaapp.appspot.com/api?endpoint=beers&hasLabels=Y";
  var request = HttpRequest.getString(url).then(parseHeader);
 
}

void parseHeader(String responseText){
  
  String jsonString = responseText;
  //Decode the response
  Map parsedMap = JSON.decode(jsonString);
  int totalPages = parsedMap["numberOfPages"];
  
  print(totalPages);
  
  Random rnd = new Random(); //get new random number, max total pages
  
  int randPage = rnd.nextInt(totalPages);
  
  if(randPage == 0){
    randPage = 1; //sanity
  }
  
  print(randPage.toString());
  
  //get actual info
  String url = "http://beersherpaapp.appspot.com/api?endpoint=beers&p=$randPage&hasLabels=Y&withBreweries=Y&withIngredients=Y";
  var request = HttpRequest.getString(url).then(getRandData);
  
  
}

void getRandData(String responseText){
  
  String jsonString = responseText;
   //Decode the response
   Map parsedMap = JSON.decode(jsonString);
   List data = parsedMap["data"];
   
   int numItems = data.length;
   
   Random rnd = new Random();
   
   int randIndex = rnd.nextInt(numItems);
   
   String id = data[randIndex]["id"];
   
   
   //Create url 
   String url = "http://beersherpaapp.appspot.com/api?endpoint=beer/$id&withBreweries=Y";
   //Send request
   var request = HttpRequest.getString(url).then(buildResult);
  
}

void buildResult(String responseText) {
  
  String jsonString = responseText;

  //Decode the response
  Map parsedMap = JSON.decode(jsonString);
  
  Map dataMap = parsedMap["data"];
  
  currentData = dataMap;
    
  DivElement jumbotron = querySelector("#rate-jumbotron");
  
  //set name
  jumbotron.querySelector("#rate-name").text = dataMap["name"];
  
  
  //set brewery
  Map breweries = dataMap["breweries"][0];
  if(breweries != null){
    jumbotron.querySelector("#rate-brewery").text = breweries["name"];
  }
  
  //set img
  Map imgs = dataMap["labels"];
  if (imgs != null){
    jumbotron.querySelector("#rate-img").setAttribute("src", imgs["medium"]);
  }
  

   
}

/*
 * 
 * LISTENERIES:
 * 
 */

void skip(){
  populateRandom();
}

