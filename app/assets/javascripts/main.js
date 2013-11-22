$(document).ready(function() {
  $(".festival-banner").click(function(e) {
    window.location = $(this).attr("data-url");
  })
});