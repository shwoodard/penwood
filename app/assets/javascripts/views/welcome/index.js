(function($){
    $(document).ready(function() {
      $('#welcome_dialog_link').each(function () {
        var url = $(this).val();
        var self = $(this);
        var title = self.attr('rel');
        $.ajax({
          url: url,
          success: function (resp) {
            var dialogDom = $(resp);

            dialogDom.dialog({
              width: 'auto',
              title: title || '',
              modal: true,
              open: function () {
                self.trigger('dialog.open');
                dialogDom.find('.close_win').click(function (evt) {
                  evt.preventDefault();
                  self.trigger('dialog.close');
                  dialogDom.dialog('close');
                });
              },
              buttons: {
                "Close": function (evt) {
                  dialogDom.dialog('close');
                },
                
                "Don't show this window again": function (evt) {
                  dialogDom.dialog('close');
                  $.post($('#dont_show_welcome_dialog_path').val(), {_method: 'put', authenticity_token: $('#dont_show_welcome_dialog_path').attr('rel')});
                }
              }
            });
          },
          dataType: 'html'
        });
      });
      $('.slideShow').cjSimpleSlideShow();
    });
})(jQuery);
 