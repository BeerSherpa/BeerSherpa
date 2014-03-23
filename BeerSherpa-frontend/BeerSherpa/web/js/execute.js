function execute(wordList)
{
console.log(wordList);

  d3.layout.cloud().size([800, 400])
      .words(wordList.map(function(d) {
        return {text: d, size: 10 + Math.random() * 90};
      }))
      .padding(5)
      .rotate(function() { return ~~(Math.random() * 2) * 90; })
      .font("Impact")
      .fontSize(function(d) { return d.size; })
      .on("end", draw)
      .start();
}

  function draw(words) {
  
  	var fill = d3.scale.category20c();
  	
    d3.select("#wordcloud-row").append("svg")
    	.attr("style","background-color:white;border-radius:10px;")
        .attr("width", 800)
        .attr("height", 400)
        .attr("class", "center-block img-responsive")
        .attr("id","wordcloud-img")
      .append("g")
        .attr("transform", "translate(367,200)")
      .selectAll("text")
        .data(words)
      .enter().append("text")
        .style("font-size", function(d) { return d.size + "px"; })
        .style("font-family", "Impact")
        .style("fill", function(d) { return fill(d.text.toLowerCase()); })
        .attr("text-anchor", "middle")
        .attr("transform", function(d) {
          return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
        })
        .text(function(d) { return d.text; });
  }