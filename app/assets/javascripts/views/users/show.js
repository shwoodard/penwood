(function($){
    $(document).ready(function() {
        $('#welcome_dialog').click(function (evt) {
          $.post($('#show_welcome_dialog_path').val(), {_method: 'put', authenticity_token: $(this).attr('rel'), welcome_dialog: !!$(this)[0].checked});
        });
    });
})(jQuery);
 