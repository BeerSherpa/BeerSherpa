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
    populateRandom();
  });
  querySelector("#rate-button-yuk")..onClick.listen((MouseEvent e) {
    currentUser.like(currentData, false);
    populateRandom();
  }); 
  currentNumber=0;
  
  populateRandom();
  
}

//get a random one
void populateRandom(){
  
  int random = currentNumber++;
  
  String id = beerids[random];
  
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

