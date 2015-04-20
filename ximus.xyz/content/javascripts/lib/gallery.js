window.initGallery = function(lightbox) {
  "use strict";

  var ALBUM_URL = "//picasaweb.google.com/data/feed/api/user/104618138749013524886/albumid/ALBUM_ID?alt=json&fields=entry(content,media:group)&imgmax=1000"

  lightbox.options.onImageChanged = function(newImage) {
    if (newImage.id) {
      history.replaceState(undefined, undefined, '#'+newImage.id)
    }
  }

  function largestGoogleThumb (thumbs) {
    var largest
    for (var i = 0; i < thumbs.length; i++) {
      var thumb = thumbs[i]
      if (!largest || thumb.width > largest.width) {
        largest = thumb
      }
    }
    return largest
  }

  $('[data-google-album-id]').each(function() {
    var $parent = $(this)
    var albumID = $parent.data('google-album-id')
    var url = ALBUM_URL.replace('ALBUM_ID', albumID)

    $.ajax({
      dataType: "json",
      url: url,
      success: function(data) {
        var items = []
        $.each(data.feed.entry, function(_, image) {
          var id = image['media$group']['media$title']['$t']
          id = encodeURIComponent(id)
          var url = image.content.src
          var thumb = largestGoogleThumb(image['media$group']['media$thumbnail'])
          items.push(
            "<li id='" + id + "'>\
              <a href='" + url + "' data-lightbox='" + albumID + "'>\
                <img src='" + thumb.url + "'>\
              </a>\
            </li>"
          )
        })
        $parent.html("<ul class='image-list'>" + items.join("\n") + "</ul>")
        setTimeout(onImagesLoaded)
      }
    })
  })

  function scrollTo(id) {
    var $match = $(document.getElementById(id));
    // debugger
    if ($match.length > 0) {
      var offset = $match.offset().top
      $('html,body').animate({scrollTop: offset}, 500, 'swing')
      $match.find('a').click()
    }
  }

  function scrollToImageAnchor() {
    var anchor = window.location.hash.substring(1);
    scrollTo(anchor)
  }

  function onImagesLoaded() {
    scrollToImageAnchor()
  }
}