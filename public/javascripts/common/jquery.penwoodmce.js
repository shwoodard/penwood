(function ($) {
  $.fn.penwoodmce = function () {
    $(this).tinymce({
      script_url: '/javascripts/common/tinymce/tiny_mce.js',
      // General options
      theme : "advanced",
      plugins : "preview",

      // Theme options
      theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
      theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,preview,|,forecolor,backcolor",
      theme_advanced_toolbar_location : "top",
      theme_advanced_toolbar_align : "left",
      theme_advanced_statusbar_location : "bottom",
      theme_advanced_resizing : true,
      
      convert_fonts_to_spans : true,
      content_css : "/stylesheets/common/global.css",
      theme_advanced_styles: "h1=heading1,h2=heading2,p=para,big_text=bigText"
    });
  };
})(jQuery);