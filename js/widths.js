$(document).ready(function() {
  var width = $(window).width();
  if (width < 500) {
    $("body").addClass("small");
  } else if (width < 1050) {
    $("body").addClass("medium");
  }
})
