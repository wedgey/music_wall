$(document).ready(function() {

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $(document).on("click", '.upvotes > a', function() {
    event.preventDefault();
    cur_obj = $(this);
    count = Number($(this).parent().text());

    $.ajax({
      method: "GET",
      url: $(this).attr('href'),
      success: function(id) {
        if (cur_obj.attr('href').includes("/music/upvote")) {

          cur_obj.parent().html("<a href=\"/music/downvote/"+id+"\"><span class=\"glyphicon glyphicon-thumbs-up upvoted\" aria-hidden=\"true\"></span></a>" + (count+1));
        } else {
          cur_obj.parent().html("<a href=\"/music/upvote/"+id+"\"><span class=\"glyphicon glyphicon-thumbs-up upvote\" aria-hidden=\"true\"></span></a>" + (count-1));
        }
      }
    });
  });

  var $review_form_rate = $('#review_form_rate').rateYo({
    onSet: function(rating, rateInstance) {
      $('#num_stars').attr('value', rating);
    }
  });

  $(".user_review_stars").rating({displayOnly: true, min:0, max:5, step:0.1, size:'xs'});

});
