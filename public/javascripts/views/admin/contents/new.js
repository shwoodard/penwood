(function($){
    $(document).ready(function() {
        $('.rte').tinymce({
            script_url: '/javascripts/common/tinymce/tiny_mce.js',
            theme: "advanced",
            theme_advanced_toolbar_location : "top",
            theme_advanced_toolbar_align : "left",
            theme_advanced_statusbar_location : "bottom"
        });
    });
})(jQuery);
 