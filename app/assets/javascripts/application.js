// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
$(document).ready(function(){
  $(".like").on('click', '.add-like', function(){
    $.ajax({
      url: "/photos/" + $(this).parent().attr("id") + "/likes",
      type: "POST",
      dataType: "json",
      success: function(res) {
        $("#" + res.photo_id + " .add-like").replaceWith("<span class='remove-like glyphicon glyphicon-heart red' data-like-id='" + res.like_id + "'></span>");
        $("#" + res.photo_id + " .count-like").replaceWith("<span class='count-like'>" + res.likes_count + "</span>");
      }
    });
  });

  $(".like").on("click", ".remove-like", function(){
    $.ajax({
      url: "/photos/" + $(this).parent().attr("id") + "/likes/" + $(this).attr("data-like-id"),
      type: "POST",
      dataType: "json",
      data: { _method: "DELETE" },
      success: function(res) {
        $("#" + res.photo_id + " .remove-like").replaceWith("<span class='add-like glyphicon glyphicon-heart blue'></span>");
        $("#" + res.photo_id + " .count-like").replaceWith("<span class='count-like'>" + res.likes_count + "</span>");
      }
    });
  });

  

});

Share = {
	vkontakte: function(purl, ptitle, pimg, text) {
		url  = 'http://vkontakte.ru/share.php?';
		url += 'url='          + encodeURIComponent(purl);
		url += '&title='       + encodeURIComponent(ptitle);
		url += '&description=' + encodeURIComponent(text);
		url += '&image='       + encodeURIComponent(pimg);
		url += '&noparse=true';
		Share.popup(url);
  },
  popup: function(url) {
		window.open(url,'','toolbar=0,status=0,width=626,height=436');
	}
};

