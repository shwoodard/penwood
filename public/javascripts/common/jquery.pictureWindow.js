(function ($){
  var BLANK_IMAGE_PATH = "/images/blank.gif";
  
  function preCacheWindowImages (paths) {
    if (!paths || !paths.lenth) { return; }
    var tempImage = $('<img src="' +  paths[0] + '" class="hidden"/>');
    $(body).append(tempImage);
    for (var i = 1; i < paths.length; i++) {
      tempImage.attr('src', paths[i]);
    }
    
    tempImage.remove();
  }
  
  $.fn.pictureWindow = function() {
    return $(this).each(function () {
      var el = $(this);
      var thumbs = el.siblings('.thumbs').find('.thumb');
      var thumbLinks = thumbs.find('a');
      
      var windowImagePaths = [];
      thumbLinks.each(function () { windowImagePaths.push($(this).attr('rel')); });

      if (!windowImagePaths || !windowImagePaths.length || thumbs.length !== windowImagePaths.length) { 
        throw 'You must put the main window image paths in the rel tags of the thumb nail links';
      }
      
      preCacheWindowImages();
      
      if (!el.find('img').length) {
        el.html('<img src="' + BLANK_IMAGE_PATH +'" />');
      }
      
      var windowImage = el.find('img');
      windowImage.addClass('pictureWindowImage');
      if (windowImage.attr('src') !==  windowImagePaths[0]) {
        windowImage.attr('src', windowImagePaths[0]);
      }
      
      thumbLinks.bind('mouseover click', function (evt) {
        evt.preventDefault();
        windowImage.attr('src', $(this).attr('rel'));
      });
    });
  };
})(jQuery);
