$(document).ready(function() {
  $(".vote-button").click(function(e) {
    $.ajax({
      url: '/votes',
      method: 'post',
      dataType: 'json',
      data: { film_id: $(this).attr("data-film-id"), vote_type: $(this).attr("data-vote-type") }
    })
    .done(function(data) {
      var count = "  " + data.count;
      if (data.vote_type == "up") {
        $(".fa-thumbs-up").text(count);
      } else {
        $(".fa-thumbs-down").text(count);
      }
      $(".voting-space").text(data.message);
    })
  });
});