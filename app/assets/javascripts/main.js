$(document).ready(function() {
  $(".festival-banner").click(function(e) {
    var target = $(e.target);
    window.location = target.attr("data-url");
  })
});