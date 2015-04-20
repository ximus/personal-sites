//= require ./lib/gallery

$(function() {
  var options  = new LightboxOptions();
  var lightbox = new Lightbox(options);

  initGallery(lightbox)
})