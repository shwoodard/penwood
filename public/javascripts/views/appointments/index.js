(function($){
    $(document).ready(function() {
        $('#tentative_appts_wpr').load($('#tentative_appointments_path').val());
        $('#confirmed_appts_wpr').load($('#confirmed_appointments_path').val());
    });
})(jQuery);
 