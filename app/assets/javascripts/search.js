$(document).ready(function() {
  var allFilms = null;
  var festivalPage = $(".festival-banner").attr("data-festival-slug");
  $.ajax({
    url: "/searchable_films",
    method: "get",
    dataType: "json",
    data: { festival_slug: festivalPage }
  })
  .done(function(data) {
    allFilms = data.films;
    var lastId = "0";
    if ($(window).width() > 600) {
      var myPosition = "right top";
      var atPosition = "right bottom";
    }
    $("#search-bar").autocomplete({
      source: allFilms,
      focus: function(event, ui) {
        $("#search-bar").val(ui.item.value);
        $("#" + lastId).attr("style", "background-color: white;");
        $("#" + ui.item.styleId).attr("style", "background-color: #F8F8F8;");
        lastId = ui.item.styleId;
        return false;
      },
      position: {
        my: myPosition,
        at: atPosition
      },
      select: function(event, ui) {
        window.location = ui.item.link;
      }
    }).data("ui-autocomplete")._renderItem = function(ul, item) {
      return $( "<li>" )
      .append("<div class=custom-search-item id="
        + item.styleId + "><img height=50px style='float: left;' src="
        + item.icon + "><div style='float: left;'><a><strong>"
        + item.value + "</strong><br><div class='search-item-description'>"
        + item.festival + "</div></a></div></div>")
      .appendTo(ul);
    };
  });

  $(".search-button").click(function(e) {
    e.preventDefault();
    window.location = "/search?query=" + $("#search-bar").val();
  });

  $(".expand-search").click(function(e) {
    e.preventDefault();
    $(".search-button").removeClass("hidden-sm");
    $(".fa-search").removeClass("hidden-sm");
    $("#search-bar").removeClass("hidden-sm");
    $(".shrink-search").removeClass("hidden");
    $(".expand-search").addClass("hidden");

    $(".search-removable").toggle();
  });
})