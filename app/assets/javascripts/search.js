$(document).ready(function() {
  var allFilms = null;
  $.ajax({
    url: "/searchable_films",
    method: "get",
    dataType: "json"
  })
  .done(function(data) {
    allFilms = data.films;
    $("#search-bar").autocomplete({
      source: allFilms,
      position: {
        my: "right top",
        at: "right bottom"
      },
      select: function(event, ui) {
        $("#search-bar").val(ui.item.label);
        window.location = ui.item.value;
        return false;
      }
    }).data("ui-autocomplete")._renderItem = function(ul, item) {
      return $( "<li>" )
      .append("<div style='margin-top: -20px; padding: 5px;'><img height=50px style='float: left;' src="
        + item.icon + "><div style='float: left;'><a><strong>"
        + item.label + "</strong><br><div class='search-item-description'>"
        + item.desc + "</div></a></div></div>")
      .appendTo(ul);
    };
  });
})