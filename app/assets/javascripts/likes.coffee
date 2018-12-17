# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#gal').on('click', '.add-like', ->
    $.ajax(
      url: "/photos/" + $(this).parent().attr("id") + "/likes",
      type: "POST",
      dataType: "json",
      success: (res) ->
        $("#" + res.photo_id + " .add-like").replaceWith("<span class='remove-like glyphicon glyphicon-heart red' data-like-id='" + res.like_id + "'></span>")
        $("#" + res.photo_id + " .count-like").replaceWith("<span class='count-like'>" + res.likes_count + "</span>")
    )
  )


$(document).ready ->
  $('#gal').on('click', '.remove-like', ->
    $.ajax(
      url: "/photos/" + $(this).parent().attr("id") + "/likes/" + $(this).attr("data-like-id"),
      type: "POST",
      dataType: "json",
      data:
        _method: "DELETE",
      success: (res) ->
        $("#" + res.photo_id + " .remove-like").replaceWith("<span class='add-like glyphicon glyphicon-heart blue'></span>")
        $("#" + res.photo_id + " .count-like").replaceWith("<span class='count-like'>" + res.likes_count + "</span>")
    )
  )
