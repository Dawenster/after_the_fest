$(document).ready(function() {
  $(".festival-banner").click(function(e) {
    window.location = $(this).attr("data-url");
  });

  var gridItems = $(".film-grid-item");
  var positionIfLast = null;
  var defaultPosition = null;

  for (var i=0; i < gridItems.length; i++) {
    currentItem = $(gridItems[i]);
    switch (currentItem.attr("data-screen")) {
      case "lg":
        positionIfLast = 4;
        var defaultPosition = "right";
        break;
      case "md":
        positionIfLast = 3;
        var defaultPosition = "right";
        break;
      case "sm":
        positionIfLast = 3;
        var defaultPosition = "right";
        break;
      case "xs":
        positionIfLast = 1;
        var defaultPosition = "bottom";
        break;
    }
    var count = parseInt(currentItem.attr("data-count"));
    if (count % positionIfLast == 0 && positionIfLast != 1) {
      defaultPosition = "left";
    } else if ( positionIfLast == 1 && 
                gridItems.length / 4 > 2 && 
                (gridItems.length / 4 == count || gridItems.length / 4 - 1 == count)) {
      defaultPosition = "top";
    }
    currentItem.attr("data-placement", defaultPosition);
  }

  $(".film-grid-item img").hover(function(e) {
    var parent = $(this).parent();
    parent.popover("show");
    parent.addClass("hovering");
    parent.siblings(".play-button").removeClass("hidden");
  }, function(e) {
    var target = $(e.target);
    var parent = target.parent();
    var popoverCount = setInterval(function() {
      if (!$(".popover:hover").length && !parent.is(":hover")) {
        clearInterval(popoverCount);
        parent.popover("hide");
        parent.removeClass("hovering");
        parent.siblings(".play-button").addClass("hidden");
      }
    }, 100);
  });

  $(".touch-info").click(function(e) {
    var currentItem = null;
    switch ($(this).attr("data-screen")) {
      case "lg":
        currentItem = $(this).siblings(".visible-lg")
        break;
      case "md":
        currentItem = $(this).siblings(".visible-md")
        break;
      case "sm":
        currentItem = $(this).siblings(".visible-sm")
        break;
      case "xs":
        currentItem = $(this).siblings(".visible-xs")
        break;
    }
    for (var i=0; i < gridItems.length; i++) {
      if ($(gridItems[i]).attr("data-count") != currentItem.attr("data-count")) {
        $(gridItems[i]).popover("hide");
      }
    }
    currentItem.popover("toggle");
  });

  $(".film-grid-item").click(function(e) {
    window.location = $(this).attr("data-url");
  });

  if (Modernizr.touch) {
    $(".touch-info").removeClass("hidden");
    $(".navbar-fixed-top").attr("style", "position: absolute !important;");
  }
});