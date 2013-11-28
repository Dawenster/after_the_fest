$(document).ready(function() {
  var allFilms = null;
  $.ajax({
    url: "/searchable_films",
    method: "get",
    dataType: "json"
  })
  .done(function(data) {
    allFilms = data.films;
    var lastId = "0";
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
        my: "right top",
        at: "right bottom"
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

  $(".fa-search").click(function(e) {
    e.preventDefault();
    // $(".fa-search-plus").togg
  });
})