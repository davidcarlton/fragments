$(document).ready(function() {
  var width = $(window).width()
  if (width < 1050) {
    var body = $("body")
    body.width("auto")
    if (width < 500) {
      body.css("margin", "20px")
      body.css("fontSize", "16px")
    } else {
      body.css("margin", "100px")        
    }
  }
})
