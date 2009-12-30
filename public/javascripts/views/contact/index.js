(function($){
    $(document).ready(function() {
        $('#user_register').change(function () {
          $('.contactPasswordField').setClass('hidden', !$('#user_register').get(0).checked);
        });
        $('#user_register').change();
    });
})(jQuery);
 