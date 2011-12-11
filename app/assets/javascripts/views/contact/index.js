(function($){
    $(document).ready(function() {
        $('#user_register').change(function () {
          $('.contactPasswordField').setClass('hidden', !$('#user_register').get(0).checked);
        });
        $('#user_register').change();
        
        // $('.new_user_button').click(function(evt) {
        //   evt.preventDefault();
        //   $('.new_user_form_wpr').removeClass('hidden');
        //   $(this).remove();
        // });
    });
})(jQuery);
 