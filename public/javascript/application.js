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

});
