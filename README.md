BeerSherpa
==========

<img src='BeerSherpa-frontend/BeerSherpa/web/img/logo.png' width='25%' height='25%' align='left' />
Meet the Sherpa!
He will be your personal guide through the world of craft beer.

The Sherpa doesn't offer suggestions but, rather, guides you before you purchase a beer. The Sherpa will first learn your personal taste-profile based on beers you rate with a simple thumbs-up or thumbs-down. Then, when you are at the bar or bottle-shop, you can ask the Sherpa if you'd enjoy a beer before you make the purchase.

<h2>Check it out: <a href='http://www.buckyoung.com/beersherpa'>Beer Sherpa</a> (Open-Beta)!</h2>

<hr>
We (Buck Young and Robert McDermot) designed Beer Sherpa for the 2014 University of Pittsburgh <a href='http://www.cs.pitt.edu/events/CSDay/2014/hackathon.php'>CS Day Hackathon</a>.  Our challenge was to build a web application that solved a problem.  Mostly this was an open-ended challenge that was scored based on how good your idea was, how well you implemented it, and how well you presented it.

Beer Sherpa won second place amongst 5 total projects.

<hr>
If you are interested in how the project was put together, please have a look through this repository.  We used Google's <a href='https://developers.google.com/appengine/'>Appengine</a> to manage the backend information storage and account creation.  For the client side, we made use of Twitter's <a href = 'http://getbootstrap.com/2.3.2/'>Bootstrap</a> CSS framework to create a beautiful website an Google's <a href='https://www.dartlang.org/'>Dart</a> to hook everything up and implement our application's logic.

Our source of information came from the wonderful <a href='http://www.brewerydb.com/'>BreweryDB</a> api.  This provided us with a fantastic base of information about beers and brewerys that we used to keep track of a user's taste profile and make determinations about what kinds of beer they will like.  Finally, we made use of Jason Davies' excellent <a href='https://github.com/jasondavies/d3-cloud'>word cloud generator</a>.  Origionally we were going to use a web based api for generating our word clouds <a href='https://www.mashape.com/gatheringpoint/word-cloud-maker#!endpoint-MakeWordCloud'>here</a>, but ultimately we found that while it produced good images, it was too slow to use.

<hr>
In order to make determinations about whether or not a user will like a certain beer, we stored a flavor profile for each user, determined by the styles, breweries, and individual beers that each user indicated that they enjoyed or didn't.  This flavor profile took information from BreweryDB about a beer's ingredients (such as the different kinds of hops, malts, and yeasts), its style, its ABV, and its IBU and weighted all of these components according to how much we thought they contributed to a beer's taste.  When a user asked us about a particular beer, we computed a % similarity between their taste profile and the individual beer's taste profile.  This was done using n-dimensional vectors, comprised of all of the individual flavor components stored as above, and computing their similarity using <a href='http://en.wikipedia.org/wiki/Cosine_similarity'>cosine similarity</a>.  We also determined how sure we were in our result based on how much information that the user has supplied to us in terms of beer preferences in the past.  We then presented this by telling the user if they would love, like, tolerate, or hate the beer they were asking us about and that "The Sherpa" was 68% sure of his answer (for example).
