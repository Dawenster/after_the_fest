$(document).ready(function() {
  $(".post-button").click(function(e) {
    e.preventDefault();
    var author = $("#comment_author").val();
    var content = $("#comment_content").val();
    var captcha = $("#captcha").val();

    if (author && content && captcha) {
      var formData = {
        comment: { 
          author: author,
          content: content,
          film_id: $("#comment_film_id").val()
        },
        captcha: captcha,
        captcha_key: $("#captcha_key").val()
      }

      $.ajax({
        url: "/comments",
        method: "post",
        dataType: "json",
        data: formData
      })
      .done(function(data) {
        $(".captcha-container").html(data.captcha);
        if ($(".comments-bucket").children().length == 0) {
          $(".comments-bucket").after(data.comment);
        } else {
          $(".comments-bucket").children().first().before(data.comment);
        }
        $("#comment_author").val("");
        $("#comment_content").val("");
      })
      .fail(function() {
        alert("Incorrect captcha - please try again :)");
      })
    } else {
      alert("Please fill in all fields - including the captcha :)");
    }
  });
});